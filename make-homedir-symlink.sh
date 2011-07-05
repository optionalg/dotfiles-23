#!/bin/sh

if [ "${HOST}" != "yhmba\.local" ]; then
  find "${PWD}" -maxdepth 1 -name '.git' -prune -o -name '.gitignore' -prune -o -name '.*' -print0 | xargs -0 ln -fs -t ~/
else
  files=`find "${PWD}" -maxdepth 1 -name '.git' -prune -o -name '.gitignore' -prune -o -name '.*' -print`

  for file in ${files}
  do
    ln -fs ${file} ~/
  done
fi

