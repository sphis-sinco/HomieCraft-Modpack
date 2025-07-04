function onCreatePost()
        totalNotes = 0
        for i = 1, getProperty('unspawnNotes.length') - 1 do -- Counts the Total notes
                if not getPropertyFromGroup('unspawnNotes', i, 'isSustainNote') then
                        if not getPropertyFromGroup('unspawnNotes', i, 'hitCausesMiss') then
                                if getPropertyFromGroup('unspawnNotes', i, 'mustPress') then
                                        totalNotes = totalNotes + 1
                                end
                        end
                end
        end

        setOnScripts('totalNotes', totalNotes)
end

gotFC = false
function onSectionHit()
        if combo == totalNotes and not gotFC then
                gotFC = true
                callOnScripts('fullCombo')
        end
end
