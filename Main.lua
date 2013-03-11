-- TAP SCREEN TO CHANGE ANIMATION
DEBUG = true
-- Use this function to perform your initial setup
function setup()
    displayMode(FULLSCREEN)
    print("Demo animation")
    toggle = false
    --call this for function info when used as a library

    img = readImage("Dropbox:cats")
    a = Animation(img,8,12)
    
    coord = vec2(100,HEIGHT/2,0)
     size = vec2(100,100)

    cat = "cat1"
    a:addSprite(cat,coord,size)
    a:addAnimation(cat,"right",{24,23,22})
    a:addAnimation(cat,"left",{36,35,34})
    a:addAnimation(cat,"stop",{48,47,46})
    a:speed("cat1",4,4)
    
    
    --cat 2
    cat = "cat2"
    a:addSprite(cat,{x=900,y=HEIGHT/2},size)
    a:addAnimation(cat,"right",{21,20,19})
    a:addAnimation(cat,"left",{33,32,31})
    a:addAnimation(cat,"stop",{45,44,43})
    a.spriteName["cat2"].animSpeed = 10
    

    
end

-- This function gets called once every frame
function draw()
    -- This sets a dark background color 
    background(0, 0, 0, 255)
    a:draw()
    -- This sets the line thickness
    strokeWidth(5)

    -- Do your drawing here
    
end

function touched(touch)

    if touch.state == ENDED then
        --local loc = a.spriteName["cat1"].moveCoords
        --tween(1,loc,{x=100,y=100},tween.easing.linear)
    --a.spriteName["cat1"].moveCoords = loc
    --a:moveTo("cat1",loc)
    --local tweenLoc = a:getLoc()
    
    a:moveTo("cat1",{x = touch.x,y=touch.y,rotation=0})
    a:tweenSprite("cat2",1,{x=touch.x,y=touch.y,rotation=360},{tween.easing.linear})
    end
end

