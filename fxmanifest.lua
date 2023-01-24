fx_version 'cerulean'
game 'gta5'

name "hydrix-laptop"
author "imtorchedbud"
description "Practice Laptop by <Hydrix>"
version '1.0.0'

shared_scripts {
    -- '@ox_lib/init.lua', -- nothing is being used from ox_lib
    'shared/config.lua'
}

client_scripts {
    'client/client.lua'
}

dependencies {
    'hacking',
}

server_script 'server/server.lua'

lua54 'yes'