---@diagnostic disable: undefined-global
--script by Krnqle, Sosclabab, or volv. borrowed from the 17bucks song "boulevard"
--i modified it a bit

--getRandomInt(1, 3, true) is op omg



local ffi = require("ffi")        -- Load FFI module (instance)

local user32 = ffi.load("user32") -- Load User32 DLL handle

ffi.cdef([[
	enum{
		MB_OK = 0x00000000L,
		MB_ICONINFORMATION = 0x00000040L
	};

	typedef void* HANDLE;
	typedef HANDLE HWND;
	typedef const char* LPCSTR;
	typedef unsigned UINT;

	int MessageBoxA(HWND, LPCSTR, LPCSTR, UINT);
	]]) -- Define C -> Lua interpretation


music = {
	'deathScreen/c418/11',
	'deathScreen/c418/aria math',
	'deathScreen/c418/biome fest',
	'deathScreen/c418/haggstrom',
	'deathScreen/c418/haunt muskie',
	'deathScreen/c418/minecraft',
	'deathScreen/c418/moog city',
	'deathScreen/c418/subwoofer lullaby',
	'deathScreen/c418/sweden',
	'deathScreen/c418/wet hands',
}

function onCreatePost()
	precacheImage('songToast')
	precacheImage('deathScreen/particle-smoke')
	precacheImage('deathScreen/button')
	precacheImage('deathScreen/button-hovered')
	precacheImage('deathScreen/button-pressed')

	setProperty('comboGroup.x', -9000)
end

function onGameOver()
	return Function_Stop
end

dead = false
function onUpdate(elapsed)
	if getHealth() <= 0.0001 and not dead then
		openCustomSubstate('gamerrrr', true)
		dead = true
	end
end

