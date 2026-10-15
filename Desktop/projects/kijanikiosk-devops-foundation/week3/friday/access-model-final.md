
Access Model

1.Directories /opt/kijanikiosk/ is owned by root:kijanikiosk with 750 base permissions across root, config, and health paths.
2.Logs Directory shared/logs/ Uses default ACLs setfacl -d to ensure correct permissions propagate to subfiles.
3.kk-api Account runs the public API with read/write access to logs and configurations.
4.kk-payments Account runs financial services with read-only log access and strict security bounds.
5.kk-logs account manages log collection, owning post-rotation files via create 0640 kk-logs kijanikiosk.
6.Logrotate Integration parent default ACLs automatically inherit to newly rotated files.
7.Verification  post-remediation touch tests confirm services retain write capability post-rotation.
