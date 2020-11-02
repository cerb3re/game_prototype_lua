-- WORK IN PROGRESS

local frameWidth
local animations = {}
animations.pictures = love.graphics.newImage("animations.png")
animations.pictureH = animations.pictures:getHeight() / 2
animations.pictureW = animations.pictures:getWidth() / 6
animations.quad = love.graphics.newQuad(0, 0, animations.pictureW, animations.pictureH, animations.pictures:getDimensions())
animations.frame = 1

function love.load()
  --love.graphics.setBackgroundColor(1, 1, 1, 1)
  frameWidth = animations.pictureH
end

function love.update(dt)
  
  animations.frame = animations.frame + 3 * dt
  
  if animations.frame >= 7 then
    animations.frame = 1
  end
  
end

function love.draw()  
  
  
  local frameArrondie = math.floor(animations.frame)
  local width = animations.pictureW * frameArrondie
  if animations.frame >= 7 then
    width = frameWidth
  end
  
  --local height = animations.pictureW
  
  animations.pictureW = width
  animations.quad = love.graphics.newQuad(0, 0, animations.pictureW, animations.pictureH, animations.pictures:getDimensions())

  love.graphics.print(tostring(frameArrondie))
  love.graphics.print(tostring(width), 0, 30)
  love.graphics.print(tostring(frameWidth), 0, 30 * 2)

  love.graphics.draw(animations.pictures, animations.quad, 50, 50)
end

