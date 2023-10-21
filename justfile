@list:
  just --list

@kill port:
  lsof -i tcp:{{port}} | awk 'NR!=1 {print $2}' | xargs kill;
  echo "Killed port {{port}} ✅"

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
