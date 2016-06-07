require('app-module-path').addPath(__dirname)

app = require('express')()
config = require('./config')
log = require('app/mixins/utils').log
exphbs  = require('express-handlebars');


#Middleware
app.use(require('morgan')('dev'))
app.use(require('serve-static')(__dirname + '/public', redirect: false))

#Views engine
app.engine('.hbs', exphbs(
  extname: '.hbs'
  layoutsDir: __dirname + '/templates/'
  partialsDir: __dirname + '/templates/components/'
  defaultLayout: 'layout'
  helpers: require(__dirname + '/app/mixins/utils')
))
app.set('views', __dirname + '/templates/')
app.set('view engine', '.hbs')

#Controllers
controller.use(app) for key, controller of require('app/server/controllers')

#Start listen
log config.server.ip
if config.server.ip
  app.listen config.server.port, config.server.ip, ->
    log "[App]: Server starts on address #{config.server.ip} and port #{config.server.port}"
else
  app.listen config.server.port, ->
    log "[App]: Server starts on port #{config.server.port}"
