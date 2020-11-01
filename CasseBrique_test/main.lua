io.stdout:setvbuf('no') -- Used to print in terminal
love.graphics.setDefaultFilter("nearest")
if arg[#arg] == "-debug" then require("mobdebug").start() end
math.randomseed(love.timer.getTime()) -- get sure that the timer works

local largeur
local hauteur
local lstBrick = {}
local pad = {}
local ball = {}
local soundBall = love.audio.newSource("Sounds/ball.wav", "static")

function love.load()
  
  largeur = love.graphics.getWidth()
  hauteur = love.graphics.getHeight()
  
  pad.hauteur = 50
  pad.largeur = 100
  pad.x = 0
  pad.y = hauteur - pad.hauteur
  
  ball.radius = 20
  ball.y = hauteur / 2
  ball.x = largeur / 2
  ball.vx = 6
  ball.vy = 6
  
  for ligne = 0, largeur / 15 do
    for colonne = 0, 3 do
      
      local brick = {}
      
      brick.largeur = largeur / 15
      brick.hauteur = 30
      brick.x = ligne * brick.largeur
      brick.y = colonne * brick.hauteur
      
      table.insert(lstBrick, brick)
    end
  end
  
end

function love.update(dt)

  -- ball
  ball.y = ball.y + ball.vy
  ball.x = ball.x + ball.vx
  
  if ball.x <= 0 + ball.radius or ball.x >= largeur - ball.radius then
    ball.vx = -ball.vx
    soundBall:play()
  end
  
  if ball.y - ball.radius <= 0 or ball.y >= hauteur - ball.radius then
    ball.vy = -ball.vy
    soundBall:play()
  end
  
  if ball.y + ball.radius >= pad.y then
    
    if ball.x >= pad.x - ball.radius and ball.x <= pad.x + pad.largeur then
      ball.y = pad.y - ball.radius
      ball.vy = -ball.vy
      soundBall:play()
    end
  end
  
  -- pad
  pad.x = love.mouse.getX()
  if pad.x <= 0 then
    pad.x = 0
  end
  if pad.x >= largeur - pad.largeur then
    pad.x = largeur - pad.largeur
  end
  
  --bricks
  for i = #lstBrick, 1, -1 do
    brick = lstBrick[i]
    
    if ball.y <= brick.y + brick.hauteur then
      if ball.x >= brick.x + ball.radius and ball.x <= brick.x + brick.largeur then
        ball.y = brick.y + brick.hauteur
        ball.vy = -ball.vy
        soundBall:play()
        
        table.remove(lstBrick, i)        
      end
    end
  end


end

function love.draw()
  largeur = love.graphics.getWidth()
  hauteur = love.graphics.getHeight()
  
  -- bricks
  for i = 1, #lstBrick do
    local brick = lstBrick[i]

    love.graphics.rectangle("fill", brick.x, brick.y, brick.largeur - 3, brick.hauteur - 3)
  end


  love.graphics.rectangle("fill", pad.x, pad.y, pad.largeur, pad.hauteur)
  

  
  love.graphics.circle("fill", ball.x, ball.y, ball.radius)

end

function love.mousepressed(px, py, pn)

end