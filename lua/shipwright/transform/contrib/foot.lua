--- foot transform, expects a table in the shape:
--
-- @param colors {
--   fg = "#000000",
--   bg = "#000000",
--   cursor_fg = "#000000",
--   cursor_bg = "#000000",
--   black = "#000000",
--   red = "#000000",
--   green = "#000000",
--   yellow = "#000000",
--   blue = "#000000",
--   magenta = "#000000",
--   cyan = "#000000",
--   white = "#000000",
--   bright_black = "#000000",
--   bright_red = "#000000",
--   bright_green = "#000000",
--   bright_yellow = "#000000",
--   bright_blue = "#000000",
--   bright_magenta = "#000000",
--   bright_cyan = "#000000",
--   bright_white = "#000000",
-- }

local helpers = require("shipwright.transform.helpers")
local check_keys = {
  "fg", "bg",
  "cursor_fg", "cursor_bg",
  "black", "red", "green", "yellow", "blue",
  "magenta", "cyan", "white",
  "bright_black", "bright_red", "bright_green", "bright_yellow", "bright_blue",
  "bright_magenta", "bright_cyan", "bright_white",
}

local base_template = [[
# -*- conf -*-

[cursor]
color=$cursor_fg $cursor_bg

[colors]
background=$bg
foreground=$fg
regular0=$black
regular1=$red
regular2=$green
regular3=$yellow
regular4=$blue
regular5=$magenta
regular6=$cyan
regular7=$white
bright0=$bright_black
bright1=$bright_red
bright2=$bright_green
bright3=$bright_yellow
bright4=$bright_blue
bright5=$bright_magenta
bright6=$bright_cyan
bright7=$bright_white]]

local function transform(colors)
  for _, key in ipairs(check_keys) do
    assert(colors[key],
      "foot colors table missing key: " .. key)
  end

  local text = string.gsub(helpers.apply_template(base_template, colors), "#", "")
  return helpers.split_newlines(text)
end

return transform
