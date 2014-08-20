_                 = require 'underscore'
moment            = require 'moment'
config            = require '../config'
ec                = encodeURIComponent

# Application-specific utilities
# ------------------------------

utils =

  time: ->
    moment().unix()

  numberCommas: (nStr) ->
    return "0" if not nStr
    nStr += ""
    x = nStr.split(".")
    x1 = x[0]
    x2 = (if x.length > 1 then "." + x[1] else "")
    rgx = /(\d+)(\d{3})/
    x1 = x1.replace(rgx, "$1" + "," + "$2")  while rgx.test(x1)
    x1 + x2

  intval: (value, mod = 10) ->
    parseInt(value, mod) or 0

  timeZone: _.memoize ->
    try timeZone = config.user.get('time_zone')
    timeZone = moment().zone() / -60 if not timeZone
    timeZone

  dateFormat: (date, format) ->
    return '' if not date
    format = 'YYYY-MM-DD HH:mm:ss' if not _.isString format
    moment(date).utc().add('hours', utils.timeZone()).format format

  store:
    read: (key) ->
      localStorage.getItem key
    write: (key, value) ->
      localStorage.setItem key, value
    remove: (key) ->
      localStorage.removeItem key

  showLoader: ->
    config.loader.showMsg()

  hideLoader: ->
    config.loader.hideMsg()

  sleep: (microSeconds = 0) ->
    (callback) -> setTimeout callback, microSeconds

  showError: (error) ->
    config.messager.httpError error

module.exports = utils
