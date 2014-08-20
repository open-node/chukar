Backbone = require 'backbone'

module.exports = class Loader

  syncCount: 0
  $el: null

  constructor: (selector) ->
    @$el = $(selector)
    sync = Backbone.sync
    Backbone.sync = (method, object, options) =>
      @syncStart(method, object, options)
      sync.apply(null, arguments).always(@syncEnd)

  syncShowMsg: (msg) ->
    @showMsg(msg)

  syncStart: (method, object, options) =>
    @syncCount += 1
    @syncShowMsg()

  syncEnd: (res) =>
    @syncCount -= 1
    if @syncCount is 0
      @hideMsg()
    else
      @syncShowMsg()

  showMsg: (msg) =>
    @$el.show()

  hideMsg: =>
    @$el.fadeOut()
