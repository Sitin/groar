"use strict"

# Setup chai assertions.
chai = require 'chai'
spies = require 'chai-spies'
chai.use spies
{expect} = chai

module = require '../index'
lib = require '../lib/'


describe '<Package name> as a module', ->

  it "should export lib contents", ->
    expect(module).to.be.deep.equal lib