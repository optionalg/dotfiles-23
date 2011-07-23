#platform specific
case $HOST in
    sid)
        # sshfs -o y-hara@192.168.71.1: ~/win/
        screen -U -D -RR
        ;;
    sie)
        screen -U -D -RR
        dropbox.py start
        # sshfs -o yukihr@172.16.231.1: ~/mac
        #sudo aptitude update
        ;;
    yhmba.local)
        echo '';;
esac
