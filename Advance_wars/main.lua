io.stdout:setvbuf('no') -- Used to print in terminal
love.graphics.setDefaultFilter("nearest")
if arg[#arg] == "-debug" then require("mobdebug").start() end
math.randomseed(love.timer.getTime()) -- get sure that the timer works

love.window.setMode(1250,1050)

Tilemap = {}

Tilemap[1] = {1,1,1,1,1,1,1,1,1,1}
Tilemap[2] = {1,1,1,1,1,1,1,1,1,1}
Tilemap[3] = {1,1,1,1,1,1,1,1,1,1}
Tilemap[4] = {1,1,1,2,2,1,1,1,1,1}
Tilemap[5] = {1,1,1,1,1,1,1,1,1,1}
Tilemap[6] = {1,1,1,1,1,1,1,1,1,1}
Tilemap[7] = {1,1,1,1,1,1,1,1,1,1}
Tilemap[8] = {1,1,1,1,1,1,1,1,1,1}
Tilemap[9] = {1,1,1,1,1,1,1,1,1,1}
Tilemap[10] = {1,1,1,1,1,1,1,1,1,1}

Selection = {}
Selection.l = 1
Selection.c = 1

TileSize = 40

dbUnits = {}
dbUnits["TANK"] = {}
dbUnits["TANK"].image = love.graphics.newImage("pictures/tank.png")

dbUnits["INFANTRY"] = {}
dbUnits["INFANTRY"].image = love.graphics.newImage("pictures/infantry.png")

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
  createUnit("TANK",3,5)
  createUnit("INFANTRY",2,3)
end

function love.draw()
  
  local x,y = 0,0
  
  for l=1, #Tilemap do
    x = 0
    for c=1, #Tilemap do
      
      if Tilemap[l][c] == 1 then
        love.graphics.setColor(.5,.5,0,1)
      elseif Tilemap[l][c] == 2 then
        love.graphics.setColor(1,.5,0,1)
      end
      
      love.graphics.rectangle("fill",x,y,TileSize -1,TileSize -1)
      
    
      if Selection.c == c and Selection.l == l then
        love.graphics.setColor(1,1,1,1)
        love.graphics.rectangle("line", x, y, TileSize - 2, TileSize -2)
        love.graphics.rectangle("line", x, y, TileSize - 3, TileSize -3)
      end
      
      for u=1, #lstUnits do
        local unit = lstUnits[u]
        
        love.graphics.setColor(1,1,1,1)
        love.graphics.draw(dbUnits[unit.type].image, (unit.x - 1) * TileSize, (unit.y - 1) * TileSize)
        
        if Selection.c == unit.x and Selection.l == unit.y then
          love.graphics.print("TYPE: "..unit.type, #Tilemap * TileSize, 0)
          love.graphics.print("HP: "..unit.HP, #Tilemap * TileSize, TileSize)
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
  
end