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

    baseCollider = {}
        baseCollider.b = love.physics.newBody(world, width/2,height-wallHeight*wallScale/2, "static")
        baseCollider.s = love.physics.newRectangleShape(width,wallHeight*wallScale)
        baseCollider.f = love.physics.newFixture(baseCollider.b, baseCollider.s)
        baseCollider.f:setUserData("Block")
    topCollider = {}
        topCollider.b = love.physics.newBody(world, width/2,wallHeight*wallScale/2, "static")
        topCollider.s = love.physics.newRectangleShape(width,wallHeight*wallScale)
        topCollider.f = love.physics.newFixture(topCollider.b, topCollider.s)
        topCollider.f:setUserData("Block")
    leftCollider = {}
        leftCollider.b = love.physics.newBody(world, wallScale*wallWidth/2,height/2, "static")
        leftCollider.s = love.physics.newRectangleShape(wallWidth*wallScale,height)
        leftCollider.f = love.physics.newFixture(leftCollider.b, leftCollider.s)
        leftCollider.f:setUserData("Block")
    rightCollider = {}
        rightCollider.b = love.physics.newBody(world, width - wallScale*wallWidth/2,height/2, "static")
        rightCollider.s = love.physics.newRectangleShape(wallWidth*wallScale,height)
        rightCollider.f = love.physics.newFixture(rightCollider.b, rightCollider.s)
        rightCollider.f:setUserData("Block")
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
    love.graphics.polygon("line", baseCollider.b:getWorldPoints(baseCollider.s:getPoints()))
    love.graphics.polygon("line", topCollider.b:getWorldPoints(topCollider.s:getPoints()))
    love.graphics.polygon("line", leftCollider.b:getWorldPoints(leftCollider.s:getPoints()))
    love.graphics.polygon("line", topCollider.b:getWorldPoints(topCollider.s:getPoints()))

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
