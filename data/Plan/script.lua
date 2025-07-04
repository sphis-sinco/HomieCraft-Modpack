---@diagnostic disable: undefined-global, lowercase-global
camStartZoom = 1.5

camzoomInDUET = -0.25
camzoomInBF = 1
camzoomInGF = 0.5

function onStepHit()
        zoomOffset = 0

        if mustHitSection then
                zoomOffset = camzoomInBF
        end

        if gfSection then
                zoomOffset = camzoomInGF
        end

        duetSections()

        doTweenZoom('camz', 'camGame', camStartZoom + zoomOffset, 0.4, 'expoOut')
end

function duetSections()
        if curSection == 4 then
                duet()
        end

        if curSection == 5 then
                duet()
        end

        if curSection == 19 then
                duet()
        end

        if curSection == 20 then
                duet()
        end

        if curSection == 21 then
                duet()
        end

        if curSection == 22 then
                duet()
        end

        if curSection == 23 then
                duet()
        end

        if curSection == 24 then
                duet()
        end

        if curSection == 43 then
                duet()
        end

        if curSection == 44 then
                duet()
        end
end

function duet()
        zoomOffset = camzoomInDUET
        setCameraFollowPoint(getGraphicMidpointX(getProperty('boyfriend')) + 100,
                getGraphicMidpointY(getProperty('boyfriend')) - 50)
end
