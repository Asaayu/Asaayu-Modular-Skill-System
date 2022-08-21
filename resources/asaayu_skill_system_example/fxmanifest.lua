-- Information about this specific resource
name "asaayu_skill_system_example"
description "An example skill that works with Asaayu's Modular Skill System. Avaliable @ https://asaayu.tebex.io/"
version '1.0.0'

-- Files that escrow will ignore
escrow_ignore {'**.lua'}

-- Scripts that will be run only on the client side
client_scripts { 'client/**/*.lua' }

-- Scripts that will be run only on the server side
server_scripts { 'server/**/*.lua' }

-- Resource dependencies
dependencies { 'asaayu_skill_system' }

-- Default resource information
author 'Asaayu'
fx_version 'cerulean'
game 'gta5'
lua54 'yes'
tebex 'https://asaayu.tebex.io/'
