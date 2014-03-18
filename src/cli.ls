flightit = require ".."
{sprintf} = require \sprintf
moment = require 'moment-timezone'
require! <[optimist csv]>

iatatz = {}
<- csv!from.path __dirname+'/iata.tzmap', { delimiter: '\t', escape: '"', -header }
.on 'record', ([code, tz],index) -> iatatz[code] = tz
.on 'error' -> console.log \err it
.on 'end'

{query-date, connection, direct, _: argv} = optimist.argv
[departure, arrival] = argv

query-date = [query-date] unless \Array is typeof! query-date
throw "query-date required" unless query-date
throw "departure and arrival required" unless departure and arrival

require! async

funcs = for let query-date in query-date => (done) ->
  all-flights <- flightit.get-seats {departure, arrival, connection, query-date} <<< do
    query-time: \C
    cabin-Code: \B
    num-of-seats: 1
    query-type: \D

  unless all-flights
    console.log \err
    return done!

  for fn, {cabins,depCode,arrCode,arrTimeMS,depTimeMS,arrTime,depTime} of all-flights
    if direct and (depCode isnt departure or arrCode isnt arrival)
      continue
    cabin-summary = ["#c#n" for c, n of cabins.B.fares].join ' '
    dep = moment.tz depTimeMS - 1000ms * 3600s * 15h, iatatz[departure]
    arr = moment.tz arrTimeMS - 1000ms * 3600s * 15h, iatatz[arrival]
    console.log "#{dep.format 'DDMMM' .to-upper-case!} #{sprintf("%-6s", fn)} #{depCode}(#{dep.format 'HHmm'}) #{arrCode}(#{arr.format 'HHmm'}) " + cabin-summary
  done!
<- async.series funcs
