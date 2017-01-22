default: help

all: main service getconf start

main: download sys install
	
download: 
	sudo wget http://dev.tfcis.org/cms/install.sh
	sudo wget http://dev.tfcis.org/cms/service.sh
	sudo wget http://dev.tfcis.org/cms/delip.sh
	sudo wget http://dev.tfcis.org/cms/showip.sh
	sudo wget http://dev.tfcis.org/cms/clearip.sh
	sudo wget http://dev.tfcis.org/cms/sys.sh
	sudo wget http://dev.tfcis.org/cms/makeconf.sh
	sudo wget http://dev.tfcis.org/cms/getconf.sh
	sudo wget http://dev.tfcis.org/cms/start.sh
	make chmod
chmod:
	sudo chmod 777 install.sh
	sudo chmod 777 service.sh
	sudo chmod 777 delip.sh
	sudo chmod 777 showip.sh
	sudo chmod 777 clearip.sh
	sudo chmod 777 sys.sh
	sudo chmod 777 makeconf.sh
	sudo chmod 777 getconf.sh
	sudo chmod 777 start.sh
rmfile:
	rm install.sh service.sh delip.sh showip.sh clearip.sh sys.sh makeconf.sh getconf.sh start.sh
service:
	./service.sh s=$(s) c=$(c)
showip:
	./showip.sh
clearip:
	./clearip.sh
sys:
	./sys.sh
install:
	./install.sh
makeconf:
	./makeconf.sh
getconf: makeconf
	./getconf.sh
start:
	./start.sh
help:
	@echo "Usage: make [OPTION]"
	@echo ""
	@echo "OPTION:"
	@echo "download   download all bash file"
	@echo "rmfile     remove all bash file"
	@echo "service      add this ip to file"
	@echo "delip      del this ip from file"
	@echo "clearip    clear all ip in file"
	@echo "sys        kill cms & disable firewall"
	@echo "install    install all requirements & cms"
	@echo "makeconf   make cms.conf"
	@echo "getconf    make & download cms.conf"
	@echo "start      start worker"
	@echo "main       run download & sys & install"
	@echo "all        run main & service & getconf & start"
	@echo ""
	@echo "setup worker steps:"
	@echo "1. \"make main\""
	@echo "2. \"make service\""
	@echo "   wait all worker finish to step 2"
	@echo "3. \"make getconf\" & download \"cms.conf\" to judge server"
	@echo "4. \"make start\""