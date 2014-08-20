_                     = require 'underscore'
Model                 = require './base/model'
config                = require '../config'

# Base model.
module.exports = class SessionModel extends Model

  urlPath: -> "/session"

  updatedAt: 0

  # 为了解决不需要用户id获取当前用户详情的问题，所以每次都当成新用户处理
  isNew: ->
    yes

  fetch: =>
    super.success => @updatedAt = new Date

  # 普通未读信息的变化
  unreadNoticeCountChange: (value) ->
    @set 'unreadNoticeCount', @get('unreadNoticeCount') + value

  # 判断是否过期
  isExpired: ->
    @updatedAt < Date.now() - config.sessionExpired
