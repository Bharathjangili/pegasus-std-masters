# pegasus project rootfs creation

ZILOGIC_APT_REPO=deb [trusted=yes] http://shark/zdrive/debian/repo/ wheezy main

export ZILOGIC_APT_REPO

all: before_install install script

before_install:
	sudo apt-get update

install:
	sudo apt-get install --no-install-recommends -y `cat dpkg-deps.txt`
	sudo apt-get install --no-install-recommends -y fpm-equivs

script:
	cp config-jessie-arm.sh config.sh
	sudo ./all.sh
