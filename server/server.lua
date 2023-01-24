local QBCore = exports['qb-core']:GetCoreObject()

--// Server Events // --
QBCore.Functions.CreateUseableItem('practicelaptop' , function(item)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local laptop = math.random(Config.Laptopchance)

    if not Player.Functions.GetItemByName('practicelaptop') then return end

    if laptop == 1 then
        TriggerClientEvent('QBCore:Notify', src, 'Your laptop just broke', 'error')
        Player.Functions.RemoveItem('practicelaptop', 1)
        TriggerClientEvent('hydrix-laptop:client:practiceLaptop', src)
    end
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