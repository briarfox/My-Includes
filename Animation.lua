--Sprite Sheet Animation
local DEBUG = false
--Developed by Chris Houser

Animation = class()

function Animation:init(img,rows,cols)
    -- you can accept and set parameters here
   -- self.animations = {}    
    self.spriteName = {} --tables of sprites
    self.img = img --hold spritesheet img    
    self.m = mesh()
    self.imgSizeX,self.imgSizeY = spriteSize(img)
    self.imgSizeX = self.imgSizeX/cols
    self.imgSizeY = self.imgSizeY/rows
    self.m.texture = img
    self.cols = cols
    self.rows = rows
    self.animationCoords = {} -- hold coords for each grid
    self :setupCoords()
end

function Animation:draw()
    --self.m:clear()
    self :isMoving()
    -- Codea does not automatically call this method
    for i,j in pairs(self.spriteName) do
        
        self :drawAnimation(i)
        end
      --  self.m:draw()
      --  self.m:draw()
        
        --self.m:draw()
        
end

function Animation:touched(touch)
    -- Codea does not automatically call this method
end

function Animation:setupCoords()
   
    local counter = 1
    local x = 0
    local y = self.rows -1
    for i=1, self.rows*self.cols do
        if counter <= self.cols then
        self.animationCoords[i] = vec2(x,y)
        x = x + 1
        counter = counter + 1
        else
            y = y - 1
            x = 0
            self.animationCoords[i] = vec2(x,y)
            x = x + 1
            counter = 2
        end
        end 
end

function Animation:addSprite(name,sC,sSize)
    if sC.size == nil then sC.size = vec2(1,1)end
    self.spriteName[name] = {
                                animDelay = 0,
                                animSpeed = 5,
                                speed = 1,
                                spawnLoc = {x=sC.x,y=sC.y,rotation=sC.rotation,size=sC.size},
                                moveCoords = {x=sC.x,y=sC.y,rotation=sC.rotation,size=sC.size},
                                currentLoc = {x=sC.x,y=sC.y,rotation=sC.rotation,size=sC.size},
                                size = sSize,
                                animdelay = 0,
                                visible = true,
                                moving = false,
                                animation = {},
                                currentAnimation = nil,
                                currentFrame = 1
                            }    
     debug(DEBUG,"sprite "..name.." Created")
    --print(a.idx)
end

