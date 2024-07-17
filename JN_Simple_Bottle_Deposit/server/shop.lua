RegisterNetEvent("JN_Pfand:sellpfandbar")
AddEventHandler("JN_Pfand:sellpfandbar", function(bottles)
    local xPlayer = ESX.GetPlayerFromId(source)
    local amount = xPlayer.getInventoryItem(bottles).count
    if amount >= 1 then
        for k, v in pairs(Config.shop) do 
            xPlayer.removeInventoryItem(bottles, amount)
            money = (amount * v.price)
            xPlayer.addAccountMoney("money", money)
            xPlayer.showNotification("Du hast Pfand Im Wert von " .. money .. " Verkauft")
        end
    else
        xPlayer.showNotification("Du hast Keine Pfandflaschen")
    end
end)

RegisterNetEvent("JN_Pfand:sellpfandbank")
AddEventHandler("JN_Pfand:sellpfandbank", function(bottles)
    local xPlayer = ESX.GetPlayerFromId(source)
    local amount = xPlayer.getInventoryItem(bottles).count
    if amount >= 1 then
        for k, v in pairs(Config.shop) do 
            xPlayer.removeInventoryItem(bottles, amount)
            money = (amount * v.price)
            xPlayer.addAccountMoney('bank', money)
            xPlayer.showNotification("Du hast Pfand Im Wert von " .. money .. " Verkauft")
        end
    else
        xPlayer.showNotification("Du hast Keine Pfandflaschen")
    end
end)
