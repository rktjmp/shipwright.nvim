describe "run", ->
  run = require('shipwright').run
  data = {4, 3, 2, 1}
  sort_transform = (v) ->
    table.sort(v)
    return v
  sum = (v) ->
    t = 0
    for i in *v
      t = t + i
    return {t}

  before_each ->
      vim = {}
      _G.vim = mock(vim)

  it "runs a pipeline", ->
    assert.same({1,2,3,4}, run(data, sort_transform))
    assert.same({10}, run(data, sort_transform, sum))

  it "warns on bad types", ->
    assert.has_error(->
      run(data, nil))

    -- we can match "bad lengths" when nils are mid-pipe
    assert.has_error(->
      run(data, nil, sort_transform))

    -- unfortunately we cant see errors like this, because lua
    -- will just say the length is 1
    assert.not.has_error(->
      run(data, sort_transform, nil, sort_transform))

    assert.has_error(->
      run(data, sort_transform, 1, sort_transform))

    assert.has_error(->
      run(data, sort_transform, "beans", sort_transform))
