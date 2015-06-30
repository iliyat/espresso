require('app-module-path').addPath(__dirname)

gulp = require('gulp')
browserify = require('browserify')
coffeify = require('coffeeify')
source = require('vinyl-source-stream')

stylus = require('gulp-stylus')
rename = require('gulp-rename')
log = require('app/mixins/utils').log

stylusSource = __dirname + '/stylesheets/index.styl'
clientSource = __dirname + '/app/client/app.coffee'

cssDest = __dirname + '/public/css/'
jsDest = __dirname + '/public/js/'

gulp.task 'css', ->
  gulp.src(stylusSource)
    .pipe(stylus(
      'include css': true
      paths: ["#{__dirname}/node_modules"]
    ))
    .pipe(rename('app.css'))
    .pipe(gulp.dest(cssDest))
    .on 'end', -> log "[Gulp]: CSS compiled."

gulp.task 'js', ->
  b = browserify(
    entries: clientSource
    extensions: ['.coffee']
  )

  b.transform(coffeify)
  b.bundle()
    .pipe(source('app.js'))
    .pipe(gulp.dest(jsDest))
    .on 'end', -> log "[Gulp]: Client JS compiled"

gulp.task 'build', ['js', 'css'], ->
  log "[Gulp]: All compiled."

gulp.task 'watch', ['js', 'css'], ->

  stylesheets = [
    "#{__dirname}/stylesheets/**/*.styl"
    "#{__dirname}/stylesheets/**/**/*.styl"
  ]

  gulp.watch(clientSource, ['js'])
  gulp.watch(stylesheets, ['css'])