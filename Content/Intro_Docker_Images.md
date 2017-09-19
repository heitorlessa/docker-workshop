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


FROM ubuntu:latest
RUN apt-get update -y \
    && apt-get install -y python-pip python-dev build-essential
COPY ./app.py /app/
COPY ./requirements.txt /app/
RUN pip install -r /app/requirements.txt
CMD ["python", "/app/app.py"]

Here's the optimizations we've done:

Optimization | Description
------------------------------------------------------------------------------ | --------------------------------------------------------------------------------- 
**FROM python:3.6.2-alpine**| Alpine is a minimalist Linux OS that helps us reduce Docker images considerably, and this already has python installed
**WORKDIR /app** | Workdir works similar to `cd` as it allows us to change the current directory so we can remove `/app` preffixes
RUN pip install **--no-cache-dir** -r requirements.txt | ``--no-cache-dir`` ensures pip doesn't save any dependencies locally in the docker image filesystem
EXPOSE 5000 | 




## Building via container

using a container to build a Go app
create an image that will use app binary

 
## Building with Maven

```bash
mvn package -Pdocker
```

