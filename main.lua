function love.load()
    world = love.physics.newWorld(0, 1000, true)
    world:setCallbacks(beginContact, endContact, preSolve, postSolve)
    width = 1270
    height = 720
    velocity = 400
    love.window.setMode(width , height)
    
    wall = love.graphics.newImage("images/redTile.png")
    wallWidth = wall:getWidth()
    wallHeight = wall:getHeight()
    wallScale = 2

    davePic = love.graphics.newImage("images/dave1.png")
    daveScale = 2
    daveWidth = davePic:getWidth()*daveScale
    daveHeight = davePic:getHeight()*daveScale

    static = {}
        static.b = love.physics.newBody(world, width/2,height-wallHeight*wallScale/2, "static")
        static.s = love.physics.newRectangleShape(width,wallHeight*wallScale)
        static.f = love.physics.newFixture(static.b, static.s)
        static.f:setUserData("Block")
    box = {}
        box.b = love.physics.newBody(world, width/2,height-wallHeight*wallScale/2, "static")
        box.s = love.physics.newRectangleShape(width,wallHeight*wallScale)
        box.f = love.physics.newFixture(static.b, static.s)
        box.f:setUserData("Block")
    daveCollider = {}
        daveCollider.b = love.physics.newBody(world, 400,500, "dynamic")
        daveCollider.b:setMass(10)
        daveCollider.s = love.physics.newRectangleShape(daveWidth,daveHeight)
        daveCollider.f = love.physics.newFixture(daveCollider.b, daveCollider.s)
        daveCollider.f:setRestitution(0)    -- make it bouncy
        daveCollider.f:setUserData("Dave")
end
up =false
right = false
left = false
function love.update(dt)
    world:update(dt)
    if up==true then
    	if touch == 1 then
    		touch = 0
        	daveCollider.b:applyForce(0,-51000)
        end
    end
    if right==true then
        daveCollider.b:setX(daveCollider.b:getX()+velocity*dt)
    end
    if left==true then
        daveCollider.b:setX(daveCollider.b:getX()-velocity*dt)
    end
end

function love.keypressed( key )
   if key == "up" then
      up = true
   end
   if key == "right" then
      right = true
   end
   if key == "left" then
      left = true
   end
end

function love.keyreleased( key )
      if key == "up" then
      up = false
   end
   if key == "right" then
      right = false
   end
   if key == "left" then
      left = false
   end
end

function love.draw()
    --love.graphics.polygon("line", daveCollider.b:getWorldPoints(daveCollider.s:getPoints()))
    love.graphics.draw(davePic, daveCollider.b:getX()-daveWidth/2,daveCollider.b:getY()-daveHeight/2, 0,daveScale,daveScale,0,0)
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
function beginContact(a, b, coll)
end
function endContact(a, b, coll)
end
function preSolve(a, b, coll)
end
function postSolve(a, b, coll, normalimpulse, tangentimpulse)
	touch =1
end
