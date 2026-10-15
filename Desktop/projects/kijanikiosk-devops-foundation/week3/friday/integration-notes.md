# Integration Notes 

1.ProtectSystem vs. Configs: Moved environment files to `/opt/kijanikiosk/config/` to prevent read-only `/etc` failures under strict hardening.
2.Health Check ACLs: Applied default ACLs (`setfacl -d`) on `/opt/kijanikiosk/health/` so the shared group can read root-written JSON files without sudo.
3.Logrotate Reload: Used `systemctl kill -s HUP` in postrotate to safely signal log rotation without breaking `PrivateTmp` isolation.
4.Dirty VM Packages:** Implemented pre-installation version checks to handle existing packages and package holds idempotently.
