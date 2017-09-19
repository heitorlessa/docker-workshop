## Hello-world

Let's first ensure you have Docker properly configured and running by launching a hello-world container:

```bash
docker run hello-world
```

If everything worked as expected you should have a similar output:

```bash
...
docker run hello-world
Unable to find image 'hello-world:latest' locally
latest: Pulling from library/hello-world
....

Hello from Docker!
This message shows that your installation appears to be working correctly.

To generate this message, Docker took the following steps:
 1. The Docker client contacted the Docker daemon.
 2. The Docker daemon pulled the "hello-world" image from the Docker Hub.
 3. The Docker daemon created a new container from that image which runs the
    executable that produces the output you are currently reading.
 4. The Docker daemon streamed that output to the Docker client, which sent it
    to your terminal.
...
```

## Interacting with the container

Although hello world worked, wouldn't be nice if we could get access to the container OS and explore what we can do with it?

Depending on how an image was built we can pass commands to the Docker container, and with that in mind we could potentially get access to Linux shell by passing `/bin/sh` - Let's try this with a minimalist image called `busybox`.

```bash
docker run -it busybox /bin/sh
```

> **Something to try out**

* Check if you have network connectivity (hint: ping?)
* Create a file with any content; exit and re-run the container
* Instead of `exit` try to `detach` from your interactive session
    - If succeeded, try `attach` to the same session
    - Perhaps even try to `stop` the container

Since `busybox` is often used in embedded system you won't find much else to play with, but should be enough to get a basic understanding of a container for now. Let's try the very same technique but now using a more complete Linux distribution - **Ubuntu**:

```bash
docker run -it ubuntu /bin/bash
```

> **Something to try out**

* Try installing a web server (apache2, nginx?)
    - Are you able to access from the outside?
* Pass a script to automate web server installation to this container
* Check how big is this Ubuntu image
* Find out what files changed from original image (docker diff)
    - Try something smaller like installing `figlet`


## Running a container in the background

Most of the time you'll want to run an application or a job in a container in background mode, but how can you do that?

Let's try run a random springboot app:

```bash
docker run -d -p 8080:8080 ajitesh/springboot-web-app
```

We need to look at docker container logs to understand whether spring ran successfully or not:

```bash
docker logs -f <containerID>
```

> **Something to try out**

* Try launching a NGINX container in the same host port 8080
* Look up for Docker Maven
* Try out any image available within hub.docker.com
