local settingsMods = {
    [{"Pacifist", "Shortcuts-ick"}] = {
        ["ick-compatibility-mode"] = true,
        ["discharge-defense-remote"] = false,
        ["active-defense-equipment"] = false,
        ["artillery-targeting-remote"] = false,
        ["artillery-toggle"] = "disabled",
    },
    ["DeadlockBlackRubberBelts"] = {
        ["ir2rb-rails"] = true,
    },
    ["inbuilt_lighting"] = {
        ["inbuilt_lighting-light_brightness"] = 1.0,
    },
    ["light-overhaul"] = {
        ["night-lut-set"] = "Bright",
    },
    ["RealisticFlashlight"] = {
        ["rf-enable-light-halo"] = true,
        ["rf-enable-vehicle-light-halo"] = true,
    },
    ["Smart_Inserters"] = {
        ["si-range-adder"] = "incremental",
        ["si-range-technologies"] = true,
        ["si-diagonal-technologies"] = true,
        ["si-offset-technologies"] = true,
    },
    ["Automatic_Train_Painter"] = {
        ["paint-cargo-wagon"] = true,
        ["paint-fluid-wagon"] = true,
        ["unpaint-empty"] = false,
    },
    ["UtilizationMonitorBlargh"] = {
        ["utilization-monitor-secs-assembling-machine"] = 100,
        ["utilization-monitor-secs-furnace"] = 100,
        ["utilization-monitor-secs-mining-drill"] = 100,
        ["utilization-monitor-secs-lab"] = 100,
        ["utilization-monitor-secs-boiler"] = 100,
        ["utilization-monitor-secs-generator"] = 100,
        ["utilization-monitor-secs-pump"] = 100,
        ["utilization-monitor-secs-offshore-pump"] = 100,
        ["utilization-monitor-label-alt"] = true,
    },
}

local function checkMods(mod)
    if (type(mod) == "string") then
        return mods[mod]
    elseif (type(mod) == "table") then
        for _, value in pairs(mod) do
            if not mods[value] then
                return false
            end
        end
        return true
    end
end

for mods, settings in pairs(settingsMods) do
    if checkMods(mods) then
        for key, value in pairs(settings) do
            if (type(value) == "boolean") then
                data.raw["bool-setting"][key].default_value = value
            elseif (type(value) == "number") then
                local setting = data.raw["int-setting"][key] or data.raw["double-setting"][key]
                setting.default_value = value
            elseif (type(value) == "string") then
                data.raw["string-setting"][key].default_value = value
            elseif (type(value) == "table") then
                data.raw["color-setting"][key].default_value = value
            end
        end
    end
end
