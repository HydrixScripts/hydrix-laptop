local QBCore = exports['qb-core']:GetCoreObject()
local PlayerData = QBCore.Functions.GetPlayerData()
local IsHacking = false

-- // Functions // -- 
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

-- // RegisterNetEvents // --
RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    PlayerData = QBCore.Functions.GetPlayerData()
end)

RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
    PlayerData = {}
end)

RegisterNetEvent('hydrix-laptop:client:practiceLaptop', function()
    TriggerEvent('animations:client:EmoteCommandStart', {"texting"})  
    Wait(3000)
    exports['hacking']:OpenHackingGame(Config.HackTime, Config.HackBlocks, Config.HackRepeat, 
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

-- // EventHandlers // --
AddEventHandler('open:minigame', function(callback)
    Callbackk = callback
    openHack()
end)

RegisterNUICallback('callback', function(data, cb)
    closeHack()
    Callbackk(data.success)
    cb('ok')
end)
