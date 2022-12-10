#!/bin/bash

CHAT_GPT_DIR=~/dev/tools/chatgpt-api

cd $CHAT_GPT_DIR

npx tsx src/cli.ts "$1"
