describe "helpers.apply_template", ->
  apply_template = require("shipwright.transform.helpers").apply_template

  it "accepts strings and numbers", ->
    x = {
      str: "my_string"
      int: 10,
      float: 99.99,
      bool: false,
      missing: nil -- wont convert
    }
    template = "$missing, $str, $int, $float, $bool"
    value = apply_template(template, x)
    assert.matches("$missing, my_string, 10, 99.99, false", value)

  it "calls tostring internally", ->
    x = {a: 1}
    setmetatable(x, {
      __tostring: (v) ->
        "to_string"
    })
    template = "$rep"

    value = apply_template(template, {
      rep: x
    })
    assert.matches("to_string", value)

  it "warns on tables with no tostring", ->
    x = {a: 1}
    template = "$rep"
    assert.has_error(->
      apply_template(template, {
        rep: x
    }))

  it "warns on raw functions", ->
    x = ->
    template = "$rep"
    assert.has_error(->
      value = apply_template(template, {
        rep: x
    }))
