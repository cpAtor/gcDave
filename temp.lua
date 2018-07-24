width = 1270
height = 720
velocity = 100
love.window.setMode(width , height)
wall = love.graphics.newImage("images/redTile.png")
davePic = love.graphics.newImage("images/dave1.png")
-- wallWidth = wall:getWidth()
-- wallHeight = wall:getHeight()
-- wallScale = 1.5

-- function love.draw()
--     for x = 0 , width/(wallScale*wallWidth) do
--         love.graphics.draw(wall,x*wallScale*wallWidth,0,0,wallScale,wallScale,0,0)
--         love.graphics.draw(wall,x*wallScale*wallWidth,height-wallScale*wallHeight,0,wallScale,wallScale,0,0)
--     end
--     for x = 1 , (height/(wallScale*wallHeight))-1 do
--         love.graphics.draw(wall,0,x*wallHeight*wallScale,0,wallScale,wallScale,0,0)
--         love.graphics.draw(wall,width-wallScale*wallWidth,x*wallHeight*wallScale,0,wallScale,wallScale,0,0)
--     end
-- end
--hello
function love.load()
	love.graphics.setBackgroundColor( 1, 0, 1 )
    world = love.physics.newWorld(0, 100, true)
        world:setCallbacks(beginContact, endContact, preSolve, postSolve)
 
    ball = {}
        ball.b = love.physics.newBody(world, 400,200, "dynamic")
        ball.b:setMass(100)
        ball.s = love.physics.newRectangleShape(24,24)
        ball.f = love.physics.newFixture(ball.b, ball.s)
        ball.f:setRestitution(0)    -- make it bouncy
        ball.f:setUserData("Ball")
    static = {}
        static.b = love.physics.newBody(world, 400,400, "static")
        static.s = love.physics.newRectangleShape(240,48)
        static.f = love.physics.newFixture(static.b, static.s)
        static.f:setUserData("Block")
 
    text       = ""   -- we'll use this to put info text on the screen later
    persisting = 0    -- we'll use this to store the state of repeated callback calls
end
 
function love.update(dt)
    world:update(dt)
    if love.keyboard.isDown("up") then
    	if touch ==1 then
    		touch =0
        	ball.b:applyForce(0,-5000)
        end
    elseif love.keyboard.isDown("right") then
        ball.b:setX(ball.b:getX()+velocity*dt)
    elseif love.keyboard.isDown("left") then
        ball.b:setX(ball.b:getX()-velocity*dt)
    end
 
    if string.len(text) > 768 then    -- cleanup when 'text' gets too long
        text = ""
    end
end
 
function love.draw()
	love.graphics.draw(dave, ball.b:getX()-12,ball.b:getY()-12, 0,1,1,0,0)
    love.graphics.draw(wall, static.b:getX()-120,static.b:getY()-24, 0,10,2,0,0)
    
 
    love.graphics.print(text, 10, 10)
end
 
function beginContact(a, b, coll)
    x,y = coll:getNormal()
    text = text.."\n"..a:getUserData().." colliding with "..b:getUserData().." with a vector normal of: "..x..", "..y
end
 
function endContact(a, b, coll)
    persisting = 0
    text = text.."\n"..a:getUserData().." uncolliding with "..b:getUserData()
end
 
function preSolve(a, b, coll)
    if persisting == 0 then    -- only say when they first start touching
        text = text.."\n"..a:getUserData().." touching "..b:getUserData()
    elseif persisting < 20 then    -- then just start counting
        text = text.." "..persisting
    end
    persisting = persisting + 1    -- keep track of how many updates they've been touching for
end
 
function postSolve(a, b, coll, normalimpulse, tangentimpulse)
	touch =1
end