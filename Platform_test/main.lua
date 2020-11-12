io.stdout:setvbuf('no')
if arg[#arg] == "-debug" then require("mobdebug").start() end

love.graphics.setDefaultFilter("nearest")

tile = love.graphics.newImage("tile1.png")

player = {}
player.x = 0
player.y = 0
player.vx = 0
player.vy = 0
player.isJumping = false
player.intertia = 5

map = {}

function love.load()
  loadLevel(1)
end

function love.update(dt)
  
end

function love.draw()
  local posMouseX = math.floor(love.mouse.getX() / 32) + 1
  local posMouseY = math.floor(love.mouse.getY() / 32) + 1
  
  for ligne = 1, #map do
    
    for colonne = 1, #map[1] do
      
      local id = string.sub(map[ligne], colonne, colonne)
      
      if tonumber(id) > 0 then
        love.graphics.draw(tile, (colonne - 1) * 32, (ligne - 1) * 32)
      end

      local tile = getTileAt(ligne, colonne)
      love.graphics.print(tile)
       
    end
    
  end
end

function getTileAt(pX, pY)
  local posX = math.floor(love.mouse.getX() / 32) + 1
  local posY = math.floor(love.mouse.getY() / 32) + 1

  local id = string.sub(map[posY], posX, posX)
  
  if posX > 0 and posX <= #map[1] and posY > 0 and posY <= #map then
    return id
  end
  
  return 0
end

function loadLevel(pLevel)
  
  if pLevel == 1 then
    
    map[1]  = "1111111111111111111111111"
    map[2]  = "1000000000000000000000001"
    map[3]  = "1000111111111111111100001"
    map[4]  = "1000000000000000000010011"
    map[5]  = "1000000000000000000000001"
    map[6]  = "1000000000000000000000111"
    map[7]  = "1000000000000000000000001"
    map[8]  = "1000000000000000011111111"
    map[9]  = "1000000000000100000000001"
    map[10] = "1000000000000001000000001"
    map[11] = "1000000000111100000000001"
    map[12] = "1000000000000000000000001"
    map[13] = "1111111000000000000000001"
    map[14] = "1000000010000000000000001"
    map[15] = "1100000000111100000000001"
    map[16] = "1000000001000010000000001"
    map[17] = "1000000010000001000000001"
    map[18] = "1111111111111111111111111"
    
  end
  
  return map
end