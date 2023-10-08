RED=$'\033[0;31m'

# Uses the GitHub CLI to get the name of the repo:
repo_name=$(gh repo view --json name -q ".name" 2>/dev/null)

# If no GitHub repo exists yet, we can't proceed:
if [ -z "$repo_name" ]; then
  echo "${RED}GitHub remote repository name not found. Please run 'g create' to create a remote repository."
  exit 1
fi

aws ecr create-repository --repository-name $repo_name > /dev/null 2>&1

gh variable set AWS_ECR_REPO_NAME --body $repo_name

set_github_secret_from_op "AWS_ACCESS_KEY_ID" "op://Personal/atj2kzxcprsfmi3q43ycio2mje/Deployer API user/access key id"
set_github_secret_from_op "AWS_SECRET_ACCESS_KEY" "op://Personal/atj2kzxcprsfmi3q43ycio2mje/Deployer API user/secret access key"
