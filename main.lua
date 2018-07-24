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
    daveRight = love.graphics.newImage("images/dave1.png")
    daveLeft = love.graphics.newImage("images/dave5.png")
    daveRightJump = love.graphics.newImage("images/dave4.png")
    daveLeftJump = love.graphics.newImage("images/dave7.png")
    daveRightWalk = love.graphics.newImage("images/dave3.png")
    daveLeftWalk = love.graphics.newImage("images/dave6.png")

    davePic = daveRight
    face = "right"
    l=0
    r=0
    onGround = true
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
function love.update(dt)
    world:update(dt)
    if love.keyboard.isDown("right") then
        face = "right"
        if onGround then
            if davePic == daveRightWalk then
                if r<5 then r=r+1
                else
                   r=0
                    davePic = daveRight
                end
            elseif davePic == daveRight then
                if r<5 then r=r+1
                else
                    r=0
                    davePic = daveRightWalk
                end
            else
                davePic = daveRight 
            end
        else
            davePic = daveRightJump
        end
        daveCollider.b:setX(daveCollider.b:getX()+velocity*dt)
    end
    if love.keyboard.isDown("left") then
        face = "left"
        if onGround then
            if l<5 then l=l+1
            else
                l=0
                if davePic == daveLeftWalk then
                    davePic = daveLeft
                else
                    davePic = daveLeftWalk
                end
            end
        else
            davePic = daveLeftJump
        end
        daveCollider.b:setX(daveCollider.b:getX()-velocity*dt)
    end
    if love.keyboard.isDown("up") then
        if onGround then
            daveCollider.b:applyForce(0,-50000)
        end
    end
    if face == "right" then
    else
        
    end
end
function love.draw()
    love.graphics.draw(davePic, daveCollider.b:getX()-daveWidth/2,daveCollider.b:getY()-daveHeight/2, 0,daveScale,daveScale,0,0)
    for x = 0 , width/(wallScale*wallWidth) do
        love.graphics.draw(wall,x*wallScale*wallWidth,0,0,wallScale,wallScale,0,0)
        love.graphics.draw(wall,x*wallScale*wallWidth,height-wallScale*wallHeight,0,wallScale,wallScale,0,0)
    end
    for x = 1 , (height/(wallScale*wallHeight))-1 do
        love.graphics.draw(wall,0,x*wallHeight*wallScale,0,wallScale,wallScale,0,0)
        love.graphics.draw(wall,width-wallScale*wallWidth,x*wallHeight*wallScale,0,wallScale,wallScale,0,0)
    end

end
function beginContact(a, b, coll)
    if (a==daveCollider.f and b == baseCollider.f) or (b==daveCollider.f and a == baseCollider.f) then
        print("on ground")
        onGround = true
        if(face == "right")then
            davePic = daveRight
        else
            davePic = daveLeft
        end
    end
end
function endContact(a, b, coll)
    if (a==daveCollider.f and b == baseCollider.f) or (b==daveCollider.f and a == baseCollider.f) then
        print("in air")
        onGround = false
        if(face == "right")then
            davePic = daveRightJump
        else
            davePic = daveLeftJump
        end
    end
end
function preSolve(a, b, coll)
end
function postSolve(a, b, coll, normalimpulse, tangentimpulse)
end
