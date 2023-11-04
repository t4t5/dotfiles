import * as aws from "@pulumi/aws";

export const createEcrRepo = (projectName: string) => {
  const tags = { project: projectName };

  const registry = new aws.ecr.Repository("ecr-registry", {
    name: projectName,
    tags,
  });

  return {
    AWS_ECR_REPO_NAME: registry.name,
    AWS_ECR_REPO_URL: registry.repositoryUrl,
  };
};
