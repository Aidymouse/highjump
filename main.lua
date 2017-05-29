Ballmeister = require 'objects/ballmeister'

function love.load()
	c_transform = 'lshift'
	c_jump = 'space'
end

function love.update(dt)

	if love.keyboard.isDown('escape') then
		love.event.quit()
	end

	Ballmeister.shape = 'square'
	if love.keyboard.isDown(c_transform) and not Ballmeister.isGrounded then
		Ballmeister.shape = 'circle'
	end

	Ballmeister:move(dt)

	Ballmeister:setGroundHeight(590)

end

function love.keypressed(k)
	if k == c_jump then
		Ballmeister.isGrounded = false
		Ballmeister.isFlying = true
		Ballmeister.yVel = -12
	end
end

function love.draw()
	love.graphics.setColor(255,255,255)
	Ballmeister:draw(Ballmeister.shape)

	love.graphics.setColor(100,100,100)
	love.graphics.rectangle('fill', 0, 590, 800, 10)

end
