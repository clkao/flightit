require! <[request qs cheerio fs vm csv]>

function parse-seats(html)
  all-flights = {}
  $ = cheerio.load html

  var content-script
  $('script').each -> if @text! is /availLoadingDiv/
    content-script := @text!

  lib = fs.readFileSync require.resolve("./Availability.js"), \utf-8

  lib += '''
  var document = null;

  disableTextSelection = function() {};
  $ = function() {
    return {
      ready: function(cb) { cb() },
      remove: function() {}
    }
  };
  showNoResultsMessage = function() { throw "no result"};
  getPunctualityHTML = function() {}
  AvailableRoute.prototype.display = function (){}
  '''

  res = vm.runInThisContext lib ++ content-script  ++ 'availRoutes;'

  for ,route of res
    for ,{flight-number,airline}:flight of route.flights
      fn = "#airline#{flight-number}"
      all-flights[fn] ?= flight
  return all-flights

export function get-seats(params, cb)
  err, response, html <- request.get do
    url: 'http://www.flightstats.com/go/FlightAvailability/flightAvailability.do?' + 
      qs.stringify params

  cb try parse-seats html
