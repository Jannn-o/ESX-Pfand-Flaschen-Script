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
    Citizen.Wait(0)
end)
-- blip

Citizen.CreateThread(function()
    for k, v in pairs(Config.shop) do
        while (not HasModelLoaded(GetHashKey(v.ped))) do
            Citizen.Wait(1)
        end
        CreatePed(1, GetHashKey(v.ped), v.coords.x, v.coords.y, v.coords.z, v.heading, false)
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
                ESX.ShowHelpNotification("Drücke ~INPUT_CONTEXT~ um dein Pfand zu Verkaufen!")
                if IsControlJustPressed(0, 38) then 
                    menu()
                end
            end
        end
        Citizen.Wait(msec)
    end
end)

function menu()
    local options = {
        {label = "Pfand Verkaufen", name = "sellpfand"},
        {label = "Abbrechen", name = "back"}
    }

    ESX.UI.Menu.Open("default", GetCurrentResourceName(), "Pfand_händler", {
        titel = "Pfand Händler",
        align = "right",
        elements =  options   
    },

    function(data, menu)
        if data.current.name == "sellpfand" then 
            sellmenu()
            menu.close()
        end
        if data.current.name == "back" then 
            menu.close()
        end
    end, function(data, menu)
        menu.close()
    end)
end

function sellmenu()
    local options = {
        {label = "Bar Geld?", name = "bar"},
        {label = "Auf die Bank", name = "bank"}
    }

    ESX.UI.Menu.Open("default", GetCurrentResourceName(), "Pfand", {
        titel = "Pfand",
        align = "right",
        elements =  options   
    },

    function(data, menu)
        if data.current.name == "bar" then
            for k, v in pairs(Config.shop) do
                TriggerServerEvent("JN_Pfand:sellpfandbar", v.item)
                menu.close()
            end
        end
        if data.current.name == "bank" then 
            for k, v in pairs(Config.shop) do
                TriggerServerEvent("JN_Pfand:sellpfandbank", v.item)
                menu.close()
            end
        end
    end, function(data, menu)
        menu.close()
    end)
end
