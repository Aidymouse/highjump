-- PLAN
-- More jumps = more fun
MAXJUMPS = 3

COLLISIONS = require '../collision'

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

	maxSpeed = { x=200, y=800 },

	xVel = 0,
	yVel = 0,

	gravity = 10, -- 10
	falling = "down",
	speed = 200,

	flags = {
		grounded = true
	},

	friction = 20,
	numJumps = MAXJUMPS,

	shape = playerShapes.SQUARE
}

function Ballmeister:update(dt, platforms)
	Ballmeister:move(dt, platforms)
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

function Ballmeister:move(dt, platforms)
	if love.keyboard.isDown(controls.LEFT) then  -- Allow ballmeister to move left
		self.x = self.x - 5
	end

	if love.keyboard.isDown(controls.RIGHT) then  -- Allow ballmeister to move right
		self.x = self.x + 5
	end

	-- GRAVITY --
	self.yVel = self.yVel + self.gravity * dt

	-- COLLISIONS --
	for key, platform in pairs(platforms) do
		
		colData = COLLISIONS.AABB(
			{x=self.x-self.r, y=self.y-self.r+self.yVel, width=self.r*2, height=self.r*2},
			platform
		)


		if colData.collided then
			self.yVel = 0
			self.y = self.y + colData.shortestVert
			--colData.shortestVert
			--self.xVel = self.xVel + colData.shortestHoriz
		end
		
	end

	self.y = self.y + self.yVel
	self.x = self.x + self.xVel


end

function Ballmeister:setGroundHeight(h)
	self.groundY = h
end

return Ballmeister