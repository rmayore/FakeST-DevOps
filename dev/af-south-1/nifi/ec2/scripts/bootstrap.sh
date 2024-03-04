#!/bin/bash

# The host the Nifi service will bind to.
# Use: 127.0.0.1 if you want the Nifi https interface only available within the instance. Not ideal since we want Nifi accessible outside
# Use: 0.0.0.0 if you want the https interface to be accessible to all network iterfaces. Not ideal since we can bind to just the vm's internal IP
# Use: {VM internal IP} if you want to bind the service to the vm's port 443. You can find the internal IP with the command `hostname -I` 
HOST=`hostname -I`

# In case the vm's publicly accessible address is not the same as the above HOST (the vm's internal address), you can put that public address below.
# This is especially needed for vms that are behind proxies or private clouds
PROXY="nifi.dev.fake-st.com" # dns or public IP

# The default port Nifi's https interface will bind to. Setting it to be the default https port looks ideal but you can change it
PORT=443

cd ~

sudo add-apt-repository -y ppa:webupd8team/java 
sudo apt-get update

apt-get -y install openjdk-8-jre
export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64/jre 
echo "export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64/jre" > /etc/profile.d/jdk_home.sh # for persisting JAVA_HOME across sessions 

mkdir nifi && cd nifi

wget https://archive.apache.org/dist/nifi/1.25.0/nifi-1.25.0-bin.zip

sudo apt-get install unzip

unzip nifi-1.25.0-bin.zip


sudo sed -i "/nifi.security.autoreload.enabled=/ s/=.*/=true/" nifi-1.25.0/conf/nifi.properties
sudo sed -i "/nifi.security.autoreload.interval=/ s/=.*/=10000 secs/" nifi-1.25.0/conf/nifi.properties

sudo sed -i "/nifi.web.https.host=/ s/=.*/=$HOST/" nifi-1.25.0/conf/nifi.properties
sudo sed -i "/nifi.web.proxy.host=/ s/=.*/=$PROXY/" nifi-1.25.0/conf/nifi.properties
sudo sed -i "/nifi.web.https.port=/ s/=.*/=$PORT/" nifi-1.25.0/conf/nifi.properties


sudo bash nifi-1.25.0/bin/nifi.sh install
sudo service nifi start

# To get credentials, run
# cat  nifi-1.25.0/logs/nifi-app.log | grep Generated