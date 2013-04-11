-- Houser Functions

-- Use this function to perform your initial setup
demos = {}
demo = nil

function setup()
    
    --Import a single library
import.library("StatusBar")
--Import all
    import.all()
    --download and save spritesheet
    url = "https://photos-6.dropbox.com/t/0/AACY0omsU0F8LYDwXR7mZxEgH3-b3vihB648KJoR7pS0OA/12/15163166/png/1024x768/3/1365465600/0/2/Photo%20Mar%2002%2C%207%2043%2027%20AM.png/5TJpaBrfNpTEEesndJby2Vm2w999AikliQsuZUG2rXI"
    hlib.downloadSprite("cat04082013",url)
    menuSelect = 1
    loaded = false
    currentDemo = {}
    menu = {"StatusBar","Emoji","CommonFunctions","Animation","FileIO"}
    --parameter.integer("menuSelect",1,5,menuSelect,callBack) 
   loadMenu()
    
    --currentDemo = demos.statusBar
   -- currentDemo.load()
    
end

-- This function gets called once every frame
function draw()
    background(10, 9, 9, 255)
    
    --currentDemo.draw()
    --demo:draw()
    currentDemo.draw()

end

function touched(touch)
   currentDemo.touched(touch)

end

function loadMenu()
    parameter.clear()
  parameter.integer("menuSelect",1,5,menuSelect,callBack) 
end

function callBack()
if not loaded then
    loaded = true
    output.clear()
    parameter.clear()
    loadMenu()
    --parameter.integer("menuSelect",1,5,menuSelect,callBack) 
   -- parameter.integer("menuSelect",1,5,menuSelect) 
currentDemo = nil
currentMenu = menu[menuSelect]   
currentDemo = demos[menuSelect]
currentDemo.load()
print("Demo Selected: "..menu[menuSelect]) 
loaded = false
--status Bar
   

if currentMenu == Emoji then
    parameter.integer("fSize",1,1000,100)
    moon = hlib.unicode2UTF8(127768)
end

end
end

--status Bar Demo
demos[1] = {}
demos[1].load = function()  demo = StatusBar() end
demos[1].draw = function() demo:draw() end
demos[1].touched = function(touch) demo:touched(touch) end

--Emoji Demo
demos[2] = {}
demos[2].load = function()print("Not Currently Setup")  end
demos[2].draw = function()  end
demos[2].touched = function() end

--CommonFunctions Demo
demos[3] = {}
demos[3].load = function() print("Not Currently Setup") end
demos[3].draw = function()  end
demos[3].touched = function() end

--Animations Demo
demos[4] = {}

demos[4].load = function()  
img = readImage("Documents:cat04082013")
    a = Animation(img,8,12) 
    -- create an animation class
    coord = {x=HEIGHT/2,y=WIDTH/2,rotation=0,size = vec2(1,1)} size = vec2(100,100)
a.rectScale = .70
    cat = "cat1" --add a new sprite
    a:addSprite(cat,coord,size)
    --add animations
    a:addAnimation(cat,"right",{31,32,33})
    a:addAnimation(cat,"left",{19,20,21})
    a:addAnimation(cat,"stop",{7,8,9})
    a:speed("cat1",4,4)
    --cat 2
    cat = "cat2" -- add another sprite
    a:addSprite(cat,{x=0,y=HEIGHT/2,rotation=0},size)
    a:addAnimation(cat,"right",{31,32,33}) -- add an animation
    a.spriteName["cat2"].animSpeed = 10
    
    a:scaleRect(.60)
    --tween sprite function.
    a:tweenSprite("cat2",3,{x=WIDTH,y=HEIGHT/2,rotation=0},{easing = tween.easing.linear,loop = tween.loop.forever})
end

demos[4].draw = function() 
    --draw the sprites
a:draw()
--using hlib.collision to check collision
    if hlib.collision(a.spriteName["cat2"].rectLoc,a.spriteName["cat1"].rectLoc) then 
    pushStyle()
    fill(255, 0, 0, 255)
    fontSize(36)
    text("HIT!",WIDTH/2,HEIGHT-200)
    popStyle()
     end
 end

demos[4].touched = function(touch) 
    --using the move function
if touch.state == BEGAN then
    a:moveTo("cat1",{x = touch.x,y=touch.y,rotation=0})
    end
end

--FileIO Demo
demos[5] = {}
demos[5].load = function()  print("Not Currently Setup") end
demos[5].draw = function()  end
demos[5].touched = function() end











