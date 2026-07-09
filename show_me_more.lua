-- Display abilities/ultimates cast time


---@class AbilityHandler
---@field INFO table
---@field STATE table
---@field on_add_modifier? fun(self: AbilityHandler, modifier: modifier, target: entity|nil, owner: entity|nil)
---@field on_remove_modifier? fun(self: AbilityHandler, modifier: modifier, target: entity|nil)
---@field on_add_entity? fun(self: AbilityHandler, entity: entity|player_pawn|ability)
---@field on_remove_entity? fun(self: AbilityHandler, entity: entity|player_pawn|ability)
---@field on_draw? fun(self: AbilityHandler)
---@field on_frame? fun(self: AbilityHandler)

---@type fun(screen_pos: Vec2, progress: number, icon: integer)
local render_panel = function(screen_pos, progress, icon)
    local x = screen_pos.x - 30
    local y = screen_pos.y

    local start = Vec2(x, y)
    local finish = Vec2(x + 60, y + 60)

    Render.FilledRect(start, finish, Color(20, 20, 25, 180), 6)

    local center = Vec2(x + 30, y + 30)
    Render.Circle(center, 22, Color(), 3.5, 180, progress)

    local icon_size = 32
    local icon_pos = Vec2(center.x - icon_size / 2, center.y - icon_size / 2)
    local icon_vec_size = Vec2(icon_size, icon_size)

    Render.Image(icon, icon_pos, icon_vec_size, Color())
end

---@param config table
local function create_handler(config)
    if not config.INFO and (config.MODIFIER_CLASS or config.MODIFIER_NAME) then
        config = { INFO = config }
    end

    local handler = {
        INFO = config.INFO or {},
        STATE = {
            target = nil,

            duration = nil,
            end_time = nil
        }
    }

    if config.STATE then
        for k, v in pairs(config.STATE) do
            handler.STATE[k] = v
        end
    end

    handler.on_draw = function(self)
        local current_target = self.STATE.target
        if not current_target or not self.STATE.duration or not self.STATE.end_time then
            return
        end

        local position = current_target:get_origin()
        if position == nil then return end

        local z_offset = self.INFO.Z_OFFSET or 40
        local screen_pos = Vector(position.x, position.y, position.z + z_offset):ToScreen()

        local time = self.STATE.end_time - global_vars.curtime()
        if time <= 0 then
            self.STATE.end_time = nil
            return
        end

        local progress = 1.0 - math.max(0.0, math.min(1.0, time / self.STATE.duration))
        render_panel(screen_pos, progress, self.INFO.ABILITY_ICON)
    end

    handler.on_add_modifier = function(self, modifier, target, _)
        if self.INFO.MODIFIER_CLASS and modifier:get_class_name() ~= self.INFO.MODIFIER_CLASS then return end
        if self.INFO.MODIFIER_NAME and modifier:get_name() ~= self.INFO.MODIFIER_NAME then return end

        if not self.INFO.ENTITY_CLASS then
            self.STATE.target = target
        end

        self.STATE.duration = modifier.m_flDuration
        self.STATE.end_time = global_vars.curtime() + modifier.m_flDuration
    end

    handler.on_remove_modifier = function(self, modifier, _)
        if self.INFO.MODIFIER_CLASS and modifier:get_class_name() ~= self.INFO.MODIFIER_CLASS then return end
        if self.INFO.MODIFIER_NAME and modifier:get_name() ~= self.INFO.MODIFIER_NAME then return end

        if not self.INFO.ENTITY_CLASS then
            self.STATE.target = nil
        end

        self.STATE.duration = nil
        self.STATE.end_time = nil
    end

    for key, value in pairs(config) do
        if type(value) == "function" then
            ---@diagnostic disable-next-line
            handler[key] = value
        end
    end

    return handler
end

