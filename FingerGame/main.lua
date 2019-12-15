-- Cette ligne permet d'afficher des traces dans la console pendant l'éxécution
io.stdout:setvbuf('no')

-- Empèche Love de filtrer les contours des images quand elles sont redimentionnées
-- Indispensable pour du pixel art
love.graphics.setDefaultFilter("nearest")

-- Cette ligne permet de déboguer pas à pas dans ZeroBraneStudio
if arg[#arg] == "-debug" then require("mobdebug").start() end

local velocity = 5

function drawGame(dt, pVelocity)
  velocity = (velocity + 2);

  love.graphics.rectangle("fill", 10, velocity, 20, 20)
end

function love.draw(dt)
  drawGame(0.2, velocity)
end

function love.update(dt)
end

function love.load()
  
end