function onCustomSubstateCreatePost(n)
	if n == 'gamerrrr' then
		setPropertyFromClass('flixel.FlxG', 'mouse.visible', true)

		playAnim('boyfriend', 'die', false)
		playAnim('dad', 'idle')
		playAnim('gf', 'NOOO')
		setObjectOrder('boyfriendGroup', getObjectOrder('boyfriendGroup') - 1)

		playSound('deathScreen/hurt' .. getRandomInt(1, 11, true))
		runTimer('gameOverMusic', 1.2)

		for i = 0, 3 do
			removeLuaSprite('part' .. i, false)
		end

		setProperty('boyfriend.color', getColorFromHex('FF0000'))
		doTweenAngle('turnp', 'boyfriend', 90, 0.4, 'expoOut')
		doTweenX('fallX', 'boyfriend', getProperty(('boyfriend.x')) + 180, 0.4, 'expoOut')
		doTweenY('fallY', 'boyfriend', getProperty(('boyfriend.y')) + 320, 0.4, 'expoOut')
		runTimer('villagerFade', 0.7)

		doTweenAngle('oof', 'camGame', 0, 0.1, 'linear')
		doTweenZoom('camz', 'camGame', 2, 180, 'quintOut')
		doTweenAlpha('cama', 'camHUD', 0, 0.6, 'sineOut')
		doTweenY('seeBFY', 'camGame', getProperty('camGame.y') - 100, 180, 'quintOut')
		doTweenX('seeBFX', 'camGame', getProperty('camGame.x') + 25, 180, 'quintOut')

		makeLuaSprite('chatbg', '', 0, 546 + 27)
		makeGraphic('chatbg', 996, 27, '000000')
		setScrollFactor('chatbg', 0, 0)
		addLuaSprite('chatbg', true)
		setObjectCamera('chatbg', 'other')
		setProperty('chatbg.alpha', 0.6)

		makeLuaSprite('chatw', '', 0, 546 + 27)
		makeGraphic('chatw', 6, 27, 'FFFFFF')
		setScrollFactor('chatw', 0, 0)
		addLuaSprite('chatw', true)
		setObjectCamera('chatw', 'other')

		makeLuaText('chat s', 'insert the death message', 1280, 10 + 3, 546 + 27 - 5 + 3)
		setTextFont('chat s', 'minecraft.ttf')
		setTextColor('chat s', '0x3e3e3e')
		setTextSize('chat s', 24)
		setTextBorder('chat s', 0, '0xffffff')
		addLuaText('chat s')
		setTextAlignment('chat s', 'left')
		setObjectCamera('chat s', 'other')

		makeLuaText('chat', 'insert the death message', 1280, 10, 546 + 27 - 5)
		setTextFont('chat', 'minecraft.ttf')
		setTextColor('chat', '0xffffff')
		setTextSize('chat', 24)
		setTextBorder('chat', 0, '0xffffff')
		addLuaText('chat')
		setTextAlignment('chat', 'left')
		setObjectCamera('chat', 'other')

		runTimer('chatFade', 9)


		makeLuaSprite('red', '', 0, 0)
		makeGraphic('red', 1280, 720, '780000')
		setScrollFactor('red', 0, 0)
		addLuaSprite('red', true)
		setObjectCamera('red', 'other')
		setProperty('red.alpha', 0.4)

		makeLuaText('you died s', 'You Died!', 1280, 6, (screenHeight / 2) - 194 + 6)
		setTextFont('you died s', 'minecraft.ttf')
		setTextColor('you died s', '0x3e3e3e')
		setTextSize('you died s', 48)
		setTextBorder('you died s', 0, '0xffffff')
		addLuaText('you died s')
		setTextAlignment('you died s', 'center')
		setObjectCamera('you died s', 'other')

		makeLuaText('you died', 'You Died!', 1280, 0, (screenHeight / 2) - 194)
		setTextFont('you died', 'minecraft.ttf')
		setTextColor('you died', '0xffffff')
		setTextSize('you died', 48)
		setTextBorder('you died', 0, '0xffffff')
		addLuaText('you died')
		setTextAlignment('you died', 'center')
		setObjectCamera('you died', 'other')

		makeLuaText('way to die s', 'insert the death message', 1280, 3, (screenHeight / 2) - 113 + 3)
		setTextFont('way to die s', 'minecraft.ttf')
		setTextColor('way to die s', '0x3e3e3e')
		setTextSize('way to die s', 24)
		setTextBorder('way to die s', 0, '0xffffff')
		addLuaText('way to die s')
		setTextAlignment('way to die s', 'center')
		setObjectCamera('way to die s', 'other')

		makeLuaText('way to die', 'insert the death message', 1280, 0, (screenHeight / 2) - 113)
		setTextFont('way to die', 'minecraft.ttf')
		setTextColor('way to die', '0xffffff')
		setTextSize('way to die', 24)
		setTextBorder('way to die', 0, '0xffffff')
		addLuaText('way to die')
		setTextAlignment('way to die', 'center')
		setObjectCamera('way to die', 'other')


		makeLuaText('score s', 'Score: ' .. score, 1280, 3, (screenHeight / 2) - 68 + 3)
		setTextFont('score s', 'minecraft.ttf')
		setTextColor('score s', '0x3e3e3e')
		setTextSize('score s', 24)
		setTextBorder('score s', 0, '0xffffff')
		addLuaText('score s')
		setTextAlignment('score s', 'center')
		setObjectCamera('score s', 'other')

		makeLuaText('score', 'Score: ' .. score, 1280, 0, (screenHeight / 2) - 68)
		setTextFont('score', 'minecraft.ttf')
		setTextColor('score', '0xffffff')
		setTextSize('score', 24)
		setTextBorder('score', 0, '0xffffff')
		addLuaText('score')
		setTextAlignment('score', 'center')
		setObjectCamera('score', 'other')

		makeLuaSprite('toast', 'songToast', 0, 40)
		setLuaSpriteScrollFactor('toast', 0, 0);
		setObjectCamera('toast', 'other')
		scaleObject('toast', 2, 2)
		setProperty('toast.antialiasing', false)
		screenCenter('toast', 'x')
		addLuaSprite('toast', true)

		musicPathSplit = stringSplit(musicPath, '/')

		makeLuaText('toastMusicText', 'Song: ' .. musicPathSplit[table.getn(musicPathSplit)],
			getProperty('toast.width'), 0, 0)
		setTextFont('toastMusicText', 'minecraft.ttf')
		setTextColor('toastMusicText', '0xffffff')
		setTextSize('toastMusicText', 16)
		setTextBorder('toastMusicText', 0, '0xffffff')
		addLuaText('toastMusicText')
		setTextAlignment('toastMusicText', 'center')
		setObjectCamera('toastMusicText', 'other')
		setProperty('toastMusicText.x', getProperty('toast.x'))
		setProperty('toastMusicText.y', getProperty('toast.y') + (getProperty('toastMusicText.height') / 2))

		if musicPathSplit[table.getn(musicPathSplit) - 1] == 'deathScreen' then
			-- nothing
		else
			setProperty('toastMusicText.text',
				getProperty('toastMusicText.text') ..
				' by ' .. musicPathSplit[table.getn(musicPathSplit) - 1])
		end

		makeLuaSprite('button1', 'deathScreen/button', (screenWidth / 2) - (200 * 3) / 2,
			(screenHeight / 2) + 36)
		setLuaSpriteScrollFactor('button1', 0, 0);
		addLuaSprite('button1', true)
		setObjectCamera('button1', 'other')
		setProperty('button1.antialiasing', false)
		scaleObject('button1', 3, 3)

		makeLuaSprite('button1h', 'deathScreen/button-hovered', (screenWidth / 2) - (200 * 3) / 2,
			(screenHeight / 2) + 36)
		setLuaSpriteScrollFactor('button1h', 0, 0);
		addLuaSprite('button1h', true)
		setObjectCamera('button1h', 'other')
		setProperty('button1h.antialiasing', false)
		scaleObject('button1h', 3, 3)
		setProperty('button1h.alpha', 0.00001)

		makeLuaSprite('button1p', 'deathScreen/button-pressed', (screenWidth / 2) - (200 * 3) / 2,
			(screenHeight / 2) + 36)
		setLuaSpriteScrollFactor('button1p', 0, 0);
		addLuaSprite('button1p', true)
		setObjectCamera('button1p', 'other')
		setProperty('button1p.antialiasing', false)
		scaleObject('button1p', 3, 3)

		makeLuaText('retry s', 'Retry', 1280, 3, (screenHeight / 2) + 36 + 10 + 3)
		setTextFont('retry s', 'minecraft.ttf')
		setTextColor('retry s', '0x3e3e3e')
		setTextSize('retry s', 24)
		setTextBorder('retry s', 0, '0xffffff')
		addLuaText('retry s')
		setTextAlignment('retry s', 'center')
		setObjectCamera('retry s', 'other')

		makeLuaText('retry', 'Retry', 1280, 0, (screenHeight / 2) + 36 + 10)
		setTextFont('retry', 'minecraft.ttf')
		setTextColor('retry', '0xffffff')
		setTextSize('retry', 24)
		setTextBorder('retry', 0, '0xffffff')
		addLuaText('retry')
		setTextAlignment('retry', 'center')
		setObjectCamera('retry', 'other')

		makeLuaText('retry sp', 'Retry', 1280, 3, (screenHeight / 2) + 36 + 10 + 3)
		setTextFont('retry sp', 'minecraft.ttf')
		setTextColor('retry sp', '0x282828')
		setTextSize('retry sp', 24)
		setTextBorder('retry sp', 0, '0xffffff')
		addLuaText('retry sp')
		setTextAlignment('retry sp', 'center')
		setObjectCamera('retry sp', 'other')

		makeLuaText('retryp', 'Retry', 1280, 0, (screenHeight / 2) + 36 + 10)
		setTextFont('retryp', 'minecraft.ttf')
		setTextColor('retryp', '0x9e9e9e')
		setTextSize('retryp', 24)
		setTextBorder('retryp', 0, '0xffffff')
		addLuaText('retryp')
		setTextAlignment('retryp', 'center')
		setObjectCamera('retryp', 'other')



		makeLuaSprite('button2', 'deathScreen/button', (screenWidth / 2) - (200 * 3) / 2,
			(screenHeight / 2) + 108)
		setLuaSpriteScrollFactor('button2', 0, 0);
		addLuaSprite('button2', true)
		setObjectCamera('button2', 'other')
		setProperty('button2.antialiasing', false)
		scaleObject('button2', 3, 3)

		makeLuaSprite('button2h', 'deathScreen/button-hovered', (screenWidth / 2) - (200 * 3) / 2,
			(screenHeight / 2) + 108)
		setLuaSpriteScrollFactor('button2h', 0, 0);
		addLuaSprite('button2h', true)
		setObjectCamera('button2h', 'other')
		setProperty('button2h.antialiasing', false)
		scaleObject('button2h', 3, 3)
		setProperty('button2h.alpha', 0.00001)

		makeLuaSprite('button2p', 'deathScreen/button-pressed', (screenWidth / 2) - (200 * 3) / 2,
			(screenHeight / 2) + 108)
		setLuaSpriteScrollFactor('button2p', 0, 0);
		addLuaSprite('button2p', true)
		setObjectCamera('button2p', 'other')
		setProperty('button2p.antialiasing', false)
		scaleObject('button2p', 3, 3)


		makeLuaText('menu s', 'Menu', 1280, 3, (screenHeight / 2) + 108 + 10 + 3)
		setTextFont('menu s', 'minecraft.ttf')
		setTextColor('menu s', '0x3e3e3e')
		setTextSize('menu s', 24)
		setTextBorder('menu s', 0, '0xffffff')
		addLuaText('menu s')
		setTextAlignment('menu s', 'center')
		setObjectCamera('menu s', 'other')

		makeLuaText('menu', 'Menu', 1280, 0, (screenHeight / 2) + 108 + 10)
		setTextFont('menu', 'minecraft.ttf')
		setTextColor('menu', '0xffffff')
		setTextSize('menu', 24)
		setTextBorder('menu', 0, '0xffffff')
		addLuaText('menu')
		setTextAlignment('menu', 'center')
		setObjectCamera('menu', 'other')


		makeLuaText('menu sp', 'Menu', 1280, 3, (screenHeight / 2) + 108 + 10 + 3)
		setTextFont('menu sp', 'minecraft.ttf')
		setTextColor('menu sp', '0x282828')
		setTextSize('menu sp', 24)
		setTextBorder('menu sp', 0, '0xffffff')
		addLuaText('menu sp')
		setTextAlignment('menu sp', 'center')
		setObjectCamera('menu sp', 'other')

		makeLuaText('menup', 'Menu', 1280, 0, (screenHeight / 2) + 108 + 10)
		setTextFont('menup', 'minecraft.ttf')
		setTextColor('menup', '0x9e9e9e')
		setTextSize('menup', 24)
		setTextBorder('menup', 0, '0xffffff')
		addLuaText('menup')
		setTextAlignment('menup', 'center')
		setObjectCamera('menup', 'other')

		if not isStoryMode then
			setTextString('menu s', 'Freeplay Menu')
			setTextString('menu', 'Freeplay Menu')
			setTextString('menu sp', 'Freeplay Menu')
			setTextString('menup', 'Freeplay Menu')
		else
			setTextString('menu s', 'Story Mode Menu')
			setTextString('menu', 'Story Mode Menu')
			setTextString('menu sp', 'Story Mode Menu')
			setTextString('menup', 'Story Mode Menu')
		end

		bfName = boyfriendName
		dadAltName = dadName;

		if bfName == 'sinco-plan' then
			bfName = 'Sphis_Sinco'
		end

		if dadAltName == 'dj-plan' then
			dadAltName = 'DjottaFlow'
		end

		deathMethod = " died in a rap battle with " .. dadAltName

		if songName == 'Plan' then
			deathMethod = " couldn't accept " .. dadAltName .. "'s plan"
		end

		setTextString('chat s', bfName .. deathMethod)
		setTextString('chat', bfName .. deathMethod)
		setTextString('way to die s', bfName .. deathMethod)
		setTextString('way to die', bfName .. deathMethod)

		runTimer('pressable', 1)

		makeLuaSprite('black', '', 0, 0)
		makeGraphic('black', 1280, 720, '000000')
		setScrollFactor('black', 0, 0)
		addLuaSprite('black', true)
		setObjectCamera('black', 'other')
		setProperty('black.alpha', 0.00001)
	end
