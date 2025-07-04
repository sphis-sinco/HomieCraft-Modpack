healthSkin = 'normal'                              -- 'normal' or 'hardcore'
hunger = 1                                         -- JUST IN CASE IF YOU WANT IT! ( goes from 0 to 1 )
items = {                                          -- you can add custom items here so yeah. {'item texture(in images/items)', 'Display Name', Is it Enchnated? (true/false), stack size}
  { 'empty',       '',                 false, 1 }, -- 1
  { 'empty',       '',                 false, 1 }, -- 2
  { 'empty',       '',                 false, 1 }, -- 3
  { 'empty',       '',                 false, 1 }, -- 4
  { 'empty',       '',                 false, 1 }, -- 5
  { 'empty',       '',                 false, 1 }, -- 6
  { 'stick',       'Debug Mode',       true,  1 }, -- 7, Debug Menu
  { 'armor_stand', 'Character Editor', true,  1 }, -- 8, Character Editor
  { 'empty',       '',                 true,  1 }  -- 9
}
sing_item = 0

-- DONT MESS WITH UNLESS YOU KNOW WHAT YOU ARE DOING!!!!!
scalething = 3
curItem = 1
pastitems = {
  { '', '', false, 1 },
  { '', '', false, 1 },
  { '', '', false, 1 },
  { '', '', false, 1 },
  { '', '', false, 1 },
  { '', '', false, 1 },
  { '', '', false, 1 },
  { '', '', false, 1 },
  { '', '', false, 1 },
}

function goodNoteHitPre(index, noteData, noteType, isSustain)
  if sing_item > 0 and switched_item then
    curItem = sing_item
    switched_item = false
    callOnLuas('onSlotSwitch', { curItem }, true, false)
  end
end

function onCreate()
  setOnScripts('scalething', scalething)
  if downscroll then
    baseCoords = { 232, 30 }
  else
    baseCoords = { 232, 600 }
  end

  setOnScripts('baseCoords', baseCoords)
end

