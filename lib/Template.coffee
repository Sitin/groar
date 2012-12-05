"use strict"

GROAR_HOME = global.GROAR_HOME

assert = require 'assert'
fs = require 'fs'
path = require 'path'
_ = require 'underscore'
ncp = (require 'ncp').ncp
async = require 'async'

defaultMessages =
  before: "Init with template '<%=name %>' to '<%=relative %>'."

class Template
  defaultMessages:
    before: "Init with template '<%=name %>' to '<%=relative %>'."

  constructor: (template, dest) ->
    assert.strictEqual typeof template, 'string', "Invalid template name."

    config = require "#{GROAR_HOME}/templates/#{template}.coffee"

    @name = if config.name? then config.name else template

    @setAction config.action
    @initPaths dest, config.path
    @setMessages config.messages
    @initEvents config.before, config.after

  initEvents: (before, after) ->
    def = (callback) -> callback?()
    [@before, @after] = (fn || def for fn in [before, after])


  initPaths: (dest, tpl) ->
    @base = process.cwd()

    @dest = dest if dest?
    @dest = path.resolve @dest

    @path = tpl
    assert.ok fs.existsSync @path

    @relative = path.relative @base, @dest

  setAction: (action) ->
    @action = action || 'copy'
    @action = @[@action] if typeof @action is 'string'

  setMessages: (messages) ->
    @messages = {} unless @messages?
    _.defaults messages, @defaultMessages

    keys = _.keys messages
    texts = _.map messages, @render

    _.extend @messages, _.object keys, texts

  perform: (callback) ->
    console.log @messages.before
    async.series [@before, @action, @after], callback

  copy: (callback) =>
    ncp @path, @dest, (err) =>
      console.log @messages.after unless err
      console.log err if err
      callback? err

  render: (message) =>
    _.template message, @


module.exports.Template = Template
module.exports.perform = (tpl, dest, callback) ->
  template = new Template tpl, dest
  template.perform ->
    callback?()