end

musicPath = music[getRandomInt(1, table.getn(music), true)]

stop = false
function onTimerCompleted(t)
	if t == 'gameOverMusic' then
		if not stop then
			playMusic(musicPath, 1, true, 'musicMinecraft')
		end
	end
	if t == 'villagerFade' then
		setProperty('boyfriend.visible', false)
		greyColors = { 'FFFFFF', 'EBEBEB', 'D6D6D6', 'D1D1D1', 'C9C9C9', 'BFBFBF', 'B8B8B8', 'A1A1A1' }
		for i = 0, 12 do
			yuck = 'smoke' .. i
			makeAnimatedLuaSprite('smoke' .. i, 'deathScreen/particle-smoke',
				defaultBoyfriendX + 120 + getRandomInt(0, 500, true) - 250,
				defaultBoyfriendY + 350 + getRandomInt(0, 300, true) - 150)
			addAnimationByPrefix('smoke' .. i, 'smoke', 'smoke', 24, true)
			playAnim('smoke' .. i, 'smoke')
			doTweenY('tweenSmokeY' .. i, 'smoke' .. i,
				getGraphicMidpointY('boyfriend') - 500 - getRandomInt(0, 1000, true), 5)
			doTweenX('tweenSmokeX' .. i, 'smoke' .. i,
				getGraphicMidpointX('boyfriend') + 120 + getRandomInt(0, 1000, true) - 500, 8,
				'bounceInOut')
			doTweenX('tweenSmokeXscale' .. i, yuck .. '.scale', 0, 1.2, 'linear');
			doTweenY('tweenSmokeYscale' .. i, yuck .. '.scale', 0, 1.2, 'linear')
			scale = getRandomInt(100, 350, true) / 100
			scaleObject('smoke' .. i, scale, scale)
			addLuaSprite('smoke' .. i, true)


			setProperty(yuck .. '.antialiasing', false)
			setProperty(yuck .. '.color', getColorFromHex(greyColors[getRandomInt(1, 8, true)]))

			runTimer('smokeInvisible', 1.2)
		end
	end
	if t == 'chatFade' then
		doTweenAlpha('chatbgTA', 'chatbg', 0, 0.67, 'linear')
		doTweenAlpha('chatwTA', 'chatw', 0, 0.67, 'linear')
		doTweenAlpha('chat sTA', 'chat s', 0, 0.67, 'linear')
		doTweenAlpha('chatTA', 'chat', 0, 0.67, 'linear')
	end
	if t == 'smokeInvisible' then
		for i = 0, 12 do
			removeLuaSprite('smoke' .. i, false)
		end
	end
	if t == 'pressable' then
		setProperty('button1p.alpha', 0.00001)
		setProperty('retry sp.alpha', 0.00001)
		setProperty('retryp.alpha', 0.00001)
		setProperty('button2p.alpha', 0.00001)
		setProperty('menu sp.alpha', 0.00001)
		setProperty('menup.alpha', 0.00001)
	end
	if t == 'retryProceed' then
		setPropertyFromClass('flixel.FlxG', 'mouse.visible', false)
		setProperty('black.alpha', 1)
		restartSong(false)
	end
	if t == 'exitProceed' then
		setPropertyFromClass('flixel.FlxG', 'mouse.visible', false)
		setProperty('black.alpha', 1)
		exitSong(false)
	end
