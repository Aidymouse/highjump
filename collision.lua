collision = {}

function collision.AABB(rect1, rect2)
    
    -- Returns data to move rect1 out of rect2 (shortest path)
    if rect1.x < rect2.x + rect2.width and rect1.x + rect1.width > rect2.x and
    rect1.y < rect2.y + rect2.height and rect1.y + rect1.height > rect2.y then


        leftPush = rect2.x - rect1.width - rect1.x
        rightPush = rect2.x + rect2.width - rect1.x

        sH = 0

        if math.abs(leftPush) < math.abs(rightPush) then
            sH = leftPush
        else
            sH = rightPush
        end

        upPush = rect2.y - rect1.height - rect1.y
        downPush = rect2.y + rect2.height - rect1.y

        sV = 0;
        if math.abs(upPush) < math.abs(downPush) then
            sV = upPush
        else
            sV = downPush
        end

        return {
            collided = true,
            shortestHoriz = sH,
            shortestVert = sV,
        }

    end

    return {
        collided = false
    }

end



return collision