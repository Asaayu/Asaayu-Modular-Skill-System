Citizen.CreateThread(function()

    -- Register a command to add xp to the player.
    RegisterCommand('addXP', function(source)

        -- Block requests from the server console
        if source == 0 then error("This command can't be called from the server console.") end

        -- Add 100 xp to the player's skill.
        local result = exports.asaayu_skill_system:addXp(source, "example_skill", 100)

        -- You can use the result, 'asaayu_skill_system:xpEarned' event, or 'asaayu_skill_system:levelEarned' event depending on your needs.
        -- It's recommened to use the events as they contain helpful arguments rather then a true/false result.
        -- In this example we'll use the events sent to the client.
    end)

    -- Register a command to add xp to the player.
    RegisterCommand('removeXP', function(source)

        -- Block requests from the server console
        if source == 0 then error("This command can't be called from the server console.") end

        -- Remove 100 xp from the player's skill.
        local result = exports.asaayu_skill_system:removeXp(source, "example_skill", 100)

        -- You can use the result, 'asaayu_skill_system:xpLost' event, or 'asaayu_skill_system:levelLost' event depending on your needs.
        -- It's recommened to use the events as they contain helpful arguments rather then a true/false result.
        -- In this example we'll use the events sent to the client.
    end)

    -- Register a command to get the player's xp in the skill.
    RegisterCommand('getXP', function(source)

        -- Block requests from the server console
        if source == 0 then error("This command can't be called from the server console.") end

        -- Get the player's xp in the skill.
        -- The data variable will contain '{total xp, player's level}' in the skill.
        local data = exports.asaayu_skill_system:getXp(source, "example_skill")

        -- Get the display name of the skill.
        local displayName = exports.asaayu_skill_system:getSkillDisplayName("example_skill")

        -- Send the information to the player that sent the command.
        TriggerClientEvent('asaayu_skill_system_example:print', source, string.format("%s - Level: %d, Total XP: %d", displayName, data[2], data[1]))
    end)

    -- Register a command to get the player's xp in the skill.
    RegisterCommand('getLeaderboard', function(source)

        -- Block requests from the server console
        if source == 0 then error("This command can't be called from the server console.") end

        -- To avoid duplicating code we just use the command from the base system
        ExecuteCommand('viewSkillLeaderboard')
    end)

    -- Register a command to get all the player's skills.
    RegisterCommand('getSkills', function(source)

        -- Block requests from the server console
        if source == 0 then error("This command can't be called from the server console.") end

        -- Get all the player's skills.
        local data = exports.asaayu_skill_system:getPlayerSkills(source)

        local str = ""
        for k,v in pairs(data) do
            str = str..string.format("%s - XP: %d, ", exports.asaayu_skill_system:getSkillDisplayName(k), v)
        end

        -- Send the information to the player that sent the command.
        TriggerClientEvent('asaayu_skill_system_example:print', source, string.format("Skills - { %s}", str))
    end)
end)
