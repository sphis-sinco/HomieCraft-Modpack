function onCreate()
        initSaveData('HomieCraftSave', 'HomieCraft')

        setSaveData('screenRotate', true)
        setSaveData('hurtSound', true)
        setSaveData('levelupsfx', true)
        setSaveData('watermark', true)

        flushSaveData('HomieCraftSave')
end

function setSaveData(save, default)
        setDataFromSave('HomieCraftSave', save, getModSetting(save))

        if (getDataFromSave('HomieCraftSave', save, nil) == nil) then
                setDataFromSave('HomieCraftSave', save, default)
        end
end
