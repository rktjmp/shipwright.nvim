describe "export", ->
  run = require("shipwright.builder").run

  it "warns if a transformation doesn't return a table", ->
    to_string_transform = (something) ->
      nil

    ast = {1,2}
    assert.has_error(->
      run(ast, to_string_transform))

  it "passes through 1 arity functions", ->
    val = {name: "xyz"}
    to_string = (val) ->
      {"A.gui=#{val.name}"}

    to_uppercase = (lines) ->
      {string.upper(lines[1])}

    assert.same(run(val, to_string), {"A.gui=xyz"})
    assert.same(run(val, to_string, to_uppercase), {"A.GUI=XYZ"})

  it "passes through multi arity functions", ->
    val = {name: "xyz"}

    to_string = (val, append) ->
      {"A.gui=#{val.name}+#{append}"}

    to_uppercase = (lines, s, e) ->
      {string.sub(string.upper(lines[1]), s, e)}

    assert.same(run(val, {to_string, "bort"}), {"A.gui=xyz+bort"})
    assert.same(run(val, {to_string, "bort"}, {to_uppercase, -4, -1}), {"BORT"})
