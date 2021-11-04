describe "transform.branch", ->
  run = require("shipwright.builder").run
  branch = require("shipwright.transform.branch")

  -- passing spies to run seems to break because it messes with the #len
  -- value (sets it to 0)
  t = {
    double: spy.new(->)
    square: spy.new(->)
  }

  square = (v) ->
    v = v[1] * v[1]
    t.square(v)
    return {v}

  double = (v) ->
    v = v[1] * 2
    t.double(v)
    return {v}

  it "branch once", ->
    value = run({3},
      {branch, double, square})
    assert.spy(t.double).was.called_with(3*2)
    assert.spy(t.square).was.called_with(6*6)

  it "branch once", ->
    s = spy.new(-> return {})
    value = run({3},
      {branch, square},
      {branch, double},
      (v) ->
        s(v)
        return v)
    assert.spy(t.double).was.called_with(3*2)
    assert.spy(t.square).was.called_with(3*3)
    assert.spy(s).was.called_with({3})

