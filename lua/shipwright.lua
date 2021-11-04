local M = {}

M.build = function(build_file)
  build_file = build_file or "shipwright_build.lua"
  assert(type(build_file) == "string",
    "shipwright.build build_file must be a string")

  local build_fn, errors = loadfile(build_file)
  -- it seems sometimes we can fail a loadfile without an error?
  -- provide a default...
  assert(build_fn,
    "Could not load buildfile: "
    .. (errors or "lua reported no message but failed to load"))

  local builder = require('shipwright.builder')
  local env = builder.make_env()
  build_fn = setfenv(build_fn, env)
  assert(pcall(build_fn))
end

return M
