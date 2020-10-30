io.stdout:setvbuf('no') -- Used to print in terminal
love.graphics.setDefaultFilter("nearest")
if arg[#arg] == "-debug" then require("mobdebug").start() end
math.randomseed(love.timer.getTime()) -- get sure that the timer works

local largeur = love.graphics.getWidth()
local hauteur = love.graphics.getHeight()

local lstPad = {}

local ball = {}
ball.w = 40
ball.h = 40
ball.vx = 0.5
ball.vy = 0.5
ball.x = largeur / 2
ball.y = hauteur / 2

function createPad(pX, pY, pW, pH)
  local pad = {}
  pad.x = pX
  pad.y = pY
  pad.w = pW
  pad.h = pH
  
  table.insert(lstPad, pad)
end

function centrerLaBalle()
  ball.x = (largeur / 2) + (ball.w / 2) 
  ball.y = (hauteur / 2) + (ball.h / 2)
  ball.vx = 0.5
  ball.vy = 0.5
end

function love.load()
  love.window.setMode(1024, 768, {resizable=true, vsync=false, minwidth=400, minheight=300})
  hauteur = love.graphics.getHeight()
  largeur = love.graphics.getWidth()
  
  createPad(0,0,50, 100)
  createPad(largeur - 50,hauteur - 100,50, 100)
end

function love.draw()
  
  for i = 1, #lstPad do
    local pad = lstPad[i]
  
    love.graphics.rectangle("fill", pad.x, pad.y, pad.w, pad.h)
  end
  
  love.graphics.rectangle("fill", ball.x, ball.y, ball.w, ball.h)
end

function love.update(dt)
  hauteur = love.graphics.getHeight()
  largeur = love.graphics.getWidth()
  
  ball.x = ball.x + ball.vx
  ball.y = ball.y + ball.vy
  
  if ball.x <= 0 then
    centrerLaBalle()
  end
  
  if ball.x >= largeur - ball.w or ball.x <= 0 then
    ball.vx = -ball.vx
  end
  
  if ball.y >= hauteur - ball.h or ball.y <= 0 then
    ball.vy = -ball.vy
  end
  
  for i = 1, #lstPad do
    local pad = lstPad[i]
    
    if ball.x <= pad.x + pad.w and i == 1 then
      if ball.y <= pad.y + pad.h and ball.y + ball.h >= pad.y then
        ball.vx = -ball.vx
        ball.x = pad.x + pad.w
      end
    end 
    
    if i == 2 then
      pad.y = ball.y
    end
    
    if ball.x + ball.w >= pad.x and i == 2 then
      if ball.y <= pad.y + pad.h and ball.y + ball.h >= pad.y then
        ball.vx = -ball.vx
        ball.x = pad.x - pad.w
      end
    end
    
    if love.keyboard.isDown("down") and i == 1 then
      if pad.y >= hauteur - pad.h then
        pad.y = hauteur - pad.h
      else
        pad.y = pad.y + 1
      end
    end
    
    if love.keyboard.isDown("up") and i == 1 then
      if pad.y > 0 then
        pad.y = pad.y - 1
      else
        pad.y = 0
      end
    end
    
  end

end

function love.keypressed(key)

end