Ballmeister = {
	y = 100,
	x = 10,
	w = 10,
	h = 10,
	r = 5,
	xVel = 0,
	yVel = 0,
	gravity = 10,
	falling = "down",
	shape = "square",
	speed = 200,
	isGrounded = false,
	isFlying = true,
	friction = 20,
	groundY = 590
}

function Ballmeister:draw(shape)
	local Shape = shape or 'square'

	if Shape == 'square' then
		love.graphics.rectangle('fill', self.x-5, self.y-5, self.w, self.h)
	else
		love.graphics.circle('fill', self.x, self.y, self.r)
	end
end

function Ballmeister:move(dt)
	if self.isFlying then
		
		self.y = self.y + self.yVel
		self.yVel = self.yVel + (dt * self.gravity)

		if self.y + 5 >= self.groundY then

			self.y = self.groundY - 5

			if -(self.yVel-2) > 1 then
				self.shape = "square"
			end

			if self.shape == "square" then
				self.isFlying = false
				self.isGrounded = true
			else
				self.yVel = -(self.yVel-2)
			end
			
		end

	end
	self.x = self.x + 1
end

function Ballmeister:setGroundHeight(h)
	self.groundY = h
end

return Ballmeister