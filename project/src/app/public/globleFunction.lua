

-- --播放一次性动画
-- function playAniamationOnce(target,fileName,startFrame,endFrame,callback,x,y,isRemove_)
-- 	local isRemove = true
-- 	if isRemove_ == false then
-- 		isRemove = false
-- 	end
-- 	print("=============fileName",fileName)
-- 	print("--------------s e frame",startFrame,endFrame)
-- 	local node = cc.CSLoader:createNode(fileName)
--     local action = cc.CSLoader:createTimeline(fileName)
--     node:runAction(action)
--     action:gotoFrameAndPlay(startFrame,endFrame,false)

--     node:setPosition(x,y)
--     target:addChild(node)
    
-- 	print("===============callback1")
-- 	local function onFrameEvent(frame)
-- 		print("===============callback2")
-- 		if isRemove then
-- 			node:removeFromParent()
-- 		end
-- 		if callback ~= nil then
-- 			callback()
-- 		end
    	
-- 	end
-- 	action:setFrameEventCallFunc(onFrameEvent)
     
-- end

-- --播放永久性动画
-- function playAniamationForever(target,fileName,startFrame,endFrame,x,y)
-- 	print("=============fileName",fileName)
-- 	print("--------------s e frame",startFrame,endFrame)
-- 	local node = cc.CSLoader:createNode(fileName)
--     local action = cc.CSLoader:createTimeline(fileName)
--     node:runAction(action)
--     action:gotoFrameAndPlay(startFrame,endFrame,true)
--     node:setPosition(x,y)
--     target:addChild(node)
--     return node
-- end

function getSceneMgGF()
	return require("app.scene.sceneManager"):getInstance()
end

function getPropertyMgGF()
	return require("app.role.rolePropertyManager"):getInstance()
end

function SSGetP2PAngle(bPos, ePos)
	local function D2R(angle)
		return angle/180*3.1415926
	end
	local function R2D(angle)
		return angle/3.1415926*180
	end

	local delta = cc.pSub(ePos, bPos)
	local angle = 0
	if delta.x == 0 then
		if delta.y > 0 then
			angle = 90
		elseif delta.y < 0 then
			angle = 270
		end
	else
		angle = R2D(math.atan(delta.y/delta.x))
	end

	if delta.x < 0 then
		angle = angle + 180
	end

	if angle < 0 then angle = angle + 360 end
	return angle,D2R(angle)
end