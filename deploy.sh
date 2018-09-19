#!/bin/bash

set -euo pipefail

docker build . -t gcr.io/mechmania2017/tv:latest
docker push gcr.io/mechmania2017/tv:latest
kubectl delete deployments/tv
sleep 4
kubectl apply -f app.yaml