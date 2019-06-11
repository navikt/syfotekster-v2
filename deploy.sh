#!/usr/bin/env bash

version="$(date +'%m.%d.%H%M')-$(git rev-parse --short HEAD)"
echo "$version"

docker build --build-arg version=latest --build-arg app_name=syfotekster-v2 -t "repo.adeo.no:5443/syfo/syfotekster-v2:$version" .

docker push "repo.adeo.no:5443/syfo/syfotekster-v2:$version"

sed -e "s/{{VERSION}}/$version/g" nais.yaml > dist-nais.yaml

kubectl apply --context dev-fss --namespace default -f dist-nais.yaml

kubectl --context dev-fss --namespace default rollout status -w deployment/syfotekster-v2
