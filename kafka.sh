# Version kafka:2.5.0

# linger.ms (old queue.buffering.max.ms)
```
bin/kafka-console-producer.sh --broker-list kafka-1-kafka-bootstrap:9092 --topic my-topic --producer-perty linger.ms=100

bin/kafka-console-consumer.sh --bootstrap-server kafka-1-kafka-bootstrap:9092
```
