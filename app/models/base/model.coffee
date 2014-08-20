Backbone  = require 'backbone'
_         = require 'underscore'
config    = require '../../config'
utils     = require 'lib/utils'

# Base model.
module.exports = class Model extends Backbone.Model
  # Mixin a synchronization state machine.
  # _(@prototype).extend Chaplin.SyncMachine
  # initialize: ->
  #   super
  #   @on 'request', @beginSync
  #   @on 'sync', @finishSync
  #   @on 'error', @unsync

  apiRoot: config.apiRoot

  urlRoot: ->
    return "#{@apiRoot}#{@urlPath()}" if @id or not @collection
    return "#{@apiRoot}#{@collection.urlPath()}"

  url: ->
    "#{super}?#{@querystring(@queryParams())}"

  querystring: (params) ->
    params.access_token = utils.store.read 'access_token'
    _.map(params, (v, k) -> "#{k}=#{encodeURIComponent v}").join '&'

  queryParams: ->
    {}

  getCollection: (name, Collection, opt = {}, callback) =>
    collection = @["_#{name}s"]
    if collection
      if callback
        if collection.fetched
          return callback null, collection
        else
          collection.once 'sync', ->
            callback null, collection
    else
      collection = new Collection(null, null, opt)
      collection.parent = @
      promise = collection.fetch()
      if callback
        promise.success(->
          callback null, collection
        ).error(callback)
      @["_#{name}s"] = collection

    collection

# 类方法
# 获取单一资源
Model.find = (id, callback = ->) ->
  model = new @({id})
  model.fetch().success(->
    callback(null, model)
  ).error(callback)
  model
