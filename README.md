# cloud-azure-ghrunner-chart
Helm chart for new GitHub Runners for the University of Bern

## Updating the referenced actions-runner-controller version

The `ghrunner-unibe` chart depends on the upstream `gha-runner-scale-set` chart
(`charts/ghrunner-unibe/Chart.yaml`), which provides the actual GitHub Actions
runner. To bump it to a new release:

1. Check the available versions/releases of the upstream chart:
   https://github.com/actions/actions-runner-controller/releases
   (or `helm search repo` against `oci://ghcr.io/actions/actions-runner-controller-charts`).
2. Update `charts/ghrunner-unibe/Chart.yaml`:
   - `dependencies[].version` to the new `gha-runner-scale-set` chart version.
   - Bump `version` (the chart's own version) following semver.
3. Refresh the dependency lock and local cache:
   ```sh
   cd charts/ghrunner-unibe
   helm dependency update
   ```
   This regenerates `Chart.lock` and `charts/*.tgz` — commit the updated
   `Chart.lock` (the `.tgz` archives are git-ignored).
4. Review `values.yaml` for any new/changed/removed settings introduced by the
   upstream chart and adjust defaults as needed.
5. Commit the changes and open a PR. Merging to `main` triggers the
   `Release Charts` workflow, which packages and publishes the new chart
   version automatically.
