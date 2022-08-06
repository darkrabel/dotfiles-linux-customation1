---@diagnostic disable: undefined-global
local gears = require "gears"
local beautiful = require "beautiful"

-- apply border radius
client.connect_signal('request::manage', function (c)
    if not c.maximized then
        c.shape = function (cr, w, h)
            return gears.shape.rounded_rect(cr, w, h, beautiful.border_radius)
        end
    else
        c.shape = gears.shape.rectangle
    end
end)

-- maximize wibar when a client is maximized
client.connect_signal('request::border', function (c)
    if c.maximized then
        c.screen.mywibox.width = c.screen.geometry.width
        c.screen.mywibox.shape = gears.shape.rectangle
    else
        c.screen.mywibox.width = c.screen.geometry.width - beautiful.useless_gap * 1.5
        c.screen.mywibox.shape = function (cr, w, h)
            return gears.shape.partially_rounded_rect(cr, w, h, true, true, false, false, beautiful.border_radius)
        end
    end
end)