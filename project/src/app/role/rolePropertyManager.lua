--角色属性管理器
local base = cc.Node

local rolePropertyManager = class("rolePropertyManager", base)

local instance = nil

function rolePropertyManager:getInstance()
	if not instance then
		instance = rolePropertyManager.new()
		instance:retain()
	end
	return instance
end

function rolePropertyManager:ctor()
	--从本地储存的信息初始化角色属性
end

--获取角色移动速度   
--@return 100/s
function rolePropertyManager:getSpeed()
	return 1000
end

return rolePropertyManager