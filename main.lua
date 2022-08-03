Ballmeister = require 'objects/ballmeister'



function love.load()

end

function love.update(dt)

	if love.keyboard.isDown('escape') then
		love.event.quit()
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
	Ballmeister:draw()

	love.graphics.rectangle('line', 0, 200, 100, 400)

	love.graphics.setColor(100,100,100)
	love.graphics.rectangle('fill', 0, 590, 800, 10)

end
