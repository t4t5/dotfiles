#!/usr/bin/env bash
languages=`echo "js typescript nodejs rust solidity ruby" | tr ' ' '\n'`

selected=`printf "$languages" | fzf`
read -p "query: " query

tmux neww bash -c "curl cht.sh/$selected/`echo $query | tr ' ' '+'` & while [ : ]; do sleep 1; done"
