-- Main Thread
Citizen.CreateThread(function()

    -- Set our variables
    local skill, name, maxLevel, firstLevelXp, xpMultiplier = "example_skill", "Asaayu's Example Skill", 100, 1000, 0.1143233142569

    -- Register this skill with the skill system, this adds it to the base resource's list of skills and creates the database column if it doesn't exist.
    exports.asaayu_skill_system:registerSkill(skill, name, maxLevel, firstLevelXp, xpMultiplier)

end)