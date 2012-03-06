case $HOST in
  ubuntu)
    export PATH=/home/yhara/bin/:$PATH
    export NAVEVERSION=0.7.2
    ;;
  yhmba.local | *plala.or.jp)
    export PATH=/Users/yukihr/bin:$PATH
    export NAVEVERSION=0.6.11
    ;;
esac

export PATH=$HOME/.nave/installed/${NAVEVERSION}/bin:$PATH
export NODE_PATH=$HOME/.nave/installed/${NAVEVERSION}/lib/node_modules:$NODE_PATH
export NAVE=$NAVEVERSION
export NAVE_DIR=$HOME/.nave
export NAVE_ROOT=$HOME/.nave/installed
export NAVE_SRC=$HOME/.nave/src
