#! /bin/bash
sudo add-apt-repository "deb http://archive.ubuntu.com/ubuntu $(lsb_release -sc) universe"
sudo apt-get update 
sudo apt-get -y install build-essential fpc postgresql postgresql-client gettext python2.7 python-setuptools python-tornado python-psycopg2 python-sqlalchemy python-psutil python-netifaces python-crypto python-tz python-six iso-codes shared-mime-info stl-manual python-beautifulsoup python-mechanize python-coverage python-mock cgroup-lite python-requests python-werkzeug python-gevent patool tmux vim htop
