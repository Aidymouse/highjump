-- PLAN
-- More jumps = more fun
MAXJUMPS = 3

COLLISIONS = require '../collision'

controls = {
	JUMP = "space",
	CHANGESHAPE = "lshift",
	LEFT = "left",
	RIGHT = "right"
}

playerShapes = {
	SQUARE = "square",
	CIRCLE = "circle"
}

Ballmeister = {
	y = 100,
	x = 50,
	w = 10,
	h = 10,

	r = 5,

	maxSpeed = { x=1000, y=800 },

	xVel = 0,
	yVel = 0,

	gravity = 10, -- 10
	falling = "down",
	speed = 200,
	acceleration = 50,

	flags = {
		grounded = true
	},

	friction = 20,
	numJumps = MAXJUMPS,

	jumpPower = 200,

	shape = playerShapes.SQUARE
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

function Ballmeister:draw(shape)
	

	if self.shape == playerShapes.SQUARE then
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
		self.yVel = -self.jumpPower
	end
end

function Ballmeister:move(dt, platforms)
	
	-- X MOVEMENT --
	if love.keyboard.isDown(controls.LEFT) then  -- Allow ballmeister to move left
		self.xVel = self.xVel - self.acceleration
	elseif love.keyboard.isDown(controls.RIGHT) then  -- Allow ballmeister to move right
		self.xVel = self.xVel + self.acceleration
	
	else
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
		self.shape = playerShapes.CIRCLE
	else
		self.shape = playerShapes.SQUARE
	end


	-- Y MOVEMENT --
	
	-- Gravity
	self.yVel = self.yVel + self.gravity

	-- Jumping is handled in keypressed
	



	-- APPLY MOVEMENTS --
	self.y = self.y + self.yVel * dt
	self.x = self.x + self.xVel * dt



	-- PLATFORM COLLISIONS --
	for key, platform in pairs(platforms) do
		
		colData = COLLISIONS.AABB(
			{x=self.x-self.r, y=self.y-self.r, width=self.r*2, height=self.r*2},
			platform
		)


		if colData.collided then

			if math.abs(colData.shortestVert) < math.abs(colData.shortestHoriz) then
				self.y = self.y + colData.shortestVert

				if self.shape == playerShapes.CIRCLE then
					self.yVel = -self.yVel
				else
					self.yVel = 0
					self.numJumps = MAXJUMPS
				end
				
				

			else

				self.x = self.x + colData.shortestHoriz

				if self.shape == playerShapes.CIRCLE then
					self.xVel = -self.xVel
				else
					self.xVel = 0
				end

			end


		end
		
	end


end

return Ballmeister