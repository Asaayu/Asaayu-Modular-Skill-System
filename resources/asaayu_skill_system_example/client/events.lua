local skill = 'example_skill'

-- This event is triggered when the player earns some XP.
RegisterNetEvent('asaayu_skill_system:xpEarned', function(skill, displayName, oldAmount, amount, newAmount, origLevel, newLevel, xpRequired)

    -- Print the amount of XP earned to the console, and how much XP is required to level up.
    print("^4You earned "..amount.." XP, you now have "..newAmount.." XP and are level "..newLevel..". You need "..math.max(0, math.ceil(xpRequired-newAmount)).." XP to reach the next level.^0")

end)

-- This event is triggered only when the player levels up.
RegisterNetEvent('asaayu_skill_system:levelEarned', function(skill, displayName, oldAmount, amount, newAmount, origLevel, newLevel, xpRequired)

    -- Print the level up message to the console.
    print("^2You have leveled up in "..displayName.."! You are now level "..newLevel.."!^0")

end)

-- This event is triggered when the player earns some XP.
RegisterNetEvent('asaayu_skill_system:xpLost', function(skill, displayName, oldAmount, amount, newAmount, origLevel, newLevel, xpRequired)

    -- Print the amount of XP earned to the console, and how much XP is required to level up.
    print("^4You lost "..amount.." XP, you now have "..newAmount.." XP and are level "..newLevel..". You need "..math.max(0, math.ceil(xpRequired-newAmount)).." XP to reach the next level.^0")

end)

-- This event is triggered only when the player levels up.
RegisterNetEvent('asaayu_skill_system:levelLost', function(skill, displayName, oldAmount, amount, newAmount, origLevel, newLevel, xpRequired)

    -- Print the level up message to the console.
    print("^2You have lost a level in "..displayName.."! You are now level "..newLevel.."!^0")

end)

-- This is just a simple event to display text sent to a clients console
RegisterNetEvent('asaayu_skill_system_example:print', function(text) print("^4"..text.."^0") end)

