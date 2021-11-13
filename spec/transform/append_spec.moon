describe "transform.append", ->
  run = require("shipwright.builder").run
  append = require("shipwright.transform.append")

  it "appends one value", ->
    value = run({1, 2,},
        {append, 3})
    assert.equals(1, value[1])
    assert.equals(2, value[2])
    assert.equals(3, value[3])

  it "appends one value in table", ->
    value = run({1, 2,},
        {append, {3}})
    assert.equals(1, value[1])
    assert.equals(2, value[2])
    assert.equals(3, value[3])

  it "appends all values", ->
    value = run({1, 2},
        {append, {3,4,5}})
    assert.equals(1, value[1])
    assert.equals(2, value[2])
    assert.equals(3, value[3])
    assert.equals(4, value[4])
    assert.equals(5, value[5])
