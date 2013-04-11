---------Contains---------------
--hlib.counter()
--hlib.dump()
--hlib.debug()
--hlib.debugf()
--hlib.debugd()
--hlib.unicode2UTF8
--hlib.collision(rectA,rectB)
--
--
--------------------------------
import.libraries.CommonFunction = function()



--Counter Function
hlib.counter = function()
    local i = 0
    return function(s)
        if s == "+" then 
        i = i+1
        return i
        end
        if s == "-" then
            i = i-1
            return i
        end
    return i 
    end
end
--------------------------------

--Dump a Table
hlib.dump = function(t,indent)
    local names = {}
    if not indent then indent = "" end
    for n,g in pairs(t) do
        table.insert(names,n)
    end
    table.sort(names)
    for i,n in pairs(names) do
        local v = t[n]
        if type(v) == "table" then
            if(v==t) then -- prevent endless loop if table contains reference to itself
                print(indent..tostring(n)..": <-")
            else
                print(indent..tostring(n)..":")
                dump(v,indent.."   ")
            end
        else
            if type(v) == "function" then
                print(indent..tostring(n).."()")
            else
                print(indent..tostring(n)..": "..tostring(v))
            end
        end
    end
end
-------------------------------------------------

--Debug Functions
hlib.debug = function(d,str)
   if d == true then print("---DEBUG Print---"); print(str) end 
end

hlib.debugf = function(d,f, ...)
    if d == true then print("---debugf---"); return f(unpack(arg)) end
end
hlib.debugd = function(d,t)
    if d == true then hlib.dump(t) end
end
------------------------------------------------

hlib.unicode2UTF8 = function(u)
    u = math.max(0, math.floor(u)) -- A positive integer
    local UTF8
    if u < 0x80 then          -- less than  8 bits
        UTF8 = string.char(u)
    elseif u < 0x800 then     -- less than 12 bits
        local b2 = u % 0x40 + 0x80
        local b1 = math.floor(u/0x40) + 0xC0
        UTF8 = string.char(b1, b2)
    elseif u < 0x10000 then   -- less than 16 bits
        local b3 = u % 0x40 + 0x80
        local b2 = math.floor(u/0x40) % 0x40 + 0x80
        local b1 = math.floor(u/0x1000) + 0xE0
        UTF8 = string.char(b1, b2, b3)
    elseif u < 0x200000 then  -- less than 22 bits
        local b4 = u % 0x40 + 0x80
        local b3 = math.floor(u/0x40) % 0x40 + 0x80
        local b2 = math.floor(u/0x1000) % 0x40 + 0x80
        local b1 = math.floor(u/0x40000) + 0xF0
        UTF8 = string.char(b1, b2, b3, b4)
    elseif u < 0x800000 then -- less than 24 bits
        local b5 = u % 0x40 + 0x80
        local b4 = math.floor(u/0x40) % 0x40 + 0x80
        local b3 = math.floor(u/0x1000) % 0x40 + 0x80
        local b2 = math.floor(u/0x40000) % 0x40 + 0x80
        local b1 = math.floor(u/0x1000000) + 0xF8
        UTF8 = string.char(b1, b2, b3, b4, b5)
    else
        print("Error: Code point too large for Codea's Lua.")
    end
    return UTF8
end

hlib.collision = function(rectA, rectB)
    if rectA.x and rectB.x then
    local ax2, bx2, ay2, by2 = rectA.x + rectA.width, rectB.x + rectB.width, rectA.y + rectA.height, rectB.y + rectB.height
    return ax2 > rectB.x and bx2 > rectA.x and ay2 > rectB.y and by2 > rectA.y
    end
end


--end function
end





