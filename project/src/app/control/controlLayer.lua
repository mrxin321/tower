local base = cc.Layer
 
local controlLayer = class("controlLayer", base)

function controlLayer:ctor()

	local function onTouchBegan(touch, event)
		self:onTouchBeganEvent(touch,event)
        return true
    end
    local function onTouchMoved(touch,event)
    	self:onTouchMovedEvent(touch,event)
    end
    local function onTouchEnded(touch,event)
    	self:onTouchEndedEvent(touch,event)
    end 

    local listener = cc.EventListenerTouchOneByOne:create()
    listener:registerScriptHandler(onTouchBegan,cc.Handler.EVENT_TOUCH_BEGAN)
    listener:registerScriptHandler(onTouchMoved,cc.Handler.EVENT_TOUCH_MOVED)
    listener:registerScriptHandler(onTouchEnded,cc.Handler.EVENT_TOUCH_ENDED)
    listener:setSwallowTouches(true)
    local eventDispatcher = self:getEventDispatcher()
    eventDispatcher:addEventListenerWithSceneGraphPriority(listener, self)

end

function controlLayer:onTouchBeganEvent(touch, event)
	-- print("touch began")
    self:starToMove(touch,event)
end



--开始移动
function controlLayer:starToMove(touch,event)
    self:stopScheduler()
    local role = getSceneMgGF():getScene():getRole()
    local pos = cc.p(role:getPosition())
    local touchPos = touch:getLocation()
    pprint(touchPos,"touchPos")
    pprint(pos,"rolePos")
    local angle = SSGetP2PAngle(pos,touchPos)
    print("angle:",angle)
    self:starMove(angle, endPos)
end



function controlLayer:onTouchMovedEvent(touch, event)
	-- print("touch move")
    self:starToMove(touch,event)
end

function controlLayer:onTouchEndedEvent(touch, event)
	-- print("touch ended")
    --停止定时器
    self:stopScheduler()
end

function controlLayer:stopScheduler()
    if self.schdulerId then
        cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self.schdulerId)
        self.schdulerId = nil
    end
end

--@angle 移动的角度
--@endPos 终点
function controlLayer:starMove(angle,endPos)
    local sinA = math.sin(math.rad(angle))
    local cosA = math.cos(math.rad(angle))

    local speed = getPropertyMgGF():getSpeed()
    --每秒移动的距离
    local distance = speed / 60       
        
    self.dx = distance * cosA
    self.dy = distance * sinA

    print("self.dx",self.dx)
    print("self.dy",self.dy)

    local function update(dt)
        self:updateMovePos(dt)
    end
    self:updateMovePos()
    self.schdulerId = cc.Director:getInstance():getScheduler():scheduleScriptFunc(update,0,false)

end

function controlLayer:updateMovePos(dt)
    --判断地图是否已经到达临界点
    local map = getSceneMgGF():getScene():getMap()
    local role = getSceneMgGF():getScene():getRole() 
    local mapPos = cc.p(map:getPosition())

    local scanSize = cc.Director:getInstance():getVisibleSize()
    local mapSize_  = map:getMapSize()
    local mapSize = cc.size(mapSize_.width * 32 ,mapSize_.height * 32)

    pprint(scanSize,"scanSize")
    pprint(mapSize,"mapSize")

    local minX = scanSize.width - mapSize.width
    local minY = scanSize.height - mapSize.height

    print("mapPos.x",mapPos.x,self.dx)
    print("ffffff",mapPos.x + self.dx <= minX or mapPos.x + self.dx >= 0,mapPos.x + self.dx , minX , mapPos.x + self.dx , 0)
    --x轴方向
    if mapPos.x - self.dx <= minX or mapPos.x - self.dx >= 0 then
        --移动角色
        role:setPositionX(role:getPositionX() + self.dx)
    else
        map:setPositionX(map:getPositionX() - self.dx)
    end

    print("yyyyyyy",mapPos.y + self.dy <= minY or mapPos.y + self.dy >= 0,mapPos.y + self.dy , minY , mapPos.y + self.dy , 0)
    --y轴方向
    if mapPos.y - self.dy <= minY or mapPos.y - self.dy >= 0 then
        --移动角色
        role:setPositionY(role:getPositionY() + self.dy)
    else
        map:setPositionY(map:getPositionY() - self.dy)
    end
end

--更新角色坐标
function controlLayer:updateRolePos(dt)
    local rolePos = self.role:getPosition()
    --
end

--更新地图坐标
function controlLayer:updateMapPos(dt)

end

--判断角色是否可以移动
function controlLayer:isRoleCanMove(moveDistance,endPs)
    
end





return controlLayer