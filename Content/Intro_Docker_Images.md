## First Dockerfile


flask hello world app
copy file to container and build it

Flask hello world

```bash
FROM ubuntu:latest
RUN apt-get update -y \
    && apt-get install -y python-pip python-dev build-essential
COPY ./app.py /app
COPY ./requirements.txt /app
WORKDIR /app
RUN pip install -r requirements.txt
ENTRYPOINT ["python"]
CMD ["app.py"]
```


## Building via container

using a container to build a Go app
create an image that will use app binary

 
## Building with Maven

```bash
mvn package -Pdocker
```

