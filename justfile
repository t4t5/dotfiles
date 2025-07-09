default:
  @just --choose

addtoworkspace app library:
  cd {{invocation_directory()}} && \
  pnpm --filter="{{app}}" add {{library}}

server port:
  cd {{invocation_directory()}} && \
  python3 -m http.server {{port}}

edit:
  nvim ~/.justfile

ngrok port:
  ngrok http --domain=$(NGROK_URL="op://Personal/ngrok/ngrok domain" op run --no-masking -- printenv NGROK_URL) {{port}}

bitcoin-regtest:
  bitcoind -regtest -rpcuser=user -rpcpassword=password

casks tap:
  brew tap-info homebrew/cask-fonts {{tap}} --json | jq -r '.[]|(.formula_names[],.cask_tokens[])'
