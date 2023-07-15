v() {
  if [ $# -gt 0 ]; then
    nvim "$@"
  else
    nvim
  fi
}

