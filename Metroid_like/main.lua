-- Cette ligne permet d'afficher des traces dans la console pendant l'éxécution
io.stdout:setvbuf('no')

-- Pour ne pas avoir de lissage
love.graphics.setDefaultFilter("nearest")

local sprites       = love.graphics.newImage("pictures/sprites.png")
local velocity      = 10
local position      = 0
local screen_width  = love.graphics.getWidth()
local screen_heigth = love.graphics.getHeight()
local top_left      = love.graphics.newQuad(32, 8, 8, 8, sprites:getDimensions())

function love.load()
  
end

function love.update(dt)
 
end

function love.draw()
  love.graphics.scale(4,4)
  love.graphics.draw(sprites, top_left);
end