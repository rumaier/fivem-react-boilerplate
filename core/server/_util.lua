local resource = GetCurrentResourceName()
local version = GetResourceMetadata(resource, 'version', 0)
local rateLimits = {}
local cooldowns = {}

function IsRateLimited(src, action, duration)
    local last = rateLimits[('%s:%s'):format(src, action)]
    return last and GetGameTimer() - last < duration
end

function SetRateLimit(src, action)
    rateLimits[('%s:%s'):format(src, action)] = GetGameTimer()
end

function IsOnCooldown(src, action, duration)
    local last = cooldowns[('%s:%s'):format(src, action)]
    return last and GetGameTimer() - last < duration
end

function SetCooldown(src, action)
    cooldowns[('%s:%s'):format(src, action)] = GetGameTimer()
end

local function checkVersion()
    if not Cfg.VersionCheck then return end
    bridge.version.check(resource)
    SetTimeout(3600000, checkVersion)
end

-- Uncomment for MySQL resources:
-- Add '@oxmysql/lib/MySQL.lua' to server_scripts in fxmanifest.lua
-- local function buildDb()
--     MySQL.query.await(([[
--         CREATE TABLE IF NOT EXISTS `%s` (
--             `example` varchar(50) NOT NULL,
--             PRIMARY KEY (`example`)
--         ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci
--     ]]):format(resource))
--     -- Cache*() on resource start
-- end

AddEventHandler('onResourceStart', function(name)
    if name ~= resource then return end
    print('------------------------------')
    print(resource .. ' | ' .. version)
    if bridge then
        print('^2' .. locale('bridge_loaded') .. '^0')
    else
        print('^1' .. locale('update_bridge') .. '^0')
    end
    if Cfg and Cfg.Debug then print('^1' .. locale('debug_enabled') .. '^0') end
    print('------------------------------')
    checkVersion()
    -- buildDb()
end)

AddEventHandler('playerDropped', function()
    local src = source
    local prefix = '^' .. src .. ':'
    for key in pairs(rateLimits) do
        if key:match(prefix) then rateLimits[key] = nil end
    end
    for key in pairs(cooldowns) do
        if key:match(prefix) then cooldowns[key] = nil end
    end
end)
