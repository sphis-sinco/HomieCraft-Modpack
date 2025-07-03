---@diagnostic disable: undefined-global
--script by n_bonnie2
--i modified it a bit

--luaDebugMode = true

function onCreate()
	-- triggered when the lua file is started, some variables weren't created yet
end

function onCreatePost()
	--thx _mxnolusion_ from https://gamebanana.com/questions/61997
	jsonTxt = getTextFromFile('characters/' .. boyfriendName .. '.json')
	jsonTxt = string.gsub('' .. jsonTxt, '[%{%}%\n]', '')
	bfDesc = stringSplit('' .. jsonTxt, ',')

	ifNew0 = stringSplit('' .. bfDesc[table.getn(bfDesc) - 1], ':')
	ifNew0 = stringSplit('' .. ifNew0[1], '"')
	ifNew = ifNew0[2]


	bfDesc2 = bfDesc[table.getn(bfDesc) - 9]
	bfDesc3 = stringSplit('' .. bfDesc2, ']')
	bfPosition = bfDesc3[1]

	--it checks if character's .json has "_editor_isPlayer"
	if ifNew == 'scale' then
		bfDesc2 = bfDesc[table.getn(bfDesc) - 10]
		bfDesc3 = stringSplit('' .. bfDesc2, ']')
		bfPosition = bfDesc3[1]
	end




	local bfIconColor = getProperty('boyfriend.healthColorArray')
	--thx Meme1079 from https://github.com/ShadowMario/FNF-PsychEngine/issues/12189 <3
	bfIC = string.format('%02x%02x%02x', bfIconColor[1], bfIconColor[2], bfIconColor[3])

	local dadIconColor = getProperty('dad.healthColorArray')
	dadIC = string.format('%02x%02x%02x', dadIconColor[1], dadIconColor[2], dadIconColor[3])

	--debug?
	--[[
		makeLuaText('way to die', ifNew, 1280, 0, (screenHeight / 2) - 113)
		setTextFont('way to die', 'minecraft.ttf')
		setTextColor('way to die', '0x000000')
		setTextSize('way to die', 24)
		setTextBorder('way to die', 0, '0xffffff')
		addLuaText('way to die')
		setTextAlignment('way to die', 'right')
		setObjectCamera('way to die', 'other')
		]] --

	setProperty('boyfriend.y', defaultBoyfriendY + bfPosition)

	for i = 1, 11 do
		precacheSound('deathScreen/hurt' .. i)
	end
end

local function hurt()
	playSound('deathScreen/hurt' .. getRandomInt(1, 11, true))

	if flashingLights then
		setProperty('boyfriend.color', getColorFromHex('FF0000'))
		setProperty('iconP1.color', getColorFromHex('FF0000'))
		setHealthBarColors(dadIC, 'FF0000')
	end
	if cameraZoomOnBeat then
		setProperty('boyfriend.angle', 30)
		doTweenAngle('turnp', 'boyfriend', 0, 0.07, 'linear')

		setProperty('iconP1.angle', 30)
		doTweenAngle('iconTween2', 'iconP1', 0, 0.07, 'linear')
	end

	runTimer('oofie', 0.1)
end

function noteMissPress()
	hurt()
end

function noteMiss()
	hurt()
end

function onTimerCompleted(tag, loops, loopsLeft)
	if tag == 'oofie' then
		if flashingLights then
			setProperty('boyfriend.color', getColorFromHex('FFFFFF'))
			setProperty('iconP1.color', getColorFromHex('FFFFFF'))
			setHealthBarColors(dadIC, bfIC)
		end
		if cameraZoomOnBeat then
			doTweenY('bfTweenY2', 'boyfriend', defaultBoyfriendY + bfPosition, 0.1, 'linear')
		end
	end
	if tag == 'partInvisible' then
		for i = 0, 3 do
			removeLuaSprite('part' .. i, false)
		end
	end
end
