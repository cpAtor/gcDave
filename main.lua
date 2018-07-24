function love.load()
    world = love.physics.newWorld(0, 200, true)
        world:setCallbacks(beginContact, endContact, preSolve, postSolve)
    width = 1270
    height = 720
    love.window.setMode(width , height)
    
    wall = love.graphics.newImage("images/redTile.png")
    wallWidth = wall:getWidth()
    wallHeight = wall:getHeight()
    wallScale = 1.5

    dave = love.graphics.newImage("images/dave1.png")
    daveWidth = dave:getWidth()
    daveHeight = dave:getHeight()

    static = {}
        static.b = love.physics.newBody(world, width/2,height-wallHeight*wallScale/2, "static")
        static.s = love.physics.newRectangleShape(width,wallHeight*wallScale)
        static.f = love.physics.newFixture(static.b, static.s)
        static.f:setUserData("Block")
    daveCollider = {}
        daveCollider.b = love.physics.newBody(world, 400,200, "dynamic")
        daveCollider.b:setMass(10)
        daveCollider.s = love.physics.newRectangleShape(daveWidth,daveHeight)
        daveCollider.f = love.physics.newFixture(daveCollider.b, daveCollider.s)
        daveCollider.f:setRestitution(0)    -- make it bouncy
        daveCollider.f:setUserData("daveCollider")
end

function love.update(dt)
    world:update(dt)
end

function love.draw()
    love.graphics.polygon("line", daveCollider.b:getWorldPoints(daveCollider.s:getPoints()))
    love.graphics.draw(dave,daveCollider.b:getX(),daveCollider.b:getX(),0 ,1 , 1 , 0 , 0)
    for x = 0 , width/(wallScale*wallWidth) do
        love.graphics.draw(wall,x*wallScale*wallWidth,0,0,wallScale,wallScale,0,0)
        love.graphics.draw(wall,x*wallScale*wallWidth,height-wallScale*wallHeight,0,wallScale,wallScale,0,0)
    end
    for x = 1 , (height/(wallScale*wallHeight))-1 do
        love.graphics.draw(wall,0,x*wallHeight*wallScale,0,wallScale,wallScale,0,0)
        love.graphics.draw(wall,width-wallScale*wallWidth,x*wallHeight*wallScale,0,wallScale,wallScale,0,0)
    end
    love.graphics.polygon("line", static.b:getWorldPoints(static.s:getPoints()))
end
