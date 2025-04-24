# Numaflow Issue: The idle watermark has a larger offset from the head idle watermark

Minimal reproducible example for numaflow issue [#2569](https://github.com/numaproj/numaflow/issues/2569).

## Prerequisites

`kind`, `kubectl`, `skaffold`

## Install

```bash
make install
make pipeline
```

## Test

Verify that output logs a constantly printing warning *"The idle watermark has a larger offset from the head idle watermark"*.

```bash
$ kubectl logs -f pipeline-log-output-0-[...]
...

2025/04/11 09:30:43 (log-output)  Payload -  count=0  Keys -  []  EventTime -  1744363839283  Headers -    ID -  samplemapper-1-0-0
2025/04/11 09:30:44 (log-output)  Payload -  count=5  Keys -  []  EventTime -  1744363844107  Headers -    ID -  samplemapper-6-0-0
{"level":"info","ts":"2025-04-11T09:30:45.171382071Z","logger":"numaflow.Sink-processor","caller":"fetch/processor_manager.go:213","msg":"Successfully added a new fromProcessor","pipeline":"pipeline","vertex":"log-output","fromProcessor":"pipeline-samplemapper-0"}
2025/04/11 09:30:47 (log-output)  Payload -  count=10  Keys -  []  EventTime -  1744363847283  Headers -    ID -  samplemapper-11-0-0
2025/04/11 09:30:51 (log-output)  Payload -  count=15  Keys -  []  EventTime -  1744363851107  Headers -    ID -  samplemapper-16-0-0
{"level":"warn","ts":"2025-04-11T09:30:52.117897993Z","logger":"numaflow.Sink-processor","caller":"timeline/offset_timeline.go:141","msg":"The idle watermark has a larger offset from the head idle watermark","pipeline":"pipeline","vertex":"log-output","idleWatermark":1744363841107,"existingOffset":6,"inputOffset":8}
2025/04/11 09:30:54 (log-output)  Payload -  count=20  Keys -  []  EventTime -  1744363854107  Headers -    ID -  samplemapper-21-0-0
{"level":"warn","ts":"2025-04-11T09:30:56.120050603Z","logger":"numaflow.Sink-processor","caller":"timeline/offset_timeline.go:141","msg":"The idle watermark has a larger offset from the head idle watermark","pipeline":"pipeline","vertex":"log-output","idleWatermark":1744363843283,"existingOffset":8,"inputOffset":10}
2025/04/11 09:30:57 (log-output)  Payload -  count=25  Keys -  []  EventTime -  1744363857283  Headers -    ID -  samplemapper-26-0-0
{"level":"warn","ts":"2025-04-11T09:30:58.117136488Z","logger":"numaflow.Sink-processor","caller":"timeline/offset_timeline.go:141","msg":"The idle watermark has a larger offset from the head idle watermark","pipeline":"pipeline","vertex":"log-output","idleWatermark":1744363846107,"existingOffset":10,"inputOffset":12}
```