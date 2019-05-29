io.stdout:setvbuf('no') -- Used to print in terminal

local Lander = {} -- Lander, as object 
Lander.x = 0
Lander.y = 0
Lander.angle = 270
Lander.velocity_x = 0
Lander.velocity_y = 0
Lander.speed = 3
Lander.max_speed = 1
Lander.engine_is_on = false
Lander.image = love.graphics.newImage("pictures/ship.png")
Lander.image_engine = love.graphics.newImage("pictures/engine.png")
Lander.test = 0
function love.load()
  width = love.graphics.getWidth()
  height = love.graphics.getHeight()
  
  Lander.x = width / 2
  Lander.y = height / 2
end

function love.update(dt)
  if love.keyboard.isDown("right") then
    Lander.angle = Lander.angle + 90 * dt
    if Lander.angle > 360 then
      Lander.angle = 0
    end
  end
  if love.keyboard.isDown("left") then
    Lander.angle = Lander.angle - 90  * dt -- 3 times 90° = 270 ° from the initial position
    if Lander.angle < 0 then
      Lander.angle = 360
    end
  end
    if love.keyboard.isDown("up") then
      Lander.engine_is_on = true

      local radian_angle = math.rad(Lander.angle)
      local strenght_x = math.cos(radian_angle) * Lander.speed * dt
      local strenght_y = math.sin(radian_angle) * Lander.speed * dt

      Lander.velocity_x = Lander.velocity_x + strenght_x
      Lander.velocity_y = Lander.velocity_y + strenght_y
    else
      Lander.engine_is_on = false
  end
 
  Lander.velocity_y = Lander.velocity_y + (0.6 * dt) -- Gravity
  
  if math.abs(Lander.velocity_x) > 1 then
    if Lander.velocity_x > 0 then
      Lander.velocity_x = 1
    else
      Lander.velocity_x = -1
    end
  end

  if math.abs(Lander.velocity_y) > 1 then
    if Lander.velocity_y > 0 then
      Lander.velocity_y = 1
    else
      Lander.velocity_y = -1
    end
  end 

  Lander.x = Lander.x + Lander.velocity_x
  Lander.y = Lander.y + Lander.velocity_y
end

function love.draw()
  love.graphics.draw(Lander.image, Lander.x, Lander.y, math.rad(Lander.angle), 1, 1, Lander.image:getWidth() / 2, Lander.image:getHeight() / 2)
  
  if Lander.engine_is_on then
    love.graphics.draw(Lander.image_engine, Lander.x, Lander.y, math.rad(Lander.angle), 1, 1, Lander.image_engine:getWidth() / 2, Lander.image_engine:getHeight() / 2)

  end
  
  -- debug
  local debug_speed_debug = "speed="..tostring(math.abs(Lander.velocity_x + Lander.velocity_y))
  local debug_vx = "vx="..tostring(Lander.velocity_x)
  local debug_vy = "vy="..tostring(Lander.velocity_y)
  local debug_angle = "angle="..tostring(Lander.angle)
  local debug = debug_angle.."\n"..debug_speed_debug.."\n".."test="..tostring(Lander.test).."\n"..debug_vx.."\n"..debug_vy
  love.graphics.print(debug)
end