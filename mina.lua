 ---@class HelperFeature
---@field is_enabled boolean Marks is function enabled in menu.
---@field allow_psilent boolean Allows using p-silent when activate ability.
---@field smooth integer Vector aim smooth
---@field prevent_fails boolean


local LP = entity_list.local_pawn()

local function make_ability(id, settings_name)
    local handle = LP:get_ability(id)
    if not handle then return nil end

    return {
        id = id,
        settings = settings_name,
        handle = handle,
        icon = HERO_LIB.get_ability_icon(handle)
    }
end

local abilities = {
    steal_life = make_ability("ability_vampirebat_steallife", "steal_life"),
    bat_swarm = make_ability("ability_vampirebat_batswarm", "bat_swarm")
}

local settings = {
    is_enabled = false,

    button = nil,

    -- Идея такова что, если включен хелпер на Владыку ночи то комбо просто кастит его. Если нет, то кастит и аимит
    combo = {
        items = {
            is_enabled = false,
            smooth = 0,
            allow_psilent = false,


            aoe_items = {},
            target_items = {},
            non_target_items = {}
        }



    },


    helpers = {
        steal_life = {
            is_enabled = false,

            allow_psilent = false,
            smooth = 10,
            prevent_fails = true,

            logic = {
                ability = abilities.steal_life.handle,
                fov = function() return HERO_LIB.get_helper_fov(LP) end,

                can_run = function(cmd)
                    return cmd:get_orig_button_state0() == InputBitMask_t.IN_ABILITY1
                end,

                block_dist = 430
            }
        },

        bat_swarm = {
            is_enabled = false,

            allow_psilent = false,
            smooth = 10,
            prevent_fails = true,

            logic = {
                ability = abilities.bat_swarm.handle,
                fov = function() return HERO_LIB.get_helper_fov(LP) end,

                can_run = function(cmd)
                    return HERO_LIB.is_channeling_ability(abilities.bat_swarm.handle)
                end,

                block_dist = nil
            }
        }
    }
}


do
    local main_section = NEW_UI_LIB.create_tab(true, "hero_vampirebat", "vampirebat", 63)
    local enable_switch

    do
        local group = main_section:create("Combo Settings", Enum.GroupSide.Left)

        enable_switch = group:switch("Enable", false, "\u{f00c}")
            :set_callback(function(sw)
                settings.is_enabled = sw:Get()
            end, true)

        settings.button = group:bind("Combo Key", Enum.ButtonCode.KEY_NONE, "\u{f647}")
            :link_to_ui_disable_condition(enable_switch)
    end

    do
        local items_group = main_section:create("Combo Items Settings")
            :link_to_ui_disable_condition(enable_switch)

        local items_enabled, items_smooth, items_psilent, aoe_items, target_items, non_target_items =
            HERO_LIB.create_item_multiselects(items_group)

        items_enabled:set_callback(function(switch)
            settings.combo.items.is_enabled = switch:Get()
        end, true)

        items_smooth:set_callback(function(slider)
            settings.combo.items.smooth = slider:Get()
        end, true)

        items_psilent:set_callback(function(switch)
            settings.combo.items.allow_psilent = switch:Get()
        end)

        aoe_items:set_callback(function(multiselect)
            settings.combo.items.aoe_items = multiselect:ListEnabled()
        end, true)

        target_items:set_callback(function(multiselect)
            settings.combo.items.target_items = multiselect:ListEnabled()
        end, true)

        non_target_items:set_callback(function(multiselect)
            settings.combo.items.non_target_items = multiselect:ListEnabled()
        end, true)
    end

    do
        local group = main_section:create("Helper Settings", Enum.GroupSide.Left)
            :link_to_ui_disable_condition(enable_switch)

        for _, ability in pairs(abilities) do
            local feature = settings.helpers[ability.settings]

            local sw = group:switch(ability.id, feature.is_enabled, ability.icon)
                :set_callback(function(s)
                    feature.is_enabled = s:Get()
                end, true)

            sw:switch("Allow PSilent", feature.allow_psilent, "\u{f710}")
                :set_callback(function(s)
                    feature.allow_psilent = s:Get()
                end, true)

            sw:slider("Smooth", 0, 100, feature.smooth)
                :icon("\u{f899}")
                :set_callback(function(sl)
                    feature.smooth = sl:Get()
                end, true)

            sw:switch("Prevent Fails", feature.prevent_fails, "\u{e247}")
                :set_callback(function(s)
                    feature.prevent_fails = s:Get()
                end, true)
        end
    end
end

callback.on_createmove:set(function(cmd)
    if not settings.is_enabled then
        return
    end

    local target = HERO_LIB.find_helper_target(cmd, LP)

    local combo_settings = settings.combo.items

    HERO_LIB.handle_all_items(
        cmd,
        LP,
        target,
        true,
        combo_settings.smooth,
        combo_settings.allow_psilent,
        combo_settings.aoe_items,
        combo_settings.target_items,
        combo_settings.non_target_items
    )

    for _, h in pairs(settings.helpers) do
        local logic = h.logic

        if not h.is_enabled or not logic then
            goto continue
        end

        if logic.can_run(cmd) then
            if target ~= nil then
                local pos = HERO_LIB.get_target_pos(target)
                if pos ~= nil then
                    HERO_LIB.aim_psilent_default(
                        cmd,
                        h.smooth,
                        pos,
                        target,
                        logic.fov(),
                        h.allow_psilent,
                        15
                    )
                end
            end
        end

        if h.prevent_fails then
            if target == nil then
                HERO_LIB.block_item(cmd, logic.ability)
            else
                local tpos = target:get_origin()
                local dist = tpos and LP:get_origin():Distance(tpos)

                if not tpos or (logic.block_dist and dist > logic.block_dist) then
                    HERO_LIB.block_item(cmd, logic.ability)
                end
            end
        end

        ::continue::
    end
end)
