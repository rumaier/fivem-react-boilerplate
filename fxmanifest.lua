---@diagnostic disable: undefined-global
fx_version 'cerulean'
game 'gta5'
lua54 'yes'

name 'resource_name'
description 'resource_description'
author 'author_name'
version '1.0.0'

shared_scripts {
    '@ox_lib/init.lua',
    '@r_bridge/init.lua',
    'core/shared/_util.lua',
    'locales/*.lua',
}

server_scripts {
    'config.lua',
    'core/server/_util.lua',
    'core/server/main.lua',
}

client_scripts {
    'core/client/_util.lua',
    'core/client/main.lua',
}

-- ui_page 'web/dist/index.html' -- uncomment if resource has nui built
-- ui_page 'http://localhost:5173/' -- uncomment for vite dev server, remove in production
files {
    'core/client/modules/*.lua',
    'web/dist/index.html',
    'web/dist/**/*',
}

dependencies {
    'ox_lib',
    'r_bridge',
}

escrow_ignore {
    'install/**/*.*',
    'locales/*.*',
    'config.lua'
}
