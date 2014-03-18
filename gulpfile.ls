require! <[gulp gulp-livescript gulp-download fs]>

gutil = require 'gulp-util'

gulp.task 'init' ->
  return if fs.existsSync 'lib/iata.tzmap' and fs.existsSync 'lib/Availability.js'
  gulp-download 'https://raw.github.com/hroptatyr/dateutils/tzmaps/iata.tzmap'
    .pipe gulp.dest "./lib"
  gulp-download 'http://www.flightstats.com/go/scripts/schedules/Availability.js'
    .pipe gulp.dest "./lib"

gulp.task 'build' ->
  gulp.src 'src/**/*.ls'
    .pipe gulp-livescript({+bare}).on 'error', gutil.log
    .on \error -> throw it
    .pipe gulp.dest './lib'

gulp.task 'watch' ->
  gulp.watch 'src/**/*.ls' <[build]>

gulp.task 'default' <[init build]>
