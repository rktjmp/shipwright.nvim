-- core
assert(type(run) == "function")
assert(type(branch) == "function")
assert(type(overwrite) == "function")
assert(type(patchwrite) == "function")
assert(type(prepend) == "function")
assert(type(append) == "function")

-- contrib
assert(type(contrib) == "table")
assert(type(contrib.wezterm) == "function")
assert(type(contrib.alacritty) == "function")
assert(type(contrib.kitty) == "function")
assert(type(contrib.foot) == "function")

-- can still access normal stuff
assert(type(vim) == "table")
