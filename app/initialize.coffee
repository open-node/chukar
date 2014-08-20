Application     = require './application'
routes          = require './routes'
i18n            = require 'lib/i18n'
config          = require './config'
Loader          = require 'lib/loader'
Messager        = require 'lib/messager'

# Initialize the application on DOM ready event.
$ ->
  # i18n L10n support. Initialize at here
  i18n.start i18n.lang()

  # 现实loading效果
  config.loader = new Loader("#sync-loader-container")

  # 初始化message
  config.messager = new Messager()

  config.application = new Application {
    title: 'Socialmaster witch elasticsearch'
    pushState: no
    routes
  }
