--- windows terminal transform, expects a table in the shape:
--
-- @param colors {
-- "name" : "Theme Name",

-- "cursorColor": "#000000",
-- "selectionBackground": "#000000",

-- "background" : "#000000",
-- "foreground" : "#000000",

-- "black" : "#000000",
-- "blue" : "#000000",
-- "cyan" : "#000000",
-- "green" : "#000000",
-- "purple" : "#000000",
-- "red" : "#000000",
-- "white" : "#000000",
-- "yellow" : "#000000",
-- "brightBlack" : "#000000",
-- "brightBlue" : "#000000",
-- "brightCyan" : "#000000",
-- "brightGreen" : "#000000",
-- "brightPurple" : "#000000",
-- "brightRed" : "#000000",
-- "brightWhite" : "#000000",
-- "brightYellow" : "#000000"
-- }

local template = [[{
    "name": "$name",

    "selectionBackground": "$selection_bg",
    "cursorColor": "$cursor_bg",

    "foreground": "$fg",
    "background": "$bg",

    "black": "$black",
    "blue": "$blue",
    "cyan": "$cyan",
    "green": "$green",
    "purple": "$magenta",
    "red": "$red",
    "white": "$white",
    "yellow": "$yellow",
    "brightBlack": "$bright_black",
    "brightBlue": "$bright_blue",
    "brightCyan": "$bright_cyan",
    "brightGreen": "$bright_green",
    "brightRed": "$bright_red",
    "brightPurple": "$bright_magenta",
    "brightWhite": "$bright_white"
    "brightYellow": "$bright_yellow",
}]]

local helpers = require("shipwright.transform.helpers")
local check_keys = {
  "name",
  "fg", "bg",
  "cursor_bg",
  "selection_bg",
  "black", "red", "green", "yellow", "blue",
  "magenta", "cyan", "white",
  "bright_black", "bright_red", "bright_green", "bright_yellow", "bright_blue",
  "bright_magenta", "bright_cyan", "bright_white",
}

local function transform(colors)
  for _, key in ipairs(check_keys) do
    assert(colors[key],
      "Windows terminal colors table missing required key: " .. key)
  end
  local replaced = helpers.split_newlines(helpers.apply_template(template, colors))
  local kept = {}
  for _, line in ipairs(replaced) do
    if not string.match(line, "%$") then
      table.insert(kept, line)
    end
  end

  return kept
end

return transform
