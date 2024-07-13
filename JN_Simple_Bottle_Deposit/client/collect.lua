Citizen.CreateThread(function()
    while true do 
        local ped = PlayerPedId()
        local pedcoords = GetEntityCoords(ped)
        local msec = 1000
        for k, v in pairs(Config.pfand) do 
            local binhash = GetHashKey(v.bin)
            local objectId1 = GetClosestObjectOfType(pedcoords, 9.0, binhash, false)
            if DoesEntityExist(objectId1) then 
                msec = 0
                local binpos = GetEntityCoords(objectId1)
                DrawMarker(20, binpos.x, binpos.y, binpos.z +1.5, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 1.0, 225, 137, 0, 145, false, true, 2, false, nil, nil, false)
                local objectId2 = GetClosestObjectOfType(pedcoords, 0.6, binhash, false)
                if DoesEntityExist(objectId2) then 
                    ESX.ShowHelpNotification("Drücke ~INPUT_CONTEXT~ um nach Pfand zu suchen!")
                    if IsControlJustPressed(0, 38) then 
                        emote(v.lib, v.dict)
                        Citizen.Wait(3000)
                        TriggerServerEvent("JN_Pfand:giveitem", v.item, v.maxamount, objectId2)
                    end
                end
            end
        end
        Citizen.Wait(msec)
    end
end)

function emote(lib, dict)
    local ped = PlayerPedId()
    ESX.Streaming.RequestAnimDict(dict, function()
        TaskPlayAnim(ped, dict, lib, 8.0, -8.0, 3000, 0, 0, false, false, false)
    end)
end

RegisterNetEvent("JN_Pfand:removebin")
AddEventHandler("JN_Pfand:removebin", function(bin)
    ESX.Game.DeleteObject(bin)
end)

