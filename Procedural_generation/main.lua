io.stdout:setvbuf('no')
if arg[#arg] == "-debug" then require("mobdebug").start() end

love.graphics.setDefaultFilter("nearest")

local donjon = {}
donjon.nombreDeColonnes = 9
donjon.nombreDeLignes   = 6
donjon.map              = {}

function generateMap()
  print("Map generation is loading...")
  
  local nLigne, nColonne
  for nLigne = 1, donjon.nombreDeLignes, 1 do
    donjon.map[nLigne] = {}
    for nColonne = 1, donjon.nombreDeColonnes, 1 do
      donjon.map[nLigne][nColonne] = nil
    end
  end
end

function love.load()
  generateMap()
end

function love.update(dt)
end

function love.draw()
  local x, y
  local largeurCase = 34
  local longeurCase = 13
  local espaceCase  = 5
  x = 5
  y = 5
  
  local nLigne, nColonne
  for nLigne = 1, donjon.nombreDeLignes, 1 do
    x = 5
    
    for nColonne = 1, donjon.nombreDeColonnes, 1 do
      if donjon.map[nLigne][nColonne] == nil then
        love.graphics.rectangle("fill", x, y, largeurCase, longeurCase)
      end
      
      x = x + largeurCase + espaceCase
    end
    y = y + longeurCase + espaceCase
  end
end