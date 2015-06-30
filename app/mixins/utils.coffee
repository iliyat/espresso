moment = require('moment')

module.exports = 
  log: (string) ->
    console.log "#{moment().format('LLLL')} - #{string}"