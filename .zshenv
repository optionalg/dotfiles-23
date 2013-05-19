alias diff="diff -u"
alias grep="grep --exclude='tags' --exclude='*.svn-*' --exclude='*.git*' --exclude='entries'"
alias lv="lv -Ou8 -c"
# alias g=hub
alias g=git
alias r=rails
# below needs /usr/obj dir
# $ mkdir /usr/obj
# $ chmod 777 /usr/obj
alias gtags="gtags -O"

case `uname -s` in
  Linux)
    export PATH=/home/yhara/bin/:/home/yhara/.cabal/bin:$PATH
    export EDITOR="emacsclient -n"
    export PAGER='lv -Ou8 -c'
    export GIT_PAGER=${PAGER}
    alias emacs="emacs -rv"
    alias e=${EDITOR}
    alias o="xdg-open"

    export NAVEVERSION=0.7.2
    ;;
  Darwin)
    case $HOST in
      staff04001*)
        export EDITOR="/Users/yhara/Applications/Emacs.app/Contents/MacOS/bin/emacsclient -n"
        alias emacs="/Users/yhara/Applications/Emacs.app/Contents/MacOS/Emacs -rv"
        alias e=${EDITOR}
        alias o="open"
        ;;
      *)
        export PATH=/Users/yukihr/bin:/Users/yukihr/Library/Haskell/ghc-7.0.4/lib/yi-0.6.5.0/bin/:$PATH
        export EDITOR="/usr/local/Cellar/emacs/24.2/bin/emacsclient -n"
        alias emacs="/Applications/Emacs.app/Contents/MacOS/Emacs -rv"
        alias e=${EDITOR}
        alias o="open"
        alias be="bundle exec"

        export NAVEVERSION=0.9.6
    esac
    ;;
esac


export PATH=$HOME/.nave/installed/${NAVEVERSION}/bin:$PATH
export NODE_PATH=$HOME/.nave/installed/${NAVEVERSION}/lib/node_modules #:$NODE_PATH
export NAVE=$NAVEVERSION
export NAVE_DIR=$HOME/.nave
export NAVE_ROOT=$HOME/.nave/installed
export NAVE_SRC=$HOME/.nave/src

# gtags
export PATH=/usr/local/share/gtags/script/:$PATH


if [ $EMACS ]; then
# when fired in emacs, TERM is set to eterm-color but its not in terminfo
# so, we have to set manually TERM to exisisting one in terminfo to have correct face
  export TERM=xterm-256color

# dont use vim in emacs!
  alias vim=${EDITOR}
fi

## Ruby Version Manager
#[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"  # This loads RVM into a shell session.
#fpath=(~/.rvm/scripts/zsh/Completion ${fpath})
#autoload -U compinit; compinit

#PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

# rbenv
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

#global
export GTAGSLABEL=exuberant-ctags
