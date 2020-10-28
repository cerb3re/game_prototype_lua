io.stdout:setvbuf('no') -- Used to print in terminal
love.graphics.setDefaultFilter("nearest")
if arg[#arg] == "-debug" then require("mobdebug").start() end
math.randomseed(love.timer.getTime()) -- get sure that the timer works

local largeur = love.graphics.getWidth()
local hauteur = love.graphics.getHeight()

local pad = {}
pad.x = 0
pad.y = 0
pad.w = 50
pad.h = 100

local ball = {}
ball.w = 40
ball.h = 40
ball.vx = 0.5
ball.vy = 0.5
ball.x = largeur / 2
ball.y = hauteur / 2

function love.load()
  love.window.setMode(1024, 768, {resizable=true, vsync=false, minwidth=400, minheight=300})
end

function love.draw()
  love.graphics.rectangle("fill", pad.x, pad.y, pad.w, pad.h)
  love.graphics.rectangle("fill", ball.x, ball.y, ball.w, ball.h)
end

function love.update(dt)
  hauteur = love.graphics.getHeight()
  largeur = love.graphics.getWidth()
  
  ball.x = ball.x + ball.vx
  ball.y = ball.y + ball.vy
  
  if ball.x >= largeur - ball.w or ball.x <= 0 or (ball.x <= pad.x + ball.w and ball.y <= pad.y + ball.h) then
    ball.vx = -ball.vx
  end
  
  if ball.y >= hauteur - ball.h or ball.y <= 0 then
    ball.vy = -ball.vy
  end
  
  if love.keyboard.isDown("down") then
    if pad.y >= hauteur - pad.h then
      pad.y = hauteur - pad.h
    else
      pad.y = pad.y + 1
    end
  end
  
  if love.keyboard.isDown("up") then
    if pad.y > 0 then
      pad.y = pad.y - 1
    else
      pad.y = 0
    end
  end
end

function love.keypressed(key)

end