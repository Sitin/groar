"use strict"

GROAR_HOME = global.GROAR_HOME

assert = require 'assert'
fs = require 'fs'
path = require 'path'
_ = require 'underscore'
ncp = (require 'ncp').ncp

class Template
  constructor: (template, dest) ->
    assert.strictEqual typeof template, 'string', "Invalid template name."

    config = require "#{GROAR_HOME}/templates/#{template}.coffee"
    _.extend @, config

    @action = @copy

    @name = template unless @name?

    @base = process.cwd()

    @dest = dest if dest?
    @dest = path.resolve @dest

    assert.ok fs.existsSync @path

    @relative = path.relative @base, @dest

    @message = @render @message
    #@description = @render @description

  perform: (callback) ->
    @before?()
    switch typeof @action
      when 'function' then @action callback
      when 'string' then @[action]? callback
    @after?()

  copy: (callback) ->
    ncp @path, @dest, (err) =>
      console.log @message unless err
      console.log err if err
      do callback? err

  render: (message) ->
    switch typeof message
      when 'string' then message = _.template message, @
      when 'function' then message = do message
    message


module.exports.Template = Template
module.exports.perform = (tpl, dest) ->
  template = new Template tpl, dest
  do template.perform
  template