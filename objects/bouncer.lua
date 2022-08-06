Collider = require 'objects.collider'

Bouncer = Collider:New("bouncer")


function Bouncer:New(x, y, radius, strength)
    local bouncer = Collider:New("bouncer")
    
    bouncer.x = x or 0
    bouncer.y = y or 0
    bouncer.radius = radius or 50
    bouncer.strength = strength or 100
    
    setmetatable(bouncer, self)
    self.__index = self
    

    return bouncer
end

function Bouncer:handleCollision()
end

function Bouncer:draw()

    love.graphics.setColor(1, 0, 0)

    love.graphics.circle('line', self.x, self.y, self.radius)

    love.graphics.setColor(1, 1, 1)
end

return Bouncer
