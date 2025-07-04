baseCoords = { 0, 0 }
scalething = 1
function onCreatePost()
        makeLuaSprite('expempty', 'desatbar/empty', 0, baseCoords[2] + 18)
        scaleObject('expempty', scalething, scalething)
        setObjectCamera('expempty', 'hud')
        setProperty('expempty.antialiasing', false)
        addLuaSprite('expempty', true)
        screenCenter('expempty', 'x')

        makeLuaSprite('expfill', 'desatbar/full-railed', 0, baseCoords[2] + 18)
        scaleObject('expfill', scalething, scalething)
        setObjectCamera('expfill', 'hud')
        setProperty('expfill.antialiasing', false)
        addLuaSprite('expfill', true)
        screenCenter('expfill', 'x')

        makeLuaText('exptext', '0', screenWidth, 0, baseCoords[2] - 8)
        setTextAlignment('exptext', 'center')
        setTextFont('exptext', 'Minecraftia.ttf')
        setTextSize('exptext', 24)
        addLuaText('exptext')
        screenCenter('exptext', 'x')
end

totalNotes = 0

function onUpdatePost(elapsed)
        boyColor = rgbToHex(getProperty('boyfriend.healthColorArray'))
        setProperty('expfill.color', getColorFromHex(boyColor))
        setProperty('expempty.color', getColorFromHex(boyColor))
        setProperty('exptext.color', getColorFromHex(boyColor))

        exp = combo / totalNotes
        if exp <= 0 then
                exp = 0.0000000001 -- lerp hates zero
        end
        setProperty('expfill._frame.frame.width', (0 + exp * (182 - 0)))

        if getProperty('expfill._frame.frame.width') > 182 then
                setProperty('expfill._frame.frame.width', 182)
        end

        setTextString('exptext', combo)
end

function rgbToHex(array)
        return string.format('%.2x%.2x%.2x', array[1], array[2], array[3])
end
