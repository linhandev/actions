# Actions

This project will be merged with the product repo during ci run. So no file can conflict with the product repo.

package.json will be deleted during ci run. See all files that will be deleted [here](./.github/actions/prepare-rnoh-env/action.yml). Workflow script dependencies should be kept to absolute minimum, kept at the same version as used in product repo and will be [installed globally](./workflow_utils/deps.sh) during ci run. The package.json in this repo is only used to suppress lint errors during development.