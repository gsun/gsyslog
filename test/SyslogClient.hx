import syslog.Syslog;

class SyslogClient {
    static function main(){
        Syslog.openlog("gsyslog");
        Syslog.syslog(Severity.info, "test");
        Sys.sleep(10);
    }
}