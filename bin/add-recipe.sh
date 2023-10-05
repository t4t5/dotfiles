RED='\033[0;31m'

recipe_name=$1
recipe_dir="$HOME/dotfiles/recipes/$recipe_name"

if [ -d "$recipe_dir" ]; then
  cp -r $recipe_dir/* . 
  echo "Added $recipe_name files!"
else
  echo "${RED}Error: Unknown recipe type: $1"
  echo "Available options:"
  echo "  - ansible"
fi
