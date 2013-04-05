#platform specific
#

case $HOST in
  ubuntu)
    #screen -U -D -RR
    ;;
  yhmba.local)
    ;;
esac


[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
