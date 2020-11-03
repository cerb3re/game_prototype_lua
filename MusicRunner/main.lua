-- Cette ligne permet d'afficher des traces dans la console pendant l'éxécution
io.stdout:setvbuf('no')

-- Empèche Love de filtrer les contours des images quand elles sont redimentionnées
-- Indispensable pour du pixel art
love.graphics.setDefaultFilter("nearest")

-- Cette ligne permet de déboguer pas à pas dans ZeroBraneStudio
if arg[#arg] == "-debug" then require("mobdebug").start() end

local screenw -- largeur écran
local screenh -- hauteur écran

-- Le futur héro !
local hero = {}

-- Nom des zones
local zone1 = "COOL"
local zone2 = "TECHNO"
-- Fond des zones
local imgBG1 = love.graphics.newImage("images/forest.png")
local imgBG2 = love.graphics.newImage("images/volcano.png")
-- Position horizontale du fond (pour scrolling)
local bgX = 1
-- Position verticale du hero au sol (calculée dans le load)
local groundPosition

-- Les 2 musiques
local musicCool = love.audio.newSource("sons/cool.mp3", "stream")
local musicTechno = love.audio.newSource("sons/techno.mp3", "stream")
-- Les sons
local sndJump = love.audio.newSource("sons/sfx_movement_jump13.wav","static")
local sndLanding = love.audio.newSource("sons/sfx_movement_jump13_landing.wav","static")

-- Le futur musicManager
local musicManager = {}

-- Fonction créant et renvoyant un MusicManager
function CreateMusicManager()
  local myMM = {}
  myMM.lstMusics = {} -- Liste des musiques du mixer
  myMM.currentMusic = 0 -- ID de la musique en cours
  
  -- Méthode pour ajouter une musique à la liste
  function myMM.addMusic(pMusic)
    local newMusic = {}
    newMusic.source = pMusic
    -- S'assure de faire boucler la musique
    newMusic.source:setLooping(true)
    -- Coupe le volume par défaut
    newMusic.source:setVolume(0)
    table.insert(myMM.lstMusics, newMusic)
  end
  
  -- Méthode pour mettre à jour le mixer (à appeler dans update)
  function myMM.update()
    -- Parcours toutes les musiques pour s'assurer
    -- 1) que la musique en cours à son volume à 1, sinon on l'augmente
    -- 2) que si une ancienne musique n'a pas son volume à 0, on le baisse
    for index, music in ipairs(myMM.lstMusics) do
      if index == myMM.currentMusic then
        if music.source:getVolume() < 1 then
          music.source:setVolume(music.source:getVolume()+0.01)
        end
      else
        if music.source:getVolume() > 0 then
          music.source:setVolume(music.source:getVolume()-0.01)
        end
      end
    end
  end

  -- Méthode pour démarrer une musique de la liste (par son ID)
  function myMM.PlayMusic(pNum)
    -- Récupère la musique dans la liste et la démarre
    local music = myMM.lstMusics[pNum]
    if music.source:getVolume() == 0 and myMM.currentMusic ~= pNum then
      print("Start music "..pNum)
      music.source:play()
    end
    -- Prend note de la nouvelle musique
    -- Pour que la méthod update prenne le relai
    myMM.currentMusic = pNum
  end
  
  return myMM
end

-- Fonction créant et renvoyant un héro
function CreateHero()
  local myHero = {}
  -- Sa position
  myHero.x = 0
  myHero.y = 0
  -- Sa vélocité verticale
  myHero.vy = 0
  -- Par défaut il n'est pas en train de sauter
  myHero.jump = false
  -- Liste des images de l'animation
  myHero.lstImages = {}
  
  -- Charge les images dans une liste
  local n
  for n=1,8 do
    local myImg = love.graphics.newImage("images/hero-day-"..n..".png")
    table.insert(myHero.lstImages,myImg)
  end
  
  -- On commence par la 1ère image
  myHero.currentImage = 1
  
  -- On note sa taille
  myHero.width = myHero.lstImages[1]:getWidth()
  myHero.height = myHero.lstImages[1]:getHeight()
  
  return myHero
end

