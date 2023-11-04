import { Output } from "@pulumi/pulumi";
import * as github from "@pulumi/github";

export const addSecretsToGithubRepo = (
  projectName: string,
  keyVals: Record<string, Output<string> | string>,
) => {
  Object.keys(keyVals).forEach((key) => {
    const val = keyVals[key];

    new github.ActionsSecret(`github-secret-${key}`, {
      repository: projectName,
      secretName: key,
      plaintextValue: val,
    });
  });
};

export const addVariableToGithubRepo = (
  projectName: string,
  keyVals: Record<string, Output<string> | string>,
) => {
  Object.keys(keyVals).forEach((key) => {
    const val = keyVals[key];

    new github.ActionsVariable(`github-variable-${key}`, {
      repository: projectName,
      variableName: key,
      value: val,
    });
  });
};
