# pi-gen-expand

此工程用于自动生成适配多个设备的树莓派系统。可以在workflow中指定设备和配置，然后自动生成对应的树莓派系统。

## 镜像下载

| Name                  |   username & password   | enable-ssh |        stage-list       |      date      |
|-----------------------|-------------------------|------------|-------------------------|----------------|
| raspberrypi-arm64     | pi & raspberry          | 1          | stage0 stage1 stage2 stage3 stage4 stage4a | [2024-06-24](https://github.com/is-qian/pi-gen/actions/runs/9641251531/artifacts/1630637877)|
| reTerminal-arm64      | pi & raspberry          | 1          | stage0 stage1 stage2 stage3 stage4 stage4a | [2024-07-03](https://github.com/is-qian/pi-gen/actions/runs/9772615711/artifacts/1662620401)|
| reTerminal-plus-arm64 |                         |            |                         |   [DATE](NULL) |
| reComputer-R100X-arm64|                         |            |                         |   [DATE](NULL) |
| reComputer-R100x-arm64 | recomputer & 12345678   | 1          | stage0 stage1 stage2 stage3 stage4 stage4a | [2024-07-03](https://github.com/is-qian/pi-gen/actions/runs/9772615640/artifacts/1662611671)|

