# kStreams

## Table of content
1. KStreamsApp1: demo kStreams project to do a simple join of two topics
2. KStreamsApp2: demo kStreams project to ...


### Project KStreamsApp1: KStreamJoinDemo.java

This demo project shows how to create a KStreams Application to (stream-)join two Kafka topics. With every new message ... Note: KStream - KTable join ...

0. Pre-requisites
```
import org.apache.kafka.clients.consumer.ConsumerConfig;
import org.apache.kafka.common.serialization.Serdes;
import org.apache.kafka.streams.KafkaStreams;
import org.apache.kafka.streams.StreamsBuilder;
import org.apache.kafka.streams.StreamsConfig;
import org.apache.kafka.streams.kstream.KStream;
import org.apache.kafka.streams.kstream.KTable;
import org.apache.kafka.streams.kstream.Produced;
import org.apache.kafka.streams.kstream.JoinWindows;

import java.util.Arrays;
import java.util.Locale;
import java.util.Properties;
import java.util.concurrent.CountDownLatch;
```

1. Define properties
```
Properties props = new Properties();
props.put(StreamsConfig.APPLICATION_ID_CONFIG, "KstreamsJoinDemo");
props.put(StreamsConfig.BOOTSTRAP_SERVERS_CONFIG, "localhost:9092");
props.put(StreamsConfig.CACHE_MAX_BYTES_BUFFERING_CONFIG, 0);
props.put(StreamsConfig.DEFAULT_KEY_SERDE_CLASS_CONFIG, Serdes.String().getClass().getName());
props.put(StreamsConfig.DEFAULT_VALUE_SERDE_CLASS_CONFIG, Serdes.String().getClass().getName());
props.put(ConsumerConfig.AUTO_OFFSET_RESET_CONFIG, "earliest");
```

2. Use StreamsBuilder to create KStream and KTable (having defined underlying topics)
```
StreamsBuilder builder = new StreamsBuilder();

KStream<String, String> sourceLeft = builder.stream("input-topic-left");
KTable<String, String> sourceRight = builder.table("input-topic-right");
```

3. Use StreamsBuilder to create KStream and KTable (having defined underlying topics)
```
StreamsBuilder builder = new StreamsBuilder();

KStream<String, String> sourceLeft = builder.stream("input-topic-left");
KTable<String, String> sourceRight = builder.table("input-topic-right");
```

4. Define join logic
```
join.to("join-topic-output",Produced.with(Serdes.String(), Serdes.String()));
```

5. Create and run KafkaStreams
```
       final KafkaStreams streams = new KafkaStreams(builder.build(), props);
        final CountDownLatch latch = new CountDownLatch(1);

        // attach shutdown handler to catch control-c
        Runtime.getRuntime().addShutdownHook(new Thread("KstreamsJoinDemo-shutdown-hook") {
            @Override
            public void run() {
                streams.close();
                latch.countDown();
            }
        });

        try {
            streams.start();
            latch.await();
        } catch (Throwable e) {
            System.exit(1);
        }
        System.exit(0);
    }
```