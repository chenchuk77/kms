# KMS : Kafka Monitoring Stack

## Introduction
KMS is a collection of kafka tools for monitoring and visualizing a Kafka cluster status.

### Project target
After a lot of search about how to monitor kafka, it turns out that there are many ways but it was very difficult to setup the configiration.
The project target is to create a simple and robust environment running those tools

### KMS containers roles
* Burrow:
  * Burrow connects to Kafka brokers and Zookeeper hosts
  and gather data about Kafka.
  * Expose REST api at http://localhost:8000/v3/kafka
  * [README.md](https://github.com/chenchuk77/kms/blob/master/Burrow/README.md)
* Burrow-dashboard
  * Angular JS frontend.
  * Consumes the Burrow's REST api's.
  to provide kafka statistics and graphs.
  * [README.md](https://github.com/joway/burrow-dashboard/blob/master/README.md)
* Burrow-exporter
  * Burrow by itself cannot expose its data as prometheus
  formatted metrics.
  * Acts as data transformer.
  * Scrapes Burrow and expose its data as prometheus
  formatted metrics.
  * [README.md](https://github.com/jirwin/burrow_exporter/blob/master/README.md)
* Kafka-minion
  * Scrapes directly from Kafka brokers.
  * Not using zookeeper.
  * a different approach from Burrow.
  * equivalent to Burrow + Burrow-exporter.
  * [README.md](https://github.com/chenchuk77/kms/blob/master/kafka-minion/README.md)
* Prometheus
  * Acts as a datasource for Grafana.
  * Aggregates all metrics from downstream targets.
  * Expose Burrow metrics and Kafa-minion metrics.
  * [README.md](https://hub.docker.com/r/prom/prometheus)
* Grafana
  * Visualization of data.
  * Graphs, Alerts, Dashboards, Queries, etc.
  * Uses Prometheus as datasource.
  * [README.md](https://github.com/grafana/grafana/blob/master/README.md)

### KMS structure
KMS uses docker-compose technology to wire up the underlying docker containers. the docker-compose.yml file contains the KMS services and configurations.

### default setup
the 'complete' setup is used by default (6 containers). if u want a different setup, just comment out the unnecesary services from docker-compose.yml 

### dependencies
a running kafka is required.

### Environment setup options
KMS monitors kafka in 3 different ways:
1. Using Burrow and Burrow-Dashboard
2. Using Burrow on Grafana
3. Using Kafka-minion on Grafana

##### Burrow standalone dashboard 
* burrow pull/exposes kafka data
* burrow-dashboard visualizes burrow
##### Kafka-minion on Grafana
* kafka-minion scrapes kafka
* prometheus scrapes kafka-minion
* grafana visualizes prometheus
##### Burrow on Grafana
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
##### Complete
* burrow pulls/exposes kafka data
* burrow-dashboard visualizes burrow
* burrow-exporter scrapes burrow
* prometheus scrapes burrow-exporter
* kafka-minion scrapes kafka
* prometheus scrapes kafka-minion
* grafana visualizes prometheus

### How KMS built
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

## Running KMS
```
$ ./start-kms.sh
```


## Authors
* **Chen Alkabets** - *Initial work* - [chenchuk77](https://github.com/chenchuk77)

### Licenses
KMS is a collection of 3 forked projects (and 3 another 3 pre-built images). 
Each forked project has its own license untouched as appeared when forked. 
Im not taking any credit for those. With that said, This project is all about 
orchestration of multi-container services using Docker-compose technology.
* [Burrow](https://github.com/linkedin/Burrow) - Kafka Consumer Lag Checking.
* [Burrow-dashboard](https://github.com/joway/burrow-dashboard) - Kafka Dashboard for Burrow.
* [Burrow_exporter](https://github.com/jirwin/burrow_exporter) - Prometheus exporter for burrow.
* [Kafka-minion](https://github.com/cloudworkz/kafka-minion) - Prometheus exporter for Apache Kafka.
* [Prometheus](https://hub.docker.com/r/prom/prometheus) - Systems and service monitoring system.
* [Grafana](https://github.com/grafana/grafana) - Grafana allows you to query, visualize, alert on and understand your metrics.

### Tips and notes
* burrow-on-grafana setup has extra container. this is because burrow cant expose metrics in Prometheus format. 
* note the convention through this project for clarification:
  * kafka data - row data from kafka
  * kafka metrics - prometheus formated data
  * scrape - read data and expose as prometheus formatted metric. 

### TODOs
* Support dynamic kafka zookeeper connection-string (variable num of brokers)
* Add system picture
* Support profiles (setup )

