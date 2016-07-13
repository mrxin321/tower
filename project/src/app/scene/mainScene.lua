local base = require("app.scene.baseScene")

local mainScene = class("mainScene", base)

function mainScene:ctor()
	self.super.ctor(self)
	--加载地图层
	local  map = cc.TMXTiledMap:create("map/test.tmx")
	self.map = map
	self:getMapLayer():addChild(map)
	--加载角色
	local role = require("app.role.role"):create(1,320,480,1)
	self:getRoleLayer():addChild(role)
	self.role = role
	--加载控制层
	self:getGestureLayer():addChild(require("app.control.controlLayer"):create())
end

function mainScene:getRole()
	return self.role
end

function mainScene:getMap()
	return self.map
end

function mainScene:getPreLodingRes()
end

return mainScene