- burrow
curl http://localhost:8000/v3/kafka

- kafka-minion
curl http://localhost:7070/metrics

- dashboard:
web: http://localhost:90 , choose 'local' kafka cluster.

- kafka_exporter
curl http://localhost:8880/metrics

- prometheus
curl http://localhost:9090/metrics
web: http://localhost:9090, check status->targets (2 should be up)

- grafana
web: http://localhost:3000, prometheus datasorce should be provisioned

