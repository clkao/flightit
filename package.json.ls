#!/usr/bin/env lsc -cj
name: 'flightit'
description: 'javascript api for seat availability data from flightstats'
version: '0.0.1'
homepage: 'http://github.com/clkao/flightit'
main: 'lib/flightit.js'
bin:
  flightit: 'bin/flightit'
repository:
  type: 'git'
  url: 'https://github.com/clkao/flightit'
dependencies:
  LiveScript: \1.2.x
  cheerio: '^0.13.1'
  request: '^2.34.0'
  qs: '^0.6.6'
  csv: '^0.3.7'
  async: '^0.2.10'
  optimist: '^0.6.1'
  sprintf: '^0.1.3'
  'moment-timezone': '^0.0.3'
devDependencies:
  'gulp-util': '~2.2.14'
  'gulp-livescript': '~0.1.2'
  'gulp-exec': '~1.0.4'
  'gulp-download': '~0.0.1'
  'gulp': '~3.5.2'
scripts:
  prepublish: 'node node_modules/LiveScript/bin/lsc -c package.json.ls || lsc -c package.json.ls || echo'
  build: 'gulp --require LiveScript'
engines:
  node: '>= 0.10.x'
