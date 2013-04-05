#!/bin/sh

if [ `uname -s` = 'Darwin' ]; then
  files=`find "${PWD}" -maxdepth 1 -name '.git' -prune -o -name '.gitignore' -prune -o -name '.*' -print`

  for file in ${files}
  do
    ln -is ${file} ~/
  done
else
  find "${PWD}" -maxdepth 1 -name '.git' -prune -o -name '.gitignore' -prune -o -name '.*' -print0 | xargs -0 ln -ins -t ~/
fi

