local IsHacking = false
local HackStartTime = 0
local CustomHackTime = 30

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
    HackStartTime = GetGameTimer()
end

function closeHack()
    SetNuiFocus(false, false)
    IsHacking = false
    HackStartTime = 0
end

function GetHackingStatus()
    return IsHacking
end

function GetHackingProgress()
    if not IsHacking then return 0 end
    local elapsed = GetGameTimer() - HackStartTime
    local progress = elapsed / (Config.AllowCustomHackTime and CustomHackTime or Config.HackTime)
    return math.min(progress, 1)
end

function GetCustomHackTime()
    local menu = exports['qb-menu']:CreateMenu('Custom Hack Time', 'Enter the time in seconds:', 'top-right', 200, 25, 100, 'size-125', 'none', 'menuv', 'test')
    local input = exports['qb-input']:CreateInput({menu = menu, id = 'time', label = 'Time (sec)', value = CustomHackTime, type = 'number', min = Config.CustomHackTimeMin, max = Config.CustomHackTimeMax})
    menu.onClosed = function()
        if input.value then
            CustomHackTime = tonumber(input.value)
            QBCore.Functions.Notify("Custom hack time set to " .. CustomHackTime .. " seconds.", "success")
        else
            QBCore.Functions.Notify("Invalid custom hack time. It must be between " .. Config.CustomHackTimeMin .. " and " .. Config.CustomHackTimeMax .. " seconds.", "error")
        end
    end
    menu:Open()
end

-- // RegisterNetEvents // --
RegisterNetEvent('hydrix-laptop:client:practiceLaptop')
AddEventHandler('hydrix-laptop:client:practiceLaptop', function()
    local src = source
    local item = QBCore.Functions.GetItemByName("practicelaptop")

    if item ~= nil then
        TriggerEvent('animations:client:EmoteCommandStart', {"texting"})
        Wait(3000)
        local hackTime = Config.AllowCustomHackTime and CustomHackTime or Config.HackTime
        exports['hacking']:OpenHackingGame(hackTime, Config.HackBlocks, Config.HackRepeat, function(success)
            if success then
                QBCore.Functions.Notify("You completed the hack.", "success")
                TriggerEvent('animations:client:EmoteCommandStart', {"c"})
                closeHack() -- close the minigame after success
            else
                QBCore.Functions.Notify("You failed the hack.", "error")
                TriggerEvent('animations:client:EmoteCommandStart', {"c"})
                if math.random(100) <= Config.FailureRemovalChance then
                    TriggerServerEvent('hydrix-laptop:server:confiscateLaptop')
                end
                closeHack() -- close the minigame after failure
            end
        end)
    else
        QBCore.Functions.Notify("You don't have a practice laptop.", "error")
    end
end)


-- // Net Events // --
RegisterNetEvent('hydrix-laptop:client:setCustomHackTime')
AddEventHandler('hydrix-laptop:client:setCustomHackTime', function()
    QBCore.Functions.TriggerCallback('hydrix-laptop:server:getCustomHackTime', function(time)
        CustomHackTime = time
        QBCore.Functions.Notify("Custom hack time set to " .. CustomHackTime .. " seconds.", "success")
    end)
end)

