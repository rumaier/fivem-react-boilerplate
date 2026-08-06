local function onClientReady()
    -- Defer blips, zones, targets, and NUI openers until Cfg is populated
end

AddEventHandler('r_bridge:playerLoaded', onClientReady)

AddEventHandler(GetCurrentResourceName() .. ':clientConfigLoaded', function()
    if not bridge.framework.isPlayerLoaded() then return end
    onClientReady()
end)