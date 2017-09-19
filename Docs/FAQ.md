**Q: How do I know if I have Docker installed and running properly?**

Run: ``docker run hello-world``, and you should have a similar output:

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

**Q: Is there a place where I can easily find all commands, dockerfile references, etc.?**

This could be a good starting point, but pay attention to deprecated notes as Docker has changed quite a bit in the last years: https://github.com/wsargent/docker-cheat-sheet