---@type table<string, AbilityHandler>
local handles = {
    ICE_DOME = create_handler({
        INFO = {
            MODIFIER_CLASS = "CCitadel_Modifier_IceDome",
            ENTITY_CLASS = "C_Citadel_Ice_Dome_Blocker",
            ABILITY_ICON = Render.LoadImage("panorama/images/hud/abilities/kelvin/frozen_shelter_psd.vtex_c"),
            Z_OFFSET = 350
        },
        on_add_entity = function(self, entity)
            if entity:get_class_name() ~= self.INFO.ENTITY_CLASS then return end
            self.STATE.entity = entity
        end,
        on_remove_entity = function(self, entity)
            if entity:get_class_name() ~= self.INFO.ENTITY_CLASS then return end
            self.STATE.entity = nil
        end
    }),
    BULLET_DANCE = create_handler({
        INFO = {
            MODIFIER_CLASS = "CCitadel_Modifier_BulletFlurry",
            ABILITY_NAME = "ability_bullet_flurry",
            ABILITY_ICON = Render.LoadImage("panorama/images/hud/abilities/haze/haze_bullet_flurry_psd.vtex_c")
        },
        on_add_modifier = function(self, modifier, target, _)
            if modifier:get_class_name() ~= self.INFO.MODIFIER_CLASS or not target then return end

            local ability = target:get_ability(self.INFO.ABILITY_NAME)
            if not ability then return end
            local end_time = ability.m_flFlurryEndTime.m_flTime

            self.STATE.target = target
            self.STATE.duration = end_time - global_vars.curtime()
            self.STATE.end_time = end_time
        end,
        on_remove_modifier = function(self, modifier, _)
            if modifier:get_class_name() ~= self.INFO.MODIFIER_CLASS then return end

            self.STATE.target = nil
            self.STATE.duration = nil
            self.STATE.end_time = nil
        end
    }),
    ROCKET_BARRAGE = create_handler({
        INFO = {
            MODIFIER_CLASS = "CCitadel_Modifier_RocketBarrageVolley",
            ABILITY_NAME = "citadel_ability_rocket_barrage",
            ABILITY_ICON = Render.LoadImage("panorama/images/hud/abilities/weapon_damage_psd.vtex_c")
        },
        on_add_modifier = function(self, modifier, target, _)
            if modifier:get_class_name() ~= self.INFO.MODIFIER_CLASS or not target then return end

            local ability = target:get_ability(self.INFO.ABILITY_NAME)
            if not ability then return end
            local end_time = ability.m_flBarrageEndTime.m_flTime

            self.STATE.target = target
            self.STATE.duration = end_time - global_vars.curtime()
            self.STATE.end_time = end_time
        end,
        on_remove_modifier = function(self, modifier, _)
            if modifier:get_class_name() ~= self.INFO.MODIFIER_CLASS then return end

            self.STATE.target = nil
            self.STATE.duration = nil
            self.STATE.end_time = nil
        end
    }),

    -- SHADOW_PULSE = create_handler({
    --     INFO = {
    --         MODIFIER_CLASS = "",
    --         ABILITY_ICON = Render.LoadImage("panorama/images/hud/abilities/haze/haze_bullet_flurry_psd.vtex_c")
    --     },
    --     on_draw = function()
    --         -- local pawn = entity_list.local_pawn()
    --         -- for index, value in ipairs(pawn:get_abilities()) do
    --         --     print(value:get_name())
    --         -- end
    --     end,
    --     on_add_modifier = function(self, modifier, target, _)
    --         print(modifier:get_class_name())
    --     end,
    -- }),

    BLACK_HOLE = create_handler({
        MODIFIER_CLASS = "CCitadel_Modifier_VacuumAura",
        ABILITY_ICON = Render.LoadImage("panorama/images/hud/abilities/sumo/sumo_vacuum_psd.vtex_c")
    }),
    LAST_FIGHT = create_handler({
        MODIFIER_CLASS = "CCitadel_Modifier_Warden_RiotProtocol",
        ABILITY_ICON = Render.LoadImage("panorama/images/hud/abilities/warden/warden_riot_protocol_psd.vtex_c")
    }),
    SHADOW_TRANSFORM = create_handler({
        MODIFIER_CLASS = "CCitadel_Modifier_Yamato_InfinitySlash_BuffTimer",
        ABILITY_ICON = Render.LoadImage("panorama/images/hud/abilities/yamato/yamato_blinding_steel_psd.vtex_c")
    }),
    STORM = create_handler({
        MODIFIER_CLASS = "CCitadel_Modifier_StormCloud",
        ABILITY_ICON = Render.LoadImage("panorama/images/hud/abilities/giga_storm_psd.vtex_c")
    }),
    COMBO = create_handler({
        MODIFIER_CLASS = "CCitadel_Modifier_UltCombo_Self",
        ABILITY_ICON = Render.LoadImage("panorama/images/hud/abilities/grappler/grappler_combo_psd.vtex_c")
    }),
    AIR_HELP = create_handler({
        MODIFIER_NAME = "citadel_ability_tengu_airlift/modifier_base",
        ABILITY_ICON = Render.LoadImage("panorama/images/hud/abilities/tengu/tengu_lightning_crash_psd.vtex_c")
    }),
    REVIVING = create_handler({
        MODIFIER_CLASS = "CCitadel_Modifier_Frank_Reviving",
        ABILITY_ICON = Render.LoadImage("panorama/images/hud/abilities/frank/frank_shocking_reanimation_psd.vtex_c")
    }),

    -- todo
    -- SLIME_BALL = create_handler({ INFO = {} }),
    -- HEAVY_SHOOT = create_handler({ INFO = {} }),
    -- HYPER_LASER = create_handler({ INFO = {} }),
}

---@param callback_name string
local function dispatch(callback_name, ...)
    for _, handler in pairs(handles) do
        local fn = handler[callback_name]
        if fn then
            fn(handler, ...)
        end
    end
end

callback.on_add_modifier:set(function(mod, target, owner) dispatch("on_add_modifier", mod, target, owner) end)
callback.on_remove_modifier:set(function(mod, target) dispatch("on_remove_modifier", mod, target) end)
callback.on_add_entity:set(function(ent) dispatch("on_add_entity", ent) end)
callback.on_remove_entity:set(function(ent) dispatch("on_remove_entity", ent) end)
callback.on_draw:set(function() dispatch("on_draw") end)
callback.on_frame:set(function() dispatch("on_frame") end)
