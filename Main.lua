-- TAP SCREEN TO CHANGE ANIMATION
local DEBUG = false
-- Use this function to perform your initial setup
function setup()
    
    sUrl = "http://baptizeacat.com/CCAT047_1_1.png"
    
    --IO test
    url = "https://dl.dropbox.com/s/67pbwwj88w6a2ib/cats.csv?token_hash=AAF5K7DdyJCsLCIMuFM9OcvE_6eDAh3HeopHzsetaiipCg&dl=1"
    --downloadSprite("testCat", sUrl,url)
    --downloadAnimation("testCat",url)
    local t = {"chris","Kristin","Cigan","Baby"}
    
    str = readProjectData("testCatcsv")
    print(str)

    --saveLocalData("test",t)
    --srt = getFile(url)
    --txt = readCSV(srt)
    --dump(txt,"--")
    
    
    ---------------
    --Backup Function
    version = 0.1
    b = Backup("Houser Library v"..version)
    ----------
    displayMode(FULLSCREEN)
    print("Demo animation")
    toggle = false
    --call this for function info when used as a library

    img = readImage("Dropbox:cats")
    a = Animation(img,8,12)

    
    coord = {x=HEIGHT/2,y=WIDTH/2,rotation=0,size = vec2(1,1)}
     size = vec2(100,100)
    a:spriteFromFile("testCat",{x=100,y=400,rotation=0,size=vec2(1,1)},size)


    cat = "cat1"
    a:addSprite(cat,coord,size)
    a:addAnimation(cat,"right",{31,32,33})
    a:addAnimation(cat,"left",{19,20,21})
    a:addAnimation(cat,"stop",{7,8,9})
    a:speed("cat1",4,4)
    
    
    --cat 2
    cat = "cat2"
    a:addSprite(cat,{x=900,y=HEIGHT/2,rotation=0},size)
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
    a:moveTo("testCat",{x = touch.x,y=touch.y,rotation=0})
    a:tweenSprite("cat2",1,{x=touch.x,y=touch.y,rotation=360},{tween.easing.linear})
    end
end

