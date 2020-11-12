io.stdout:setvbuf('no')
if arg[#arg] == "-debug" then require("mobdebug").start() end

love.graphics.setDefaultFilter("nearest")

-- Images loading
local imgTiles = {}
imgTiles["1"] = love.graphics.newImage("images/tile1.png")
imgTiles["2"] = love.graphics.newImage("images/tile2.png")
imgTiles["3"] = love.graphics.newImage("images/tile3.png")
imgTiles["4"] = love.graphics.newImage("images/tile4.png")
imgTiles["5"] = love.graphics.newImage("images/tile5.png")
imgTiles["="] = love.graphics.newImage("images/tile=.png")
imgTiles["["] = love.graphics.newImage("images/tile[.png")
imgTiles["]"] = love.graphics.newImage("images/tile].png")
imgTiles["H"] = love.graphics.newImage("images/tileH.png")
imgTiles["#"] = love.graphics.newImage("images/tile#.png")
imgTiles["g"] = love.graphics.newImage("images/tileg.png")
imgTiles[">"] = love.graphics.newImage("images/tile-arrow-right.png")
imgTiles["<"] = love.graphics.newImage("images/tile-arrow-left.png")

-- demo test
local mapTest = {
     {1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
     {1, 0, 0, 0, 0, 0, 0, 0, 0, 1},
     {1, 0, 0, 0, 0, 0, 0, 0, 0, 1},
     {1, 0, 0, 0, 0, 0, 0, 0, 0, 1},
     {1, 0, 0, 0, 0, 0, 0, 0, 0, 1},
     {1, 0, 0, 0, 0, 0, 0, 0, 0, 1},
     {1, 0, 0, 0, 0, 0, 0, 0, 0, 1},
     {1, 0, 0, 0, 0, 0, 0, 0, 0, 1},
     {1, 0, 0, 0, 0, 0, 0, 0, 0, 1},
     {1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
}

local player = {}
player.x = 4 * 32
player.y = 8 * 32
player.vx = 0
player.vy = 0
player.force = 5
player.isJumping = false
player.jumpReady = false

function love.load()
  
end

function love.update(dt)
  
  if love.keyboard.isDown("left") then
    player.vx = -player.force
  end
  
  if love.keyboard.isDown("right") then
    player.vx = player.force
  end
  
  if love.keyboard.isDown("up") then
    player.vy = - player.force
  end
  
  if player.vx < 0 then 
    player.vx = player.vx + 0.3
    if player.vx > 0 then player.vx = 0 end
  end
  
  if player.vx > 0 then
    player.vx = player.vx - 0.3
    if player.vx < 0 then player.vx = 0 end
  end
  

  
  
  
  player.x = player.x + player.vx
  player.y = player.y + player.vy
  player.vy = player.vy + 0.3
  
  if player.y >= 8 * 32 then
    player.y = 8 * 32
  end
  
  
  
end

function love.draw()
  for ligne = 1, #mapTest do
    
    for colonne = 1, #mapTest[1] do
      
      if mapTest[ligne][colonne] == 1 then
        --love.graphics.rectangle("fill", colonne * 32, ligne * 32, imgTiles["1"]:getHeight(), imgTiles["1"]:getHeight())
        love.graphics.draw(imgTiles["1"], (colonne - 1) * 32, (ligne - 1) * 32, 0, 4, 4)
        
      end
      
    -- player
    love.graphics.rectangle("fill", player.x, player.y, 32, 32)
    end
    
  end
end