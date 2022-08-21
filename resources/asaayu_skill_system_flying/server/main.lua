local loaded = false
local timeout = tonumber(GetResourceMetadata(GetCurrentResourceName(), 'timeout', 0))

Citizen.CreateThread(function()

    -- Register the skill with the system.
    local result = exports.asaayu_skill_system:registerSkill("flying", "Flying", 100, 1000, 0.12)
    if not result then error("Failed to register 'flying' skill.") end
    loaded = true
end)


-- Register a net event to give player's xp when they drive.
local lastCall = {}
RegisterNetEvent("asaayu_skill_system_flying:action", function()
    local source = source

    -- Check that the player has waited long enough to get xp.
    if lastCall[source] and lastCall[source] > GetGameTimer() then return end

    -- Get the player's identifier.
    local identifier = exports.asaayu_skill_system:getIdentifier(source)
    if not identifier or identifier == "" then return end

    -- For security, lets confirm that the player is flying.
    local player = GetPlayerPed(source)
    local vehicle = GetVehiclePedIsIn(player, false)

    -- Confirm that all the requirements are met on the server side as well.
    if not vehicle or GetPedInVehicleSeat(vehicle, -1) ~= player or GetEntitySpeed(vehicle) < 30 then return end

    -- Set the last call time.
    lastCall[source] = GetGameTimer() + timeout

    -- Increase the amount of xp based on the speed of the vehicle.
    local kph = GetEntitySpeed(vehicle)*3.6

    -- Limit the amount of xp that can be earned to between 50 and 350
    local amount = math.min(350, math.max(50, kph))

    -- Give the player xp.
    exports.asaayu_skill_system:addXp(source, "flying", math.floor(amount))
end)


-- Register a net event get the player's xp and level.
RegisterNetEvent("asaayu_skill_system_flying:getLevel", function()
    local source = source

    -- Wait for the skill to be loaded.
    while not loaded do Wait(100) end

    -- Get the player's xp and level.
    local data = exports.asaayu_skill_system:getXp(source, "flying")

    -- Get the max level of the skill.
    local maxLevel = exports.asaayu_skill_system:getMaxLevel("flying")

    -- Send the data back to the client.
    TriggerClientEvent("asaayu_skill_system_flying:getLevel", source, data[1], data[2], maxLevel)
end)