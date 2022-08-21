local loaded = false
local timeout = tonumber(GetResourceMetadata(GetCurrentResourceName(), 'timeout', 0))

Citizen.CreateThread(function()

    -- Register the skill with the system.
    local result = exports.asaayu_skill_system:registerSkill("strength", "Strength", 100, 1000, 0.12)
    if not result then error("Failed to register 'strength' skill.") end
    loaded = true

end)


-- Register a net event to give player's xp when they drive.
local lastCall = {}
RegisterNetEvent("asaayu_skill_system_strength:action", function()
    local source = source

    -- Check that the player has waited long enough to get xp.
    if lastCall[source] and lastCall[source] > GetGameTimer() then return end

    -- Get the player's identifier.
    local identifier = exports.asaayu_skill_system:getIdentifier(source)
    if not identifier or identifier == "" then return end

    -- For security, lets confirm that the player is punching.
    local player = GetPlayerPed(source)
    local weapon = GetSelectedPedWeapon(player)

    -- Because we can't check if the player is punching server side, we'll just have to check that they have a weapon selected.
    -- Make sure the player is using either their fists or the brass knuckles.
    if weapon ~= joaat('WEAPON_UNARMED') and weapon ~= joaat('WEAPON_KNUCKLE') then return end

    -- Set the last call time.
    lastCall[source] = GetGameTimer() + timeout

    -- Randomly give the player between 150 and 450 xp.
    local amount = math.random(100, 450)

    -- Give the player xp.
    exports.asaayu_skill_system:addXp(source, "strength", amount)
end)


-- Register a net event get the player's xp and level.
RegisterNetEvent("asaayu_skill_system_strength:getLevel", function()
    local source = source

    -- Wait for the skill to be loaded.
    while not loaded do Wait(100) end

    -- Get the player's xp and level.
    local data = exports.asaayu_skill_system:getXp(source, "strength")

    -- Get the max level of the skill.
    local maxLevel = exports.asaayu_skill_system:getMaxLevel("strength")

    -- Send the data back to the client.
    TriggerClientEvent("asaayu_skill_system_strength:getLevel", source, data[1], data[2], maxLevel)
end)