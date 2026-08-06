local resource = GetCurrentResourceName()

lib.callback.register(resource .. ':getClientConfig', function()
    return {
        Language = Cfg.Language,
        Debug = Cfg.Debug,
        NuiColor = Cfg.NuiColor,
    }
end)
