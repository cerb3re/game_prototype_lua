-- Ecrit en FranGlais pour distinguer les deux actions
-- Written in EngLench 
io.stdout:setvbuf('no')
if arg[#arg] == "-debug" then require("mobdebug").start() end
math.randomseed(love.timer.getTime()) -- get sure that the timer works

love.graphics.setDefaultFilter("nearest")
love.window.setTitle("Map Generation - T.CHENIER")

local donjon = {}
donjon.nombreDeColonnes = 9
donjon.nombreDeLignes   = 6
donjon.map              = {}
donjon.salleDepart      = nil


function createRoom(lign, column)
  local newRoom = {}

  newRoom.lign        = lign
  newRoom.column      = column
  newRoom.isOpen      = false
  newRoom.doorHeight  = false
  newRoom.doorRight   = false
  newRoom.doorBotom   = false
  newRoom.doorLeft    = false
  
  return newRoom
end

function generateDungeon()
  print("Map generation is loading...")
  
  local nLigne, nColonne, nLigneDepart, nColonneDepart
  local listeSalles  = {}
  local nbSalles    = 20
  local startRoom
  
  nLigneDepart      = math.random(1, donjon.nombreDeLignes)
  nColonneDepart    = math.random(1, donjon.nombreDeColonnes)
  
  for nLigne = 1, donjon.nombreDeLignes, 1 do
    donjon.map[nLigne] = {}
    for nColonne = 1, donjon.nombreDeColonnes, 1 do
      donjon.map[nLigne][nColonne] = createRoom(nLigne, nColonne)
    end
  end
  
  startRoom         = donjon.map[nLigneDepart][nColonneDepart]
  startRoom.isOpen  = true
  table.insert(listeSalles, startRoom)
  
  donjon.salleDepart = startRoom
end

function love.load()
  generateDungeon()
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
      if donjon.map[nLigne][nColonne].isOpen == false then
        love.graphics.setColor(0.30, 0.30, 0.30)
      else
        love.graphics.setColor(255, 255, 255)
      end
      love.graphics.rectangle("fill", x, y, largeurCase, longeurCase)
      
      x = x + largeurCase + espaceCase
    end
    y = y + longeurCase + espaceCase
  end
  love.graphics.setColor(255, 255, 255)
end