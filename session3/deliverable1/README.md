# Deliverable 1: WordPress + MariaDB with Canary

## Create a namespace

* Use deployments to create WP+MariaDB
* You will need to set some env. variables
* Use configMap to configure the apps
* Use secrets for sensitive data
* Add Liveness & Readiness Probes on your containers.
* Create the corresponding services to access WordPress

### Canary Deployment

* Consider WP 5.3.1 the stable version
* Use WP 5.3.2 for the canary


## Solution proposed

### Current solution has several parts:

1. ConfigMaps and Secrets

Created a folder config where are located a configMap and secret files for mariadb deployment and another couple of files for wordpress deployment.

Enable all of them using the following command:

```
kubectl create -f deployments/
```

2. Services

There was created a service of type 'ClusterIP' for expose mariadb database access and also a 'NodePort' service to expose wordpress website. Both of the are inside services folder and can be activated using the following command:

```
kubectl create -f services/
```

3. Deployments

Inside deployments folder there area two YML files declaring the wordpress and mariadb specs. Those specs make use of environment variables declared previously in configMaps and secrets. These deployment and their corresponding configMaps, secrets and services are declared inside a custom namespace 's3d1' (from session3, delivery1). 
There was also created liveness and radiness probes for these deployments. For mariadb, it was used a TCP socket check in port 3306 port for liveness check and a custom mysql command for readiness check. In the case of wordpress, it was created a TCP socket check in port 80 for liveness check and a httpGet to website root for readiness check.

They can be deployed using command:

```
kubectl create -f deployments/
```

4. Canary deployment

Canary deployment was created to update wordpress version from 5.3.1 to 5.3.2. It is located in canary-deployment folder and can be deployed using following command:

```
kubectl create -f canary-deployment/
```

Initially there are created two replicas of 'stable' wordpress deployment and new 'canary' deployment has only one. If everything goes well with new deployment, the initial proportion could be modified to increase the amount of canary replicas and decrease the previous stables ones until completely remove old versions and new canary deployment belongs the new 'stable' one.

5. Confirmation

To check working website, it is needed to confirm first what is the IP of the kubernetes cluster with this command:

```
minikube ip
```

And check what is the port where it is exposed the wordpress website checking column PORT(S) in row named 'wordpress-service' it in services:

```
kubectl get svc --namespace=s3d1
```

Finally, if (hopefully) all worked ok, the wordpress website can be accessed in http://<minikube-ip>:<wordpress-service-port>