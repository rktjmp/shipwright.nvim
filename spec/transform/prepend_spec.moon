describe "transform.prepend", ->
  run = require("shipwright.builder").run
  prepend = require("shipwright.transform.prepend")

  it "prepends one value", ->
    value = run({2, 3},
        {prepend, 1})
    assert.is(1, value[1])
    assert.is(2, value[2])
    assert.is(3, value[3])

  it "prepends all values", ->
    value = run({4, 5},
        {prepend, {1,2,3}})
    assert.is(1, value[1])
    assert.is(2, value[2])
    assert.is(3, value[3])
    assert.is(4, value[4])
    assert.is(5, value[5])
