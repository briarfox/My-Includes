
import.libraries.FileIO = function()
local DEBUG = false

local f = 0
        
function hlib.readCSV(data)
   local  m = data
    local t = {}                   -- table to store the indices
    local idx = 0
    local idx2 = 0
    local i = 0
    local brk = 0
    
    while true do
        brk = string.find(m,"\n",idx2)
        i= string.find(m, ",",idx)    -- find 'next' newline
          if i == nil then 

            if brk == string.find(m,"\n",#m) then
                local txt = string.sub(m,idx,#m -1)
                table.insert(t,txt)
                break
            end
        local txt = string.sub(m,idx,#m)
        table.insert(t,txt)
        break 
        end
            if brk >=idx and brk <= i then
                --print("loaded")
                idx2 = brk+1
                local txt = string.sub(m,idx,brk-1)
                table.insert(t,txt)
                idx = brk+1
                txt = "brk"
                table.insert(t,txt)
                txt = string.sub(m,idx,i-1)
                table.insert(t,txt) 
            idx=i+1 
        else
            local txt = string.sub(m,idx,i-1)
              table.insert(t, txt)
            idx = i+1
            
        end
    end
    --table.insert(t,"brk")
    --hlib.debugf(DEBUG,dump,t)
    return t
end

hlib.getFile = function(file,ret)
    --local f
    function didGetData(data,status,head)
    print(status)
        hlib.rImage = data
        
        print("File Request Sucess!")
        --return f
    end
    
    http.request(file,didGetData)
    --print("hit end")
    
    return f
end

hlib.downloadSprite = function(name,url)
if readImage("Documents:"..name) then return end 
    function didGetImage(data,status,header)
    saveImage("Documents:"..name,data)
    print("Sprite Sheet Saved")
    end
    http.request(url,didGetImage) 
    
    
end

--end import
end


