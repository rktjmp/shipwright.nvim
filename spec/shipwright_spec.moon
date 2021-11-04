describe "shipwright", ->
  sw = require('shipwright')

  it "exposes run", ->
    assert.is_function(sw.run)
    data = {3,1,5}
    trans = (t) ->
      table.sort(t)
      t

    result = sw.run(data, trans)
    assert.is_table(result)
    assert.same({1,3,5}, result)
