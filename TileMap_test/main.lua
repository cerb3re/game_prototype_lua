io.stdout:setvbuf('no') -- Used to print in terminal
love.graphics.setDefaultFilter("nearest")
if arg[#arg] == "-debug" then require("mobdebug").start() end
math.randomseed(love.timer.getTime()) -- get sure that the timer works
local largeur = love.graphics.getWidth()
local hauteur = love.graphics.getHeight()
local game = require("game")

function love.load()
  game.load()
end

function love.draw()
  game.draw()
end

function love.update(dt)
  
end

function love.keypressed(key)
  
end