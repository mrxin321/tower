
cc.FileUtils:getInstance():setPopupNotify(false)
cc.FileUtils:getInstance():addSearchPath("src/")
cc.FileUtils:getInstance():addSearchPath("res/")

require "config"
require "cocos.init"

local function main()
    require("app.public.public")

	cc.Director:getInstance():setDisplayStats(true)

    -- require("app.MyApp"):create():run()
    local scene = cc.Scene:create()
    cc.Director:getInstance():runWithScene(scene)

    -- local  map = cc.TMXTiledMap:create("map/test.tmx")
    -- scene:addChild(map)

    -- local label = cc.Label:create()
    -- label:setString("Hello World")
    -- label:setSystemFontSize(32)
    -- label:setPosition(cc.p(320,480))
    -- scene:addChild(label)
    local a1,a2 = SSGetP2PAngle(cc.p(0,0),cc.p(-1,1))
    print("a1:",a1)
    print("a2:",a2)
    require("app.scene.sceneManager"):getInstance():runScene("mainScene")
   
    
end

local status, msg = xpcall(main, __G__TRACKBACK__)
if not status then
    print(msg)
end
