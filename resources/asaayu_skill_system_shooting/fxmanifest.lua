-- Information about this specific resource
name "asaayu_skill_system_shooting"
description "This resource allows players to gain xp in a 'shooting' skill, allowing them to level up and compete against each other. The higher the level, the better the player's recoil control and accuracy will be."
version '1.0.0'

timeout '10000'

-- Files that escrow will ignore
escrow_ignore {'**.lua'}

-- Scripts that will be run only on the client side
client_scripts {
    'client/**/*.lua'
}

-- Scripts that will be run only on the server side
server_scripts {
    'server/**/*.lua'
}

-- Resource dependencies
dependencies {
    'asaayu_skill_system',
}

-- Default resource information
author 'Asaayu'
fx_version 'cerulean'
game 'gta5'
lua54 'yes'
tebex 'https://asaayu.tebex.io/'
