io.stdout:setvbuf('no') -- Used to print in terminal
love.graphics.setDefaultFilter("nearest")
if arg[#arg] == "-debug" then require("mobdebug").start() end
math.randomseed(love.timer.getTime()) -- get sure that the timer works

lst_heros = {}
level = {}
liste_sprites = {}
liste_tirs = {}
liste_aliens = {}
lst_tiles_pictures = {}
lst_tiles_explosion = {}
camera = {}

actual_screen = "menu"
screen_picture = love.graphics.newImage("pictures/menu.png")
death_picture = love.graphics.newImage("pictures/gameover.jpg")
victory_picture = love.graphics.newImage("pictures/victory.jpg")
title_game = "test"
sound_shoot = love.audio.newSource("sounds/shoot.wav", "static")
sound_explode = love.audio.newSource("sounds/explode_touch.wav", "static")
theme_sound = love.audio.newSource("sounds/theme.mp3", "static")
theme_sound:setVolume(0.1)
gameover_sound = love.audio.newSource("sounds/gameover.mp3", "static")
camera.y = 0
camera.speed = 1


table.insert(level, { 0,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0 })
table.insert(level, { 0,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0 })
table.insert(level, { 0,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0 })
table.insert(level, { 0,2,2,2,2,0,0,0,0,0,0,0,0,0,0,0 })
table.insert(level, { 0,0,0,0,0,0,1,1,1,1,1,1,1,1,0,0 })
table.insert(level, { 0,0,0,0,0,0,1,1,1,1,1,1,1,1,0,0 })
table.insert(level, { 0,0,0,0,0,0,1,1,1,1,1,1,1,1,0,0 })
table.insert(level, { 0,0,0,0,0,0,1,1,1,1,1,1,1,1,0,0 })
table.insert(level, { 0,0,0,0,0,0,1,1,1,1,1,1,1,1,0,0 })
table.insert(level, { 0,0,0,0,0,0,2,2,2,2,2,2,2,2,0,0 })
table.insert(level, { 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 })
table.insert(level, { 0,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0 })
table.insert(level, { 0,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0 })
table.insert(level, { 0,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0 })
table.insert(level, { 0,2,2,2,2,0,0,0,0,0,0,0,0,0,0,0 })
table.insert(level, { 0,0,0,0,0,0,1,1,1,1,1,1,1,1,0,0 })
table.insert(level, { 0,0,0,0,0,0,1,1,1,1,1,1,1,1,0,0 })
table.insert(level, { 0,0,0,0,0,0,1,1,1,1,1,1,1,1,0,0 })
table.insert(level, { 0,0,0,0,0,0,1,1,1,1,1,1,1,1,0,0 })
table.insert(level, { 0,0,0,0,0,0,1,1,1,1,1,1,1,1,0,0 })
table.insert(level, { 0,0,0,0,0,0,2,2,2,2,2,2,2,2,0,0 })
table.insert(level, { 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 })
table.insert(level, { 0,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0 })
table.insert(level, { 0,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0 })
table.insert(level, { 0,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0 })
table.insert(level, { 0,2,2,2,2,0,0,0,0,0,0,0,0,0,0,0 })
table.insert(level, { 0,0,0,0,0,0,1,1,1,1,1,1,1,1,0,0 })
table.insert(level, { 0,0,0,0,0,0,1,1,1,1,1,1,1,1,0,0 })
table.insert(level, { 0,0,0,0,0,0,1,1,1,1,1,1,1,1,0,0 })
table.insert(level, { 0,0,0,0,0,0,1,1,1,1,1,1,1,1,0,0 })
table.insert(level, { 0,0,0,0,0,0,1,1,1,1,1,1,1,1,0,0 })
table.insert(level, { 0,0,0,0,0,0,2,2,2,2,2,2,2,2,0,0 })
table.insert(level, { 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 })
table.insert(level, { 0,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0 })
table.insert(level, { 0,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0 })
table.insert(level, { 0,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0 })
table.insert(level, { 0,2,2,2,2,0,0,0,0,0,0,0,0,0,0,0 })
table.insert(level, { 0,0,0,0,0,0,1,1,1,1,1,1,1,1,0,0 })
table.insert(level, { 0,0,0,0,0,0,1,1,1,1,1,1,1,1,0,0 })
table.insert(level, { 0,0,0,0,0,0,1,1,1,1,1,1,1,1,0,0 })
table.insert(level, { 0,0,0,0,0,0,1,1,1,1,1,1,1,1,0,0 })
table.insert(level, { 0,0,0,0,0,0,1,1,1,1,1,1,1,1,0,0 })
table.insert(level, { 0,0,0,0,0,0,2,2,2,2,2,2,2,2,0,0 })
table.insert(level, { 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 })
table.insert(level, { 3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3 })

-- pictures of tiles composing the screen
for i=1, 3 do
  lst_tiles_pictures[i] = love.graphics.newImage("pictures/tuile_"..i..".png")
end

-- pictures of the explosion
for i=1, 5 do
  lst_tiles_explosion[i] = love.graphics.newImage("pictures/explode_"..i..".png")
end

----------------------------------------------------------------------
function collide(a1, a2)
 if (a1==a2) then return false end

 local dx = a1.x - a2.x
 local dy = a1.y - a2.y

 if (math.abs(dx) < a1.image:getWidth()+a2.image:getWidth()) then
  if (math.abs(dy) < a1.image:getHeight()+a2.image:getHeight()) then
   return true
  end
 end

 return false
end
----------------------------------------------------------------------
function math.angle(x1,y1, x2,y2) return math.atan2(y2-y1, x2-x1) end
----------------------------------------------------------------------
function create_sprite(pimg, px, py)
  sprite = {}
  sprite.x = px
  sprite.y = py
  sprite.image = love.graphics.newImage("pictures/"..pimg..".png")
  sprite.height = sprite.image:getHeight()
  sprite.width = sprite.image:getWidth()
  sprite.delete_sprite = false
  sprite.frame = 1
  sprite.frame_max = 1
  sprite.frames_lst = {}
  
  table.insert(lst_sprites, sprite)
  
  return sprite
end
----------------------------------------------------------------------
function create_explosion(px, py)
  local new_explosion = create_sprite("explode_1", px, py)
  new_explosion.frames_lst = lst_tiles_explosion
  new_explosion.frame_max = 5
end
----------------------------------------------------------------------
function create_shoot(pType, pPicture, px, py, pSpeedX, pSpeedY)    
  local shoot = create_sprite(pPicture, px, py)
  shoot.type = pType
  shoot.velocity_x = pSpeedX
  shoot.velocity_y = pSpeedY
  shoot.shoot_speed = pSpeedY
  
  table.insert(lst_shoots, shoot)
  love.audio.play(sound_shoot)
end
-----------------------------------------------------------------
function create_hero(pType, px, py)
  image = "heros"

  local hero = create_sprite(image, px, py)

  if pType == 1 then
    hero.energy = 10
  end
  table.insert(lst_heros, hero)

  return hero
end
-----------------------------------------------------------------
function create_alien(pType, px, py)
  alien_picture = ""
  
  if pType == 1 then alien_picture = "enemy1"
  elseif pType == 2 then alien_picture = "enemy2"
  elseif pType == 3 then alien_picture = "enemy3"
  elseif pType == 4 then alien_picture = "tourelle"
  elseif pType == 5 then alien_picture = "enemy3"
  end

  local alien = create_sprite(alien_picture, px, py)
  alien.chrono_shoot = 0
  alien.is_asleep = true
  alien.type = pType
  
  if pType == 1 then
    alien.velocity_y = 2 -- |
    alien.velocity_x = 0 -- __
    alien.energy = 1
  elseif pType == 2 then
    local direction = math.random(1, 2)
    alien.velocity_y = 2
    alien.energy = 2
    
    if direction == 1 then
      alien.velocity_x = 1
    else
      alien.velocity_x = -1
    end
  elseif pType == 3 then
    alien.velocity_x = 0
    alien.velocity_y = camera.speed
    alien.energy = 5
  elseif pType == 5 then
    alien.velocity_x = 0
    alien.velocity_y = camera.speed * 2
    alien.energy = 10
    alien.angle = 0
    end

  table.insert(lst_aliens, alien)
end
-----------------------------------------------------------------
function love.load()
  love.window.setMode(1024, 768)
  love.window.setTitle(title_game)

  width = love.graphics.getWidth()
  height = love.graphics.getHeight()
    
  init_game()
end
----------------------------------------------------------------------
function keypress_menu(key)
  if key == "space" then
    actual_screen = "game"
  end
end
----------------------------------------------------------------------
function keypress_game(key)
  if key == "space" then
   create_shoot("gamer", "laser1", heros.x, (heros.y * 2) / 2, 0, -10)
  end
end
-----------------------------------------------------------------
function love.keypressed(key)
  if actual_screen == "menu" then
    keypress_menu(key)
  elseif actual_screen == "game" then
    keypress_game(key)
  end
end
----------------------------------------------------------------------
function death_menu()
    actual_screen = "dead"
end
----------------------------------------------------------------------
function update_dead(key)
  
end

function update_victory(key)
  actual_screen = "victory"
end
----------------------------------------------------------------------
function update_menu()
  actual_screen = "menu"
end
----------------------------------------------------------------------
function update_game(dt)
    -- camera movement
  camera.y = camera.y + camera.speed * (60 * dt)
  
  local i
  for i = #lst_shoots, 1, -1 do
    local shoot = lst_shoots[i]
    shoot.x = shoot.x + (shoot.velocity_x) * (60 * dt)
    shoot.y = shoot.y + (shoot.velocity_y) * (60 * dt)

    -- If the alien touch the player
    if shoot.type == "alien" then
      if collide(heros, shoot) then
        shoot.delete_sprite = true
        table.remove(lst_shoots, i)
        heros.energy = heros.energy - 1
        -- if the heros have no energy, goto dead screen
        if heros.energy <= 0 then
          actual_screen = "dead"
        end
      end
    end
    -- if the player touch the alien
    if shoot.type == "gamer" then
        local nAlien
        for nAlien=#lst_aliens,1,-1 do
          local alien = lst_aliens[nAlien]

          if alien.is_asleep == false then

            if collide(shoot,alien) then
              create_explosion(shoot.x, shoot.y)
              shoot.delete_sprite = true
              table.remove(lst_shoots, i)
              alien.energy = alien.energy - 1
              love.audio.play(sound_explode)

              if alien.energy <= 0 then
                local nExplosion
                for nExplosion=1,5 do
                  create_explosion(alien.x + math.random(-10,10), alien.y + math.random(-10,10))
                end

                if alien.type == 5 then
                  victory = true
                  timer_victory = 200
                  for nExplosion=1, 20 do
                    create_explosion(alien.x + math.random(-100,100), alien.y + math.random(-100,100))
                  end
                end

                alien.delete_sprite = true
                table.remove(lst_aliens, nAlien)
              end
            end

          end
        end
      end 
    
    -- if the sending shoot is not in the screen, we must delete it
    if (shoot.y < 0 or shoot.y > height) and shoot.delete_sprite == false then 
        shoot.delete_sprite = true
        table.remove(lst_shoots, i)
    end

  end -- FIN DE LA BOUCLE

  -- treatment of Aliens 
  for i=#lst_aliens, 1, -1 do
    local alien = lst_aliens[i]
    
    if alien.y > 0 then alien.is_asleep = false end
    
    if alien.is_asleep == false then
      alien.x = alien.x + alien.velocity_x * (60 * dt)
      alien.y = alien.y + alien.velocity_y * (60 * dt)
      
      if alien.type == 1 or alien.type == 2 then
        alien.chrono_shoot = alien.chrono_shoot - 1 * (60 * dt)
          if alien.chrono_shoot <= 0 then
            alien.chrono_shoot = math.random(60,100)   

            create_shoot("alien", "laser2", alien.x, alien.y, 0, 10)
          end
      elseif alien.type == 3 or alien.type == 4 then
        alien.chrono_shoot = alien.chrono_shoot - 1 * (60 * dt)
        
        if alien.chrono_shoot <= 0 then
          alien.chrono_shoot = 40        
          
          local vx, vy, angle
          angle = math.angle(alien.x, alien.y, heros.x, heros.y)

          vx = 10 * math.cos(angle)
          vy = 10 * math.sin(angle)
            
          create_shoot("alien", "laser2", alien.x, alien.y, vx, vy)
        end
      elseif alien.type == 5 then -- BOSS
        if alien.y > height / 3 then
          alien.y = height / 3
        end

        alien.chrono_shoot = alien.chrono_shoot - 1 * (60 * dt)
        if alien.chrono_shoot <= 0 then
          local vx, vy

          alien.chrono_shoot = 15
          alien.angle = alien.angle + 0.5
          vx = 10 * math.cos(alien.angle)
          vy = 10 * math.sin(alien.angle) 

          create_shoot("alien", "laser2", alien.x, alien.y, vx, vy)
        end
      end

    else
      alien.y = alien.y + camera.speed * (60 * dt)
    end
  end
    -- Purge of the sprites 
  for i=#lst_sprites , 1, -1 do
    local sprite = lst_sprites[i]

    if sprite.frame_max > 1 then
      sprite.frame = sprite.frame + 0.2
      if math.floor(sprite.frame) > sprite.frame_max then
          sprite.delete_sprite = true
        else
          sprite.image = sprite.frames_lst[math.floor(sprite.frame)]
        end
      end

      if sprite.delete_sprite == true then
      
      table.remove(lst_sprites,i)
    end
  end

  -- CONTROL PAD
  if love.keyboard.isDown("right") and heros.x < width then
    heros.x = heros.x + 3 * (60 * dt)
  end
  
  if love.keyboard.isDown("left") and heros.x > 0  then
    heros.x = heros.x - 3 * (60 * dt)
  end
  
  if love.keyboard.isDown("up") and heros.y > 0 then
    heros.y = heros.y - 3 * (60 * dt)
  end
  
  if love.keyboard.isDown("down") and heros.y < height then
    heros.y = heros.y + 3 * (60 * dt)
  end

  -- VICTORY
  if victory == true then
    timer_victory = timer_victory - 1
    if timer_victory == 0 then
      actual_screen = "victory"
    end
  end
end

function draw_victory()
  love.graphics.draw(victory_picture, 0, 0)
end

function draw_dead()
  love.graphics.draw(death_picture, 0, 0)
  love.audio.play(gameover_sound)
end

function draw_menu()
  love.graphics.draw(screen_picture, 0, 0)
end

function draw_game()
  
  -- level
  local nbLignes = #level
  local ligne, column, x, y
  
  x = 0
  y = (0 - 64) + camera.y
  for ligne=nbLignes, 1, -1 do

    for column=1, 16 do
      local tile = level[ligne][column]
      
      if tile > 0 then
        love.graphics.draw(lst_tiles_pictures[tile], x, y, 0, 2, 2)
      end
      
      x = x + 64
    end
    
    x = 0
    y = y - 64
  
  end
  
  local i
  for i=#lst_sprites, 1, -1 do
    local s = lst_sprites[i]
    love.graphics.draw(s.image, s.x, s.y, 0, 2, 2, s.width / 2, s.height / 2)
  end
end
-----------------------------------------------------------------
function love.update(dt)
  if actual_screen == "game" then
    update_game(dt)
  elseif actual_screen == "menu" then
    update_menu(key)
  elseif actual_screen == "dead" then
    update_dead(key)
  elseif actual_screen == "victory" then
    update_victory()
  end
end
-----------------------------------------------------------------
function love.draw()
  if actual_screen == "game" then
    draw_game()
    love.audio.play(theme_sound)
  elseif actual_screen == "menu" then
    draw_menu()
  elseif actual_screen == "dead" then
    theme_sound:stop()
    draw_dead()
  elseif actual_screen == "victory" then
    draw_victory()
  end
end
-----------------------------------------------------------------
function init_game()
  lst_sprites = {}
  lst_shoots = {}
  lst_aliens = {}

  heros = create_hero(1, width/2, height/2)
  heros.x = width / 2
  heros.y = height - (heros.height * 2)
  
  camera.y = 0

  actual_screen = "menu"
  victory = false
  timer_victory = 0

  local ligne = 1
  create_alien(1, width/ 2, -(64/2)-(64*(ligne-1)))
  ligne = 10
  create_alien(2, width/2, -(64/2)-(64*(ligne-1)))
  ligne = 11
  create_alien(3, 3*64, -(64/2)-(64*(ligne-1)))

  ligne = #level
  create_alien(5, width/2, -(64/2)-(64*(ligne-1)))
  camera.y = 0
end