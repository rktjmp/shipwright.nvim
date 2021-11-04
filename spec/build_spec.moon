describe "build", ->
  build = require('shipwright').build
  before_each ->
      vim = {}
      _G.vim = mock(vim)

  it "propagates load errors", ->
    assert.errors(->
      build("fake_file"))

    assert.errors(->
      build("spec/build/malformed_build_file.lua"))

  it "runs a build file with an injected context", ->
    -- build_file.lua also performs work, checking that a prescribed set of
    -- functions are availible inside it.
    assert.no.errors(->
      build("spec/build/build_file.lua"))
