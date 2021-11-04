describe "transform.append", ->
  run = require("shipwright.builder").run
  append = require("shipwright.transform.append")

  it "appends one value", ->
    value = run({1, 2,},
        {append, 3})
    assert.is(1, value[1])
    assert.is(2, value[2])
    assert.is(3, value[3])

  it "appends all values", ->
    value = run({1, 2},
        {append, {3,4,5}})
    assert.is(1, value[1])
    assert.is(2, value[2])
    assert.is(3, value[3])
    assert.is(4, value[4])
    assert.is(5, value[5])
