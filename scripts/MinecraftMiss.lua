function onCreatePost()
        precacheSound('hit1')
        precacheSound('hit2')
        precacheSound('hit3')
end

function noteMiss(index, noteData, noteType, isSustain)
        if getDataFromSave('HomieCraftSave', 'hurtSound', true) then
                playSound('hit' .. math.random(1, 3), 1, 'minecraftHit')
        end
        if getDataFromSave('HomieCraftSave', 'screenRotate', true) then
                setProperty('camGame.angle', 0)
                doTweenAngle('oof', 'camGame', 6, 0.05, 'linear')
        end
        if flashingLights then
                setProperty('boyfriend.color', getColorFromHex('FF0000'))
        end
        runTimer('oofie', 0.1)

        return Function_Stop
end

function onTimerCompleted(tag, loops, loopsLeft)
        if tag == 'oofie' then
                if flashingLights then
                        setProperty('boyfriend.color', getColorFromHex('FFFFFF'))
                end
                if getDataFromSave('HomieCraftSave', 'screenRotate', true) then
                        doTweenAngle('oof', 'camGame', 0, 0.1, 'linear')
                end
        end
end
