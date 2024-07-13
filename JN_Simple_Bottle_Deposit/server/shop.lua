RegisterNetEvent("JN_Pfand:getpfand")
AddEventHandler("JN_Pfand:getpfand", function(bottles)
    local xPlayer = ESX.GetPlayerFromId(source)
    local amount = xPlayer.getInventoryItem(bottles).count
    if amount >= 1 then
        for k, v in pairs(Config.shop) do 
            xPlayer.removeInventoryItem(bottles, amount)
            xPlayer.addMoney(amount * v.price)
        end
    end
end)