_                   = require 'underscore'
config              = require "../config"

# Register a insertion method to the String.prototype
String.prototype.fillWith = (strings) ->
  args = strings
  @replace /{(\d+)}/g, (match, number) ->
    if typeof args[number] != 'undefined' then args[number] else match


# Implement the i18n object
i18n =
  localization : {}         # Save the .json localization file
  __locale : null           # language set
  defaultLocale : 'en'      # default language of the application that does not need a localization file
  pathToLocale : 'locale'   # path to localization files

  lang: ->
    _lang = localStorage.locale ||
      navigator.language ||
      navigator.browserLanguage ||
      'zh-cn'
    _l = _lang.split('-')[0].toLowerCase()
    return 'en' if _l not in config.languages
    _l

  start: (locale) ->
    localStorage.setItem 'locale', locale
    @setLocale i18n.lang()
    @init()

  # Init your localization, call this method in your application when you want to use i18n
  init: () ->
    @__locale = @defaultLocale unless @__locale?

    # load language dynamically if other then default locale
    @localization = require "#{@pathToLocale}/#{@__locale}"

  setLocale: (locale) ->
    @__locale = locale

  setDefault: (locale) ->
    @defaultLocale = @__locale = locale


  # Look trough the localization and get the right translation if there is any
  # When there is no translation, it will return the original string with a prepend (?)
  # This helps you to finalize your localization file too
  translate: (id, vars = {}) ->
    template = @localization[@__locale]?[id] or @localization[@__locale[0..1]]?[id]
    unless template?
      # You don't need to provide a localization for the default language
      template = if @__locale isnt @defaultLocale then "#{id}" else "#{id}"
      # uncomment the following line to show all missing translations in the console
      # console.log("missing [#{@__locale}] #{id}") if console?.log?

    _.template(template, vars)


  # Shortcut for main translation method that also implements placeholder replacements
  #
  # age = 25
  # i18n.t "I'm {0} years old!" age
  #
  # returns (in german)
  #
  # "Ich bin 25 Jahre alt!"

  t: (i18n_key) ->
    # Find the translation
    result = i18n.translate i18n_key

    # clear arguments to array and remove first and last item
    # check wether the arguments come in an array or as plain method arguments
    # depends on how you call this function
    args = Array.prototype.slice.call(arguments, 0)
    if _.isArray(args[1]) then _args = args[1] else _args = args
    if !_.isString _args[_args.length-1] then _args.pop()

    _args.shift() # the original string needs to be shifted anyway

    # Replace placeholders in the localization string with given variables
    result.fillWith _args


# Seal the i18n object
Object.seal? i18n

module.exports = i18n
