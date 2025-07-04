function onCreate()
        initSaveData('HomieCraftSave', 'HomieCraft')
        
        setSaveData('screenRotate')
        setSaveData('hurtSound')
        setSaveData('levelupsfx')
        setSaveData('watermark')

        flushSaveData('HomieCraftSave')
end

function setSaveData(save)
        if getDataFromSave('HomieCraftSave', save, true) == nil then
                setDataFromSave('HomieCraftSave', save, getModSetting(save, 'HomieCraftSave'))
        end
end
