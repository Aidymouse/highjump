Ballmeister = require 'objects/ballmeister'

function love.load()
	c_transform = 'lshift'
	c_jump = 'space'

	c_left = 'left'
end

function love.update(dt)

	if love.keyboard.isDown('escape') then
		love.event.quit()
	end

	if love.keyboard.isDown(c_left) then

	end

	Ballmeister:move(dt)	

	Ballmeister.shape = 'square'
	if love.keyboard.isDown(c_transform) then
		Ballmeister.shape = 'circle'
	end




	if Ballmeister.x < 100 then 
		Ballmeister:setGroundHeight(200)
	else
		Ballmeister:setGroundHeight(590)
	end


end

function love.keypressed(k)
	if k == c_jump then
		Ballmeister:jump()
	end
end

function love.draw()
	love.graphics.setColor(255,255,255)
	love.graphics.rectangle('line', 10-5, 100-5, 10, 10)
	Ballmeister:draw(Ballmeister.shape)

	love.graphics.rectangle('line', 0, 200, 100, 400)

	love.graphics.setColor(100,100,100)
	love.graphics.rectangle('fill', 0, 590, 800, 10)

end
