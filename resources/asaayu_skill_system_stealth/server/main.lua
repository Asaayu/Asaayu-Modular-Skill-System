local loaded = false
local timeout = tonumber(GetResourceMetadata(GetCurrentResourceName(), 'timeout', 0))

Citizen.CreateThread(function()

    -- Register the skill with the system.
    local result = exports.asaayu_skill_system:registerSkill("stealth", "Stealth", 100, 1000, 0.12)
    if not result then error("Failed to register 'stealth' skill.") end
    loaded = true
end)


-- Register a net event to give player's xp when they drive.
local lastCall = {}
RegisterNetEvent("asaayu_skill_system_stealth:action", function()
    local source = source

    -- Check that the player has waited long enough to get xp.
    if lastCall[source] and lastCall[source] > GetGameTimer() then return end

    -- Get the player's identifier.
    local identifier = exports.asaayu_skill_system:getIdentifier(source)
    if not identifier or identifier == "" then return end

    -- Unforunately, due to FiveM server limitations we can't check if the player is swimming or moving fast enough, so we'll just have to trust them and just use a cooldown timer to ensure they don't get xp too often.
    -- Hopefully sometime in the future we'll be able to check on the server side.

    -- Set the last call time.
    lastCall[source] = GetGameTimer() + timeout

    -- Randomly give the player between 150 and 450 xp.
    local amount = math.random(150, 450)

    -- Give the player xp.
    exports.asaayu_skill_system:addXp(source, "stealth", amount)
end)


-- Register a net event get the player's xp and level.
RegisterNetEvent("asaayu_skill_system_stealth:getLevel", function()
    local source = source

    -- Wait for the skill to be loaded.
    while not loaded do Wait(100) end

    -- Get the player's xp and level.
    local data = exports.asaayu_skill_system:getXp(source, "stealth")

    -- Get the max level of the skill.
    local maxLevel = exports.asaayu_skill_system:getMaxLevel("stealth")

    -- Send the data back to the client.
    TriggerClientEvent("asaayu_skill_system_stealth:getLevel", source, data[1], data[2], maxLevel)
end)