io.stdout:setvbuf('no') -- Used to print in terminal

local width = love.graphics.getWidth()
local height = love.graphics.getHeight()

local engine = {}
local ship = {}

ship.picture = love.graphics.newImage("pictures/ship.png")
ship.x = width / 2
ship.y = height / 2
ship.radius = -90
ship.vx = 0
ship.vy = 0
ship.enginePicture = love.graphics.newImage("pictures/engine.png")
ship.engineIsOn = false
ship.speed = 3

function love.load()

end

function love.update(dt)
  ship.vy = ship.vy + (0.6 * dt)
  ship.y = ship.y + ship.vy
  ship.x = ship.x + ship.vx
  
  if love.keyboard.isDown("left") then
    ship.radius = ship.radius - 0.07
  end
  
  if love.keyboard.isDown("right") then
    ship.radius = ship.radius + 0.07
  end
  
  if love.keyboard.isDown("up") then
    ship.engineIsOn = true
    
    local forceX = math.cos(ship.radius) * (ship.speed * dt)
    local forceY = math.sin(ship.radius) * (ship.speed * dt)
    
    ship.vx = ship.vx + forceX
    ship.vy = ship.vy + forceY
    
  else
    ship.engineIsOn = false
  end
  
  if ship.y + ship.picture:getHeight() / 2 >= height then
    ship.y = height - ship.picture:getHeight() / 2
    ship.vy = -ship.vy
  end
  
end

function love.draw()
  -- ship
  love.graphics.draw(ship.picture, ship.x, ship.y, ship.radius, 1, 1, ship.picture:getWidth()/2, ship.picture:getHeight()/2)
  
  -- engine of the ship
  if ship.engineIsOn == true then
    love.graphics.draw(ship.enginePicture, ship.x, ship.y, ship.radius, 1, 1, ship.enginePicture:getWidth()/2, ship.enginePicture:getHeight()/2)
  end
end