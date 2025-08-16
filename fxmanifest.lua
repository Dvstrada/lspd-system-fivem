fx_version 'cerulean'
game 'gta5'
author 'Dvstrada'
description 'LSPD Police System with Organizations Menu'
version '1.0.0'
lua54 'yes'

shared_scripts {
    'config.lua'
}

client_scripts {
    'client/main.lua'
}

server_scripts {
    'server/main.lua'
}

ui_page 'html/index.html'

files {
    'html/index.html',
    'html/style.css',
    'html/script.js'
}
