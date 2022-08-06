Collider = require 'objects.collider'
Platform = Collider:New()

enum_platformTypes = {
    NORMAL = "normal",
    BOUNCEPAD = "bouncepad"
}

function Platform:New(x, y, width, height, type)
    local platform = Collider:New("platform")

    platform.x = x or 0
    platform.y = y or 0
    platform.width = width or 100
    platform.height = height or 100
    platform.type = type or enum_platformTypes.NORMAL
    
    setmetatable(platform, self)
    self.__index = self
    
    return platform
end

function Platform:handleCollision()
end

function Platform:draw()

    if self.type == enum_platformTypes.BOUNCEPAD then
        love.graphics.setColor(0, 1, 0)
    end

    love.graphics.rectangle('line', self.x, self.y, self.width, self.height)

    love.graphics.setColor(1, 1, 1)
end

return Platform