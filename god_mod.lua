-- Forces the player into an upside-down state (roll = -180°),
-- moving the model and hitboxes below the floor.
-- Example: https://i.imgur.com/Xs36TMw.png

callback.on_createmove:set(function(cmd)
    cmd.viewangles = Angle(cmd.viewangles.pitch, cmd.viewangles.yaw, -180)
end)
