@default:
  just --list

# Initialize a new project
@create project-type:
  cd {{invocation_directory()}} && \
  ~/dotfiles/bin/create-project.sh {{project-type}}

# Add files to a project:
@add recipe:
  cd {{invocation_directory()}} && \
  ~/dotfiles/bin/add-recipe.sh {{recipe}}
