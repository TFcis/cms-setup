default: help

all: main service getconf start

main: download sys install
	
download: 
	sudo wget http://dev.tfcis.org/cms/install.sh
	sudo wget http://dev.tfcis.org/cms/service.sh
	sudo wget http://dev.tfcis.org/cms/show.sh
	sudo wget http://dev.tfcis.org/cms/showthis.sh
	sudo wget http://dev.tfcis.org/cms/sys.sh
	sudo wget http://dev.tfcis.org/cms/makeconf.sh
	sudo wget http://dev.tfcis.org/cms/getconf.sh
	sudo wget http://dev.tfcis.org/cms/start.sh
	make chmod
chmod:
	sudo chmod 777 install.sh
	sudo chmod 777 service.sh
	sudo chmod 777 show.sh
	sudo chmod 777 showthis.sh
	sudo chmod 777 sys.sh
	sudo chmod 777 makeconf.sh
	sudo chmod 777 getconf.sh
	sudo chmod 777 start.sh
rmfile:
	rm install.sh service.sh show.sh showthis.sh sys.sh makeconf.sh getconf.sh start.sh
service:
	./service.sh $(s) $(c)
show:
	./show.sh
showthis:
	./showthis.sh
sys:
	./sys.sh
install:
	./install.sh
makeconf: 
	./makeconf.sh
getconf: makeconf
	./getconf.sh
start: sys
	./start.sh $(c)
help:
	@echo "Usage: make [OPTION]"
	@echo ""
	@echo "OPTION:"
	@echo "download   download all bash file"
	@echo "chmod      set mod 777 to all bash file"
	@echo "rmfile     remove all bash file"
	@echo "service    set this ip to any service"
	@echo "           Usage: make service s=[SERVICE]"
	@echo "             default: SERVICE=Worker COUNT=4"
	@echo "           Usage: make service s=[SERVICE] c=[COUNT]"
	@echo "             default: COUNT=1"
	@echo "show       show all service"
	@echo "showthis   show this ip service"
	@echo "sys        kill cms & disable firewall"
	@echo "install    install all requirements & cms"
	@echo "getconf    make & download cms.conf"
	@echo "start      start all service"
	@echo "           Usage: make start c=[CONTEST]"
	@echo "main       run download & sys & install"
	@echo "all        run main & service & getconf & start"
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
