require('app-module-path').addPath(__dirname)

{exec, spawn} = require('child_process')
{print} = require('sys')
log = require('app/mixins/utils').log
watch = require('watch')

respawn = false

serverRunner = null
gulpRunner = null

runnerLog = (runner) ->
  runner.stdout.on('data', (data)-> process.stdout.write(data.toString()))
  runner.stderr.on('data', (data)-> process.stderr.write(data.toString()))

startServer = ->
  command = "coffee"
  log "[Cake]: Starting node with \"#{command}\""
  serverRunner = spawn(command, ["server.coffee"])
  serverRunner.on 'error', (err) -> log err
  serverRunner.on 'close', (data) ->
    log "[Cake]: Process stopped."
    startServer() if respawn
  runnerLog(serverRunner)
  process.stdin.pipe(serverRunner.stdin)
  respawn = false

startGulpWatch = ->
  command = "gulp"
  log "[Cake]: Starting Gulp watching"
  gulpRunner = spawn(command, ["watch", "--silent"])
  gulpRunner.on 'error', (err) -> log err
  runnerLog(gulpRunner)

gulpCompile = ->
  command = "gulp"
  gulpRunner = spawn(command, ["build", "--silent"])
  gulpRunner.on 'error', (err) -> log err
  runnerLog(gulpRunner)


task 'dev', 'Server start', (options) ->
  startServer()
  startGulpWatch()
  invoke 'watch'

task 'production', 'Server start', (options) ->
  gulpCompile()
  startServer()


task 'watch', 'Watch server files', (options) ->
  log "[Cake]: Start watch server files"
  if serverRunner
    watch.createMonitor './app/server', (monitor) ->
      monitor.on 'changed', (f)->
        log "[Watch]: file #{f} was changed"
        serverRunner.kill('SIGKILL') if serverRunner
        respawn = true