Vector = {}
Vector.__index = Vector


function Vector.new(x, y)
	local x = x or 0
	local y = y or 0
	local instance = setmetatable({}, Vector)
	instance.x = x
	instance.y = y
	return instance
end


function Vector.add(vectorA, vectorB)
	return Vector.new(vectorA.x + vectorB.x, vectorA.y + vectorB.y)
end

function Vector.sub(vectorA, vectorB)
	return Vector.new(vectorA.x - vectorB.x, vectorA.y - vectorB.y)
end

function Vector:mult(value)
	self.x = self.x * value
	self.y = self.y * value
end


function Vector:normalize()
	local mod = self.x * self.x + self.y * self.y
	mod = math.sqrt(mod)
	self.x = self.x / mod
	self.y = self.y / mod
end


function Vector:setMagnitude(magnitude)
	self:normalize()
	self:mult(magnitude)
end


function Vector:set(x, y)
	self.x = x
	self.y = y
end
