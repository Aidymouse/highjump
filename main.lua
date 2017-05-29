Player = require 'objects/player'

function printDebug()
	print(Player.y.."\t"..Player.yVel)
end

function love.load()
	c_transform = 'lshift'
end

function love.update(dt)

	Player.shape = 'square'
	if love.keyboard.isDown(c_transform) and not Player.isGrounded then
		Player.shape = 'circle'
	end

	Player:move(dt)

end

function love.draw()
	Player:draw(Player.shape)


	printDebug() -- Print Debug Varaibles



end
