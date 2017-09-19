## Docker related

**Detach from an interactive session**

* `CTRL+P` followed by `CTRL+Q`

This will only work if you launched a container with `-it` options otherwise it won't work.

**List existing images**

```bash
docker images
```

**Install a web server and cURL in Ubuntu oneliner**

```bash
apt-get update -y \
    && apt-get install nginx -y \
    && apt-get install curl -y \
    && service nginx start
```

**Map host port 8080 to 80 in container**

```bash
docker run -it -p 8080:80 ubuntu bin/bash
```

**Mount a single local file as a volume in a coantainer**

```bash
docker run -it -p 8080:80 -v /tmp/bootstrap.sh:/usr/local/src/bootstrap.sh ubuntu /bin/bash
```

**Continuously fetch the last 5 lines of logs**

```bash
docker logs --tail 5 -f <containerId>
```

**Launch a container within a network**

```bash
docker network create testing
docker run -d --net testing --name db redis
docker run -d --net testing --name app flask
```


**Remove all containers oneliner**

```bash
docker rm $(docker ps -a -q)
```

**Remove all docker images oneliner**

```bash
docker rmi $(docker images -q)
```

# AWS related


