---@diagnostic disable: undefined-global, deprecated, lowercase-global
deathReason = " died"

bfName = boyfriendName
dadAltName = dadName
gfAltName = gfName

countingDown = false

function onCountdownTick(counter)
        countingDown = true
        gen()
end

function onCreate()
        countingDown = false
        gen()
end

function onStepHit()
        gen()
end

function gen()
        if songName == 'Plan' then
                deathReason = " couldn't accept " .. dadAltName .. "'s plan"
        end
        if songName == 'Deviate' then
                deathReason = " didn't find any (useful) resources"
        end

        if countingDown then
                deathReason = " was very impatient"
        end

        setOnScripts('deathMethod', deathReason)
        setOnScripts('deathReason', deathReason)
end