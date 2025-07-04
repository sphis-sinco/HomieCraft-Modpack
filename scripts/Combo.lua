gotCombo = false
alrGotCombo = false

function onCreate()
        makeAnimatedLuaSprite('combo', 'combo', 0, 0, 'sparrow')
        addAnimationByPrefix('combo', 'combo', 'combo', 24, false)
        addLuaSprite('combo', true)
        -- scaleObject('combo', 0.25, 0.25)
        setObjectCamera('combo', 'camHUD')
        setProperty('combo.alpha', 0)
        screenCenter('combo')
end

function onSectionHit()
        if gotCombo and not alrGotCombo then
                alrGotCombo = true

                if getDataFromSave('HomieCraftSave', 'levelupsfx', true) then
                        playSound('levelup')
                end

                setProperty('combo.alpha', 1)
                playAnim('combo', 'combo')
        end
end

function onUpdate(elapsed)
        if getProperty('combo.animation.finished') then
                setProperty('combo.alpha', 0)
        end

        boyColor = rgbToHex(getProperty('boyfriend.healthColorArray'))
        setProperty('combo.color', getColorFromHex(boyColor))

        gotCombo = combo >= 30
end

function rgbToHex(array)
        return string.format('%.2x%.2x%.2x', array[1], array[2], array[3])
end

function noteMiss(index, noteData, noteType, isSustain)
        alrGotCombo = false
end