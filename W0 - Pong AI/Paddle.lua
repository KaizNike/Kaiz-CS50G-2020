--[[
    GD50 2018
    Pong Remake

    -- Paddle Class --

    Author: Colton Ogden
    cogden@cs50.harvard.edu

    Represents a paddle that can move up and down. Used in the main
    program to deflect the ball back toward the opponent.
]]

Paddle = Class{}

--[[
    The `init` function on our class is called just once, when the object
    is first created. Used to set up all variables in the class and get it
    ready for use.

    Our Paddle should take an X and a Y, for positioning, as well as a width
    and height for its dimensions.

    Note that `self` is a reference to *this* object, whichever object is
    instantiated at the time this function is called. Different objects can
    have their own x, y, width, and height values, thus serving as containers
    for data. In this sense, they're very similar to structs in C.
]]
-- AI Update - 3 - Options to Class
function Paddle:init(x, y, width, height)
    self.x = x
    self.y = y
    self.width = width
    self.height = height
    self.dy = 0
	-- The new additions, set to default
	self.ai = 'hard'
	self.typePlayer = 'human'
	self.action = 'wait'
	self.randomState = 'move_up'
end

function Paddle:update(dt)
    -- math.max here ensures that we're the greater of 0 or the player's
    -- current calculated Y position when pressing up so that we don't
    -- go into the negatives; the movement calculation is simply our
    -- previously-defined paddle speed scaled by dt
    if self.dy < 0 then
        self.y = math.max(0, self.y + self.dy * dt)
    -- similar to before, this time we use math.min to ensure we don't
    -- go any farther than the bottom of the screen minus the paddle's
    -- height (or else it will go partially below, since position is
    -- based on its top left corner)
    else
        self.y = math.min(VIRTUAL_HEIGHT - self.height, self.y + self.dy * dt)
    end
end

--[[
    To be called by our main function in `love.draw`, ideally. Uses
    LÖVE2D's `rectangle` function, which takes in a draw mode as the first
    argument as well as the position and dimensions for the rectangle. To
    change the color, one must call `love.graphics.setColor`. As of the
    newest version of LÖVE2D, you can even draw rounded rectangles!
]]
function Paddle:render()
    love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
end

-- AI Update - 6 - AI States by Functions
--
-- Random refers to its ability, it will hit the ball at random
function Paddle:aiRandom()
	if self.randomState == 'move_up' then
		self.action = 'move_up'
	else
		self.action = 'move_down'
	end	
	if self.y == 0 then
		self.randomState = 'move_down'
	elseif self.y == VIRTUAL_HEIGHT - self.height then
		self.randomState = 'move_up'
	end
end

-- easy will follow the ball, but not predict it
function Paddle:aiEasy(bally)
	-- 6.1 added - 1 to widen the area and reduce wobble on startup
	if bally < self.y + 1 then
		self.action = 'move_up'
	elseif bally > self.y + 3  then
		self.action = 'move_down'
	else
		self.action = 'wait'
	end
end

-- hard will predict the ball's movement and move to its final position
function Paddle:aiHard(ballx, bally, balldx, balldy)
	
end