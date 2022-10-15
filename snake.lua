require("segment")

Snake = {}
Snake.__index = Snake


local function getRelativeAngle(angleA, angleB)
		local angle = angleB+math.pi - angleA
		if angle > math.pi then
			return angle - 2*math.pi
		elseif angle < -math.pi then
			return angle + 2*math.pi
		end
		return angle
end

function Snake.new(initialX, initialY, numSegments, segmentLength, constraint)
	local instance = setmetatable({}, Snake)
	instance.enableConstraints = false
	if constraint ~= nil then
		instance.enableConstraints = true
	end
	instance.constraint = constraint or 0
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
		if self.enableConstraints then
			local deltaAngle = getRelativeAngle(previous.angle, seg.angle)
			if math.abs(deltaAngle) < self.constraint then
				if deltaAngle < 0 then
					seg.angle = (previous.angle - self.constraint) + math.pi
					seg:setB(previous.pointA.x, previous.pointA.y)
				else
					seg.angle = (previous.angle + self.constraint) + math.pi
					seg:setB(previous.pointA.x, previous.pointA.y)
				end
			end
		end
		seg:update(dt)
	end
end

function Snake:draw()
	for i = 1, self.numSegments do
		self.segments[i]:draw()
	end
end
