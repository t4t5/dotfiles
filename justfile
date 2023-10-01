@default:
  just --list

# Initialize a new project
@create project-type:
  cd {{invocation_directory()}} && \
  ~/dotfiles/bin/create.sh {{project-type}}
