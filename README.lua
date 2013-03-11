--[[

Demo sprite used - http://goo.gl/IWXj4
Gister ID = "44731d2f8fcdec0bd0ab"

--Animation(Image, rows, columns)
image = sprite Sheet
rows = rows in sprite sheet
columns = columns in sprite sheet


--addSprite(name,screenCoords,sSize)
This adds a new sprite
name = unique id to sprite
screenCoords = position on the screen
sSize = size of the sprite


--addAnimation(sName,aName,frames)
This adds a new animation for the sprite
sName = unique id of an already created sprite
aName = unique name for an animation
frames = frames that are used in order. example {1,2,3,6,7,8}

--draw()
will draw your sprite


-----------------------------------------------------
Once these are all setup the sprite will dispaly and animate
--------------


--tweenSprite(name,speed,tweenLoc,params)
This will tween the sprite
name = unique id of the sprite
speed = the tween speed
tweenLoc = coords to move to passed at a table. accepts x, y, rotation
params = {tween.easing.linear} etc

example - tweenSprite("test",1,{x=100,y=75,rotation=360},{tween.easing.linear})


--speed(name,speed,aniSpeed)
sets movment speed and animation speed of a sprite
name = unique id
speed = pixles to move
aniSpeed = animation delay, higher is slower



--setAnimation(sName,aName)
sets the current animation
sName = unique id name of sprite
aName = unique id name of animation

--moveTo(name,coords)
moves sprite to specific coords
name = unique id name
coords = {x=100,y=75}




















]]--
