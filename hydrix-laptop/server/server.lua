local QBCore = exports['qb-core']:GetCoreObject()


--item use

function QBCore.Functions.UseItem(source, item)
    QBCore.UseableItems[item.name](source, item)
end

local canUse = QBCore.Functions.CanUseItem('practicelaptop')
if not canUse then return end
TriggerEvent('hydrix-laptop:client:practiceLaptop') -- Start the minigame (Make it into a item)

-- Item Creation

QBCore.Functions.CreateUseableItem('practicelaptop', function(source)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    if not Player.Functions.GetItemByName('practicelaptop') then return end
    local Player = QBCore.Functions.GetPlayer(src)
        TriggerEvent('hydrix-laptop:client:practiceLaptop') -- Start the minigame (Make it into a item)
end)

-- sv events

RegisterNetEvent('hydrix-laptop:server:removelaptop', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    Player.Functions.RemoveItem('practicelaptop', 1)
end)

--cb

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

---end all server events---