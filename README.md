# GCP-Final-Task

The hiararchy of the project as follows:
1. build image for python-web application
2. push the image and redis image to the Google Container Registry
3. Using Terraform to build infrastructure on GCP
4. set up GKE cluster 
5. deploy the images on GKE

## Python-web-app
                      the docker file 
![This is an image](https://github.com/enggamal/gcp-final-task/blob/main/python-app/dockerfile.png)

                       the docker-compose file
![This is an image](https://github.com/enggamal/gcp-final-task/blob/main/python-app/docker-compose)
             
                       the image of app on browser 
![This is an image](https://github.com/enggamal/gcp-final-task/blob/main/python-app/python-app-web.png)

## the infrastracrure using terraform 




## deplyments and services on KGE

python-deployment

![This is an image](https://github.com/enggamal/gcp-final-task/blob/main/yaml-files/python-dep-yaml.png)

the nodeport service

![This is an image](https://github.com/enggamal/gcp-final-task/blob/main/yaml-files/node-port-service.png)

the redis deployment 

![This is an image](https://github.com/enggamal/gcp-final-task/blob/main/yaml-files/redis-dep.png)

the cluster ip dervice

![This is an image](https://github.com/enggamal/gcp-final-task/blob/main/yaml-files/cluster-ip.png)

the load balancer service

![This is an image](https://github.com/enggamal/gcp-final-task/blob/main/yaml-files/lb-service.png)

the app 0n web 

![This is an image](https://github.com/enggamal/gcp-final-task/blob/main/yaml-files/app-on-web.png)
