moment                = require 'moment'
config                = require '../config'

module.exports = class Storage
  
  constructor: (options) ->
    @options = options
    @retriveToken()

  retriveToken: ->
    @token = @options.tokenModel
    @token.fetch()
    @token

  checkToken: ->
    if not @token?
      return @retriveToken()
    # 3600 seconds is default expire time of token
    if moment().subtract('seconds', 3600).isAfter(@token.get('createdAt'))
      return @retriveToken()
    @token

  bind: ($element, options) =>
    $element.on 'click', (evt) =>
      @checkToken()
    $element.on 'change', (evt) =>
      if evt.currentTarget.files.length > 0
        @upload(evt.currentTarget, options)

  upload: (file, options) =>
    # Construct FormData
    formData = new FormData()
    formData.append 'token', @token.get('token')
    formData.append 'file', file.files[0]
    if options.key?
      formData.append 'key', options.key
    if options.params?
      for key, value in options.params
        formData.append key, value

    # Construct XHR
    xhr = new XMLHttpRequest();
    xhr.open('POST', config.storage.uploadUrl, true)
    if options.progress?
      xhr.upload.addEventListener "progress", options.progress
    xhr.onreadystatechange = (evt) ->
      if xhr.readyState is 4 and xhr.status is 200
        if options.cb?
          options.cb.call this, xhr
      else
        if options.err?
          options.err.call this, xhr
    xhr.send(formData)

  url: (key) ->
    "http://#{config.storage.bucket}.qiniudn.com/#{key}"
