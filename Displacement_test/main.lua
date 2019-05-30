io.stdout:setvbuf('no') -- Used to print in terminal
 
local picture
local width
local height
local picture_width
local picture_height
local right = true
local position = 0

function love.load()
  picture = love.graphics.newImage("pictures/heros.png")
  picture_width = picture:getWidth()
  picture_height = picture:getHeight()
  width = love.graphics.getWidth()
  height = love.graphics.getHeight()
  
end

function love.update(dt)

  if position <= 0 then right = true end
  if position > math.floor(width - picture_width) then right = false end
  if (right) then
      position = math.floor(position + 4 * 60 * dt)
  else
      position = math.floor(position - 4 * 60 * dt)
  end
end

function love.draw()
  love.graphics.line(width / 2, 0, width / 2, height)
  love.graphics.line(0, height /2, width, height / 2)
  love.graphics.print(position.."\n"..math.floor(width))

  love.graphics.draw(picture, position, height / 2 - picture_height / 2)
end