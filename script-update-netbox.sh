#!/bin/bash

# DOC e Latest Release
echo "--------------------------------------------------------------------"
echo NETBOX UPDATE
echo Refer to the documentation on the update procedure on the link:
echo https://netboxlabs.com/docs/netbox/installation/upgrading/
echo
echo Check the latest stable release avaiable at the link:
echo https://github.com/netbox-community/netbox/releases
echo "--------------------------------------------------------------------"


# NEWVER="USER INPUT"
read -p "Enter the latest version (Ex: 4.4.0): " NEWVER

# OLDVER="USER INPUT"
read -p "Enter the current version( Ex 4.4.0): " OLDVER

# Download the desirable release
wget https://github.com/netbox-community/netbox/archive/v$NEWVER.tar.gz

if [ $? -eq 0 ]; then
    echo "Download successful. File saved as v$NEWVER.tar.gz"
else
    echo "Error: Download failed."
    exit 1
fi

#Extract the new version from tar file
tar -xzf v$NEWVER.tar.gz -C /opt

#Create the Sym Link
ln -sfn /opt/netbox-$NEWVER/ /opt/netbox

#Copy Requirements and files from OLD Version
cp /opt/netbox-$OLDVER/local_requirements.txt /opt/netbox/
cp /opt/netbox-$OLDVER/netbox/netbox/configuration.py /opt/netbox/netbox/netbox/
cp /opt/netbox-$OLDVER/netbox/netbox/ldap_config.py /opt/netbox/netbox/netbox/
cp -pr /opt/netbox-$OLDVER/netbox/media/ /opt/netbox/netbox/
cp -r /opt/netbox-$OLDVER/netbox/scripts /opt/netbox/netbox/
cp -r /opt/netbox-$OLDVER/netbox/reports /opt/netbox/netbox/
cp /opt/netbox-$OLDVER/gunicorn.py /opt/netbox/

#Run Script from Netbox Docs - upgrade.sh
cd /opt/netbox
./upgrade.sh

#Change the Daemons
sed -i "s|/opt/netbox-$OLDVER/venv/bin/gunicorn|/opt/netbox-$NEWVER/venv/bin/gunicorn|" /etc/systemd/system/netbox.service
sed -i "s|/opt/netbox-$OLDVER/venv/bin/gunicorn|/opt/netbox-$NEWVER/venv/bin/gunicorn|" /etc/systemd/system/netbox-rq.service

#Reload the Daemons
systemctl daemon-reload

#Reload Services
systemctl restart netbox netbox-rq

#Check Services
systemctl status netbox netbox-rq
