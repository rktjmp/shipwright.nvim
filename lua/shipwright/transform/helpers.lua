local function rgb_to_hex(rgb)
  return string.format("#%02X%02X%02X", rgb.r, rgb.g, rgb.b)
end

local function hex_to_rgb(hex_str)
  -- normalise
  local hex = "[abcdef0-9][abcdef0-9]"
  local pat = "^#("..hex..")("..hex..")("..hex..")$"
  hex_str = string.lower(hex_str)

  -- smoke test
  assert(string.find(hex_str, pat) ~= nil,
         "hex_to_rgb: invalid hex_str: " .. tostring(hex_str))

  -- convert
  local r,g,b = string.match(hex_str, pat)
  r, g, b = tonumber(r, 16), tonumber(g, 16), tonumber(b, 16)

  return {r = r, g = g, b =  b}
end

--- Replace $values in a string from a table of {values = "string"}
-- "my_color is $COLOR", {COLOR = "red"} -> "my_color is red"
-- @param template A string
-- @param map A table of replacement values
local function apply_template(template, map)
  local output = string.gsub(template, "$([%w%d_]+)", map)
  return output
end

--- Converts a mutli-line string into a table of lines
-- @param text The multi-line string
local function split_newlines(text)
  local lines = {}
  for s in string.gmatch(text, "[^\n]+") do
    table.insert(lines, s)
  end

  return lines
end

return {
  -- split string into table by new lines
  split_newlines = split_newlines,
  -- apply "this is my $template", {template = "replacement"} templating
  apply_template = apply_template,
  -- {r = 255, g = 255, b = 255} -> "0xffffff"
  rgb_to_hex = rgb_to_hex,
  -- "0xffffff" -> {r = 255, g = 255, b = 255}
  hex_to_rgb = hex_to_rgb
}