end

rset = false

local function retryPressed(rset)
	stop = true
	if not rset then
		playSound('deathScreen/click', 1, 'click')
		setProperty('button1p.alpha', 1)
		setProperty('retry sp.alpha', 1)
		setProperty('retryp.alpha', 1)
		runTimer('retryProceed', 0.4)
	end
end

local function exitPressed(rset)
	stop = true
	if not rset then
		rset = true
		playSound('deathScreen/click', 1, 'click')
		setProperty('button2p.alpha', 1)
		setProperty('menu sp.alpha', 1)
		setProperty('menup.alpha', 1)
		runTimer('exitProceed', 0.4)
	end
end


frameBF = 0
frameGF = 0
frameDAD = 0
frameSMOKE = 0
frameLose = 0
function onCustomSubstateUpdate(n, elapsed)
	if n == 'gamerrrr' then
		frameBF = frameBF + (elapsed * 20)
		frameDAD = frameDAD + (elapsed * 20)
		frameGF = frameGF + (elapsed * 20)
		frameSMOKE = frameSMOKE + (elapsed * 20)
		frameLose = frameLose + (elapsed * 20)

		setProperty('boyfriend.animation.curAnim.curFrame', frameBF)
		setProperty('gf.animation.curAnim.curFrame', frameGF)
		setProperty('dad.animation.curAnim.curFrame', frameDAD)
		for i = 0, 12 do
			yuck = 'smoke' .. i
			setProperty(yuck .. '.animation.curAnim.curFrame', frameSMOKE)
		end
		setProperty('loseSprite.animation.curAnim.curFrame', frameLose)
	end
	--script below by krink for 17Boo
	if
	    getMouseX('other') > (screenWidth / 2) - 300 and
	    getMouseX('other') < (screenWidth / 2) + 300 and
	    getMouseY('other') > (screenHeight / 2) + 36 and
	    getMouseY('other') < (screenHeight / 2) + 36 + 60 and
	    getProperty('button1p.alpha') ~= 1 and
	    not rset then
		setProperty('button1h.alpha', 1)
		if mouseClicked('left') then
			retryPressed(rset)
			rset = true
		end
	else
		setProperty('button1h.alpha', 0)
	end
	if
	    getMouseX('other') > (screenWidth / 2) - 300 and
	    getMouseX('other') < (screenWidth / 2) + 300 and
	    getMouseY('other') > (screenHeight / 2) + 108 and
	    getMouseY('other') < (screenHeight / 2) + 108 + 60 and
	    getProperty('button2p.alpha') ~= 1 and
	    not rset then
		setProperty('button2h.alpha', 1)
		if mouseClicked('left') then
			exitPressed(rset)
			rset = true
		end
	else
		setProperty('button2h.alpha', 0)
	end
end

function onCustomSubstateUpdatePost(n, elapsed)
	if n == 'gamerrrr' then
		if (keyboardJustPressed('ENTER') or keyboardJustPressed('SPACE')) and
		    getProperty('button1p.alpha') ~= 1 and
		    rset == false then
			retryPressed(rset)
			rset = true
		end
		if (keyboardJustPressed('ESCAPE') or keyboardJustPressed('BACKSPACE')) and
		    getProperty('button2p.alpha') ~= 1 and
		    rset == false then
			exitPressed(rset)
			rset = true
		end
	end
end
