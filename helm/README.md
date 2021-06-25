# My Helm Charts

This repository contains Helm charts for various projects

* [blacklist-ephemeral](charts/blacklist-ephemeral/)
* [blacklist-persistent](charts/blacklist-persistent/)

## Installing Charts from this Repository

Add the Repository to Helm:

    helm repo add my-helm-charts https://github.com/gary-crowe/helm-charts

Install Application 1:

    helm install helm-charts/blacklist-ephemeral

Install Application 2:

    helm install helm-charts/blacklist-persistent

