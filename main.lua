Ballmeister = require 'objects.ballmeister'
Platforms = require 'objects.platform'
Bouncers = require 'objects.bouncer'


function love.load()

	colliders = {
		Platforms:New(100, 200, 100, love.graphics.getHeight()-200),
		Platforms:New(400, 500, 100, 50, "bouncepad"),
		Platforms:New(0, 500, love.graphics.getWidth(), love.graphics.getHeight()-500),

		Bouncer:New(300, 300, 50, 600)
	}

end

function love.update(dt)

	if love.keyboard.isDown('escape') then
		love.event.quit()
	end

	Ballmeister:update(dt, colliders)

end

function love.keypressed(k)
	Ballmeister:keypressed(k)
end

function love.mousepressed(x, y)
	table.insert(colliders, Bouncer:New(x, y, 50, 600))
end

function love.draw()

	Ballmeister:draw()

	for k, v in ipairs(colliders) do

		v:draw()

	end

end
