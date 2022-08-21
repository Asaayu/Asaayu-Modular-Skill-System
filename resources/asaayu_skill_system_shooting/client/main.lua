local timeout = tonumber(GetResourceMetadata(GetCurrentResourceName(), 'timeout', 0))

Citizen.CreateThread(function()

    -- Wait for the player to be ready.
    Wait(5000)

    -- Request the player's xp and level so we can setup the bonuses for the player.
    TriggerServerEvent("asaayu_skill_system_shooting:getLevel")

    -- Create a loop that we can use to detect when the player is sprinting
    local lastCall = 0
    while true do

        -- Variables
        local ply, player = PlayerId(), PlayerPedId()
        local sleep = 5000

        -- Check if the player has a weapon out.
        if IsPedArmed(player, 4) then
            sleep = 1000

            -- Check if the player is aiming.
            if IsPlayerFreeAiming(ply) then
                sleep = 0

                -- Check if the player is shooting.
                if IsPedShooting(player) then

                    -- We only want to give xp when shooting at a ped/player
                    local hit, entity = GetEntityPlayerIsFreeAimingAt(ply)

                    if hit and IsEntityAPed(entity) and not IsPedDeadOrDying(entity) then

                        -- Only call the function once per timeout
                        if lastCall < GetGameTimer() then
                            TriggerServerEvent("asaayu_skill_system_shooting:action")
                            lastCall = GetGameTimer() + timeout
                        end
                    end
                end
            end
        end

        Wait(sleep)
    end
end)

-- Function to setup the bonuses for the player.
local maxLevel
function handleBonus(level)

    -- Check input
    if not level or not maxLevel then return end

    -- Get the percentage of progress to the max level
    local progress = math.floor((level / maxLevel) * 100)

    -- Set the internal game stat.
    StatSetInt(`MP0_SHOOTING_ABILITY`, progress, true)

end

-- Listen for the event that returns the player's xp and level.
RegisterNetEvent("asaayu_skill_system_shooting:getLevel", function(xp, level, max)
    -- Set the max level for the skill.
    maxLevel = max

    -- Setup the bonuses for the player.
    handleBonus(level)
end)

-- Listen for the event that is triggered when the player gets xp.
RegisterNetEvent("asaayu_skill_system:xpEarned", function(skill, displayName, oldAmount, amount, newAmount, origLevel, newLevel, xpRequired)

    -- Because this skill will get xp constantly, we don't want to spam the player with notifications.
    if skill ~= 'shooting' then return end
end)

-- Listen for the event that is triggered when the player levels up.
RegisterNetEvent("asaayu_skill_system:levelEarned", function(skill, displayName, oldAmount, amount, newAmount, origLevel, newLevel, xpRequired)
    -- Only run the code for this skill.
    if skill ~= 'shooting' then return end

    -- Setup the bonuses for the player.
    handleBonus(newLevel)

    -- Get the player headshot image.
    local player = PlayerPedId()
    local headshot = RegisterPedheadshot(player)
    while not IsPedheadshotReady(headshot) or not IsPedheadshotValid(headshot) do Wait(0) end
    local image = GetPedheadshotTxdString(headshot)

    -- Show a notification above the map (In the feed)
    BeginTextCommandThefeedPost("TWOSTRINGS")
    AddTextComponentSubstringPlayerName(string.format("Congratulations, your %s skill is now level %d!", displayName, newLevel))
    AddTextComponentSubstringPlayerName("\nYour recoil, reloading, and accuracy have improved!")
    EndTextCommandThefeedPostMessagetext(image, image, false, 2, "Level Up!", displayName)
    EndTextCommandThefeedPostTicker(false, true)

    -- Unregister the headshot.
    UnregisterPedheadshot(headshot)

    -- Play a sound.
    PlaySoundFrontend(-1, "RACE_PLACED", "HUD_AWARDS", true)
end)

-- We never remove xp from the shooting skill, so we don't need to listen for the remove events.