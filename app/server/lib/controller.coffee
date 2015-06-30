router = require('express').Router()
_ = require('underscore')

class Controller

  constructor: (options) ->
    _.defaults(@, options) if options
    @_router = router

  use: (@app) ->
    @router?()

    @app.use(@_router)

  get: (route, callbacks...) -> @_router['get'](route, @bind(callbacks)...)

  bind: (callbacks) ->
    if _.isArray(callbacks)
      _.bind(callback, @) for callback in callbacks
    else
      _.bind(callbacks, @)

module.exports = Controller