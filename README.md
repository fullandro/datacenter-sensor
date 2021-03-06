# datacenter-sensor


### Introduction

This repository supports [my Dockercon talk and demo](http://dockercon2016.sched.org/event/6CF1)

> **Docker and IoT securing the server-room with realtime microservices by Alex Ellis**

> In this hack, we secure the data-center through a scaleable network of real-time sensors and microservices running Docker. Each rack in the server-room is filled with thousands of terabytes of priceless customer data, IoT lets us keep one step ahead and keep that data safe. The cluster deploys a set of smart sensors running the Docker Swarm agent to the rack panels.

> Each sensor constantly samples the ambient temperature of the rack and sends a real-time alarm to the control room when levels rise above normal levels. An anti-tamper motion sensor picks up tiny vibrations and alerts the admins when someone is performing unscheduled maintenance on the equipment. A custom made RGB LED display made by Pimoroni for Dockercon shows the status of up to 8 racks in real-time.

![Swag](https://c3.staticflickr.com/8/7126/27279846650_da0c806fc1_c.jpg)

### Producing the Hack

**Thanks for the support**

A large percentage of the hardware for this hack is being supplied by [Pimoroni.com](http://pimoroni.com) - so a huge thanks to them for helping out. They also designed a brand new add-on board for the Raspberry Pi with 8 RGB LEDs just for this demo and gave me early access to their environmental sensing board - envirophat.

Come to the live demo at Dockercon for all the rest of the details. We'll have a time for Q&A come prepared!

### See also: original Dockercon hack entry

[Visualizing a production-ready load-balancer with LEDs and Docker Swarm](http://blog.alexellis.io/iot-docker-cluster/)

### Contributions

I'm not accepting pull-requests to the demo code at present, but feel free to fork it or re-use elements in your own projects in-line with the MIT license. 

### Booting up the demo

#### Step 1

Log into the manager and start the Docker Swarm manager image and consul as a key-value store with this shell script:

```
$ datacenter-sensor/start_manage.sh
```

#### Step 2

Log into each additional Pi Zero and launc the Swarm Agent:

```
$ datacenter-sensor/join/auto_join.sh
```

> The Consul IP address has to be hard-coded into the systemd docker.service file and this batch file.

#### Step 3

Enter: Docker-compose

Point the DOCKER_HOST environmental variable to the swarm manager and type in:

```
$ export DOCKER_HOST=tcp://manager1.local:2376

$ docker-compose up -d
```

#### Step 4

Then once running you can scale up the sensor service to the number of sensor Pis in your network.

```
$ docker-compose scale sensor=4
```

#### Step 5

Profit.

If you want to open the web-dashboard, then use `docker-compose ps` to find where it has been placed in the swarm and which port has been dynamically assigned to it.

When you're done you can use `docker-compose stop` to pause the demo or `docker-compose down` to clean everything up. 

### Sneak previews:

Descending date of release.

* [Starting up the demo - LED animations](https://twitter.com/alexellisuk/status/742411122591051777)
* [Scaling-up monitoring two sensors](https://twitter.com/alexellisuk/status/741224768087674880)
* [Detecting motion](https://twitter.com/alexellisuk/status/740824510849503232)
* [Detecting temperature and showing alerts](https://twitter.com/alexellisuk/status/739736197442981888)
* [Unicorn pHAT making rainbows](https://twitter.com/alexellisuk/status/739557889854066688)
