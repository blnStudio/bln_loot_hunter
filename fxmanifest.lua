fx_version 'cerulean'
game 'rdr3'
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

lua54 'yes'

author "BLN Studio <bln-studio.com>"
description "World loot system for RedM"
version "1.0.0"

client_scripts {
    'c/*.lua',
}

server_scripts {
    's/*.lua',
}

shared_scripts {
    'config.lua'
}

dependencies {
    'bln_lib'
}
