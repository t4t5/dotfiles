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
