#!/bin/bash

MC_DIR="/var/papermc"
BACKUP_DIR="${MC_DIR}/backup"
MC_WORLD="${MC_DIR}/world"
MC_RUNNABLE="${MC_DIR}/start.sh"
TMUX_ID="moparcraft"
REST_TIME=5
DT=$(date '+%Y-%m-%d %H:%M:%S');

tmux_input()
{
    tmux send -t $TMUX_ID "$1" ENTER 
    echo 'Inputting into TMUX session'
    sleep $REST_TIME
}
announce () {
   tmux_input "say $1"
   sleep $REST_TIME
}
save_all () {
   tmux_input "save-all"
   echo 'save_all() called'
   sleep $REST_TIME
}
stop_server () {
   tmux_input "stop"
   echo 'stop_server() called'
   sleep $REST_TIME
}

backup() {
    zip -9 -r $BACKUP_DIR/$DT.zip "${MC_WORLD}_nether" "${MC_WORLD}_the_end" "$MC_WORLD"
    echo 'backup() called'
    sleep $REST_TIME
}
start_server () {
   tmux_input "sh $MC_RUNNABLE"
   echo "start_server($MC_RUNNABLE) called"
   sleep $REST_TIME
}
case "$1" in
 backup)
  announce "Server restart will begin in $REST_TIME seconds..."
  save_all
  stop_server
  backup
  start_server
 ;;
 announce)
  tmux_input "say $2" # usage e.g: crontab -e -> */5 * * * * /var/papermc/cronscript.sh announce "This 1 lines replaces a 250kb plugin :>)"
 ;;
esac
