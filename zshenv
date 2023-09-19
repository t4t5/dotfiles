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

# scp but simple: "download codespace /file.txt"
download() {
  if [ $# -lt 1 ]; then
    echo "Missing argument: SSH host alias (configure in ~/.ssh/config)"
  elif [ $# -lt 2 ]; then
    echo "Missing argument: path to file on remote server"
  else
    filename="$2" | sed 's:.*/::'
    scp root@"$1":"$2" ~/Downloads/"$filename"
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

# Pulumi: "pu up staging"
pu() {
  if [ $# -lt 1 ]; then
    echo "Missing argument: action (init, up)"
  fi

  if [ "$1" = "init" ]; then
    if [ ! -f ./Pulumi.yaml ]; then
      project_name=$(node -p "require('./package.json').name")
      echo "name: $project_name" >> Pulumi.yaml
      echo "runtime: nodejs" >> Pulumi.yaml
      echo "main: infra.ts" >> Pulumi.yaml

      touch infra.ts
      echo "import * as pulumi from \"@pulumi/pulumi\"" >> infra.ts

      echo "Created pulumi project $project_name"
      echo "Add a new environment with 'pu stack init'"
    fi
  elif [ "$1" = "up" ]; then
    if [ $# -lt 2 ]; then
      echo "Missing argument: env (staging, production)"
    else
      op run --env-file=.env."$2" -- pulumi preview
      echo "Deploy? (y/n)"
      read -r input
      if [ "$input" = "y" ]; then
        op run --env-file=.env."$2" -- pulumi up --skip-preview
      fi
    fi
  else
    pulumi "$@"
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
