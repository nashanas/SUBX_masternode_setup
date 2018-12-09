#!/bin/sh
#Easy daemon setup for SUBX masternode
#by mad345
#simple usage, change max to your MN count. eg: max=4 for 4 MN setup
#this tool is very simple that can handle library for SUBX coin daemon, compile the daemon and prepare data directory for each masternode.
#yet you still need to copy and paste your masternodeprivkey=YOUR_GENKEY to each subx.conf
#here an example to start daemon
#./subxd -port=21953 -datadir=yourdatadir
#to make it easy, this tool create file rundaemon.sh
#call with : sh ./runmn.sh
#tested on ubuntu server 16.04 on virtual box

GIT_SOURCE_URL="https://github.com/EXISTDevv/SUBXMN.git"
MASTERNODE=1
COIN_NAME="SUBXMN"
CONF_FILE="subx.conf"
n=1
max=5 #count your masternode
DATADIR=".subxmn"
DAEMON="subxd"
RPCPORT_PREFIX=21944
PORT_PREFIX=21953
echo Prepare needed library to compile your daemon
sudo apt-get update;wait
sudo apt-get install git automake build-essential libtool autotools-dev autoconf \
pkg-config libssl-dev libboost-all-dev software-properties-common libgmp-dev unzip -y;wait
echo Adding bitcoin apt repository
sudo add-apt-repository ppa:bitcoin/bitcoin && sudo apt-get update;wait
echo installing libdb and miniupnp from bitcoin repository
sudo apt-get install libdb4.8-dev libdb4.8++-dev libminiupnpc-dev;wait
git clone $GIT_SOURCE_URL $COIN_NAME 
cd $COIN_NAME/src
make -f makefile.unix;wait
echo Copying daemon to home direcory
cp $HOME/$COIN_NAME/src/$DAEMON $HOME/;wait

echo Creating bash 'runmn.sh' file
touch $HOME/runmn.sh;wait
while [ "$n" -le "$max" ]; do
  mkdir -p $HOME/$DATADIR$n;wait
  RPCPASSWORD=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 8 | head -n 1)
  echo Creating configuration file
  touch $HOME/$DATADIR$n/$CONF_FILE
  wait
  echo Setup your configuration
  echo rpcuser=$USER >> $HOME/$DATADIR$n/$CONF_FILE
  echo rpcpassword=$RPCPASSWORD >> $HOME/$DATADIR$n/$CONF_FILE
  echo rpcport=$RPCPORT_PREFIX$n >> $HOME/$DATADIR$n/$CONF_FILE
  echo rpcallowip=127.0.0.1 >> $HOME/$DATADIR$n/$CONF_FILE
  echo daemon=1 >> $HOME/$DATADIR$n/$CONF_FILE
  echo server=1 >> $HOME/$DATADIR$n/$CONF_FILE
  echo listen=1 >> $HOME/$DATADIR$n/$CONF_FILE
  echo addnode=144.202.18.54 >> $HOME/$DATADIR$n/$CONF_FILE
  if [ -z "$MASTERNODE" ]
    then
    echo Not masternode, leave it empty
   else
      echo masternode=1 >> $HOME/$DATADIR$n/$CONF_FILE
      echo masternodeprivkey=PASTE_YOUR_PRIVKEY_HERE >> $HOME/$DATADIR$n/$CONF_FILE
  fi
  wait
  echo "~/$DAEMON -port=$PORT_PREFIX$n -datadir=$HOME/$DATADIR$n -daemon" >> $HOME/runmn.sh
  n=`expr "$n" + 1`;
done
echo "daemon setup done, now open your local wallet masternode configuration file (masternode.conf)."
echo "Please be sure to copy masternodeprivkey from your local masternode.conf to $DATADIR{1..$max}/$CONF_FILE."
echo "Start your daemon manually with option -port=yourport -datadir=$DATADIR{1..$max}" 
echo "./$DAEMON -port=1000{1..$max} -datadir=$HOME/$DATADIR{1..$max}) one by one."
echo "Enjoy this simple tool. :-)"
