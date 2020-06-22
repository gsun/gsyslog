package syslog;

import sys.thread.Thread;
import sys.net.UdpSocket;
import sys.net.Host;

@:enum abstract Severity(Int) from Int to Int {
    var emerg    = 0; /* system is unusable */
    var alert    = 1; /* action must be taken immediately */
    var crit     = 2; /* critical conditions */
    var err      = 3; /* error conditions */
    var warning  = 4; /* warning conditions */
    var notice   = 5; /* normal but significant condition */
    var info     = 6; /* informational */                        
    var debug    = 7; /* debug-level messages */
}

@:enum abstract Facility(Int) from Int to Int {
    var kern     =  0; /* kernel messages */
    var user     =  1; /* random user-level messages */
    var mail     =  2; /* mail system */
    var daemon   =  3; /* system daemons */
    var auth     =  4; /* security/authorization messages */
    var syslog   =  5; /* messages generated internally by syslogd */
    var lpr      =  6; /* line printer subsystem */
    var news     =  7; /* network news subsystem */
    var uucp     =  8; /* UUCP subsystem */
    var cron     =  9; /* clock daemon */
    var authpriv = 10; /* security/authorization messages (private) */
    var ftp      = 11; /* ftp daemon */
    var ntp      = 12; /* NTP subsystem */
    var logaudit = 13; /* log audit */
    var logalert = 14; /* log alert */
    var clkdamon = 15; /* clock daemon */
    var local0   = 16; /* reserved for local use */
    var local1   = 17; /* reserved for local use */
    var local2   = 18; /* reserved for local use */
    var local3   = 19; /* reserved for local use */
    var local4   = 20; /* reserved for local use */
    var local5   = 21; /* reserved for local use */
    var local6   = 22; /* reserved for local use */
    var local7   = 23; /* reserved for local use */
}

class Syslog {
    private static final w:Thread = Thread.create(sendMsgs);
    private static var hostname:String = Host.localhost();
    private static var ident:String = "";
    private static var fac:Facility = Facility.user;
    private function new () {}  // private constructor

    private static function sendMsgs()  {
        var s:UdpSocket = new UdpSocket(); 
        var h:Host = new Host("localhost");
        var connected:Bool = false;
        
        while (true) {
            var m:String = Thread.readMessage(true);
            if (!connected) {
                try {
                    s.connect(h, 514);
                    connected = true;
                } catch (e) {
                    trace(e);
                    trace(m);
                }
            }
            if (connected) {
                try {
                    s.output.writeString(m);
                } catch (e) {
                    trace(e);
                    s.close();
                    connected = false;
                    trace(m);
                }
            }
        }
    }
    public static function openlog(ident:String, fac:Facility=Facility.user) {
        Syslog.ident = ident;
        Syslog.fac = fac;
    }
    public static function syslog(svr:Severity, msg:String) {
        var pri:Int = svr | (fac<<3);
        var ts = DateTools.format(Date.now(), "%b %d %H:%M:%S");
        var l = '<${pri}>${ts} ${hostname} ${ident}: ${msg}';
        w.sendMessage(l);
    }
}