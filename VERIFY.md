#### Services verification
Although the services talking between each other on an internal Docker network, it is
valuable to expose those ports on the Docker host in a dev environments. 
it makes life easy when u can check API calls from the host machine itself , or maybe
remotely on the network.

#### Verification notes:

```
# Burrow
curl http://localhost:8000/v3/kafka

# Kafka-minion
curl http://localhost:7070/metrics

# Burrow-dashboard:
# using web browser: 
#   http://localhost:90 , choose 'local' kafka cluster.

# Kafka_exporter
curl http://localhost:8880/metrics

# Prometheus
curl http://localhost:9090/metrics
# using web browser: 
#   http://localhost:9090
#     check status->targets (2 should be up)

# Grafana
# using web browser: 
#   http://localhost:3000 (admin:secret)
#   prometheus datasorce should be provisioned

```
