local function run_pipeline(value, ...)
  unpack = unpack or table.unpack
  local continue_pipeline = nil -- anything but false will continue
  local pipeline = {...}
  assert(type(value) == "table",
    "first argument to run must be a table, got: " .. type(value))
  -- because lua tables are garbage, you can do something like
  -- {my_pip, my_pipe, my_pipe} and get {nil, fn, fn},
  -- (and my_pip wont error, just silently nil out)
  -- #pipeline = 3, but ipairs wont iterate at all because it hits a nil
  -- so we will actually check that the pipeline has content we can iterate.
  local check_count = 0
  for _, _ in ipairs(pipeline) do
    check_count = check_count + 1
  end
  assert(#pipeline == check_count,
    "export pipeline reported length and actual length differ, you probably have a nil in it (mis-spelling?)")
  assert(#pipeline > 0,
    "pipeline must have at least one transform")

  -- pass through the pipeline
  for i, transform in ipairs(pipeline) do
    if type(transform) == "function" then
      -- raw function, just value -> value
      value, continue_pipeline = transform(value)
    elseif type(transform) == "table" then
      -- table, first element must be the transform, the rest are assumed to
      -- be arguments for the transform, excepting that the *first* argument
      -- should be the current value.
      assert(#transform > 0,
        " transformation # " .. i .. " was table with length 0")
      -- slice copies the table, we want to be non-destructive (no table.remove
      -- to shift) because the config may be shared between other export calls
      local func = transform[1]
      assert(func,
        "given transform function was nil, did you mis-spell it?")
      local args = {unpack(transform, 2, #transform)}
      value, continue_pipeline = func(value, unpack(args))
    else
      error("Invalid type in pipeline at index " .. i .. " ( " .. type(transform) .. ")")
    end

    assert(type(value) == "table",
      " transformation #" .. i .. " did not return a table, got: " .. type(value))

    if continue_pipeline == false then break end
  end

  return value
end

-- Create an environment to run the build file in.
-- This should expose all the built in transformers, as well as lush itself.
local function make_env(merge)
  merge = merge or {}

  local env = {
    run = require("shipwright.builder").run,
    branch = require("shipwright.transform.branch"),
    overwrite = require("shipwright.transform.overwrite"),
    patchwrite = require("shipwright.transform.patchwrite"),
    prepend = require("shipwright.transform.prepend"),
    append = require("shipwright.transform.append"),
    contrib = {
      alacritty = require("shipwright.transform.contrib.alacritty"),
      wezterm = require("shipwright.transform.contrib.wezterm"),
      kitty = require("shipwright.transform.contrib.kitty"),
    }
  }

  for key, val in pairs(merge) do
    env[key] = val
  end

  return setmetatable(env, {
    __index = function(_, name)
      -- proxy out to the real lua env when needed
      return _G[name]
    end
  })
end

return {
  run = run_pipeline,
  make_env = make_env
}
