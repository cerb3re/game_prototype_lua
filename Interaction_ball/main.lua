io.stdout:setvbuf('no') -- Used to print in terminal
love.graphics.setDefaultFilter("nearest")
if arg[#arg] == "-debug" then require("mobdebug").start() end
math.randomseed(love.timer.getTime()) -- get sure that the timer works


function love.draw()
  
  local x, y = love.mouse.getPosition()
  
  love.graphics.setColor(1,0,0)
  love.graphics.circle("fill", love.graphics.getWidth() / 2, love.graphics.getHeight() / 2, 30)
  
  love.graphics.setColor(0,0,1)
  love.graphics.circle("fill", x, y, 10)
end