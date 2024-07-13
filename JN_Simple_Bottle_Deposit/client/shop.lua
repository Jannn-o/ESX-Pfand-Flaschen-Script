-- blip    
Citizen.CreateThread(function()

    for _, info in pairs(Config.Blips) do
      info.blip = AddBlipForCoord(info.x, info.y, info.z)
      SetBlipSprite(info.blip, info.id)
      SetBlipDisplay(info.blip, 4)
      SetBlipScale(info.blip, 1.0)
      SetBlipColour(info.blip, info.colour)
      SetBlipAsShortRange(info.blip, true)
	  BeginTextCommandSetBlipName("STRING")
      AddTextComponentString(info.title)
      EndTextCommandSetBlipName(info.blip)
    end
end)
-- blip

Citizen.CreateThread(function()
    for k, v in pairs(Config.shop) do
        while (not HasModelLoaded(GetHashKey(v.ped))) do
            Citizen.Wait(1)
        end
        CreatePed(2, GetHashKey(v.ped), v.coords.x, v.coords.y, v.coords.z, v.heading, false)
    end
end)

Citizen.CreateThread(function()
    while true do 
        local msec = 1000
        local ped = PlayerPedId()
        for k, v in pairs(Config.shop) do 
            local distance = #(GetEntityCoords(ped) - v.coords)
            RequestModel(GetHashKey(v.ped))
            while (not HasModelLoaded(GetHashKey(v.ped))) do
                Citizen.Wait(1)
            end
            if distance <= 2.0 then 
                msec = 0
                ESX.ShowHelpNotification("Drücke ~INPUT_CONTEXT~ um dien Pfand zu Verkaufen!")
                if IsControlJustPressed(0, 38) then 
                    TriggerServerEvent("JN_Pfand:getpfand", v.item)
                end
            end
        end
        Citizen.Wait(msec)
    end
end)