---@diagnostic disable: undefined-global, deprecated, unused-local, lowercase-global


bfName = boyfriendName
dadAltName = dadName
gfAltName = gfName

if not lowQuality then
	T = 0
	Tend = 0
	responded = true
	function onCreatePost()
		if checkFileExists('scripts/chat/' .. boyfriendName .. '.json') then
			jsonChatTxt = getTextFromFile('scripts/chat/' .. boyfriendName .. '.json')
			jsonChatTxt = string.gsub('' .. jsonChatTxt, '[%{%}%\n]', '')
			bfChat = stringSplit('' .. jsonChatTxt, ',')
		else
			jsonChatTxt = getTextFromFile('scripts/chat/null-player.json')
			jsonChatTxt = string.gsub('' .. jsonChatTxt, '[%{%}%\n]', '')
			bfChat = stringSplit('' .. jsonChatTxt, ',')
		end

		if checkFileExists('scripts/chat/' .. dadName .. '.json') then
			jsonChatTxt = getTextFromFile('scripts/chat/' .. dadName .. '.json')
			jsonChatTxt = string.gsub('' .. jsonChatTxt, '[%{%}%\n]', '')
			dadChat = stringSplit('' .. jsonChatTxt, ',')
		else
			jsonChatTxt = getTextFromFile('scripts/chat/null-opponent.json')
			jsonChatTxt = string.gsub('' .. jsonChatTxt, '[%{%}%\n]', '')
			dadChat = stringSplit('' .. jsonChatTxt, ',')
		end
	end

	local function chatGoUp()
		for i = Tend + 1, T - 1 do
			doTweenY('chatbg' .. i .. 'TY', 'chatbg' .. i, 546 + 27 - 27 * (T - i), 0.000001)
			doTweenY('chatw' .. i .. 'TY', 'chatw' .. i, 546 + 27 - 27 * (T - i), 0.000001)
			doTweenY('chat s' .. i .. 'TY', 'chat s' .. i, 546 + 27 - 5 + 3 - 27 * (T - i), 0.000001)
			doTweenY('chat' .. i .. 'TY', 'chat' .. i, 546 + 27 - 5 - 27 * (T - i), 0.000001)
		end
	end

	local function message(txt, who)
		makeLuaSprite('chatbg' .. T, '', 0, 546 + 27)
		makeGraphic('chatbg' .. T, 996, 27, '000000')
		setScrollFactor('chatbg' .. T, 0, 0)
		addLuaSprite('chatbg' .. T, true)
		setObjectCamera('chatbg' .. T, 'other')
		setProperty('chatbg' .. T .. '.alpha', 0.6)
		setObjectOrder('chatbg' .. T, 1)

		makeLuaSprite('chatw' .. T, '', 0, 546 + 27)
		makeGraphic('chatw' .. T, 6, 27, 'FFFFFF')
		setScrollFactor('chatw' .. T, 0, 0)
		addLuaSprite('chatw' .. T, true)
		setObjectCamera('chatw' .. T, 'other')


		makeLuaText('chat s' .. T, '<' .. who .. '> ' .. txt, 1280, 10 + 3, 546 + 27 - 5 + 3)
		setTextFont('chat s' .. T, 'minecraft.ttf')
		setTextColor('chat s' .. T, '0x3e3e3e')
		setTextSize('chat s' .. T, 24)
		setTextBorder('chat s' .. T, 0, '0xffffff')
		addLuaText('chat s' .. T)
		setTextAlignment('chat s' .. T, 'left')
		setObjectCamera('chat s' .. T, 'other')

		makeLuaText('chat' .. T, '<' .. who .. '> ' .. txt, 1280, 10, 546 + 27 - 5)
		setTextFont('chat' .. T, 'minecraft.ttf')
		setTextColor('chat' .. T, '0xffffff')
		setTextSize('chat' .. T, 24)
		setTextBorder('chat' .. T, 0, '0xffffff')
		addLuaText('chat' .. T)
		setTextAlignment('chat' .. T, 'left')
		setObjectCamera('chat' .. T, 'other')

		runTimer('chatFade' .. T, 9)
	end

	dead = false
	function onUpdate(elapsed)
		if getHealth() <= 0.0001 and not dead then
			for i = Tend, T do
				setProperty('chatbg' .. i .. '.alpha', 0)
				setProperty('chatw' .. i .. '.alpha', 0)
				removeLuaText('chat s' .. i, true)
				removeLuaText('chat' .. i, true)
				removeLuaText('chatbg' .. i, true)
				removeLuaText('chatw' .. i, true)
			end
		end
	end

	function onUpdatePost(elapsed)
		if keyboardJustPressed('T') then
			T = T + 1
			message(bfChat[getRandomInt(1, table.getn(bfChat), true)], bfName)

			if responded then
				runTimer('respond', 2.2)
				responded = false
			end
			chatGoUp()
		end
	end

	function onTimerCompleted(tag)
		for i = Tend, T do
			if tag == 'chatFade' .. i then
				doTweenAlpha('chatbgTA' .. i, 'chatbg' .. i, 0, 0.67, 'linear')
				doTweenAlpha('chatwTA' .. i, 'chatw' .. i, 0, 0.67, 'linear')
				doTweenAlpha('chat sTA' .. i, 'chat s' .. i, 0, 0.67, 'linear')
				doTweenAlpha('chatTA' .. i, 'chat' .. i, 0, 0.67, 'linear')
			end
		end
		if tag == 'respond' then
			T = T + 1
			message(dadChat[getRandomInt(1, table.getn(dadChat), true)], dadAltName)
			responded = true
			chatGoUp()
		end
	end

	function onTweenCompleted(tag)
		for i = Tend, T do
			if tag == 'chatbgTA' .. i then
				removeLuaText('chatbg' .. i, true)
				removeLuaText('chatw' .. i, true)
				removeLuaText('chat s' .. i, true)
				removeLuaText('chat' .. i, true)

				Tend = Tend + 1
			end
		end
	end
end
