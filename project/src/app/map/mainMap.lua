local base = cc.TMXTiledMap
 
MAP_SIZE_WIDTH   = 38
MAP_SIZE_HEIGHT  = 38

TILE_SIZE_WIDTH  = 32
TILE_SIZE_HEIGHT = 32

local mapLayer = class("mapLayer", base)

function mapLayer:ctor(name)
	print("name",name)
	self:initWithTMXFile(name)
	-- local  map = cc.TMXTiledMap:create("map/test.tmx")
	-- self.map = map
	-- self:addChild(map)
end

function mapLayer:getMap()
	return self.map
end

function mapLayer:create(name)
	print("···",name)
	return mapLayer.new(name)
end

function mapLayer:isBlock(pos)
	local blockLayer = self.map:getLayer("block") 
	local tile = blockLayer:getTileGIDAt(self:getTilePos(pos))
	local properties = map:getPropertiesForGID(tile)
	if properies.isblock == "1" then
		return true
	end
	return false
end


--获取格子坐标
function mapLayer:getTilePos(pos)
	local x = math.floor(pos.x / TILE_SIZE_WIDTH)
	local y = math.floor(pos.y / TILE_SIZE_HEIGHT)
	return cc.p(x,y)
end

return mapLayer