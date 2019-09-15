io.stdout:setvbuf('no') -- Used to print in terminal
love.graphics.setDefaultFilter("nearest")
if arg[#arg] == "-debug" then require("mobdebug").start() end
math.randomseed(love.timer.getTime()) -- get sure that the timer works

local screenHeight = love.graphics.getHeight()
local screenWidth = love.graphics.getWidth()

local Grid = {}
Grid.width = 10
Grid.height = 20
Grid.cellSize = 0
Grid.cells = {}
Grid.offsetX = 0

local Tetros = {}

Tetros[1] = {}

Tetros[1].shape = { {
    {0,0,0,0},
    {1,1,1,1},
    {0,0,0,0},
    {0,0,0,0}
  },
  {
    {0,0,1,0},
    {0,0,1,0},
    {0,0,1,0},
    {0,0,1,0}
    } }

Tetros[1].color = {255,0,0}

Tetros[2] = {}

Tetros[2].shape = { {
    {0,0,0,0},
    {0,1,1,0},
    {0,1,1,0},
    {0,0,0,0}
    } }

Tetros[2].color = {0,71,222}

Tetros[3] = {}

Tetros[3].shape = { {
    {0,0,0},
    {1,1,1},
    {0,0,1},
  },
  {
    {0,1,0},
    {0,1,0},
    {1,1,0},
  },
  {
    {1,0,0},
    {1,1,1},
    {0,0,0},
  },
  {
    {0,1,1},
    {0,1,0},
    {0,1,0},
    } }

Tetros[3].color = {222,184,0}

Tetros[4] = {}

Tetros[4].shape = { {
    {0,0,0},
    {1,1,1},
    {1,0,0},
  },
  {
    {1,1,0},
    {0,1,0},
    {0,1,0},
  },
  {
    {0,0,1},
    {1,1,1},
    {0,0,0},
  },
  {
    {1,0,0},
    {1,0,0},
    {1,1,0},
  } }

Tetros[4].color = {222,0,222}

Tetros[5] = {}

Tetros[5].shape = { {
    {0,0,0},
    {0,1,1},
    {1,1,0},
  },
  {
    {0,1,0},
    {0,1,1},
    {0,0,1},
  },
  {
    {0,0,0},
    {0,1,1},
    {1,1,0},
  },
  {
    {0,1,0},
    {0,1,1},
    {0,0,1},
    } }

Tetros[5].color = {255,151,0}

Tetros[6] = {}

Tetros[6].shape = { {
    {0,0,0},
    {1,1,1},
    {0,1,0},
  },
  {
    {0,1,0},
    {1,1,0},
    {0,1,0},
  },
  {
    {0,1,0},
    {1,1,1},
    {0,0,0},
  },
  {
    {0,1,0},
    {0,1,1},
    {0,1,0},
  } }

Tetros[6].color = {71,184,0}

Tetros[7] = {}

Tetros[7].shape = { {
    {0,0,0},
    {1,1,0},
    {0,1,1},
  },
  {
    {0,1,0},
    {1,1,0},
    {1,0,0},
  },
  {
    {0,0,0},
    {1,1,0},
    {0,1,1},
  },
  {
    {0,1,0},
    {1,1,0},
    {1,0,0},
  } }

Tetros[7].color = {0,184,151}


local CurrentTetros = 1
local CurrentRotation = 1

function InitGrid()
  local h = screenHeight / Grid.height
  Grid.cellSize = h
  Grid.offsetX = (screenWidth / 2) - ((Grid.cellSize * Grid.width) / 2)
  Grid.cells = {}
  
  for l = 1, Grid.height do
    Grid.cells[l] = {}
    for c = 1, Grid.width do
      Grid.cells[l][c] = 0
    end
  end
end

function love.load()
  InitGrid()
end

function love.draw()
  local shape = Tetros[CurrentTetros].shape[CurrentRotation]
  
  for l=1, #shape do
    for c=1, #shape[l] do
      local x = (c-1) * 32
      local y = (l-1) * 32
      
      if shape[l][c] == 1 then
        love.graphics.rectangle("fill", x, y, 31, 31)
      else
        
      end
    end
  end
  
  drawGrid()
end

function love.update(dt)

end

function drawGrid()
  local h = Grid.cellSize
  local w = h
  local x,y
  
  
  love.graphics.setColor(50, 50, 50, 255)
  
  for l = 1, Grid.height do
    Grid.cells[l] = {}
    for c = 1, Grid.width do
      x = (c - 1) * w
      y = (l - 1) * h
      x = x + Grid.offsetX
      
      love.graphics.rectangle("fill", x, y, w - 1, h - 1)
    end
  end
end

function love.keypressed(key)
  if key == "r" then
    CurrentRotation = CurrentRotation + 1
    
    if CurrentRotation > #Tetros[CurrentTetros].shape then
      CurrentRotation = 1
    end
  end
  
  if key == "t" then
    CurrentTetros = CurrentTetros + 1
    CurrentRotation = 1

    if CurrentTetros > #Tetros then
      CurrentTetros = 1
    end
  end
end