function Animation:addAnimation(sName,aName,frames)
    local DEBUG = false
    debug(DEBUG,sName)
    debug(DEBUG,aName)
    debug(DEBUG,"Frame Count "..#frames)
    debugf(DEBUG,dump,frames)
    self.spriteName[sName].animation[aName] = {}
    debugf(DEBUG,dump,self.spriteName[sName])
    --debugf(DEBUG,dump,frames)
    for i=1,#frames do
        local j =frames[i]
         debug(true,"Animation Name "..aName.." frame "..j)
        debugd(DEBUG,self.animationCoords)
        debug(DEBUG,self.spriteName[sName].animation[aName][i])
        debug(DEBUG,self.animationCoords[tonumber(j)])
       self.spriteName[sName].animation[aName][i] = self.animationCoords[tonumber(j)] 
    debug(DEBUG,"loded and saved animations")
    debugf(DEBUG,dump,self.spriteName[sName].animation[aName][i])
    end
    --print(self.spriteName.test.animation.forward[1])
    self.spriteName[sName].currentAnimation = aName
end

function Animation:spriteFromFile(name,coords,size)
    local DEBUG = false
    
    local read = readProjectData(name.."csv")
    debug(DEBUG,read)
    if read == nil then return print("File Not Found") end
    self :addSprite(name,coords,size)
    debug(DEBUG,"Sprite Marker")
    data = readCSV(read)
    debugf(DEBUG,dump,data)
    if data == nil then print("Problem Loading File") end
    
    local ctr = 1
    --print("Elemnts in Data "..#data)
    local anims = {}
    table.insert(anims,{})
    for i=1, #data do
        
        
       if data[i] == "brk" then 
            ctr = ctr + 1 
            --print("hit Brk "..ctr)
           anims[ctr] = {}
        else
            --dump(anims)
            --print(ctr)
            table.insert(anims[ctr],data[i])
            debugf(DEBUG,dump,anims[ctr])
            --print(anims[ctr][i])
        end
        
    end
    --dump(anims,"--")
    --load animations
    
    for i=1,#anims do
        debug(DEBUG,"Anims Passed "..i)
        debugf(DEBUG,dump,anims[i])
     self  :addAnimation(name,tostring(i),anims[i]) 
    
    end
    
    
    
    
end

function downloadAnimation(name,url,str)
    function didGetAnimation(data,status,header)
        saveProjectData(name.."csv",data)
        print("CSV files Saved")
        end
        if url ~= nil then http.request(url,didGetAnimation) else
            didGetAnimation(str) end
    
end

function downloadSprite(name,url)
-------------------------------------------------------    
    function didGetImage(data,status,header)
    saveImage("Documents:"..name,data)
    print("Sprite Sheet Saved")
    end
    http.request(sUrl,didGetImage) 
    --if animationUrl == nil then return end
   -- http.request(aUrl,didGetAnimation)
    
    --Callback Functions
    
    
end

function Animation:drawAnimation(name)
 local DEBUG = false
debug(DEBUG,"Sprite name passed "..name)
debugf(DEBUG,dump,self.spriteName[name].animation)
--if sprite is visible   
if self.spriteName[name].visible == true then
    local anim = self.spriteName[name]
    local currentAnim = self.spriteName[name].currentAnimation

    self.spriteName[name].animDelay = self.spriteName[name].animDelay + 1
    
    if self.spriteName[name].animDelay > self.spriteName[name].animSpeed then
        
        self.spriteName[name].animDelay = 0
        self.spriteName[name].currentFrame = self.spriteName[name].currentFrame + 1
       -- print(self.spriteName[name].currentFrame)
    end
    if self.spriteName[name].currentFrame > #self.spriteName[name].animation[currentAnim] then
        self.spriteName[name].currentFrame = 1
        end
    pushMatrix()
    self.m:clear()
    --rotate(anim.currentLoc.rotation)
    translate(anim.currentLoc.x,anim.currentLoc.y)
    rotate(anim.currentLoc.rotation)
    scale(anim.currentLoc.size.x,anim.currentLoc.size.y)
 
local idx = self.m:addRect(0,0,anim.size.x,anim.size.y)

debug(DEBUG,"print inside animation")
debugf(DEBUG,dump,anim.animation[anim.currentAnimation])

   local  x = self.spriteName[name].animation[self.spriteName[name].currentAnimation][self.spriteName[name].currentFrame].x/self.cols

   local  y = anim.animation[anim.currentAnimation][anim.currentFrame].y/self.rows
    
    self.m:setRectTex(idx,x,y,1/self.cols,1/self.rows )
    --translate(anim.moveCoords.x,anim.moveCoords.y)
    self.m:draw()
    popMatrix()
    --self.m:draw()
    
end
end

function Animation:tweenSprite(name,speed,tweenLoc,params)
    local locx,locy,locRotation = 0,0,0
    local sn = self.spriteName[name]
    if tweenLoc.x ~= nil then locx = tweenLoc.x end
    if tweenLoc.y ~= nil then locy = tweenLoc.y end
    
    if tweenLoc.rotation ~= nil then locRotation = tweenLoc.rotation end
    
    tween(speed,sn.currentLoc,{x=locx,y=locy,rotation=locRotation},params,function() sn.currentLoc.rotation = 0 end)
end


function Animation:getLoc(name)
    return self.spriteName[name].currentLoc
end

function Animation:setLoc(name,loc)
   self.spriteName[name].currentLoc = loc
    self.spriteName[name].moveCoords = loc 
end

function Animation:moveSpawn(name)
     debug(DEBUG,"Moving to spawn")
        --print(self.spriteName[name].currentLoc.x)
        print(self.spriteName[name].spawnLoc.x)
    self.spriteName[name].currentLoc.x = self.spriteName[name].spawnLoc.x
    self.spriteName[name].currentLoc.y = self.spriteName[name].spawnLoc.y
    self.spriteName[name].currentLoc.rotation = self.spriteName[name].spawnLoc.rotation
    self.spriteName[name].moveCoords.x = self.spriteName[name].spawnLoc.x
    self.spriteName[name].moveCoords.y = self.spriteName[name].spawnLoc.y
    self.spriteName[name].moveCoords.rotation = self.spriteName[name].spawnLoc.rotation


end

function Animation:speed(name,sp,ani)
   self.spriteName[name].speed = sp
    self.spriteName[name].animSpeed = ani 
end



function Animation:setAnimation(sName,aName)
   self.spriteName[sName].currentAnimation = aName 
end

function Animation:moveTo(name,coords)
    
    self.spriteName[name].moveCoords.x = coords.x 
    self.spriteName[name].moveCoords.y = coords.y
    self.spriteName[name].moving = true
end

function Animation:isMoving()
   
for i,j in pairs(self.spriteName) do
    if j.moving == true then
        --move up
        if j.currentLoc.y > j.moveCoords.y then
            j.currentLoc.y = j.currentLoc.y - j.speed
        end
        if j.currentLoc.y < j.moveCoords.y then
            j.currentLoc.y = j.currentLoc.y + j.speed
        end
        
        --moving left 
            if j.currentLoc.x >j.moveCoords.x  then
                --change animation 
                if j.animation["left"] ~= nil and j.moving == true then
                    j.currentAnimation = "left"
                elseif j.animation["2"] ~= nil and j.moving == true then
                    j.currentAnimation = "2"
                end
                --inc by speed
                j.currentLoc.x = j.currentLoc.x - j.speed
                --check to stop moving
                if j.currentLoc.x <= j.moveCoords.x  then
                    j.moving = false
                    if j.animation["stop"] ~= nil then
                        j.currentAnimation = "stop"
                    elseif j.animation["3"] ~= nil then
                        j.currentAnimation = "3"
                    end
                end
                
            end
        --move right
            if j.currentLoc.x <j.moveCoords.x  then 
                --change animation 
                if j.animation["right"] ~= nil and j.moving == true then
                    j.currentAnimation = "right"
                elseif
                    j.animation["1"] ~= nil and j.moving == true then
                        j.currentAnimation = "1"
                end
                --inc by speed
                j.currentLoc.x = j.currentLoc.x + j.speed
                --check to stop moving
                if j.currentLoc.x >= j.moveCoords.x then
                    j.moving = false
                    if j.animation["stop"] ~= nil then
                        j.currentAnimation = "stop"
                    end
                end
            end
        
        end 
        
end 
end
















