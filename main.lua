require("snake")


function love.load()
	pause = false
	snake = Snake.new(400, 300, 100, 5)
end

function love.update(dt)
	snake:update(dt)
end

function love.draw()
	love.graphics.setBackgroundColor(89/255, 91/255, 92/255, 1)
	snake:draw()
end
