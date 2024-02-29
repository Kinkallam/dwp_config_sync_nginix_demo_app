# Nginx Demo App

Nginx demo is a tiny web application for testing Kubernetes deployments to Linux nodes.

## Configuration

The following tables lists the configurable parameters of the Nginx Demo App chart and their default values.

Parameter | Description | Default
--- | --- | ---
`replicaCount` | desired number of pods | `1`
`image.pullPolicy` | image pull policy | `IfNotPresent`
`image.repository` | image repository | `acrdwpuksdevtintaks.azurecr.io/nginx-demo-app`
`image.tag` | image tag | `latest`
`imagePullSecrets` | secret for pulling images | `[]`
`serviceAccount.create` | enabled service account creation | `true`
`serviceAccount.name` | name for the service account | None
`serviceAccount.automountToken` | enabled automount of service account token | `false`
`envVars` | pod environment variables | `environment: dev`
`livenessProbe.httpGet.path` |  | `/`
`livenessProbe.httpGet.port` |  | `http`
`livenessProbe.periodSeconds` |  | `4`
`livenessProbe.timeoutSeconds` |  | `5`
`livenessProbe.failureThreshold` |  | `3`
`readinessProbe.httpGet.path` |  | `/`
`readinessProbe.httpGet.port` |  | `http`
`readinessProbe.timeoutSeconds` |  | `30`
`lifecycle` | pod lifecycle policies | `90 second sleep preStop`
`resources.requests/cpu` | pod cpu request | `25m`
`resources.requests/memory` | pod memory request | `32Mi`
`resources.limits/cpu` | pod cpi limit | `50m`
`resources.limits/memory` | pod memory limit | `64Mi`
`service.type` | type of service | `ClusterIP`
`service.port` | container port for the service | `80`
`hpa.enabled` | enables HPA creation | `false`
`hpa.maxReplicas` | maximum pod replicas | `2`
`hpa.cpu` | target CPU usage per pod | `90`
`hpa.memory` | target memory usage per pod | `90`
`ingress.enabled` | enables ingress creation | `false`
`ingress.annotations` | ingress annotations | `AGIC Annotations`
`ingress.path` | ingress Path configuration | `/`
`ingress.hosts` | ingress accepted hostnames | `nginx-demo.local`
`ingress.tls.secretName` | ingress tls secret name | `nginx-demo-tls`
`ingress.tls.hosts` | ingress tls accepted hostnames | `nginx-demo.local`
`networkPolicy.cidrRange` | Allows web traffic from CIDR | `10.86.42.0/28`
`podSecurityPolicy.enabled` | enables psp creation | `true`
`nodeSelector` | node labels for pod assignment | `agentpool: system`
`tolerations` | List of node taints to tolerate | `[]`
`affinity` | node/pod affinities | `{}`

Specify each parameter using the `--set key=value[,key=value]` argument to `helm install`. For example,

```console
$ helm install charts/nginx-demo --name nginx-demo \
  --set=image.tag=0.0.2,service.type=NodePort
```

Alternatively, a YAML file that specifies the values for the above parameters can be provided while installing the chart. For example,

```console
$ helm install charts/nginx-demo --name nginx-demo -f values.yaml
```

> **Tip**: You can use the default [values.yaml](values.yaml)

# Helm Chart Deployment Guide

## Overview

This repository contains a Helm chart for deploying [Your Application] to Kubernetes clusters. The chart supports deployment to both Google Kubernetes Engine (GKE) and Amazon Elastic Kubernetes Service (EKS).

## Prerequisites

- [Helm](https://helm.sh/docs/intro/install/)
- [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/)
- Access to a GKE cluster and an EKS cluster
- Docker image stored in a private registry

## Configuration

## GKE Deployment

For deploying to GKE, use the values-gke.yaml file to configure the Helm chart. This file contains GKE-specific configurations.

Before deploying to GKE, ensure that you have access to the GKE cluster. Since the GKE cluster is private, a VM has been created in the same network (dwptst-dev-net-spoke-0 project). SSH into the VM, and all the prerequisites are available there.

### Connect to the GKE cluster using the following command:


```console
gcloud container clusters get-credentials dev-gke-ew2-0 --zone=europe-west2-c --project=dwptst-dev-gke-0
```

After connecting to the GKE cluster, run the Helm install command to deploy the chart with the values-gke.yaml file:

```markdown
helm install nginx-test-gke ./ -f values-gke.yaml
```

**EKS Deployment:**

For deploying to the attached EKS cluster, use the values-eks.yaml file to configure the Helm chart. This file contains EKS-specific configurations.

To connect to the attached EKS cluster, follow these steps:

Connect to the EKS cluster from your local machine.

```console
gcloud container fleet memberships get-credentials cmod-ff-test-eks-cluster-01 --project dwptst-dev-gke-0
```

Run the Helm install command to deploy the chart with the values-eks.yaml file:

```markdown
helm install nginx-test-eks ./ -f values-eks.yaml
```

> **Note**: For EKS deployment, a Kubernetes secret(registry-secret) is used to pull the image from the private registry. This secret is created with the service account key.
