Controller = require('../lib/controller')

class API extends Controller

  router: ->
    @get('/api/status', @status)

  status: (req, res)->
    res.json status: 'API available'


module.exports = new API