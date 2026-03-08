Core = exports.r_bridge:returnCoreObject()

local framework = Core.Framework.Current
local onPlayerLoaded =  framework == 'es_extended' and 'esx:playerLoaded' or 'QBCore:Client:OnPlayerLoaded'

local function initialize()
    -- init functions
end

RegisterNetEvent(onPlayerLoaded, initialize)

if Cfg.Debug then
    SetTimeout(1000, initialize)
end

RegisterNUICallback('setNuiFocus', function(focus, cb)
    cb(SetNuiFocus(focus, focus))
end)

RegisterNUICallback('fetchLocales', function(_, cb)
    cb(Language[Cfg.Language])
end)

RegisterNUICallback('fetchConfig', function(_, cb)
    Cfg.IconPath = Core.Inventory.IconPath
    cb(Cfg)
end)