-- PLAN
-- More jumps = more fun
MAXJUMPS = 3

controls = {
	JUMP = "space",
	TRANSFORM = "lshift",
	LEFT = "left",
	RIGHT = "right"
}

playerShapes = {
	SQUARE = "square",
	CIRCLE = "circle"
}

Ballmeister = {
	y = 100,
	x = 10,
	w = 10,
	h = 10,
	r = 5,

	maxSpeed = { x: 200, y: 100 },

	xVel = 0,
	yVel = 0,
	gravity = 10, -- 10
	falling = "down",
	speed = 200,
	isGrounded = false,
	isFlying = true,
	friction = 20,
	numJumps = MAXJUMPS,
	groundY = 590

	shape = playerShapes.SQUARE
}

function Ballmesiter:update(dt)
	Ballmeister:move(dt)
end

function Ballmeister:draw(shape)
	

	if Shape == playerShapes.SQUARE then
		love.graphics.rectangle('fill', self.x-5, self.y-5, self.w, self.h)
	else
		love.graphics.circle('fill', self.x, self.y, self.r)
	end

	for i=1, self.numJumps, 1 do
		love.graphics.circle('fill', 15 * i, 15, 5)
	end

end

function Ballmeister:jump()
	if self.numJumps > 0 then
		self.numJumps = self.numJumps - 1
		self.isGrounded = false
		self.isFlying = true
		self.yVel = -5
	end
end

function Ballmeister:move(dt)
	if love.keyboard.isDown(controls.LEFT) then  -- Allow ballmeister to move left
		self.x = self.x - 5
	end

	if love.keyboard.isDown(controls.RIGHT) then  -- Allow ballmeister to move right
		self.x = self.x + 5
	end

	if self.isFlying then  -- Moveing up or down through the air
		
		self.y = self.y + self.yVel  -- Update ballmeisters y coordinate by his y velocity
		self.yVel = self.yVel + (dt * self.gravity)  -- Update the y velocity with gravity

		if self.y + 5 >= self.groundY then

			self.y = self.groundY - 5

			if -(self.yVel-2) > 1 then
				self.shape = 'square'
			end

			if self.shape == "square" then
				self.numJumps = MAXJUMPS
				self.isFlying = false
				self.isGrounded = true
				self.yVel = 0
			else
				self.yVel = -(self.yVel-1)
			end
			
		end

	end

end

function Ballmeister:setGroundHeight(h)
	self.groundY = h
end

return Ballmeister