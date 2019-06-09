io.stdout:setvbuf('no') -- Used to print in terminal
love.graphics.setDefaultFilter("nearest")
if arg[#arg] == "-debug" then require("mobdebug").start() end
local sound_voyager
local scale_zoom
local kirk

sound_voyager = love.audio.newSource("sounds/voyager_transporter.mp3", "static")
scale_zoom    = 20
kirk          = {}
kirk.isBeam   = true
kirk.beamLvl  = 1
kirk.maxPerc  = 60
kirk.image    = nil
kirk.x        = 0
kirk.y        = 0
math.randomseed(love.timer.getTime()) -- get sure that the timer works

function love.load()
  love.graphics.setBackgroundColor(0.101,0.117,0.166)
  love.audio.play(sound_voyager)

  screen_height = love.graphics.getHeight() / scale_zoom
  screen_width  = love.graphics.getWidth() / scale_zoom

  kirk.image    = love.graphics.newImage("pictures/kirk.png")
  kirk.x        = math.floor(screen_width / 2) - kirk.image:getWidth() / 2
  kirk.y        = math.floor(screen_height / 2) - kirk.image:getHeight() / 2
end

local mask_shader = love.graphics.newShader[[
   vec4 effect(vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords) {
      if (Texel(texture, texture_coords).rgba == vec4(0.0)) {
         discard;
      }
      return vec4(1.0);
   }
]]

-- pochoir
local function my_stencil()
  love.graphics.setShader(mask_shader)
  love.graphics.draw(kirk.image, kirk.x, kirk.y)
  love.graphics.setShader()
end

function love.draw()
  love.graphics.scale(scale_zoom)

  if kirk.isBeam == false then
    love.graphics.draw(kirk.image, kirk.x, kirk.y)
  else
    love.graphics.setColor(50,50,50, 50 * (kirk.beamLvl / kirk.maxPerc) / 50)
    love.graphics.draw(kirk.image, kirk.x, kirk.y)

    local percent
    if kirk.beamLvl <= kirk.maxPerc / 2 then
      percent = (kirk.beamLvl * 2 / 100)
    else
      percent = ((kirk.maxPerc - kirk.beamLvl ) * 2) / 100
    end
    local l, h      = kirk.image:getWidth(), kirk.image:getHeight()
    local point_nb  = (l * h) * percent
    local np

    love.graphics.stencil(my_stencil, "replace", 1) -- créer un pochoir à pour mettre un 1 à la place des coords
    love.graphics.setStencilTest("greater", 0)
    love.graphics.setColor(253 / 50, 251 / 50, 212 / 50, 50)
    for np = 1, point_nb do
      local rx, ry = math.random(0, l - 1), math.random(0, h - 1)

      love.graphics.rectangle("fill", kirk.x + rx, kirk.y + ry, 1 ,1)
    end
    love.graphics.setStencilTest()
  end

end

function love.update(dt)
  local coeff

  coeff = 0.4 * 60 * dt
  if kirk.isBeam then
    kirk.beamLvl = kirk.beamLvl + coeff

    if kirk.beamLvl >= kirk.maxPerc then
      kirk.isBeam   = false
      kirk.beamLvl  = 1
    end
  end

end

