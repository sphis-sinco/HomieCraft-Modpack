---@diagnostic disable: undefined-global, lowercase-global
bfName = boyfriendName
dadAltName = dadName;
gfAltName = gfName;

sinco = 'Sphis_Sinco'
dj = 'DjottaFlow'
paul = 'The_Master_King'

function onCountdownTick(counter)    
        doTheChecks()
end

function onCreate()
        doTheChecks()
end

function onStepHit()
        doTheChecks()
end

function doTheChecks()
        check('sinco-plan', sinco)
        check('dj-plan', dj)
        check('paul-plan', paul)

        check('dj-deviate', dj)
        check('paul-deviate', paul)

        setOnScripts('bfName', bfName)
        setOnScripts('dadAltName', dadAltName)
        setOnScripts('gfAltName', gfAltName)
end

function check(name, new_name)
        if bfName == name then
                bfName = new_name
        end
        if gfAltName == name then
                gfAltName = new_name
        end
        if dadAltName == name then
                dadAltName = new_name
        end
end