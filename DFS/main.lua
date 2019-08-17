io.stdout:setvbuf('no')
if arg[#arg] == "-debug" then require("mobdebug").start() end
math.randomseed(love.timer.getTime()) -- get sure that the timer works

love.graphics.setDefaultFilter("nearest")
love.window.setTitle("Map Generation - T.CHENIER")

function love.load()
end

function love.update(dt)
  
end

function love.draw()
  
end

function love.keypressed()
end