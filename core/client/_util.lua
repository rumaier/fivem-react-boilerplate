Cfg = Cfg or {}

local resource = GetCurrentResourceName()
local getClientConfig = ('%s:getClientConfig'):format(resource)

local function onClientReady()
    if not bridge.framework.isPlayerLoaded() then return end
    TriggerEvent('r_bridge:playerLoaded')
end

local function buildClientConfig(config)
    for k, v in pairs(config) do
        Cfg[k] = v
    end
    onClientReady()
end

local function backgroundFetchClientConfig()
    CreateThread(function()
        while true do
            local resp = lib.callback.await(getClientConfig, false)
            if resp and type(resp) == 'table' then
                buildClientConfig(resp)
                break
            end
            Wait(1000)
        end
    end)
end

local function fetchClientConfig()
    local config = nil
    for i = 1, 10 do
        local resp = lib.callback.await(getClientConfig, false)
        if resp and type(resp) == 'table' then
            config = resp
            break
        end
        Wait(i * 250)
    end
    if not config then
        log('error', 'Failed to load client config; retrying in the background')
        backgroundFetchClientConfig()
    else
        buildClientConfig(config)
    end
end

local function buildNuiConfig()
    return {
        NuiColor = Cfg.NuiColor,
    }
end

function NormalizeTarget(data)
    if type(data) ~= 'table' then
        return {
            entity = data,
            coords = GetEntityCoords(data),
        }
    end
    return data
end

RegisterNUICallback('setNuiFocus', function(focus, cb)
    SetNuiFocus(focus, focus)
    cb(IsNuiFocused())
end)

RegisterNUICallback('fetchLocales', function(_, cb)
    cb(Language[Cfg.Language or 'en'])
end)

RegisterNUICallback('fetchConfig', function(_, cb)
    cb(buildNuiConfig())
end)

fetchClientConfig()
