io.stdout:setvbuf('no') -- Used to print in terminal
love.graphics.setDefaultFilter("nearest")
if arg[#arg] == "-debug" then require("mobdebug").start() end
math.randomseed(love.timer.getTime()) -- get sure that the timer works


Tilemap = {}

Tilemap[1] = {1,1,1,1,1}
Tilemap[2] = {1,2,2,1,1}
Tilemap[3] = {1,2,1,1,1}
Tilemap[4] = {1,1,1,1,1}
Tilemap[5] = {1,1,1,1,1}

Selection = {}
Selection.l = 1
Selection.c = 1

function createTile()
  
end

function love.load()

end

function love.draw()
  
  local y=1
  local x
  
  for c=1, #Tilemap do
    x = 1
    for l=1, #Tilemap do
      if Tilemap[l][c] == 1 then
        love.graphics.setColor(.5,1,.5,1)
      elseif Tilemap[l][c] == 2 then
        love.graphics.setColor(1,.2,0,1)
      end
      
      love.graphics.rectangle("fill",x,y,19,19)

      if Selection.c == c and Selection.l == l then
        love.graphics.setColor(1,1,1,1)
        love.graphics.rectangle("line",x,y,18,18)
        love.graphics.rectangle("line",x+1,y+1,17,17)
      end
      
      x = x + 20
    end
    y = y + 20
  end
  
end

function love.keypressed(key)
  
  if key == "right" then
    Selection.l = Selection.l + 1
  end
  
  if key == "left" then
    Selection.l = Selection.l - 1
  end
  
  if key == "down" then
    Selection.c = Selection.c + 1
  end
  
  if key == "up" then
    Selection.c = Selection.c - 1
  end
  
end