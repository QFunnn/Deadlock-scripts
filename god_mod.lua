callback.on_createmove:set(function(cmd)
    cmd.viewangles = Angle(cmd.viewangles.pitch, cmd.viewangles.yaw, -180)
end)
