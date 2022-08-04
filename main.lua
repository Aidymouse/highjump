Ballmeister = require 'objects/ballmeister'



function love.load()

	platforms = {
		{x=0, y=200, width=100, height=love.graphics.getHeight()-200},
		{x=0, y=500, width=love.graphics.getWidth(), height=love.graphics.getHeight()-500},
	}

end

function love.update(dt)

	if love.keyboard.isDown('escape') then
		love.event.quit()
	end

	Ballmeister:update(dt, platforms)

end

function love.keypressed(k)
end

function love.draw()

	Ballmeister:draw()

	for k, v in ipairs(platforms) do

		love.graphics.rectangle("line", v.x, v.y, v.width, v.height)

	end

end
