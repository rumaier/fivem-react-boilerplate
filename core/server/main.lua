local resource = GetCurrentResourceName()
local rateLimits = {}

local function getRateLimitKey(src, action)
    return ('%s:%s'):format(src, action)
end

function IsRateLimited(src, action, duration)
    local last = rateLimits[getRateLimitKey(src, action)]
    return last and GetGameTimer() - last < duration
end

function SetRateLimit(src, action)
    rateLimits[getRateLimitKey(src, action)] = GetGameTimer()
end

lib.callback.register(resource .. ':getClientConfig', function()
    return {
        Language = Cfg.Language,
        Debug = Cfg.Debug,
        NuiColor = Cfg.NuiColor,
    }
end)

AddEventHandler('playerDropped', function()
    local src = source
    for key in pairs(rateLimits) do
        if key:match('^' .. src .. ':') then
            rateLimits[key] = nil
        end
    end
end)
