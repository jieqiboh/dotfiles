## Docker Image for CTFs
- OS: Ubuntu
- Command:
docker run -it --name Assg1Container -v /Users/jieqiboh/Documents/Assg1ContainerFiles:/home --platform linux/amd64 --cap-add=SYS_PTRACE --security-opt seccomp=unconfined --security-opt apparmor=unconfined ubuntu /bin/bash

### Some neat resources
[Harvard CS61 Dockerfile (Create containers compiled for gdb on M1 Mac)](https://github.com/cs61/cs61-lectures/tree/main/docker)

## daniellim ctftools docker container cmd
docker run --rm   
-v $(pwd):/root/ctfs  
-p 80:80   
--platform linux/amd64  
--cap-add=SYS_PTRACE   
--security-opt   
seccomp=unconfined  
--security-opt   
apparmor=unconfined  
-d   
--name ctf  
-it daniellim/ctftools2004  

### Overview of some Options  
-v: Specifies volume to mount  
--platform: Specifies the specific architecture. Some options include (linux/amd64, linux/arm64, linux, etc)  
--cap-add=SYS_PTRACE: Addition of certain linux capabilities to the container, particularly system process tracing.  
seccomp=unconfined: Allows container to make a broader range of syscalls without restrictions  
apparmor=unconfined: Apparmor is a linux kernel security module  
-it: Combines 2 separate options. -i means interactive, keeping the stdin of the container open if if not attached. -t means teletypewriter, and opens a cmdline to interact with the container

## Common Docker Commands:
`docker run [OPTIONS] IMAGE [COMMAND] [ARG...]`    
Creates and starts a container from an existing image

`docker ps`  
Lists all currently running containers

`docker stop CONTAINER`  
Stops a running container

`docker logs CONTAINER`  
Shows the logs in a running container

`docker exec -it CONTAINER [COMMAND] [ARG...]`  
Runs a command inside a running container  
e.g. `docker exec -it e10b /bin/bash`

`docker pull IMAGE[:TAG]`  
Pulls an image from dockerhub

