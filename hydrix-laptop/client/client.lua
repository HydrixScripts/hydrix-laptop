local QBCore = exports['qb-core']:GetCoreObject()

local PlayerData = QBCore.Functions.GetPlayerData()

local IsHacking = false

--functions

function openHack(puzzleDuration, puzzleLength, puzzleAmount)
    SetNuiFocus(true, true)
    SendNUIMessage({
        action = "open",
        duration = puzzleDuration,
        length = puzzleLength,
        amount = puzzleAmount
    })
    IsHacking = true
end

function closeHack()
    SetNuiFocus(false, false)
    IsHacking = false
end

function GetHackingStatus()
    return IsHacking
end


function HackResults(success)
    if success then
		closeHack()
        QBCore.Functions.Notify("You completed the hack.", "success")
        TriggerEvent('animations:client:EmoteCommandStart', {"c"})
        exports["mz-skills"]:UpdateSkill("Hacking", 5)
    else
		closeHack()
		QBCore.Functions.Notify("You failed the hack.", "error")
        TriggerEvent('animations:client:EmoteCommandStart', {"c"})
	end
end

-- events

RegisterNetEvent('hydrix-laptop:client:practiceLaptop', function()
    TriggerEvent('animations:client:EmoteCommandStart', {"texting"})  
    TriggerServerEvent('hydrix-laptop:server:removelaptop')
    Wait(3000)
    exports['hacking']:OpenHackingGame(Config.hackTime, Config.hackBlocks, Config.hackRepeat, 
    function(Success)
        if Success then
            QBCore.Functions.Notify("You Are Juiced!", "success")
            TriggerEvent('animations:client:EmoteCommandStart', {"c"})
            closeHack() -- close the minigame after success
        else
            QBCore.Functions.Notify("You Failed To do the Hack...", "error")
            TriggerEvent('animations:client:EmoteCommandStart', {"c"})
            closeHack() -- close the minigame after success 
        end
    end)
end)

RegisterCommand('practicelaptop', function()
    local hasItem = QBCore.Functions.HasItem("practicelaptop")
    if hasItem then
        -- Start hacking
        TriggerEvent('hydrix-laptop:client:practiceLaptop') -- Start the minigame (Make it into a item)
    else
        QBCore.Functions.Notify('You Dont Have A Laptop! Go Get Another!', 'error', 3500)
    end
end)


RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    PlayerData = QBCore.Functions.GetPlayerData()
end)

RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
    PlayerData = {}
end)

--cb

AddEventHandler('open:minigame', function(callback)
    Callbackk = callback
    openHack()
end)


RegisterNUICallback('callback', function(data, cb)
    closeHack()
    Callbackk(data.success)
    cb('ok')
end)

---end all client events---

