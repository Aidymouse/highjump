-- PLAN
-- More jumps = more fun
MAXJUMPS = 3

local Vector = require '../Vector'

COLLISIONS = require '../collision'

controls = {
	JUMP = "space",
	CHANGESHAPE = "lshift",
	LEFT = "left",
	RIGHT = "right"
}

local enum_playerShapes = {
	SQUARE = "square",
	CIRCLE = "circle"
}

Ballmeister = {
	y = 100,
	x = 50,
	width = 10,
	h = 10,

	r = 5,

	maxSpeed = { x=1000, y=800 },

	xVel = 0,
	yVel = 0,

	gravity = 10, -- 10
	speed = 200,
	acceleration = 50,

	flags = {
		grounded = true,

		holdingJump = false
	},

	friction = 20,
	numJumps = MAXJUMPS,

	jumpPower = 600,
	holdingJump = 6,

	shape = enum_playerShapes.SQUARE
}

function Ballmeister:update(dt, platforms)
	Ballmeister:move(dt, platforms)
end

function Ballmeister:keypressed(key)

	-- Jumping
	if key == controls.JUMP then
		Ballmeister:jump()
	end

end

function Ballmeister:draw()
	

	if self.shape == enum_playerShapes.SQUARE then
		love.graphics.rectangle('fill', self.x-5, self.y-5, self.width, self.h)
	else
		love.graphics.circle('fill', self.x, self.y, self.r)
	end

	for i=1, self.numJumps, 1 do
		love.graphics.circle('fill', 15 * i, 15, 5)
	end

	love.graphics.print(self.yVel, 0, 0)
	love.graphics.print(tostring(self.flags.grounded), 0, 12)

end

function Ballmeister:jump()
	if self.numJumps > 0 then
		self.numJumps = self.numJumps - 1
		self.yVel = -self.jumpPower
		self.flags.holdingJump = true
	end
end

function Ballmeister:move(dt, platforms)
	
	-- X MOVEMENT --
	if love.keyboard.isDown(controls.LEFT) then  -- Allow ballmeister to move left
		self.xVel = self.xVel - self.acceleration
	elseif love.keyboard.isDown(controls.RIGHT) then  -- Allow ballmeister to move right
		self.xVel = self.xVel + self.acceleration
	
	elseif self.flags.grounded then
		if self.xVel < 0 then self.xVel = self.xVel + self.friction end
		if self.xVel > 0 then self.xVel = self.xVel - self.friction end
		
		if math.abs(self.xVel) < self.acceleration then self.xVel = 0 end

	end

	-- Cap speed
	if math.abs(self.xVel) > self.maxSpeed.x then
		if self.xVel < 0 then self.xVel = -self.maxSpeed.x end
		if self.xVel > 0 then self.xVel = self.maxSpeed.x end
	end





	-- SHAPE --
	if love.keyboard.isDown(controls.CHANGESHAPE) then
		self.shape = enum_playerShapes.CIRCLE
	else
		self.shape = enum_playerShapes.SQUARE
	end


	-- Y MOVEMENT --

	-- Start falling if jump is released
	if self.flags.holdingJump and (not love.keyboard.isDown(controls.JUMP)) and self.yVel < -100 then
		self.yVel = self.yVel * 0.3
		self.flags.holdingJump = false
	end
	

	-- Gravity
	self.yVel = self.yVel + self.gravity
	if self.yVel > -50 then self.yVel = self.yVel + self.gravity * 0.5 end



	-- APPLY MOVEMENTS --
	self.y = self.y + self.yVel * dt
	self.x = self.x + self.xVel * dt


	
	-- PLATFORM COLLISIONS --
	self.flags.grounded = false

	for _, collider in pairs(platforms) do
		


		if collider.collisionType == "platform" then
			self:handleCollision_platform(collider)
		
		elseif collider.collisionType == "bouncer" then
			self:handleCollision_bouncer(collider)
		end

		
		
	end


end

function Ballmeister:handleCollision_platform(collider)
	local colData = COLLISIONS.AABB(
		{ x = self.x - self.r, y = self.y - self.r, width = self.r * 2, height = self.r * 2 },
		collider
	)

	if colData.collided then

		-- Y Collision
		if math.abs(colData.shortestVert) < math.abs(colData.shortestHoriz) then

			self.flags.grounded = true

			self.y = self.y + colData.shortestVert

			if self.shape == enum_playerShapes.CIRCLE then
				self.yVel = -self.yVel * 0.8
			else
				self.yVel = 0
				self.numJumps = MAXJUMPS
				self.flags.holdingJump = false
			end

			if collider.type == "bouncepad" then
				self.yVel = self.yVel - 500
			end

			-- X Collision
		else

			self.x = self.x + colData.shortestHoriz

			if self.shape == enum_playerShapes.CIRCLE then
				self.xVel = -self.xVel
			else
				self.xVel = 0
			end

		end


	end
end

function Ballmeister:handleCollision_bouncer(collider)

	local colData = collision.twoCircles(
		{x = self.x, y=self.y, radius=self.width/2},
		collider
	)

	print(colData.collided)

	if colData.collided then
		
		local centersDir = (Vector.new(self.x, self.y) - Vector.new(collider.x, collider.y)):norm()

		self.xVel = collider.strength * centersDir.x
		self.yVel = collider.strength * centersDir.y

	end


end

return Ballmeister