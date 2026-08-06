local resource = GetCurrentResourceName()

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
