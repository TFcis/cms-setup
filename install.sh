#! /bin/bash

cd ~
sudo add-apt-repository "deb http://archive.ubuntu.com/ubuntu $(lsb_release -sc) universe"
sudo apt-get update
sudo apt-get -y install fpc
sudo apt-get -y install fpc-2.4.4
sudo apt-get -y install build-essential
sudo apt-get -y install fpc
sudo apt-get -y install postgresql
sudo apt-get -y install postgresql-client
sudo apt-get -y install gettext
sudo apt-get -y install python2.7
sudo apt-get -y install python-setuptools
sudo apt-get -y install python-tornado
sudo apt-get -y install python-psycopg2
sudo apt-get -y install python-sqlalchemy
sudo apt-get -y install python-psutil
sudo apt-get -y install python-netifaces
sudo apt-get -y install python-crypto
sudo apt-get -y install python-tz
sudo apt-get -y install python-six
sudo apt-get -y install iso-codes
sudo apt-get -y install shared-mime-info
sudo apt-get -y install stl-manual
sudo apt-get -y install python-beautifulsoup
sudo apt-get -y install python-mechanize
sudo apt-get -y install python-coverage
sudo apt-get -y install python-mock
sudo apt-get -y install cgroup-lite
sudo apt-get -y install python-requests
sudo apt-get -y install python-werkzeug
sudo apt-get -y install python-gevent patool
sudo apt-get -y install tmux
sudo apt-get -y install vim
sudo apt-get -y install htop

wget https://github.com/cms-dev/cms/releases/download/v1.2.0/v1.2.0.tar.gz
tar -zxvf ./v1.2.0.tar.gz
rm v1.2.0.tar.gz
rm cms/cms/db/filecacher.py
wget http://dev.tfcis.org/cms/filecacher.py -P cms/cms/db/
