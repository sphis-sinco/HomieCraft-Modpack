---@diagnostic disable: undefined-global

modName = 'Homie Craft'
modState = ' Alpha'
modVersion = '1.2.0'
releaseState = 'Release'

function onCreatePost()
        if checkFileExists('.dev/devText') then
                releaseState = 'Indev'
        end

        makeLuaText('front', modName .. modState .. ' ' .. modVersion .. ' (' .. releaseState .. ')', 0, 10, 0)
        setTextFont('front', 'Minecraftia.ttf')
        setTextSize('front', 16)
        setTextColor('front', '0xffffff')
        setProperty('front.y', screenHeight - getProperty('front.height'))

        makeLuaText('back', getProperty('front.text'), 0, 0, 0)
        setTextFont('back', 'Minecraftia.ttf')
        setTextSize('back', getProperty('front.size'))
        setTextColor('back', '0x3e3e3e')
        setProperty('back.x', getProperty('front.x') + 2)
        setProperty('back.y', getProperty('front.y') + 2)

        setTextBorder('front', 0, '0xffffff')
        setTextBorder('back', 0, '0xffffff')

        if getDataFromSave('HomieCraftSave', 'watermark', true) then
                addLuaText('back')
                addLuaText('front')
        end
end
