Core = exports.r_bridge:returnCoreObject()

local resource = GetCurrentResourceName()
local version = GetResourceMetadata(resource, 'version', 0)

local function checkVersion()
    if not Cfg.VersionCheck then return end
    Core.VersionCheck(resource)
    SetTimeout(3600000, checkVersion)
end

local function onDatabaseBuilt()
    -- fire off any database fetches etc
end

local function buildDatabase()
    MySQL.query(string.format([[
        CREATE TABLE IF NOT EXISTS `%s` (
            `example` varchar(50) NOT NULL,
            PRIMARY KEY (`example`)
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci
    ]], resource), function(resp)
        if resp.warningStatus == 0 then
            print('Database built for ' .. resource)
        end
        onDatabaseBuilt()
    end)
end

local function startupPrints()
    local debug = Cfg.Debug
    print('------------------------------')
    print(locale('startup_info', resource, version))
    if debug then
        print(locale('debug_enabled'))
    end
    print('------------------------------')
end

AddEventHandler('onResourceStart', function(resourceName)
    if resourceName ~= resource then return end
    startupPrints()
    checkVersion()
end)
