alias diff="diff -u"
alias grep="grep --exclude='tags' --exclude='*.svn-*' --exclude='*.git*' --exclude='entries'"
alias lv="lv -Ou8 -c"
alias g=hub
alias r=rails

if [ $EMACS ]; then
# when fired in emacs, TERM is set to eterm-color but its not in terminfo
# so, we have to set manually TERM to exisisting one in terminfo to have correct face
  export TERM=xterm-256color

# dont use vim in emacs!
  alias vim="emacsclient -n"
  export EDITOR="emacsclient"
fi

case $HOST in
  ubuntu)
    export PATH=/home/yhara/bin/:/home/yhara/.cabal/bin:$PATH
    export EDITOR="emacsclient"
    export PAGER='lv -Ou8 -c'
    export GIT_PAGER=${PAGER}
    alias emacs="emacs -rv"
    alias e="emacsclient -n"
    alias o="xdg-open"

    export NAVEVERSION=0.7.2
    ;;
  yhmba.local | *plala.or.jp)
    export PATH=/Users/yukihr/bin:/Users/yukihr/Library/Haskell/ghc-7.0.4/lib/yi-0.6.5.0/bin/:$PATH
    alias emacs="/Applications/Emacs.app/Contents/MacOS/Emacs -rv"
    alias e="/Applications/Emacs.app/Contents/MacOS/bin/emacsclient -n"
    alias o="open"

    export NAVEVERSION=0.6.11
    ;;
  staff04001*)
    alias emacs="/Users/yhara/Applications/Emacs.app/Contents/MacOS/Emacs -rv"
    alias e="/Users/yhara/Applications/Emacs.app/Contents/MacOS/bin/emacsclient -n"
    ;;
esac

export PATH=$HOME/.nave/installed/${NAVEVERSION}/bin:$PATH
export NODE_PATH=$HOME/.nave/installed/${NAVEVERSION}/lib/node_modules #:$NODE_PATH
export NAVE=$NAVEVERSION
export NAVE_DIR=$HOME/.nave
export NAVE_ROOT=$HOME/.nave/installed
export NAVE_SRC=$HOME/.nave/src
