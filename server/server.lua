local QBCore = exports['qb-core']:GetCoreObject()

--// Server Events // --
QBCore.Functions.CreateUseableItem('practicelaptop' , function(source, item)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    TriggerClientEvent('hydrix-laptop:client:practiceLaptop', src)
end)

-- // Callbacks // --
QBCore.Functions.CreateCallback("laptop:server:check", function(source, cb)
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return cb(false) end
    if Player.Functions.RemoveItem("practicelaptop", 1) then
        TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items["practicelaptop"], "remove")
        cb(true)
    else
        cb(false)
    end
end)

-- // Commands // --
if Config.Debug then
    QBCore.Commands.Add("practicelaptop", "Give yourself a laptop", {}, false, function(source, args)
        local Player = QBCore.Functions.GetPlayer(source)
        Player.Functions.AddItem("practicelaptop", 1)
        TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items["practicelaptop"], "add")
    end, "admin")
end

-- // EvnetHandlers // --
AddEventHandler('onResourceStart', function(resource)
   if resource == GetCurrentResourceName() then
    print("^5Hydrix Laptop Started ^7")
   end
end)

-- // Callbacks // --

RegisterServerEvent('hydrix-laptop:server:getCustomHackTime')
AddEventHandler('hydrix-laptop:server:getCustomHackTime', function()
    local src = source
    TriggerClientEvent('qb-menu:client:openMenu', src, {
        {
            header = "Custom Hack Time",
            txt = "Set the custom hack time in seconds",
            params = {
                event = "hydrix-laptop:client:setCustomHackTime"
            }
        }
    })
end)


RegisterServerEvent('hydrix-laptop:server:confiscateLaptop')
AddEventHandler('hydrix-laptop:server:confiscateLaptop', function()
    local src = source
    local xPlayer = QBCore.Functions.GetPlayer(src)
    local item = xPlayer.getInventoryItem("practicelaptop")

    if item ~= nil and item.count > 0 then
        xPlayer.removeInventoryItem("practicelaptop", 1)
        TriggerClientEvent('QBCore:Notify', src, "Your laptop was confiscated due to a failed hack attempt.", "error")
    end
end)
