RED='\033[0;31m'

if [[ $1 == "next" ]]; then
  bunx create-next-app@latest --ts
else
  echo "${RED}Error: Unknown project type: $1"
  echo "Available options:"
  echo "  - next"
fi
