default: help

all: main service getconf

main: download system install

download:
	sudo mkdir cmssetup
	sudo wget dev.tfcis.org/cms/getmakefile.sh
	sudo wget -P cmssetup dev.tfcis.org/cms/installpackage.sh
	sudo wget -P cmssetup dev.tfcis.org/cms/installcms.sh
	sudo wget -P cmssetup dev.tfcis.org/cms/service.sh
	sudo wget -P cmssetup dev.tfcis.org/cms/show.sh
	sudo wget -P cmssetup dev.tfcis.org/cms/showthis.sh
	sudo wget -P cmssetup dev.tfcis.org/cms/system.sh
	sudo wget -P cmssetup dev.tfcis.org/cms/makeconf.sh
	sudo wget -P cmssetup dev.tfcis.org/cms/getconf.sh
	sudo wget -P cmssetup dev.tfcis.org/cms/start.sh
	sudo wget -P cmssetup dev.tfcis.org/cms/stop.sh
	sudo wget -P cmssetup dev.tfcis.org/cms/record.sh
	make chmod
chmod:
	sudo chmod 777 getmakefile.sh
	sudo chmod -R 777 cmssetup
rmfile:
	sudo rm getmakefile.sh
	sudo rm cmssetup -rf
redownload: rmfile download

service:
	cmssetup/service.sh $(s) $(c)
show:
	cmssetup/show.sh
showthis:
	cmssetup/showthis.sh
system:
	cmssetup/system.sh
install: installpackage installcms

installpackage:
	cmssetup/installpackage.sh
installcms:
	cmssetup/installcms.sh
makeconf:
	cmssetup/makeconf.sh
getconf: makeconf
	cmssetup/getconf.sh
start: system
	cmssetup/start.sh $(c)
restart: stop getconf
	cmssetup/start.sh $(c)
stop:
	cmssetup/stop.sh
record:
	cmssetup/record.sh $(m)
help:
	@echo "Usage: make [OPTION]"
	@echo ""
	@echo "OPTION:"
	@echo "download        download all .sh file"
	@echo "chmod           set mod 777 to all .sh file"
	@echo "rmfile          remove all .sh file"
	@echo "redownload      remove & download all .sh file"
	@echo "service         set this ip to any service"
	@echo "                 Usage: make service s=[SERVICE]"
	@echo "                  default: SERVICE=Worker COUNT=4 & SERVICE=ResourceService COUNT=1"
	@echo "                 Usage: make service s=[SERVICE] c=[COUNT]"
	@echo "                  default: COUNT=1"
	@echo "show            show all service"
	@echo "showthis        show this ip service"
	@echo "system          kill cms & disable firewall"
	@echo "install         install all requirements & cms"
	@echo "installpackage  install requirements"
	@echo "installcms      (re)install cms"
	@echo "makeconf        make cms.conf"
	@echo "getconf         make & download cms.conf"
	@echo "start           start all services"
	@echo "                 Usage: make start c=[CONTEST]"
	@echo "stop            stop all services"
	@echo "restart         restart all services (including getconf)"
	@echo "                 Usage: make restart c=[CONTEST]"
	@echo "record          record ip message"
	@echo "                 Usage: make record m=[MESSAGE]"
	@echo "main            run download & system & install"
	@echo "all             run main & service & getconf & start"
	@echo "help            get this help"
	@echo ""
	@echo "setup worker steps:"
	@echo "1. make all"
	@echo ""
	@echo "setup any service steps:"
	@echo "1. make main"
	@echo "2. make service"
	@echo "3. make getconf"
	@echo "4. make start"
setup:
	sudo touch cms.conf
	sudo chmod 777 cms.conf
	sudo touch cms.example.conf
	sudo chmod 777 cms.example.conf
	sudo touch services.json
	sudo chmod 777 services.json
	sudo touch record.csv
	sudo chmod 777 record.csv
