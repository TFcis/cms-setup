#! /bin/bash

cd ~
sudo add-apt-repository "deb http://archive.ubuntu.com/ubuntu $(lsb_release -sc) universe"
sudo apt-get update 
sudo apt-get -y install fpc build-essential fpc postgresql postgresql-client gettext python2.7 python-setuptools python-tornado python-psycopg2 python-sqlalchemy python-psutil python-netifaces python-crypto python-tz python-six iso-codes shared-mime-info stl-manual python-beautifulsoup python-mechanize python-coverage python-mock cgroup-lite python-requests python-werkzeug python-gevent patool tmux vim htop

wget https://github.com/cms-dev/cms/releases/download/v1.2.0/v1.2.0.tar.gz
tar -zxvf ./v1.2.0.tar.gz
rm v1.2.0.tar.gz
rm cms/cms/db/filecacher.py
wget http://dev.tfcis.org/cms/filecacher.py -P cms/cms/db/
