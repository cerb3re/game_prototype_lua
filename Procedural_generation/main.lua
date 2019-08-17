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
  newRoom.doorUp      = false
  newRoom.doorRight   = false
  newRoom.doorBottom  = false
  newRoom.doorLeft    = false
  
  return newRoom
end

function generateDungeon()
  print("Map generation is loading...")
  
  local nLigne, nColonne, nLigneDepart, nColonneDepart
  local listeSalles  = {}
  local nbSalles     = math.random(1, 54) -- nombre de pièce à générer
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
  print(#listeSalles)
  print(nbSalles)
  while #listeSalles < nbSalles do
    local nSalle                  = math.random(1, #listeSalles)
    local nLigne                  = listeSalles[nSalle].lign
    local nColonne                = listeSalles[nSalle].column
    local salle                   = listeSalles[nSalle]
    local nouvelleSalle           = nil
    local direction               = math.random(1, 4)
    local bAjouteSalle            = false
    
    if direction == 1 and nLigne > 1 then
      nouvelleSalle = donjon.map[nLigne - 1][nColonne]
      if nouvelleSalle.isOpen == false then
        salle.doorUp = true
        nouvelleSalle.doorBottom = true
        
        bAjouteSalle = true
      end
    elseif direction == 2 and nColonne < donjon.nombreDeColonnes then
      nouvelleSalle = donjon.map[nLigne][nColonne + 1]
      if nouvelleSalle.isOpen == false then
        salle.doorRight = true
        nouvelleSalle.doorLeft  = true
        
        bAjouteSalle = true
      end
    elseif direction == 3 and nLigne < donjon.nombreDeLignes then
      nouvelleSalle = donjon.map[nLigne + 1][nColonne]
      if nouvelleSalle.isOpen == false then
        salle.doorBottom = true
        nouvelleSalle.doorUp = true
        
        bAjouteSalle = true
      end
    elseif direction == 4 and nColonne > 1 then
      nouvelleSalle = donjon.map[nLigne][nColonne - 1]
      if nouvelleSalle.isOpen == false then
        salle.doorLeft = true
        nouvelleSalle.doorRight = true
        
        bAjouteSalle = true
      end
    end
    
    if bAjouteSalle == true then
      nouvelleSalle.isOpen = true
      table.insert(listeSalles, nouvelleSalle)
    end
  end
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
        if donjon.salleDepart == donjon.map[nLigne][nColonne] then
          love.graphics.setColor(0.5, 0.255, 0.5)
        else
          love.graphics.setColor(255, 255, 255)
        end
      end
      love.graphics.rectangle("fill", x, y, largeurCase, longeurCase)
      
      x = x + largeurCase + espaceCase
    end
    y = y + longeurCase + espaceCase
  end
  love.graphics.setColor(255, 255, 255)
end

function love.keypressed(key)
  if key == " " or key == "space" then
    generateDungeon()
  end
end