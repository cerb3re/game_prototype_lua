-- Cette ligne permet d'afficher des traces dans la console pendant l'éxécution
io.stdout:setvbuf('no')

-- Empèche Love de filtrer les contours des images quand elles sont redimentionnées
-- Indispensable pour du pixel art
love.graphics.setDefaultFilter("nearest")

-- Cette ligne permet de déboguer pas à pas dans ZeroBraneStudio
if arg[#arg] == "-debug" then require("mobdebug").start() end

local velocity = 5
background = love.graphics.newImage("pictures/background.jpg")
ryu = love.graphics.newImage("pictures/ryu.jpg")

listeSF = {}
listeSF[1] = "Balrog"
listeSF[2] = "Ryu"
listeSF[3] = "Ken"

PersoSelect = 1


function drawGame(dt, pVelocity)
  --love.graphics.draw(background, 0, 0, 0, 0.8, 0.8)
  --love.graphics.draw(ryu, 0, 0)
end

function love.draw(dt)
  y = 15
  
  for i=1, #listeSF do
    if i == PersoSelect then
      love.graphics.setColor(1, 0, 0)
    else
      love.graphics.setColor(1, 1, 1)
    end
    
    love.graphics.print(listeSF[i], 10, y)
    y = y + 15
  end
end

function love.update(dt)
end

function love.keypressed(key)
  if key == "down" then
    PersoSelect = PersoSelect + 1
  elseif key == "up" then
    PersoSelect = PersoSelect - 1
  end
  
  if PersoSelect < 1 then
    PersoSelect = #listeSF
  end
  
  if PersoSelect > #listeSF then
    PersoSelect = 1
  end
  
end

function love.load()
  
end