-- Lets also add a trigger event and listen for any suspicious actions.
AddEventHandler('asaayu_skill_system:suspiciousAction', function(source, message)

    -- Create the output message.
    local output = string.format("Suspicious Action: %s", message)

    -- Drop the player and print the message to the server console.
    DropPlayer(source, output)
    print('^1'..output)

end)