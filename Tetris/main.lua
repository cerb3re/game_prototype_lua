io.stdout:setvbuf('no') -- Used to print in terminal
love.graphics.setDefaultFilter("nearest")
if arg[#arg] == "-debug" then require("mobdebug").start() end
math.randomseed(love.timer.getTime()) -- get sure that the timer works

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

function love.load()
  
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
end

function love.update(dt)
  
end

function love.keypressed(key)
  if key == "r" then
    CurrentRotation = CurrentRotation + 1
    print(#Tetros[CurrentTetros].shape)
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