function onCreatePost()
  luaDebugMode = true

  if songName == 'Plan' then
    items[1] = { 'wooden_sword', 'Wooden sword', false, 1 }
    items[2] = { 'apple', 'Apple', false, 2 }
    items[3] = { 'cobblestone', 'Cobblestone', false, 16 }
    sing_item = 1
  end

  daddycolor = rgbToHex(getProperty('dad.healthColorArray'))

  precacheSound('hit1')
  precacheSound('hit2')
  precacheSound('hit3')

  setRatingFC('N/A')

  makeLuaSprite('hotbar', 'hotbar', 0, baseCoords[2] + 40)
  scaleObject('hotbar', scalething, scalething)
  setObjectCamera('hotbar', 'hud')
  setProperty('hotbar.antialiasing', false)
  addLuaSprite('hotbar', true)
  screenCenter('hotbar', 'x')

  for i = 1, 9 do
    makeLuaSprite('item' .. i, 'items/' .. items[i][1], getProperty('hotbar.x') - 51 + (20 * scalething * (i)),
      getProperty('hotbar.y') + 9)
    scaleObject('item' .. i, scalething, scalething)
    setObjectCamera('item' .. i, 'hud')
    setProperty('item' .. i .. '.antialiasing', false)
    addLuaSprite('item' .. i, true)
  end

  makeLuaSprite('hbSelect', 'selectedItem', 0, getProperty('hotbar.y') - 3)
  scaleObject('hbSelect', scalething, scalething)
  setObjectCamera('hbSelect', 'hud')
  setProperty('hbSelect.antialiasing', false)
  addLuaSprite('hbSelect', true)

  makeLuaSprite('bossbarempty', 'desatbar/empty', 0, (downscroll and screenHeight - 25 or 30))
  scaleObject('bossbarempty', scalething, scalething)
  setObjectCamera('bossbarempty', 'hud')
  setProperty('bossbarempty.antialiasing', false)
  addLuaSprite('bossbarempty', true)
  screenCenter('bossbarempty', 'x')
  setProperty('bossbarempty.visible', false)

  makeLuaSprite('bossbarfill', 'desatbar/full', 0, (downscroll and screenHeight - 25 or 30))
  scaleObject('bossbarfill', scalething, scalething)
  setObjectCamera('bossbarfill', 'hud')
  setProperty('bossbarfill.antialiasing', false)
  addLuaSprite('bossbarfill', true)
  screenCenter('bossbarfill', 'x')
  setProperty('bossbarfill.visible', false)

  makeLuaText('bossbarname', songName .. ' (' .. string.upper(difficultyName) .. ')', screenWidth, 0,
    (downscroll and screenHeight - 50 or 0))
  setTextFont('bossbarname', 'Minecraftia.ttf')
  setTextSize('bossbarname', 16)
  addLuaText('bossbarname')
  screenCenter('bossbarname', 'x')
  setProperty('bossbarname.visible', false)


  local heartoffset = 135
  basehearty = baseCoords[2] - 12
  for i = 1, 10 do
    makeLuaSprite('heartBG' .. i, nil, baseCoords[1] + heartoffset + (i - 1) * (8 * scalething), basehearty)
    loadGraphic('heartBG' .. i, 'mineIcons/healthIcons-' .. healthSkin, 9, 9)
    addAnimation('heartBG' .. i, '1', { 0, 0 }, 24, false)
    scaleObject('heartBG' .. i, scalething, scalething)
    setObjectCamera('heartBG' .. i, 'hud')
    setProperty('heartBG' .. i .. '.antialiasing', false)
    addLuaSprite('heartBG' .. i, true)
    playAnim('heartBG' .. i, '1')
  end

  for i = 1, 10 do
    makeLuaSprite('heart' .. i, nil, baseCoords[1] + heartoffset + (i - 1) * (8 * scalething), basehearty)
    loadGraphic('heart' .. i, 'mineIcons/healthIcons-' .. healthSkin, 9, 9)
    addAnimation('heart' .. i, 'full', { 4, 1 }, 0)
    addAnimation('heart' .. i, 'half', { 5, 1 }, 0)
    addAnimation('heart' .. i, 'empty', { 0, 1 }, 0)
    scaleObject('heart' .. i, scalething, scalething)
    setObjectCamera('heart' .. i, 'hud')
    setProperty('heart' .. i .. '.antialiasing', false)
    addLuaSprite('heart' .. i, true)
    playAnim('heart' .. i, 'full', true)
  end

  local hungeroffset = 650
  basehungery = baseCoords[2] - 15
  for i = 1, 10 do
    makeLuaSprite('hungerBG' .. i, nil, baseCoords[1] + hungeroffset - (i - 1) * (8 * scalething), basehungery)
    loadGraphic('hungerBG' .. i, 'mineIcons/hungerIcons', 11, 11)
    addAnimation('hungerBG' .. i, 'full', { 0, 1 }, 0)

    scaleObject('hungerBG' .. i, scalething, scalething)
    setObjectCamera('hungerBG' .. i, 'hud')
    setProperty('hungerBG' .. i .. '.antialiasing', false)
    addLuaSprite('hungerBG' .. i, true)
    playAnim('hungerBG' .. i, 'full', true)
  end

  for i = 1, 10 do
    makeLuaSprite('hunger' .. i, nil, baseCoords[1] + hungeroffset - (i - 1) * (8 * scalething), basehungery)
    loadGraphic('hunger' .. i, 'mineIcons/hungerIcons', 11, 11)
    addAnimation('hunger' .. i, 'full', { 4, 3 }, 0)
    addAnimation('hunger' .. i, 'half', { 5, 4 }, 0)
    addAnimation('hunger' .. i, 'empty', { 0, 4 }, 0)
    scaleObject('hunger' .. i, scalething, scalething)
    setObjectCamera('hunger' .. i, 'hud')
    setProperty('hunger' .. i .. '.antialiasing', false)
    addLuaSprite('hunger' .. i, true)
    playAnim('hunger' .. i, 'full', true)
  end

  makeLuaText('shitscore', 'Score: 0 | Misses: 0 | Accuracy: ??.??% [?]', screenWidth, 0,
    baseCoords[2] + (downscroll and 130 or -120))
  setTextFont('shitscore', 'Minecraftia.ttf')
  setTextSize('shitscore', 16)
  setTextAlignment('shitscore', 'center')
  -- addLuaText('shitscore')
  screenCenter('shitscore', 'x')

  makeLuaText('itemname', '', screenWidth, 0, (downscroll and 150 or 520))
  setTextFont('itemname', 'Minecraftia.ttf')
  setTextSize('itemname', 16)
  addLuaText('itemname')
  screenCenter('itemname', 'x')
  setProperty('itemname.alpha', 0)
end

function onSongStart()
  local barstuff = { 'fill', 'empty', 'name' }
  for i = 1, 3 do
    setProperty('bossbar' .. barstuff[i] .. '.visible', true)
  end
end

function onUpdate(elapsed)
  if not curItem == sing_item then
    playAnim('boyfriend', 'item-' .. items[slot][1])
  end

  local keys = { 'ONE', 'TWO', 'THREE', 'FOUR', 'FIVE', 'SIX', 'SEVEN', 'EIGHT', 'NINE' } -- i hate how this works
  for i = 1, 9 do
    if keyboardJustPressed(keys[i]) then
      callOnLuas('onSlotSwitch', { i }, true, false)
      curItem = i
    end
  end
  setProperty('hbSelect.x', getProperty('hotbar.x') - 63 + (20 * scalething * (curItem)))
  if switched_item then
    playAnim('boyfriend', 'item-' .. items[curItem][1])
  end
end

function onStepHit()
  if curItem == sing_item then
    switched_item = false
  end
end

