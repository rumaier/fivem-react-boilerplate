local function onClientReady()
    -- Defer blips, zones, targets, and NUI openers until Cfg is populated
end

AddEventHandler(GetCurrentResourceName() .. ':clientConfigLoaded', onClientReady)
