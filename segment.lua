require("vector")

Segment = {}
Segment.__index = Segment

function Segment.new(x, y, length, angle)
	local instance = setmetatable({}, Segment)
	instance.pointA = Vector.new(x, y)
	instance.pointB = Vector.new(0, 0)
	instance.length = length
	instance.width = 10
	instance.angle = angle
	instance:calculateB()
	return instance
end

function Segment:setA(x, y)
	self.pointA.x = x
	self.pointA.y = y
	self:calculateB()
end
function Segment:setB(x, y)
	self.pointB.x = x
	self.pointB.y = y
	self:calculateA()
end

function Segment:calculateA()
	local dx = self.length * math.cos(self.angle)
	local dy = self.length * math.sin(self.angle)
	self.pointA:set(self.pointB.x - dx, self.pointB.y - dy)
end

function Segment:calculateB()
	local dx = self.length * math.cos(self.angle)
	local dy = self.length * math.sin(self.angle)
	self.pointB:set(self.pointA.x + dx, self.pointA.y + dy)
end


function Segment:follow(x, y)
	local dx = x - self.pointA.x
	local dy = y - self.pointA.y
	self.angle = (math.pi*2 + math.atan2(dy, dx)) % (2*math.pi)

	local delta = Vector.new(dx, dy)
	delta:setMagnitude(self.length)
	delta:mult(-1)
	self.pointA.x = x + delta.x
	self.pointA.y = y + delta.y
end

function Segment:update(dt)
	self:calculateB()
	self.angle = (self.angle) % (2*math.pi)
end


function Segment:draw()
	love.graphics.push()
	love.graphics.setLineWidth(self.width)
	love.graphics.line(self.pointA.x, self.pointA.y, self.pointB.x, self.pointB.y)
	love.graphics.pop()
end
