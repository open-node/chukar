homeView  = require 'views/home/index'

module.exports =
  index: (ctx, next) ->
    home = homeView()
    setInterval ->
      home.set 'now', new Date()
    , 1000
    next()
