io.stdout:setvbuf('no') -- Used to print in terminal
love.graphics.setDefaultFilter("nearest")
if arg[#arg] == "-debug" then require("mobdebug").start() end
math.randomseed(love.timer.getTime()) -- get sure that the timer works

local largeur = love.graphics.getWidth()
local hauteur = love.graphics.getHeight()
local wall = love.audio.newSource("mur.wav", "static")
local lstRacket = {}
local ball = {}

ball.x = 0
ball.y = 0
ball.vx = 0
ball.vy = 0
ball.active = false
ball.isShooting = false

function addRacket(pX, pY, pWidth, pHeight)
  local racket
  
  racket = {}
  racket.x = pX
  racket.y = pY
  racket.width = pWidth
  racket.height = pHeight
  
  table.insert(lstRacket, racket)
end

function love.load()
  love.window.setMode(1024, 768, {resizable=true, vsync=false, minwidth=400, minheight=300})
  
  addRacket(0,0,100,50)
  addRacket(0,768 - 50,100,50)
end

function love.draw()
  
  for i = 1, #lstRacket do
    local racket = lstRacket[i]
    
    love.graphics.rectangle("fill", racket.x, racket.y, racket.width, racket.height)
  end
  
  if ball.active == true then
    love.graphics.rectangle("fill", ball.x, ball.y, 40,40)
  end
  
end

function love.update(dt)
  lstRacket[1].x = love.mouse.getX()
  
  if ball.active == true then
    if ball.isShooting == false then
      ball.x = lstRacket[1].x
      ball.isShooting = true
    end
    ball.vy = 0.5
    ball.y = ball.y + ball.vy
  end
  
  if ball.active == false then
    ball.x = 0
    ball.y = 0
    ball.vx = 0
    ball.vy = 0
    ball.isShooting = false
  end
  
  if ball.y >= (768 - 50) then
    ball.active = false
    wall:play()
  end

end

function love.keypressed(key)
 
  if key == "space" then
    ball.active = true
  end
  
end