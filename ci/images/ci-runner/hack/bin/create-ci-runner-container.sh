#!/usr/bin/env bash
set -o errexit
set -o nounset
set -o pipefail
set -x

MANIFEST_DIR=$(
    cd "$(dirname "$0")/../manifests";
    pwd;
)
kubectl -n default apply -k "$MANIFEST_DIR/sidecar"

kubectl -n default wait pod/ci-runner --for=condition=Ready --timeout=90s
kubectl -n default describe pod/ci-runner

echo
echo "KUBECONFIG:"
cat "$KUBECONFIG"
echo
echo "Connect to the ci-runner with: kubectl exec -n default --stdin --tty ci-runner -- bash"
echo
