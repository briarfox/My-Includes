import.libraries.StatusBar = function()
    
StatusBar = class()

function StatusBar:init()
    local sB = readProjectData("StatusBarState")
    if sB == nil then sB = 1 end
    parameter.boolean("ShowStatusBar",sB,StatusBarstatusCallBack)
    -- you can accept and set parameters here
    self.x =  readProjectData("statusBarX") or WIDTH/2
    self.y = readProjectData("statusBarY") or HEIGHT/2
    
    self.fps = FPS(-110,0)
    self.clock = Clock(0,0)
    self.mem = Memory(110,0)
    self.moving = false
    
    --parameter.action("Reset Status Bar",self:reset())
end

function StatusBar:draw()
    -- Codea does not automatically call this method
    if ShowStatusBar then 
    pushMatrix()
    translate(self.x,self.y)
    self.fps:draw()
    self.clock:draw()
    self.mem:draw() 
    popMatrix()
    end
end

function StatusBar:touched(touch)
    -- Codea does not automatically call this method
if ShowStatusBar then
    if touch.x < (self.x+165) and touch.x > (self.x-165) and touch.state == BEGAN then
       if touch.y > (self.y-15) and touch.y < (self.y+15) then
        self.moving = true
        end 
    end
    if self.moving and touch.state == MOVING then
    
        if touch.y+15<HEIGHT and touch.y-15>0 and touch.x+165<WIDTH and touch.x-165>0 then
        self.x = touch.x
        self.y = touch.y
        
        --self.fps:setPos(-110,0)
        --self.clock:setPos(0,self.y)
        --self.mem:setPos(self.x+110,self.y)
        end
    end
    
    if self.moving and touch.state == ENDED then
       self.moving = false
        saveProjectData("statusBarX",self.x)
        saveProjectData("statusBarY",self.y) 
    end
end
end

function StatusBarstatusCallBack()
    saveProjectData("StatusBarState",ShowStatusBar)
end

-------------------FPS CLASS
FPS = class()

function FPS:init(x,y)
    --parameter.integer("fpsVisible",0,1,1)
    -- you can accept and set parameters here
    self.x = x
    self.y = y
    -----
    self.val = 60
    self.t0 = ElapsedTime
    -- min fps
    self.min = 60
    self.t1 = ElapsedTime
    ------
end

function FPS:draw()

    self:update()
    --pushMatrix()
    pushStyle()
    rectMode(CENTER)
    strokeWidth(0)
    fill(102, 108, 104, 193)
    --translate(self.x,self.y)
    rect(self.x,self.y,110,30)
    textMode(CENTER)
    font("Optima-Regular")
    fontSize(16)
    fill(213, 215, 219, 255)
    text("FPS: "..self.FPS,self.x,self.y)
    
    popStyle()
    --popMatrix()
    
    -- Codea does not automatically call this method
end

function FPS:touched(touch)
    -- Codea does not automatically call this method
end

function FPS:update()
    -- update FPS value with some smoothing
    local old = self.val
    local frac = 0.1
    local delta = DeltaTime
    local new = 1/delta or old
    if new<self.min then self.min=new; self.t1=ElapsedTime+1 end
    if self.t1<ElapsedTime then self.min=60 end
    new = old*(1-frac)+ new*frac
    self.val = new

    -- write the FPS on the screen
    local txt = tostring(math.floor(new)).." (> "..tostring(math.floor(self.min))..")"
    self.FPS = txt
end

function FPS:setPos(x,y)
    self.x = x
    self.y = y 
end

------CLOCK CLASS

Clock = class()

function Clock:init(x,y)
    -- you can accept and set parameters here
    --parameter.integer("fpsVisible",0,1,1)
    -- you can accept and set parameters here
    self.x = x
    self.y = y
    self.time = self:update()
end

function Clock:draw()
    -- Codea does not automatically call this method
    
    pushStyle()
    rectMode(CENTER)
    strokeWidth(0)
    fill(102, 108, 104, 193)
    rect(self.x,self.y,110,30)
    textMode(CENTER)
    font("Optima-Regular")
    fontSize(16)
    fill(213, 215, 219, 255)
    text(self.time,self.x,self.y)
    
    popStyle()
    
end

function Clock:touched(touch)
    -- Codea does not automatically call this method
end

function Clock:update()
    local t = os.date("*t")
    local txt
    if t.min < 10 then txt = tostring(t.hour)..":0"..tostring(t.min)
    else txt = tostring(t.hour)..":"..tostring(t.min)
    end
    return txt
end

function Clock:setPos(x,y)
    self.x = x
    self.y = y 
end

-----Memory Class
Memory = class()

function Memory:init(x,y)
    -- you can accept and set parameters here
    self.x = x
    self.y = y
    --self.x = x
     self.kb = 0
    self.txt = ""
end

function Memory:draw()
    self:update()
    pushStyle()
    rectMode(CENTER)
    strokeWidth(0)
    fill(102, 108, 104, 193)
    rect(self.x,self.y,110,30)
    textMode(CENTER)
    font("Optima-Regular")
    fontSize(16)
    fill(213, 215, 219, 255)
    text("Mem: "..self.txt,self.x,self.y)
    
    popStyle()
    -- Codea does not automatically call this method
end

function Memory:touched(touch)
    -- Codea does not automatically call this method
end

--local floor = math.floor
function Memory:update()
    local kb = gcinfo()
    kb = math.floor(kb/10)*10
    if kb ~= self.kb then
        self.txt = tostring(kb).." kb"
        self.kb = kb
    end
    return self.txt
end

function Memory:setPos(x,y)
    self.x = x
    self.y = y 
end


















end




