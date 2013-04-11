--Use hlib.help.info() for the in game help file

--Help File
hlib.help.info = function()
    output.clear()
 print("Houser Library Help File")
print("use import.library(name) to import\nOr use import.all()")
print("please select a library")
print(".CommonFunctions\n.FileIO\n.StatusBar\n.Animation\n.Button")

--print("counter(_+-)\ndump(table,indent)\ndebug(state,str)\ndebugf(state,function,params)\ndebugd(state,table,indent)\nunicode2UTF8(unicode)")
end

hlib.help.CommonFunctions = function()
    output.clear()
print("CommonFunction Library")    
print([[hlib.counter(_+-)
hlib.dump(table,indent)
hlib.debug(state,str)
hlib.debugf(state,function,params)
hlib.debugd(state,table,indent)
hlib.unicode2UTF8(unicode)
hlib.collision(rectA,rectB)
]])

end

hlib.help.StatusBar = function()
    output.clear()
   print("StatusBar Library") 
print([[--Setup StatusBar--
var=StatusBar()
var:draw()
var:touched(touch)]])
print([[--Individual setup--
--FPS
var = FPS(x,y)
var:draw()
var:setPos(x,y)
--Clock
var = Clock(x,y)
var:draw()
var:setPos(x,y)
--Memory
var = Memory(x,y)
var:draw()
var:setPos(x,y)
]]) 
end

hlib.help.Animation = function()
 output.clear()   
print([[--Animation Library--
--Add a sprite Sheet
var = Animation(spritesheet,Rows,columns)
--add a single sprite from the sheet
var:addSprite(name,screenCoords,pixelSize)
--Add animation frames to sprite
var:addAnimation(sprite's Name,Animation Name,Frames{})
    
]])    
    
end






