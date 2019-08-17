io.stdout:setvbuf('no')
if arg[#arg] == "-debug" then require("mobdebug").start() end
math.randomseed(love.timer.getTime()) -- get sure that the timer works

love.graphics.setDefaultFilter("nearest")
love.window.setTitle("Map Generation - T.CHENIER")

local screenWidth   = love.graphics.getWidth()
local screenHeight  = love.graphics.getHeight()
local position      = {}
position.parcouru   = false

function creuser(x, y)
  position.x = x
  position.y = y
  position.parcouru = true
  
  table.insert(position, position)
  return position
end

function love.load()

end

function love.update(dt)
  
end

function love.draw()
  y = 1
  for x = 1, screenWidth, 1 do
    creuser(x, y)
    print(#position)
  end
end

function love.keypressed()

end