function onUpdatePost(elapsed)
  setProperty('healthBar.visible', false)
  setProperty('healthBarBG.visible', false)
  setProperty('timeBar.visible', false)
  setProperty('timeBarBG.visible', false)
  setProperty('timeTxt.visible', false)
  setProperty('scoreTxt.visible', false)
  setProperty('iconP1.flipX', true)

  setProperty('iconP1.x', screenWidth - 250)
  setProperty('iconP1.y', getProperty('hotbar.y') - 80)
  setProperty('iconP2.x', 100)
  setProperty('iconP2.y', getProperty('hotbar.y') - 80)
  setObjectOrder('iconP1', getObjectOrder('hotbar') + 1)
  setObjectOrder('iconP2', getObjectOrder('hotbar') + 1)

  daddycolor = rgbToHex(getProperty('dad.healthColorArray'))
  setProperty('bossbarfill.color', getColorFromHex(daddycolor))
  setProperty('bossbarempty.color', getColorFromHex(daddycolor))

  realRating = math.floor(rating * 10000) / 100
  setTextString('shitscore',
    'Score: ' .. score .. ' | Misses : ' .. misses .. ' | Accuracy: ' .. realRating ..
    '% [' .. getProperty('ratingFC') .. ']')

  timey = getSongPosition() / songLength
  setProperty('bossbarfill._frame.frame.width', (0 + timey * (182 - 0)))

  for i = 1, 9 do -- enchant glint stuff,  I'm not exprienced with shaders so here is my makeshift one.
    if not pastitems[i][3] == items[i][3] then
      if items[i][3] then
        -- oops
        doTweenColor('enchantGlint' .. i, 'item' .. i, 'ff87ff', 2, 'linear')
      else
        cancelTween('enchantGlint' .. i)
        setProperty('item' .. i .. '.color', getColorFromHex('FFFFFF'))
      end
    end
  end
  pastitems = items

  for i = 1, 10 do
    playAnim('heart' .. i, 'empty', true)
    extraHealth = math.floor((getProperty('health') / 2) * 10000 / 100)
    targetHealth = (i * 10)

    if targetHealth - 5 <= extraHealth then
      playAnim('heart' .. i, 'half', true)
    end

    if targetHealth <= extraHealth then
      playAnim('heart' .. i, 'full', true)
    end
  end

  for i = 1, 10 do
    playAnim('hunger' .. i, 'empty', true)
    extraHealth = math.floor((hunger) * 10000 / 100)
    targetHealth = (i * 10)

    if targetHealth - 5 <= extraHealth then
      playAnim('hunger' .. i, 'half', true)
    end

    if targetHealth <= extraHealth then
      playAnim('hunger' .. i, 'full', true)
    end
  end

  for i = 1, 10 do -- 2 hearts and below shake
    if getProperty('health') < 0.4 then
      local randomy = math.random(-4, 4)
      setProperty('heart' .. i .. '.y', basehearty + randomy)
      setProperty('heartBG' .. i .. '.y', basehearty + randomy)
    else
      setProperty('heart' .. i .. '.y', basehearty)
      setProperty('heartBG' .. i .. '.y', basehearty)
    end
  end

  for i = 1, 10 do -- 2 hunger and below shake
    if hunger < 0.2 then
      local randomy = math.random(-4, 4)
      setProperty('hunger' .. i .. '.y', basehungery + randomy)
      setProperty('hungerBG' .. i .. '.y', basehungery + randomy)
    else
      setProperty('hunger' .. i .. '.y', basehungery)
      setProperty('hungerBG' .. i .. '.y', basehungery)
    end
  end
end

function onSlotSwitch(slot)
  setProperty('itemname.alpha', 1)
  cancelTween('fadeing')
  if items[slot][4] > 1 then
    setTextString('itemname', items[slot][2] .. " (x" .. items[slot][4] .. ")")
  else
    setTextString('itemname', items[slot][2])
  end
  runTimer('fadetext1', 2)
  switched_item = true
  playAnim('boyfriend', 'item-' .. items[curItem][1])
  if items[slot][1] == 'empty' then
    -- switched_item = false
    -- playAnim('boyfriend', 'idle')
  end
end

switched_item = false

function noteMiss(membersIndex, noteData, noteType, isSustainNote)
  if sing_item > 0 and switched_item then
    curItem = sing_item
    switched_item = false
    callOnLuas('onSlotSwitch', { curItem }, true, false)
  end
end

function onTimerCompleted(tag, loops, loopsLeft)
  if tag == 'fadetext1' then
    doTweenAlpha('fadeing', 'itemname', 0, 1, 'linear')
  end
end

function onTweenCompleted(tag)
  for i = 1, 9 do -- enchant glint shit
    if tag == 'enchantGlint' .. tostring(i) then
      doTweenColor('enchantGlintBack' .. i, 'item' .. i, 'ffffff', 2, 'linear')
    end
    if tag == 'enchantGlintBack' .. tostring(i) then
      doTweenColor('enchantGlint' .. i, 'item' .. i, 'ff87ff', 2, 'linear')
    end
  end
end

function rgbToHex(array)
  return string.format('%.2x%.2x%.2x', array[1], array[2], array[3])
end
