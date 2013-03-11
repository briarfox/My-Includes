--Sprite Sheet Animation
--Developed by Chris Houser

Animation = class()

function Animation:init(img,rows,cols)
    -- you can accept and set parameters here
   -- self.animations = {}    
    self.spriteName = {} --tables of sprites
    self.img = img --hold spritesheet img    
    self.m = mesh()
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
    local y = 0
    for i=1, self.rows*self.cols do
        if counter <= self.cols then
        self.animationCoords[i] = vec2(x,y)
        x = x + 1
        counter = counter + 1
        else
            y = y + 1
            x = 0
            self.animationCoords[i] = vec2(x,y)
            x = x + 1
            counter = 2
        end
        end 
end

function Animation:addSprite(name,screenCoords,sSize)
    
    self.spriteName[name] = {
                                animDelay = 0,
                                animSpeed = 5,
                                speed = 1,
                                spawnLoc = {x=screenCoords.x,y=screenCoords.y,rotation=screenCoords.rotation},
                                moveCoords = {x=screenCoords.x,y=screenCoords.y,rotation=screenCoords.rotation},
                                currentLoc = {x=screenCoords.x,y=screenCoords.y,rotation=screenCoords.rotation},
                                size = sSize,
                                animdelay = 0,
                                visible = true,
                                moving = false,
                                animation = {},
                                currentAnimation = nil,
                                currentFrame = 1
                            }    
     if DEBUG==true then print("sprite "..name.." Created")end
    --print(a.idx)
end

function Animation:addAnimation(sName,aName,frames)
    self.spriteName[sName].animation[aName] = {}
    
    for i=1,#frames do
        local j =frames[i]
         
       self.spriteName[sName].animation[aName][i] = self.animationCoords[j] 
    end
    --print(self.spriteName.test.animation.forward[1])
    self.spriteName[sName].currentAnimation = aName
end

function Animation:drawAnimation(name)
 
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
 
local idx = self.m:addRect(0,0,anim.size.x,anim.size.y)


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
    local locx,locy,locRotation = 0
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
      print("Moving to spawn")
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
                end
                --inc by speed
                j.currentLoc.x = j.currentLoc.x - j.speed
                --check to stop moving
                if j.currentLoc.x <= j.moveCoords.x  then
                    j.moving = false
                    if j.animation["stop"] ~= nil then
                        j.currentAnimation = "stop"
                    end
                end
                
            end
        --move right
            if j.currentLoc.x <j.moveCoords.x  then 
                --change animation 
                if j.animation["right"] ~= nil and j.moving == true then
                    j.currentAnimation = "right"
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














