RegisterNetEvent("JN_Pfand:giveitem")
AddEventHandler("JN_Pfand:giveitem", function(item, maxamount, bin)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer ~= nil then 
        local amount = math.random(1, maxamount)
        if xPlayer.canCarryItem(item, amount) then 
            xPlayer.addInventoryItem(item, amount)
            TriggerClientEvent("JN_Pfand:removebin", source, bin)
        else
            xPlayer.showNotification("dein rucksack ist voll")
        end
    end
end)