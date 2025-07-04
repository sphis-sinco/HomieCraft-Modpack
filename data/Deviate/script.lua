camStartZoom = 1.5

camzoomInDUET = -0.25
camzoomInBF = 0
camzoomInDAD = 0.1

camzoomInGF = -0.05
camzoomInGF_DAD = -0.075

function onStepHit()
        zoomOffset = 0

        if mustHitSection then
                zoomOffset = camzoomInBF
        end

        if not mustHitSection then
                zoomOffset = camzoomInDAD
        end

        if gfSection then
                zoomOffset = camzoomInGF

                if not mustHitSection then
                        zoomOffset = camzoomInGF_DAD
                end
        end

        duetSections()

        doTweenZoom('camz', 'camGame', camStartZoom + zoomOffset, 0.4, 'expoOut')
end

function duetSections()
end

function duet()
        zoomOffset = camzoomInDUET
        setCameraFollowPoint(getGraphicMidpointX(getProperty('boyfriend')) + 100,
                getGraphicMidpointY(getProperty('boyfriend')) - 50)
end
