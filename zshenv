v() {
  if [ $# -gt 0 ]; then
    nvim "$@"
  else
    nvim
  fi
}

killport() {
  lsof -i tcp:$1 | awk 'NR!=1 {print $2}' | xargs kill;
}

# copy file contents to clipboard (e.g. "copy file.txt")
copy() {
  if [ $# -lt 1 ]; then
    echo "Missing argument: file name"
  fi

  pbcopy < "$1"
  echo "Copied to clipboard!"
}

# add packages to monorepo, i.e "add web @trpc/client", "add server @trpc/server"
add() {
  if [ $# -lt 1 ]; then
    echo "Missing argument: app name"
  elif [ $# -lt 2 ]; then
    echo "Missing argument: package name"
  else 
    pnpm --filter="$1" add "${@:2}"
  fi
}

# scp but simple: "download codespace /file.txt"
download() {
  if [ $# -lt 1 ]; then
    echo "Missing argument: SSH host alias (configure in ~/.ssh/config)"
  elif [ $# -lt 2 ]; then
    echo "Missing argument: path to file on remote server"
  else
    filename="$2" | sed 's:.*/::'
    # -r so that it supports directories
    scp -r root@"$1":"$2" ~/Downloads/"$filename"
  fi
}

# Terraform with 1P: "tf staging plan"
tf() {
  if [ $# -lt 1 ]; then
    echo "Missing argument: env (staging, production)"
  elif [ $# -lt 2 ]; then
    echo "Missing argument: action (plan, apply)"
  else
    op run --env-file=.env."$1" -- terraform "$2"
  fi
}

addhusky() {
  npm install -D husky
  npm set-script prepare "husky install"
  npm run prepare
  npx husky add .husky/pre-commit "npm run format"
}

mcd() {
  mkdir -p -- "$1" &&
  cd -P -- "$1"
}

dropdbs() {
  # Clean up Layer 3 test DBs (layer3_test_xxx)
  echo "Deleting all local layer3_test_xxx databases..."

  psql -d template1 -c "copy (select datname from pg_database where datname like '%layer3_test_%') to stdout" | while read line; do
    dropdb "$line"
  done

  echo "Done!"
}
