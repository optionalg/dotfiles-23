#platform specific
case $HOST in
    sid | ubuntu)
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
        echo ''
        ;;
    staff04001*)
        screen -U -D -RR
        ;;
esac
