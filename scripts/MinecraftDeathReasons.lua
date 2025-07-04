---@diagnostic disable: undefined-global, deprecated, lowercase-global
deathReason = "died"

bfName = boyfriendName
dadAltName = dadName
gfAltName = gfName

function onStepHit()
        if songName == 'Plan' then
                deathReason = " couldn't accept " .. dadAltName .. "'s plan"
        end

        setOnScripts('deathMethod', deathReason)
        setOnScripts('deathReason', deathReason)
end