io.stdout:setvbuf('no') -- Used to print in terminal
love.graphics.setDefaultFilter("nearest")
if arg[#arg] == "-debug" then require("mobdebug").start() end
math.randomseed(love.timer.getTime()) -- get sure that the timer works

love.window.setMode(1250,1050)

-- Selection d'un joueur avec son affichage

Tilemap = {}

Tilemap[1] = {1,1,1,1,3,1,1,1,3,3}
Tilemap[2] = {1,1,1,1,2,1,1,1,1,3}
Tilemap[3] = {1,1,1,1,2,1,1,1,1,2}
Tilemap[4] = {1,1,1,1,1,1,1,1,1,1}
Tilemap[5] = {1,1,1,1,1,1,1,1,1,1}
Tilemap[6] = {1,1,1,1,1,1,1,1,1,1}
Tilemap[7] = {1,1,1,1,1,1,1,1,1,1}
Tilemap[8] = {1,1,1,1,2,1,1,1,1,1}
Tilemap[9] = {1,1,1,1,2,1,1,1,2,3}
Tilemap[10] = {1,1,1,1,3,1,1,1,3,3}

Selection = {}
Selection.l = 1
Selection.c = 1
Selection.selected = false

TileSize = 8

dbUnits = {}
dbUnits["TANK"] = {}
dbUnits["INFANTRY"] = {}

dbPictures = {}
dbPictures[1] = {}
dbPictures[2] = {}
dbPictures[3] = {}
lstUnits = {}

function createUnit(pType, pX, pY)
  local unit = {}
  unit.x = pX
  unit.y = pY
  unit.type = pType
  unit.HP = 10
  
  table.insert(lstUnits, unit)
  
  return lstUnits
end

function love.load()
  
  dbUnits["TANK"].image = love.graphics.newImage("pictures/tank_1.png")
  dbUnits["INFANTRY"].image = love.graphics.newImage("pictures/infantry_1.png")
  
  -- pictures definition
  dbPictures[1].image = love.graphics.newImage("pictures/map_plain.png")
  dbPictures[2].image = love.graphics.newImage("pictures/map_forest.png")
  dbPictures[3].image = love.graphics.newImage("pictures/map_mountain.png")
  
  -- Creation of units
  createUnit("TANK",3,5)
  createUnit("INFANTRY",2,3)
end

function love.draw()
  
  love.graphics.scale(6,6)
  
  local x,y = 0,0
  
  for l=1, #Tilemap do
    x = 0
    for c=1, #Tilemap do
      
      local tileId = Tilemap[l][c]
      
      love.graphics.draw(dbPictures[tileId].image, x -1, y -1)
    
      
      
      for u=1, #lstUnits do
        local unit = lstUnits[u]
        local rectColor = 1
        
        love.graphics.setColor(1,1,1,1)
        love.graphics.draw(dbUnits[unit.type].image, (unit.x - 1) * TileSize, (unit.y - 1) * TileSize)

          if Selection.c == c and Selection.l == l then
 
            if Selection.c == unit.x and Selection.l == unit.y then
              love.graphics.print("TYPE: "..unit.type, #Tilemap * TileSize, 0)
              love.graphics.print("HP: "..unit.HP, #Tilemap * TileSize, TileSize * 3)
              
              if Selection.selected == true then
                rectColor = 0
              end
              
            end
            
            
          love.graphics.setColor(1, rectColor, rectColor,1)
          love.graphics.rectangle("line", x, y, TileSize - 2, TileSize -2)
          love.graphics.rectangle("line", x, y, TileSize - 3, TileSize -3)
          love.graphics.setColor(1,1,1,1)

          end 
        
      end
      
      x = x + TileSize

    end
    y = y + TileSize
    
  end
  
end

function love.keypressed(key)
  
  if key == "right" then
    Selection.c = Selection.c + 1
  end
  
  if key == "left" then
    Selection.c = Selection.c - 1
  end
  
  if key == "down" then
    Selection.l = Selection.l + 1
  end
  
  if key == "up" then
    Selection.l = Selection.l - 1
  end
  
  if key == "space" then
    Selection.selected = not Selection.selected
  end
  
end