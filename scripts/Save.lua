function onCreate()
        initSaveData('HomieCraftSave', 'HomieCraft')
        if getDataFromSave('HomieCraftSave', 'screenRotate', true) == nil then
                setDataFromSave('HomieCraftSave', 'screenRotate', true)
        end
        if getDataFromSave('HomieCraftSave', 'hurtSound', true) == nil then
                setDataFromSave('HomieCraftSave', 'hurtSound', true)
        end
        if getDataFromSave('HomieCraftSave', 'levelupsfx', true) == nil then
                setDataFromSave('HomieCraftSave', 'levelupsfx', true)
        end
        flushSaveData('HomieCraftSave')
end
