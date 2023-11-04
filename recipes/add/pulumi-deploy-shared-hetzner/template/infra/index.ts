import { createEcrRepo } from "./ecr";
import { addSecretsToGithubRepo, addVariableToGithubRepo } from "./github";
import { getEnv } from "./utils";

const project = "PROJECT_NAME";

export const { AWS_ECR_REPO_URL, AWS_ECR_REPO_NAME } = createEcrRepo(project);

const AWS_ACCESS_KEY_ID = getEnv("AWS_ACCESS_KEY_ID");
const AWS_SECRET_ACCESS_KEY = getEnv("AWS_SECRET_ACCESS_KEY");
export const HETZNER_SERVER_IP = getEnv("HETZNER_SERVER_IP");
export const HETZNER_SSH_KEY = getEnv("HETZNER_SSH_KEY");

addSecretsToGithubRepo(project, {
  AWS_ACCESS_KEY_ID,
  AWS_SECRET_ACCESS_KEY,
  HETZNER_SSH_KEY,
});

addVariableToGithubRepo(project, {
  AWS_ECR_REPO_NAME,
  AWS_ECR_REPO_URL,
  HETZNER_SERVER_IP,
});
