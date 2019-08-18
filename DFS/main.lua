io.stdout:setvbuf('no')
if arg[#arg] == "-debug" then require("mobdebug").start() end
math.randomseed(love.timer.getTime()) -- get sure that the timer works

love.graphics.setDefaultFilter("nearest")
love.window.setTitle("Map Generation - T.CHENIER")

local screenWidth   = love.graphics.getWidth()
local screenHeight  = love.graphics.getHeight()
local seed          = 1
local cellSize      = 8
local explored      = 0
local nbCol
local nbLig

function digWall(lign, column)
  grid[lign][column] = "floor"

end

function getDirections(lign, column)
  local freeDirections = {}
  
  if lign > 2 then
    if grid[lign - 2][column] == "wall" then
      table.insert(freeDirections, "up")
    end
  end
  if column < nbCol - 2 then
    if grid[lign][column + 2] == "wall" then
      table.insert(freeDirections, "right")
    end
  end
  if lign < nbLig - 2 then
    if grid[lign + 2][column] == "wall" then
      table.insert(freeDirections, "down")
    end
  end
  if column > 2 then
    if grid[lign][column - 2] == "wall" then
      table.insert(freeDirections, "left")
    end
  end
  
  return freeDirections
end

function explore(lign, column)
  digWall(lign, column)
  explored = explored + 1
  
  while explored < math.floor((nbLig * nbCol) / 2) do
    local directions = getDirections(lign, column)
    
    if #directions ~= 0 then
      local r = love.math.random(1, #directions)
      local d = directions[r]
      
      if d == "up" then
        digWall(lign - 1, column)
        explore(lign - 2, column)
      elseif d == "right" then
        digWall(lign, column + 1)
        explore(lign, column + 2)
      elseif d == "down" then
        digWall(lign + 1, column)
        explore(lign + 2, column)
      elseif d == "left" then      
        digWall(lign, column - 1)
        explore(lign, column - 2)
      end
    else
      break
    end
  end
end

function init()
  love.math.setRandomSeed(seed)
  
  grid = {}
  nbCol = math.floor(screenWidth / cellSize)
  if nbCol % 2 == 0 then
    nbCol = nbCol - 1
  end
  
  nbLig = math.floor(screenHeight / cellSize)
  if nbLig % 2 == 0 then
    nbLig = nbLig - 1
  end
  
  for l = 1, nbLig do
    grid[l] = {}
    for c = 1, nbCol do
      grid[l][c] = "wall"
    end
  end
  
  explore(2, 2) -- start maze
  
end

function love.load()
  init()
end

function love.update(dt)
  
end

function love.draw()
  for l = 1, nbLig do
    for c = 1, nbCol do
      local cell = grid[l][c]
      
      if cell == "wall" then
        love.graphics.rectangle("fill", cellSize * (c - 1), cellSize * (l - 1), cellSize, cellSize)
      end
    end
  end
end

function love.keypressed()

end