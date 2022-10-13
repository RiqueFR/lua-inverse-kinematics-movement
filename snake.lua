require("segment")

Snake = {}
Snake.__index = Snake

function Snake.new(initialX, initialY, numSegments, segmentLength)
	local instance = setmetatable({}, Snake)
	instance.numSegments = numSegments
	instance.segmentLength = segmentLength
	instance.segments = {}
	local current = Segment.new(initialX, initialY, segmentLength, 0)
	table.insert(instance.segments, current)
	for i = 1, numSegments-1 do
		current = Segment.new(current.pointA.x, current.pointA.y, segmentLength, 0)
		table.insert(instance.segments, current)
	end
	return instance
end

function Snake:update(dt)
	local seg = self.segments[1]
	seg:follow(love.mouse.getPosition())
	seg:update(dt)
	for i = 2, self.numSegments do
		seg = self.segments[i]
		local previous = self.segments[i-1]
		seg:follow(previous.pointA.x, previous.pointA.y)
		seg:update(dt)
	end
end

function Snake:draw()
	for i = 1, self.numSegments do
		self.segments[i]:draw()
	end
end
