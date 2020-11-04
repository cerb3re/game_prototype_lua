local hero = {}

hero.images = {}
hero.images[1] = love.graphics.newImage("images/player_1.png")
hero.images[2] = love.graphics.newImage("images/player_2.png")
hero.images[3] = love.graphics.newImage("images/player_3.png")
hero.images[4] = love.graphics.newImage("images/player_4.png")
hero.imgCurrent = 1
hero.line = 1
hero.column = 1

function hero.Update(dt)
end

function hero.Draw(dt)
end

return hero