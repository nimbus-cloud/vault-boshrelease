#!/bin/bash

set -eu

# Setup env vars and folders for the webapp_ctl script
source /var/vcap/jobs/sanity-test/helpers/ctl_setup.sh 'sanity-test'

export VAULT_TOKEN="<%= p('vault.broker.backend.token') %>"
if [[ "${VAULT_TOKEN}" == "TODO" ]]; then
  echo "SKIPPING SANITY TESTS. \$VAULT_TOKEN set to 'TODO'"
  exit 0
fi

echo "Started vault sanity-check errand ..."
${JOB_DIR}/bin/run-vault-tests.sh
echo "Errand sanity-test vault is complete"
echo "Started broker sanity-check errand ..."
${JOB_DIR}/bin/run-broker-tests.sh
echo "Errand sanity-test broker is complete"

exit 0
