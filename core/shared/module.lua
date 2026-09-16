Module = Module or {}

local registry = Module.__registry
if not registry then
    registry = {}
    Module.__registry = registry
end

function Module.register(name, value)
    if type(name) ~= 'string' or name == '' then
        error('Module.register: name must be a non-empty string', 2)
    end
    if registry[name] ~= nil then
        error(('Module.register: %s is already registered'):format(name), 2)
    end
    registry[name] = value
    return value
end

function Module.load(name)
    local value = registry[name]
    if value == nil then
        error(('Module.load: %s is not registered'):format(name), 2)
    end
    return value
end
