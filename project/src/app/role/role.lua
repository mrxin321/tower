local pNode = cc.Sprite

local role = class("role", pNode)

function role:ctor(roleType,x,y,status)
	print("status:",x,y,status)

	self:setPosition(cc.p(x,y))

	self:setTexture("hero/role.png")
	self:runStatusAnim()
end

function role:runStatusAnim(statusId)
end

return role