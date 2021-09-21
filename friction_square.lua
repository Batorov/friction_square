FrictionSquare = {}
FrictionSquare.__index = FrictionSquare

function FrictionSquare:create (x,y,width,height,friction,color)
    local friction_square = {}
    setmetatable(friction_square, FrictionSquare)
    friction_square.x = x
    friction_square.y = y
    friction_square.width = width
    friction_square.height = height
    friction_square.friction = friction
    friction_square.color = color
    return friction_square
end 

function FrictionSquare:draw()
    local r, g, b, a = love.graphics.getColor()
    love.graphics.setColor(0, self.color.r, self.color.g, self.color.b)
    --love.graphics.rectangle("fill", self.x, self.y, self.w, self.h)
    love.graphics.rectangle("fill", self.x, self.y, self.x+self.width, self.y+self.height)
    love.graphics.setColor(r, g, b, a)
    love.graphics.print("coefficient: " .. tostring(self.friction), self.x+self.width/2, self.y+self.height/2)
end