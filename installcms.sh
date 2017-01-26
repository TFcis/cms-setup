#! /bin/bash
sudo rm -rf cmsrepo
wget https://github.com/cms-dev/cms/releases/download/v1.2.0/v1.2.0.tar.gz
sudo tar -zxvf ./v1.2.0.tar.gz
sudo rm v1.2.0.tar.gz
sudo mv cms cmsrepo
sudo rm cmsrepo/cms/db/filecacher.py
sudo wget http://dev.tfcis.org/cms/filecacher.py -P cmsrepo/cms/db/
