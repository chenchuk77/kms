# KMS : Kafka Monitoring Stack

## Introduction
KMS is a collection of kafka tools for monitoring and visualizing a Kafka cluster status.

### Project target
After a lot of search about how to monitor kafka, it turns out that there are many ways but it was very difficult to setup the configiration.
The project target is to create a simple and robust environment running those tools

### Licenses
KMS is a collection of forked projects. each forked project has its own license untouched as appeared when forked.

### KMS containers

### KMS structure
KMS uses docker-compose technology to wire up the underlying docker containers. the docker-compose.yml file contains the KMS services and configurations.

### default setup
the 'complete' setup is used by default (6 containers). if u want a different setup, just comment out the unnecesary services from docker-compose.yml 

### dependencies
a running kafka is required

## Setup options
#### Burrow standalone dashboard 
* burrow pull/exposes kafka data
* burrow-dashboard visualizes burrow
#### Kafka-minion on Grafana
* kafka-minion scrapes kafka
* prometheus scrapes kafka-minion
* grafana visualizes prometheus
#### Burrow on Grafana
* burrow pulls kafka data
* burrow-exporter scrapes burrow
* prometheus scrapes burrow-exporter
* grafana visualizes prometheus
#### Both on Grafana
* burrow pulls kafka data
* burrow-exporter scrapes burrow
* prometheus scrapes burrow-exporter
* kafka-minion scrapes kafka
* prometheus scrapes kafka-minion
* grafana visualizes prometheus
#### Complete
* burrow pulls/exposes kafka data
* burrow-dashboard visualizes burrow
* burrow-exporter scrapes burrow
* prometheus scrapes burrow-exporter
* kafka-minion scrapes kafka
* prometheus scrapes kafka-minion
* grafana visualizes prometheus

### Building the KMS
##### Using pre-built images :
Some services can accept environment variables so there is no need to build a docker image 
(just pull and inject variables)

* Grafana
  * grafana folder contains provisioning files of preconfigured data source and dashboard. 
those files get mounted at container startup

* Prometheus
  * prometheus.yml config file get mounted at container startup

* Burrow-dashboard
  * Burrow's address set by environment variables at container startup

##### Other services must be build :
* Borrow
  * Dockerfile changed to use a different location for burrow.toml .
  * kafka and zookeeper addresses injected by docker-compose as build args 
    and replaced in the burrow.toml config file when building the docker image.

* Borrow-exporter
  * remove env vars from Dockerfile.
  * env vars injected by docker-compose as build args.
 
* Kafka-minion
  * building Dockerfile // TODO: check if necessary //.
  * env vars injected by docker-compose to the running container.

### Tips and notes
* burrow-on-grafana setup has extra container. this is because burrow cant expose metrics in Prometheus format. 


todo-dynamic connstring

