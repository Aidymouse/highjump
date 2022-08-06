Collider = {}

function Collider:New(collisionType)
    local c = {
        collisionType = collisionType
    }

    setmetatable(c, self)
    self.__index = self

    return c
end

function Collider:draw()
    print("Draw is not yet implemented")
end

return Collider