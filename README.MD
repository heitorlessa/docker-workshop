
This is a crash course on Docker, development workflow and Docker on AWS. It's intended to be practical, informal and allow time for questions at any point in time.

> NOTE: Content is only for the hands-on part, and all theory is covered through presentations.

Topic | Description | Level
------------------------------------------------- | --------------------------------------------------------------------------------- | -------------------------------------------------
Intro to Docker | Introduction to Docker terminologies, including Docker Registry and some hands-on | Beginner
Docker Images | Building your first Docker Image via Dockerfile | Beginner
Break | 10 minutes break | N/A
Docker Networking | Introduction to Linking, Network and Overlay networks | Intermmediate
Local development workflow | Quick intro to Docker compose, pushing first image | Intermmediate
Break | 10 minutes break | N/A
Intro to EC2 Container Service | Intro to Orchestration, ECS, EC2 Container Registry and first cluster | Advanced
Automating Docker deployments | Building your first deployment pipeline | Advanced

## Requirements

1. Create AWS Accounts
2. Bootstrap AWS Accounts
3. Pull the following images ahead of time
    - `docker pull busybox`
    - `docker pull ubuntu`
    - `docker pull golang:1.8`
    - `docker pull python`
    - `docker pull redis`
    - `docker pull postgres`
    - `docker pull jpetaz`
4. Create EC2 Instance using [ECS Optimized AMI](docs.aws.amazon.com/AmazonECS/latest/developerguide/ecs-optimized_AMI.html)

