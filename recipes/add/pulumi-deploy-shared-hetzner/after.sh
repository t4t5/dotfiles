# Replace "PROJECT_NAME" with project name from package.json:

PROJECT_NAME=$(node -p "require('./package.json').name")

FILE_PATH="./infra/index.ts"

sed -i '' "s/PROJECT_NAME/$PROJECT_NAME/g" "$FILE_PATH"

# ----
# Make sure .env.prod is ignored by git:
echo "\n.env.prod" >> .gitignore

echo "👉 TODO: Update .github/workflows/deploy-prod.yml with the correct ports!"
echo "👉 Then run 'pu up prod' when ready"
