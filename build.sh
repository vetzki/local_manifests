#!/bin/sh

WORKDIR=`pwd`
if [ "$@" != "" ]
   then
   JOBS=$@
   echo "JOBS:$JOBS"
else
   echo "Set Jobs to default"
   JOBS=4
   echo "JOBS:$JOBS"
fi

### Arch ###
Virtualenv() {
if [ "$(python -V | cut -d . -f 1 | awk '{print $2}')" = 3 ]
  then
    echo "Setup Virtualenv"
    virtualenv2 venv
    source venv/bin/activate
  else
    echo "Bereits in Python2 virtueller umgebung"
fi  
}

Mako() {
cd $WORKDIR
sed -i s/'TARGET_PRODUCT:=.*'/'TARGET_PRODUCT:=aosp_mako'/g buildspec.mk
echo "Nur Neu (1) / Installclean (2) / Clean (3) / Clobber (4) ?"
read ANTWORTMako

case $ANTWORTMako in
	1)
	rm out/target/product/mako/system/build.prop
	make -j$JOBS dist
	;;
	2)
	make installclean
	make -j$JOBS dist
	;;
	3)
	make clean
	make -j$JOBS dist
	;;
	4)
	make clobber
	make -j$JOBS dist
	;;
	*)
	echo "Huhh ???"
	Mako
	;;
esac
}

Grouper() {
cd $WORKDIR
sed -i s/'TARGET_PRODUCT:=.*'/'TARGET_PRODUCT:=aosp_grouper'/g buildspec.mk
echo "Nur Neu (1) / Installclean (2) / Clean (3) / Clobber (4) ?"
read ANTWORTGrouper

case $ANTWORTGrouper in
        1)
        rm out/target/product/grouper/system/build.prop
        make -j$JOBS dist
        ;;
        2)
        make installclean
        make -j$JOBS dist
        ;;
        3)
        make clean
        make -j$JOBS dist
        ;;
        4)
        make clobber
        make -j$JOBS dist
        ;;
	*) 
        echo "Huhh ???"
        Grouper
        ;;
esac
}

read -p "Hallo; Mako oder Grouper ? " MODELL
case $MODELL in
	m*|M*) Virtualenv;Mako;;
	g*|G*) Virtualenv;Grouper;;
	*) echo "Huhh ???";echo "Bitte neu versuchen"; exit 1;;
esac