function love.load()
  
  -- Passe en 512x256 doublé
  love.window.setMode(512*2,256*2)
  love.window.setTitle("Atelier Sons et Musiques (c) Gamecodeur 2017")
  screenw = love.graphics.getWidth()/2
  screenh = love.graphics.getHeight()/2
  
  -- Crée le héro et le positionne au 1er quart de l'écran, au sol
  hero = CreateHero()
  hero.x = screenw/4
  groundPosition = screenh-25
  hero.y = groundPosition
  
  -- Crée le MusicManager et lui ajoute 2 musique
  musicManager = CreateMusicManager()
  musicManager.addMusic(musicCool)
  musicManager.addMusic(musicTechno)
  -- Démarre la 1ère musique
  musicManager.PlayMusic(1)
  
end

function love.update(dt)
  -- Déplacement horizontal du héro
  if love.keyboard.isDown("right") and hero.x < screenw then
    hero.x = hero.x + 2 * 60 * dt
  elseif love.keyboard.isDown("left") and hero.x > 0 then
    hero.x = hero.x - 2 * 60 * dt
  end
  -- Applique la vélocité verticale (pour le saut)
  hero.y = hero.y + hero.vy*dt 
  -- Stoppe le héro au sol si il est tombé plus bas que la ligne de sol
  if hero.jump == true and hero.y > groundPosition then
    -- On le cale au sol
    hero.y = groundPosition
    -- On note qu'il ne saute plus et qu'il n'a plus de vélocité verticale
    hero.jump = false
    hero.vy = 0
    -- On joue un effet sonore
    sndLanding:play()
  end
  -- Applique la gravité
  if hero.jump then
    hero.vy = hero.vy + 600*dt
  end
  -- Détermine quelle musique jouer
  if hero.x < screenw/2 and musicManager.currentMusic ~= 1 then
    musicManager.PlayMusic(1)
  elseif hero.x >= screenw/2 and musicManager.currentMusic ~= 2 then
    musicManager.PlayMusic(2)
  end
  
  -- On demande au MusicManager de se mettre à jour
  musicManager.update()
  
  -- Scrolling infini du fond
  bgX = bgX - 120*dt
  if bgX <= 0-imgBG1:getWidth() then
    bgX = 1
  end
  
  -- Animation du héro, on augmente lentement le numéro de la frame courante
  hero.currentImage = hero.currentImage + 12*dt
  -- Si on a dépassé la dernière frame, on repart de 0
  if hero.currentImage > #hero.lstImages then
    hero.currentImage = 1
  end
  
end

function love.draw()
  -- On sauvegarde les paramètres d'affichage
  love.graphics.push()
  -- On double les pixels
  love.graphics.scale(2,2)
  
  -- Affiche le fond en fonction de la position du personnage
  local imgBG = {}
  if hero.x > screenw/2 then
    imgBG = imgBG2
  else
    imgBG = imgBG1
  end
  love.graphics.draw(imgBG,bgX,1)
  -- Si il y a du noir à droite, on dessine un 2ème fond
  if bgX < 1 then
    love.graphics.draw(imgBG,bgX + imgBG1:getWidth(),1)
  end
  
  -- Dessine le hero en prenant la valeur entière de son numéro de frame
  local nImage = math.floor(hero.currentImage)
  love.graphics.draw(hero.lstImages[nImage], hero.x - hero.width/2, hero.y - hero.height/2)
    
  -- Ligne verticale de séparation des 2 mondes
  --love.graphics.setColor(255,100,100) -- Pour Love inférieur à 11.0
  love.graphics.setColor(1,0.4,0.4) -- Pour Love 11.0 et supérieur  
  love.graphics.line(screenw/2,0,screenw/2,screenh)
  
  -- Texte des noms de zones
  --love.graphics.setColor(255,255,255) -- Pour Love inférieur à 11.0
  love.graphics.setColor(1,1,1) -- Pour Love 11.0 et supérieur  
  love.graphics.print(zone1, screenw/4, 10)
  love.graphics.print(zone2, (screenw/4) * 3, 10)

  -- On restaure les paramètres d'affichage
  love.graphics.pop()
end

function love.keypressed(key)
  
  -- Réaction si flèche haut ou espace (+compatibilité Love 0.9)
  if (key == "up" or key == "space" or key == " ") and hero.jump == false then
    -- On note qu'il saute
    hero.jump = true
    -- Il part vers le haut comme une fusée !
    hero.vy = -400
    -- On joue un effet sonore
    sndJump:play()
  end
  
end