# The application object.
Backbone  = require 'backbone'
page      = require 'page'
doc       = document
Backbone.$ = $

module.exports = class Application
  constructor: (opts) ->
    @opts = opts
    @title opts.title
    @routerInit(opts.routes)

  title: (title) ->
    doc.title = title if title

  routerInit: (routes) ->
    for route in routes
      [path, ctl] = route
      [ctlName, action] = ctl.split('#')
      actions = (require "controllers/#{ctlName}")[action]
      page.apply page, [path].concat actions
    page()
