function onCreatePost()
        precacheSound('shield/block1')
        precacheSound('shield/block2')
        precacheSound('shield/block3')
        precacheSound('shield/block4')
        precacheSound('shield/block5')
end
function goodNoteHitPre(index, noteData, noteType, isSustain)
        if noteType == 'shield' then
                playSound('shield/block' .. math.random(1, 5), 1, 'minecraftShieldBlock')
                playAnim('shieldNote')
        end
end