local awful		  = require('awful')
local wibox		  = require('wibox')
local beautiful	  = require('beautiful')
local gears		  = require('gears')
local helpers	  = require('helpers')

local dpi		  = require('beautiful').xresources.apply_dpi
beautiful.init(gears.filesystem.get_configuration_dir() .. "deftheme.lua")
require('tots.cpu')

local icon_size = dpi(34)
local bar_size = dpi(200)

local cpu_icon = wibox.widget.imagebox(beautiful.widget_cpu)
cpu_icon.forced_height = icon_size
cpu_icon.forced_width = icon_size
cpu_icon.resize = true

local cpu_bar = wibox.widget {
	max_value = 100,
	forced_height = dpi(10),
	margins = {
		top = dpi(8),
		bottom = dpi(8),
	},
	forced_width = dpi(200),
	shape = gears.shape.rounded_bar,
	bar_shape = gears.shape.rounded_bar,
	color = "#FF837D",
	background_color = beautiful.stats_bg_color,
	border_width = 0,
	border_color = beautiful.border_color,
	widget = wibox.widget.progressbar,
}
cpu_bar.forced_width = bar_size
cpu_bar.shape = gears.shape.rounded_bar
cpu_bar.bar_shape = gears.shape.rounded_bar

awesome.connect_signal("tots::cpu", function(value)
	cpu_bar.value = tonumber(value)
end)

local cpu = wibox.widget {
	nil,
	{
		cpu_icon,
		cpu_bar,
		spacing = dpi(10),
		layout = wibox.layout.fixed.horizontal
	},
	expand = "none",
	layout = wibox.layout.align.horizontal
}

return cpu
