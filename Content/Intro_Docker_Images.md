## First Dockerfile


We'll create our first new image on top of `Ubuntu` using a simple `Python Flask`. 

To do this, create a new file named `Dockerfile` and use the following contents:

```dockerfile
FROM ubuntu:latest
RUN apt-get update -y \
    && apt-get install -y python-pip python-dev build-essential
COPY ./app.py /app/
COPY ./requirements.txt /app/
RUN pip install -r /app/requirements.txt
CMD ["python", "/app/app.py"]
```

Create the following files exactly where you created your `Dockerfile` as they'll be copied into your Docker image upon build:

**app.py**

```python
from flask import Flask
from flask import jsonify
app = Flask(__name__)

@app.route('/')
def hello_world():
    message = {
    	"message": "Flask in Docker!!!"
    }

    return jsonify(message)

if __name__ == '__main__':
    app.run(debug=True,host='0.0.0.0')
```

**requirements.txt**

```python
Flask==0.12.2
```

Let's now go ahead and build your first docker image by running:

```bash
docker build -t "flask-hello" .
```

If everything went OK, you should end up with similar message at the bottom:

```bash
Removing intermediate container 858e0bb5f172
Step 6/6 : CMD python /app/app.py
 ---> Running in f53090a507ce
 ---> 97b0a3b653f0
Removing intermediate container f53090a507ce
Successfully built 97b0a3b653f0
Successfully tagged flask-hello:latest
```

Let's run this container and access it right after:

```bash
docker run -d -p 80:5000 flask-hello
```

You should now be able to access this Flask application by either opening the browser on `localhost:80` or simply using cURL:

```bash
curl localhost:80 -v
```

> **Something to try out**

* Find out how big this image is
* Add metadata into this image to tell who the owner is


### Quick optimizations

As you probably noticed this image is quite big for simply returning a hello world message. There are several ways we could optimize this, but for now, replace Dockerfile contents with the following and let's dive into what that means:

```dockerfile
FROM python:3.6.2-alpine
COPY app.py /app/
COPY requirements.txt /app/
WORKDIR /app
RUN pip install --no-cache-dir -r requirements.txt
EXPOSE 5000
ENTRYPOINT ["python", "app.py"]
```

Here's the optimizations we've done:

Optimization | Description
------------------------------------------------------------------------------ | --------------------------------------------------------------------------------- 
**FROM python:3.6.2-alpine**| Alpine is a minimalist Linux OS that helps us reduce Docker images considerably, and this already has python installed
**WORKDIR /app** | Workdir works similar to `cd` as it allows us to change the current directory so we can remove `/app` preffixes
RUN pip install **--no-cache-dir** -r requirements.txt | ``--no-cache-dir`` ensures pip doesn't save any dependencies locally in the docker image filesystem
EXPOSE 5000 | Exposes default Flask port so it can be automatically exposed when using `docker -P` and can also be inspected at runtime
ENTRYPOINT ["python", "app.py"] | Entrypoint is commonly used to run scripts or to orchestrate multiple steps needed before running an application - Also useful to easily override at container runtime with `--entrypoint=<newValue>`


## Building via container


To understand why this is useful, let's first have a look at the official [Golang Docker Hub page](https://hub.docker.com/_/golang/)

Without this, this is how a Dockerfile that only builds a static go binary would look like

```dockerfile
FROM golang:latest 
RUN mkdir /app 
ADD . /app/ 
WORKDIR /app 
RUN go build -o main .
RUN CGO_ENABLED=0 GOOS=linux go build -a -tags netgo -ldflags '-w' -o app . 
```

From here, you'd have to create a new image from this Dockerfile, and run it in order to build a new app. But what if we could simply build at runtime and have a static file generated in any directory once the execution finishes?

Let's try this - Create a new file called `main.go` with the following contents:

```golang
package main

import (
        "fmt"
        "net/http"
        "runtime"
)

func indexHandler(w http.ResponseWriter, r *http.Request) {
        fmt.Fprintf(w, "hello world, I'm running on %s with an %s CPU ", runtime.GOOS, runtime.GOARCH)

}

func main() {
        http.HandleFunc("/", indexHandler)
        http.ListenAndServe(":8080", nil)
}
```

Let's now build a static binary out of it compiled to run on Linux:

```bash
docker run --rm \
    -v "$PWD":/usr/src/myapp \
    -w /usr/src/myapp \
    -e CGO_ENABLED=0 \
    -e GOOS=linux \
    golang:1.8 go build -a -tags netgo -ldflags '-w' -o app .
```

If everything went alright you should have a `app` executable in your current path. We can now use this in order to quickly cross-compile our app to multiple Operating Systems, and when we're ready we can simply create a minimal docker image that will be nearly as small as our static binary.

```dockerfile
FROM scratch
ADD app /
CMD ["/app"]
```

Finally, we can build a new image and run it thereafter:

```bash
docker build -t "minimal-go" .
docker run -it -d -p 80:8080 minimal-go
```


## Building with Maven

```bash
mvn package -Pdocker
```

