#! /bin/bash
sudo rm cmsrepo/config/cms.conf
sudo wget http://dev.tfcis.org/cms/cms.conf -P cmsrepo/config/

cd cmsrepo
sudo ./setup.py build
sudo ./setup.py install
sudo cmsInitDB
