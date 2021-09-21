require("vector")
require("mover")
require("friction_square")

function love.load()
   width = love.graphics.getWidth()
   height = love.graphics.getHeight()
   love.graphics.setBackgroundColor(128/255, 128/255, 128/255)

   location = Vector:create(width/4, 0)
   velocity = Vector:create(0,0)
   mover=Mover:create(location, velocity)
   location = Vector:create(width - width/4, 0)
   wmover = Mover:create (location, velocity)
   --wmover.size = 20
   friction_squares = {}
   friction_squares[#friction_squares+1] = FrictionSquare:create(0,0,400,300,0.005,{r=119/255, g=190/255, b=0.5})
   friction_squares[#friction_squares+1] = FrictionSquare:create(400,0,400,600,-0.005,{r=119/255, g=0.3, b=0.5})
   friction_squares[#friction_squares+1] = FrictionSquare:create(0,300,400,300,-0.005,{r=119/255, g=0.3, b=0.7})
   wind = Vector:create(0.01, 0)
   isWind=false
   gravity = Vector:create(0, 0.01)
   isGravity = true
   floating = Vector:create(0, -0.02)
   isFloating=false
    
end

function love.draw()
    
    for key, fs in pairs(friction_squares) do
        fs:draw()
    end
    mover:draw()
    wmover:draw()

    
    love.graphics.print(tostring(wmover.velocity), wmover.location.x+20, wmover.location.y)

    love.graphics.print(tostring(mover.velocity), mover.location.x+20, mover.location.y)
    love.graphics.print("w:" .. tostring(isWind) .." g: " .. tostring(isGravity) .. " f: " ..tostring(isFloating))
end

function love.update()
    if isGravity then 
        mover:applyForce(gravity)
    end
    if isWind then 
        mover:applyForce(wind)
    end
    if isFloating then 
        mover:applyForce(floating)
    end
    if isGravity then 
        wmover:applyForce(gravity)
    end
    if isWind then 
        wmover:applyForce(wind)
    end
    if isFloating then 
        wmover:applyForce(floating)
    end
    --mover:applyForce(gravity)
    --wmover:applyForce(gravity)
    --mover:applyForce(wind)
    --wmover:applyForce(wind)
    for key, fs in pairs(friction_squares) do
        if mover.location.x > fs.x and mover.location.y > fs.y and mover.location.x < fs.x + fs.width and mover.location.y < fs.y + fs.height then
            friction = mover.velocity:norm()
                if friction then 
                    friction:mul(fs.friction)
                    mover:applyForce(friction)
                    --wmover:applyForce(friction)
                end
        end
        if wmover.location.x > fs.x and wmover.location.y > fs.y and wmover.location.x < fs.x + fs.width and wmover.location.y < fs.y + fs.height then
            friction = wmover.velocity:norm()
                if friction then 
                    friction:mul(fs.friction)
                    wmover:applyForce(friction)
                    --wmover:applyForce(friction)
                end
        end
    end

    mover:update()
    mover:checkBoundaries()

    
    wmover:update()
    wmover:checkBoundaries()
end

function love.keypressed(key)
    if key == 'g' then
        isGravity=not isGravity
    end

    if key == 'f' then
        isFloating = not isFloating
    end
    if key=='w' then
        isWind= not isWind
        if isWind then
            wind = wind*-1
        end
    end
end
