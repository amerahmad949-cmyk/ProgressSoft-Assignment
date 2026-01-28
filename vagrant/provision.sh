#!/bin/bash

set -e

apt update -y
apt install -y openjdk-8-jdk wget

# Create tomcat base directory
mkdir -p /opt/tomcat

cd /tmp
wget https://archive.apache.org/dist/tomcat/tomcat-9/v9.0.96/bin/apache-tomcat-9.0.96.tar.gz

tar -xzf apache-tomcat-9.0.96.tar.gz

# Move contents, not the folder
cp -r apache-tomcat-9.0.96/* /opt/tomcat/

# Permissions
useradd -m -U -d /opt/tomcat -s /bin/false tomcat || true
chown -R tomcat:tomcat /opt/tomcat
chmod +x /opt/tomcat/bin/*.sh

# Change Tomcat port
sed -i 's/port="8080"/port="7070"/' /opt/tomcat/conf/server.xml

# Start Tomcat
/opt/tomcat/bin/startup.sh
