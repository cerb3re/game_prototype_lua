

-- Cette ligne permet d'afficher des traces dans la console pendant l'éxécution
io.stdout:setvbuf('no')

-- Empèche Love de filtrer les contours des images quand elles sont redimentionnées
-- Indispensable pour du pixel art
love.graphics.setDefaultFilter("nearest")

-- Cette ligne permet de déboguer pas à pas dans ZeroBraneStudio
if arg[#arg] == "-debug" then require("mobdebug").start() end

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

local currentTetros = {}
currentTetros.shapeid = 1
currentTetros.rotation = 1
currentTetros.position = { x=0, y=0 }

local Grid = {}
Grid.width = 10
Grid.height = 20
Grid.cellSize = 0
Grid.cells = {}

local dropSpeed = 1
local timerDrop = 0
local pauseForceDrop = false

local fontMenu
local fontPlay
local sndMusicMenu
local sndMusicGame
local sndLevel
local sndLine
local menuSin = 0
local gameState = ""

local score = 0
local level = 0
local lines = 0

local bag = {}

function InitBag()
  bag = {}
  for n=1,#Tetros do
    table.insert(bag,n)
    table.insert(bag,n)
  end
end

function SpawnTetros()
  local nBag = math.random(1, #bag) 
  local new = bag[nBag]
  table.remove(bag, nBag)
  if #bag == 0 then
    InitBag()
  end
  currentTetros.shapeid = new
  currentTetros.rotation = 1
  local tetrosWidth = #Tetros[currentTetros.shapeid].shape[currentTetros.rotation][1]
  currentTetros.position.x = (math.floor((Grid.width - tetrosWidth) / 2)) + 1
  currentTetros.position.y = 1
  timerDrop = dropSpeed
  pauseForceDrop = true
  
  if Collide() then
    Transfer()
    StartGameover()
  end
end

function StartGame()
  score = 0
  level = 1
  lines = 0
  
  gameState = "play"
  dropSpeed = 1
  sndMusicMenu:stop()
  sndMusicGame:play()
  InitGrid()
  InitBag()
  SpawnTetros()
  love.graphics.setFont(fontPlay)
end

function StartMenu()
  gameState = "menu"
  sndMusicGame:stop()
  sndMusicGameover:stop()
  sndMusicMenu:play()
  love.graphics.setFont(fontMenu)
end

function StartGameover()
  gameState = "gameover"
  sndMusicGame:stop()
  sndMusicGameover:play()
  love.graphics.setFont(fontMenu)
end

function InitGrid()
  local h = screen_height / Grid.height
  Grid.cellSize = h
  Grid.offsetX = (screen_width / 2) - (h*Grid.width) / 2
  Grid.offsetY = 0

  Grid.cells = {}
  for l=1,Grid.height do
    Grid.cells[l] = {}
    for c=1,Grid.width do
      Grid.cells[l][c] = 0
    end
  end
end

function RemoveLineGrid(pLine)
  -- Remonte à l'envers depuis la ligne à supprimer
  for l=pLine,2,-1 do
    for c=1,Grid.width do
      Grid.cells[l][c] = Grid.cells[l-1][c]
    end
  end
end

function DrawGrid()
  local h = Grid.cellSize
  local w = h
  local x,y
  local id
  for l=1,Grid.height do
    for c=1,Grid.width do
      x = (c-1)*w
      y = (l-1)*h
      x = x + Grid.offsetX
      y = y + Grid.offsetY
      id = Grid.cells[l][c]
      if id == 0 then
        love.graphics.setColor(255,255,255,50)
      else
        local Color = Tetros[id].color
        love.graphics.setColor(Color[1], Color[2], Color[3])
      end
      love.graphics.rectangle("fill", x, y, w-1, h-1)
    end
  end
end

function DrawShape(pShape, pColor, pColumn, pLine)
  love.graphics.setColor(pColor[1], pColor[2], pColor[3])
  for l=1,#pShape do
    for c=1,#pShape[l] do
      -- Calcule la position initiale de la case
      local x = (c-1) * Grid.cellSize
      local y = (l-1) * Grid.cellSize
      -- Ajoute la position de la pièce
      x = x + (pColumn-1) * Grid.cellSize
      y = y + (pLine-1) * Grid.cellSize
      -- Ajoute l'offset de la grille
      x = x + Grid.offsetX
      y = y + Grid.offsetY
      if pShape[l][c] == 1 then
        love.graphics.rectangle("fill", x, y, Grid.cellSize - 1, Grid.cellSize - 1)
      end
    end
  end
end

function Collide()
  local Shape = Tetros[currentTetros.shapeid].shape[currentTetros.rotation]

  for l=1,#Shape do
    for c=1,#Shape[l] do
      local cInGrid = (c-1) + currentTetros.position.x
      local lInGrid = (l-1) + currentTetros.position.y
      if Shape[l][c] == 1 then
        if cInGrid <= 0 or cInGrid > Grid.width then
          return true
        end
        if lInGrid > Grid.height then
          return true
        end
        if Grid.cells[lInGrid][cInGrid] ~= 0 then
          return true
        end
      end
    end
  end
  return false
end

function Transfer()
  local Shape = Tetros[currentTetros.shapeid].shape[currentTetros.rotation]

  for l=1,#Shape do
    for c=1,#Shape[l] do
      local cInGrid = (c-1) + currentTetros.position.x
      local lInGrid = (l-1) + currentTetros.position.y
      if Shape[l][c] == 1 then
        Grid.cells[lInGrid][cInGrid] = currentTetros.shapeid
      end
    end
  end
  return false
end

function love.load()
  
  love.window.setTitle("Tanguy CHENIER - Tetris")
  
  fontMenu = love.graphics.newFont("blocked.ttf", 50)
  fontPlay = love.graphics.newFont("blocked.ttf", 30)
  
  sndMusicMenu = love.audio.newSource("tetris-gameboy-01.mp3", "static")
  sndMusicMenu:setLooping(true)
  sndMusicGame = love.audio.newSource("tetris-gameboy-02.mp3",  "static")
  sndMusicGame:setLooping(true)
  sndMusicGameover = love.audio.newSource("tetris-gameboy-04.mp3",  "static")
  sndMusicGameover:setLooping(true)
  
  sndLine = love.audio.newSource("line.wav",  "static")
  sndLevel = love.audio.newSource("levelup.wav",  "static")

  love.keyboard.setKeyRepeat(true)

  screen_width = love.graphics.getWidth()
  screen_height = love.graphics.getHeight()

  math.randomseed(os.time())

  InitGrid()
  StartMenu()
  
end

function updateMenu(dt)
  menuSin = menuSin + 5*60*dt
end

function ManageLevel()
  local newLevel = math.floor(lines / 10) + 1
  if newLevel <= 20 then
    if newLevel ~= level then
      sndLevel:play()
      level = newLevel
      dropSpeed = dropSpeed - 0.08
    end
  end
end

function updatePlay(dt)
  if love.keyboard.isDown("down") == false then
    pauseForceDrop = false
  end

  -- Next drop
  timerDrop = timerDrop - dt
  if timerDrop <= 0 then
    currentTetros.position.y = currentTetros.position.y + 1
    timerDrop = dropSpeed
    -- Vérifie si le Tétros de "pose"
    if Collide() then
      currentTetros.position.y = currentTetros.position.y - 1
      Transfer()
      SpawnTetros()
    end
  end
  
  -- Vérifie si il y a des lignes complètes
  local lineComplete
  local nbLines = 0
  for l=1,Grid.height do
    lineComplete = true
    for c=1,Grid.width do
      if Grid.cells[l][c] == 0 then
        lineComplete = false
      end
    end
    -- On supprime la ligne !
    if lineComplete == true then
      nbLines = nbLines + 1
      RemoveLineGrid(l)
    end
  end
  lines = lines + nbLines
  if nbLines == 1 then
    score = score + (100*level)
  elseif nbLines == 2 then
    score = score + (300*level)
  elseif nbLines == 3 then
    score = score + (400*level)
  elseif nbLines == 4 then
    score = score + (800*level)
  end
  if nbLines > 0 then
    sndLine:play()
  end
  ManageLevel()
end

function love.update(dt)
  
  if gameState == "menu" then
    updateMenu(dt)
  elseif gameState == "play" then
    updatePlay(dt)
  elseif gameState == "gameover" then
    --updateGameover(dt)
  end

end

function drawPlay()
  local Shape = Tetros[currentTetros.shapeid].shape[currentTetros.rotation]
  local Color = Tetros[currentTetros.shapeid].color
  DrawShape(Shape, Color, currentTetros.position.x, currentTetros.position.y)

  -- For fun, display the drop speed
  love.graphics.setColor(255,100,0)
  love.graphics.rectangle("line",50,50, 100 * (dropSpeed/dropSpeed), 30)
  love.graphics.rectangle("fill",50,50, 100 * (timerDrop/dropSpeed), 30)
  
  local y = 100
  local h = fontPlay:getHeight("X")
  love.graphics.setColor(255,255,255)
  love.graphics.print("SCORE", 50, y)
  y = y + h
  love.graphics.print(tostring(score), 50, y)
  y = y + h
  y = y + h
  love.graphics.setColor(255,255,255)
  love.graphics.print("LEVEL", 50, y)
  y = y + h
  love.graphics.print(tostring(level), 50, y)
  y = y + h
  y = y + h
  love.graphics.setColor(255,255,255)
  love.graphics.print("LINES", 50, y)
  y = y + h
  love.graphics.print(tostring(lines), 50, y)

--  love.graphics.print("Current Tetrominos: "..tostring(currentTetros.shapeid).."/"..tostring(#Tetros).." Rotation: "..tostring(currentTetros.rotation).."/"..tostring(#Tetros[currentTetros.shapeid]))
end

function drawMenu()
  local Color
  local idColor = 1
  local sMessage = "Tanguy CHENIER - TETRIS"
  local w = fontMenu:getWidth(sMessage)
  local h = fontMenu:getHeight(sMessage)
  local x = (screen_width - w)/2
  local y = 0
  for c=1,sMessage:len() do
    Color = Tetros[idColor].color
    love.graphics.setColor(Color[1], Color[2], Color[3])
    local char = string.sub(sMessage,c,c)
    y = math.sin((x+menuSin)/50)*30
    love.graphics.print(char, x, y + (screen_height - h)/2.5)
    x = x + fontMenu:getWidth(char)
    idColor = idColor + 1
    if idColor > #Tetros then
      idColor = 1
    end
  end
  Color = Tetros[7].color
  love.graphics.setColor(Color[1], Color[2], Color[3])
  sMessage = "PRESS ENTER"
  local w = fontMenu:getWidth(sMessage)
  local h = fontMenu:getHeight(sMessage)
  love.graphics.print(sMessage, (screen_width - w)/2, (screen_height - h)/1.5)
end

function drawGameover()
  love.graphics.setColor(255,255,255)
  local sMessage = "GAME OVER :("
  local w = fontMenu:getWidth(sMessage)
  local h = fontMenu:getHeight(sMessage)
  love.graphics.print(sMessage, (screen_width - w)/2, (screen_height - h)/2)
end

function love.draw()

  DrawGrid()
  
  if gameState == "play" then
    drawPlay()
  elseif gameState == "menu" then
    drawMenu()
  elseif gameState == "gameover" then
    drawGameover()
  end

end

function inputMenu(key)
  if key == "return" then
    StartGame()
  end
end

function inputGameover(key)
  if key == "return" then
    StartMenu()
  end
end

function inputPlay(key)
  local Shape = Tetros[currentTetros.shapeid].shape[currentTetros.rotation]

  -- Sauvegarde l'état courant
  local oldX = currentTetros.position.x
  local oldY = currentTetros.position.y
  local oldRotation = currentTetros.rotation

  -- Tetros mouvement latéral et rotation
  if key == "right" then
    currentTetros.position.x = currentTetros.position.x + 1
  end
  if key == "left" then
    currentTetros.position.x = currentTetros.position.x - 1
  end
  if key == "up" then
    currentTetros.rotation = currentTetros.rotation + 1
    if currentTetros.rotation > #Tetros[currentTetros.shapeid].shape then currentTetros.rotation = 1 end
  end
  -- Vérifie la collision après le déplacement latéral
  if Collide(Shape) then
    currentTetros.position.x = oldX
    currentTetros.position.y = oldY
    currentTetros.rotation = oldRotation
  end

  -- Tetros mouvement vertical
  if pauseForceDrop == false then
    if key == "down" then
      currentTetros.position.y = currentTetros.position.y + 1
    end
    -- Vérifie si le Tétros de "pose"
    if Collide() then
      currentTetros.position.y = oldY
      Transfer()
      SpawnTetros()
    end
  end
  
  -- Touches de debug
  if key == "y" then
    SpawnTetros()
  end
  if key == "t" then
    currentTetros.shapeid = currentTetros.shapeid + 1
    if currentTetros.shapeid > #Tetros then currentTetros.shapeid = 1 end
    currentTetros.rotation = 1
  end
  if key == "r" then
    currentTetros.rotation = currentTetros.rotation + 1
    if currentTetros.rotation > #Tetros[currentTetros.shapeid] then currentTetros.rotation = 1 end
  end
end

function love.keypressed(key)

  if gameState == "menu" then
    inputMenu(key)
  elseif gameState == "play" then
    inputPlay(key)
  elseif gameState == "gameover" then
    inputGameover(key)
  end
  
end
