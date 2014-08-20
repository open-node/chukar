Ractive = require 'ractive'

module.exports = (el, template) ->
  new Ractive
    el: el or 'body'
    template: template or require './templates/home'
