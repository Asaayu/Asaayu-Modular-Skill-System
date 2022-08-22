-- All interactions with the skill system must be done through the server, allowing the server to handle all the logic and prevent any cheating.
-- This example resource contains everything needed to create your own skill system for Asaayu's GTAO Skill System & Framework resource
-- WARNING: This resource does not use any of the recommened methods for ensuring against cheating, it is only an example of how to use the skill system.
-- DO NOT USE THIS RESOURCE IN A PRODUCTION ENVIRONMENT, IT IS NOT SECURE, IT IS ONLY AN EXAMPLE RESOURCE FOR THE EDUCATION OF OTHERS.

Citizen.CreateThread(function()

    while true do
        Wait(1000)

        -- Display help text on the screen
        BeginTextCommandDisplayHelp('TWOSTRINGS')
        AddTextComponentSubstringPlayerName('Avaliable commands \'addXp\', \'getXp\', \'getLeaderboard\', and \'getSkills\'.')
        AddTextComponentSubstringPlayerName('\nReturned data is printed to the console')
        EndTextCommandDisplayHelp(0, true, true, 1000)
    end

end)
