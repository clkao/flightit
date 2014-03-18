flightit
========

A command line tool (and JavaScript library) for querying seat availability from flightstats.com

## Usage

    % npm i
    % npm run build

    # query flight from TPE to SCL on 2014-04-15
    % ./bin/flightit --queryDate 2014-04-15 TPE SCL
    15APR CI51   TPE(11:00 PM/2300) SYD(10:15 AM/0115) J2 C1 D0
    16APR QF27   SYD(11:25 AM/1125) SCL(11:05 AM/0205) J9 C9 D9 I8 U0
    16APR LA806  SYD(11:25 AM/1125) SCL(11:05 AM/0205) J7 D4 I3 R0
    15APR CI8    TPE(11:50 PM/2350) LAX( 8:35 PM/1135) J4 C4 D4
    ...

    # multiple dates
    ./bin/flightit --queryDate 2014-04-15 --queryDate 2014-04-16 TPE SCL

    # output json
    ./bin/flightit --queryDate 2014-04-15 TPE LHR --json

    # poorman's monitor for I class on LA flights from SYD to SCL
    % while true;  do (date && ./bin/flightit --queryDate 2014-04-26 --queryDate 2014-04-27 SYD SCL) | tee -a output.log; sleep 300; done
    % tail -f output.log |grep --line-buffered ' LA.* I[1-9]' | sed -l 's/.*/"&"/'  | xargs -L1 terminal-notifier -title 'flightit' -sound default -message

## License
[MIT](http://clkao.mit-license.org)
