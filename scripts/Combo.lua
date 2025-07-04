gotCombo = false
alrGotCombo = false

comboRequired = 30

function onCreate()
        makeAnimatedLuaSprite('combo', 'combo', 0, 0, 'sparrow')
        addAnimationByPrefix('combo', 'combo', 'combo', 24, false)
        addAnimationByPrefix('combo', 'full-combo', 'full-combo', 24, false)
        addLuaSprite('combo', true)
        -- scaleObject('combo', 0.25, 0.25)
        setObjectCamera('combo', 'camHUD')
        setProperty('combo.alpha', 0)

        -- debugPrint(getProperty('combo.color'))

        if getDataFromSave('HomieCraftSave', 'levelupsfx', true) then
                precacheSound('levelup')
        end
end

function onSectionHit()
        if gotCombo and not alrGotCombo then
                alrGotCombo = true

                comboPopup('')
        end
end

function comboPopup(prefix)
        if getDataFromSave('HomieCraftSave', 'levelupsfx', true) then
                playSound('levelup')
        end

        setProperty('combo.alpha', 1)
        playAnim('combo', prefix .. 'combo')
end

function fullCombo()
        comboPopup('full-')
end

function onUpdate(elapsed)
        if getProperty('combo.animation.finished') then
                setProperty('combo.alpha', 0)
        end

        boyColor = rgbToHex(getProperty('boyfriend.healthColorArray'))

        if getProperty('combo.animation.name') == 'combo' then
                setProperty('combo.color', getColorFromHex(boyColor))
        else
                setProperty('combo.color', 16777215)
        end

        gotCombo = combo >= comboRequired
        -- screenCenter('combo')
end

function rgbToHex(array)
        return string.format('%.2x%.2x%.2x', array[1], array[2], array[3])
end

function noteMiss(index, noteData, noteType, isSustain)
        alrGotCombo = false
end
