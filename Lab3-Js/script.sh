#!/bin/bash

# Tasks:
# 1. Prepend <meta charset="UTF-8"> to content of Bai{1..8}/index.html 
# 2. Turn Bai{1..8}/index.html to Bai{1..8}.html

text='<meta charset="UTF-8">'

for bai in Bai{1..8}; do
  source="$bai/index.html"
  echo $'\n===========================' $source

  if [[ ! -f $source ]]; then # check if file/folder exists: https://linuxize.com/post/bash-check-if-file-exists/
    echo ""$source" does not exist"
    continue
  fi

  first5=$(head -c 5 $source) # read first 5 characters of a file: https://stackoverflow.com/a/14364534/9787887
  if [[ "$first5" = "<meta" ]]; then
    echo "file "$source" already has meta"
  else
    sed -i $'1i\\\n'"$text" "$source" # prepend text to a file: https://unix.stackexchange.com/a/411785
  fi

  echo "$(cat $source)" # print out content of a file: https://unix.stackexchange.com/q/411780

  dest="$bai.html"
  mv -T $source $dest
  if [ $? = 0 ]; then # check if a command succeeded: https://askubuntu.com/a/29379/1000661
      rm -r $bai 
      echo "Successfully move from "$source" to "$dest""
  else
      echo "Failed to move "$source" to "$dest""
  fi

done
