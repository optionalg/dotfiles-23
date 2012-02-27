case $HOST in
  ubuntu)
    # node setup
    export NAVEVERSION=0.7.2
    export PATH=$HOME/.nave/installed/${NAVEVERSION}/bin/:$PATH
    export NODE_PATH=~/.nave/installed/${NAVEVERSION}/lib/node_modules/:$NODE_PATH
    export NAVE=$NAVEVERSION
    export NAVE_DIR=$HOME/.nave
    export NAVE_ROOT=$HOME/.nave/installed
    export NAVE_SRC=$HOME/.nave/src
    ;;
  yhmba.local)
    # node setup
    export NAVEVERSION=0.6.11
    export PATH=~/.nave/installed/${NAVEVERSION}/bin/:$PATH
    export NODE_PATH=~/lib/node_modules:$NODE_PATH
    export NAVE=$NAVEVERSION
    export NAVE_DIR=$HOME/.nave
    export NAVE_ROOT=$HOME/.nave/installed
    export NAVE_SRC=$HOME/.nave/src
    ;;
esac
