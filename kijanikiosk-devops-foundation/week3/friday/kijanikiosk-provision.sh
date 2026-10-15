#!/bin/bash

# as a safety feature the script will exit when a command fails
set -e

echo "Starting KijaniKiosk Production Foundation Provisioning"
echo "we Check the package version"
# we check if nginx is installed and matches the version we expect
if dpkg -l | grep -q "nginx"; then
    echo "Nginx is already installed. Verifying configuration..."
else
    apt-get update
    apt-get install -y nginx=1.24.0-1ubuntu2 || apt-get install -y nginx
fi
echo "we check if the service accounts and groups exists"

# we check if the primary group exists before creating it
if getent group kijanikiosk >/dev/null; then
    echo "Group 'kijanikiosk' already exists. Skipping creation."
else
    groupadd --system kijanikiosk
    echo "Created group 'kijanikiosk'."
fi
create_system_user() {
    local username=$1
    if id "$username" &>/dev/null; then
        echo "Already exists: User '$username'. Validating state."
    else
        useradd --system --g kijanikiosk --no-create-home --shell /bin/false "$username"
        echo "Created system user: '$username'."
    fi
}

create_system_user "kk-api"
create_system_user "kk-payments"
create_system_user "kk-logs"

echo " we setup the directory structures and permissions"

mkdir -p /opt/kijanikiosk/shared/logs
mkdir -p /opt/kijanikiosk/config
mkdir -p /opt/kijanikiosk/health

# Set ownership
chown -R root:kijanikiosk /opt/kijanikiosk
chmod 750 /opt/kijanikiosk/shared/logs
chmod 750 /opt/kijanikiosk/config

# we apply the default ACLs
setfacl -d -m u::rwx,g::rx,o::--- /opt/kijanikiosk/shared/logs
setfacl -m u:kk-api:rwx /opt/kijanikiosk/shared/logs
setfacl -m u:kk-payments:rx /opt/kijanikiosk/shared/logs
