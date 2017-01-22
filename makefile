default: help

all: main addip getconf start

main: download sys install
	
download: 
	sudo wget http://dev.tfcis.org/cms/install.sh
	sudo chmod 777 install.sh
	sudo wget http://dev.tfcis.org/cms/addip.sh
	sudo chmod 777 addip.sh
	sudo wget http://dev.tfcis.org/cms/delip.sh
	sudo chmod 777 delip.sh
	sudo wget http://dev.tfcis.org/cms/showip.sh
	sudo chmod 777 showip.sh
	sudo wget http://dev.tfcis.org/cms/clearip.sh
	sudo chmod 777 clearip.sh
	sudo wget http://dev.tfcis.org/cms/sys.sh
	sudo chmod 777 sys.sh
	sudo wget http://dev.tfcis.org/cms/makeconf.sh
	sudo chmod 777 makeconf.sh
	sudo wget http://dev.tfcis.org/cms/getconf.sh
	sudo chmod 777 getconf.sh
	sudo wget http://dev.tfcis.org/cms/start.sh
	sudo chmod 777 start.sh
rmfile:
	rm install.sh addip.sh delip.sh showip.sh clearip.sh sys.sh makeconf.sh getconf.sh start.sh
addip:
	./addip.sh
delip:
	./delip.sh
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
	@echo "addip      add this ip to file"
	@echo "delip      del this ip from file"
	@echo "clearip    clear all ip in file"
	@echo "sys        kill cms & disable firewall"
	@echo "install    install all requirements & cms"
	@echo "makeconf   make cms.conf"
	@echo "getconf    make & download cms.conf"
	@echo "start      start worker"
	@echo "main       run download & sys & install"
	@echo "all        run main & addip & getconf & start"
	@echo ""
	@echo "setup worker steps:"
	@echo "1. \"make main\""
	@echo "2. \"make addip\""
	@echo "   wait all worker finish to step 2"
	@echo "3. \"make getconf\" & download \"cms.conf\" to judge server"
	@echo "4. \"make start\""