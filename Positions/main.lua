function love.draw()
  local x2 = love.mouse.getX()
  local y2 = love.mouse.getY()
  
  local v = "("..x2..","..y2..")"
  
  love.graphics.line(0, y2, x2 + 15, y2)
  love.graphics.line(x2, 0, x2, y2 + 15)
  
  love.graphics.print(x2, x2, 0)
  love.graphics.print(y2, 0, y2)
  love.graphics.print(v, x2 +15, y2+15)
end