
@:enum abstract Priority(Int) from Int {
    var emerg    = 0; /* system is unusable */
    var alert    = 1; /* action must be taken immediately */
    var crit     = 2; /* critical conditions */
    var err      = 3; /* error conditions */
    var warning  = 4; /* warning conditions */
    var notice   = 5; /* normal but significant condition */
    var info     = 6; /* informational */                        
    var debug    = 7; /* debug-level messages */
}

@:enum abstract Facility(Int) from Int {
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
	                   /* other codes through 15 reserved for system use */	   
    var local0   = 16; /* reserved for local use */
    var local1   = 17; /* reserved for local use */
    var local2   = 18; /* reserved for local use */
    var local3   = 19; /* reserved for local use */
    var local4   = 20; /* reserved for local use */
    var local5   = 21; /* reserved for local use */
    var local6   = 22; /* reserved for local use */
    var local7   = 23; /* reserved for local use */
}

@:enum abstract Option(Int) from Int {
    var pid      = 0x01;    /* log the pid with each message */
    var cons     = 0x02;    /* log on the console if errors in sending */
    var odelay   = 0x04;    /* delay open until first syslog() (default) */
    var ndelay   = 0x08;    /* don't delay open */
    var nowait   = 0x10;    /* don't wait for console forks: DEPRECATED */
    var perror   = 0x20;    /* log to stderr as well */
}