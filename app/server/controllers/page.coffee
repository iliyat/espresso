Controller = require('../lib/controller')

class Page extends Controller

  router: ->
    @get('/', @index)
    @get('/:slug', @index)

  index: (req, res) ->
    slug = req.params.slug
    title = "Page - #{slug}" if slug

    res.render 'page/home',
      title: title

module.exports = new Page
