# 🐳 Docker commands to run the project
## 01. Build an image
```bash
docker build -t <image_name> ./directory/of/yours/dockerfile
```
Command to build this project: `docker build -t run_robot ./docker/docker_images`

#### 01.1. Query Docker images
```bash
docker images
```

#### 01.2. Remove a Docker image
```bash
docker rmi <image_name>
```

## 02. Start a container
```bash
docker run -itd --name <container_name> -v <local_directory_name>:<container_directory_name> <image_name>
```
* `-itd:` union of the commands `-it(--interactive)` and `-d(--detach)`. This command sends the user to the container (`-it`) and disengages the user from the same container (`-d`), allowing the container to be able to run even without an running application, [stackoverflow/what-is-docker-run-it-flag](https://stackoverflow.com/questions/48368411/what-is-docker-run-it-flag)
* `--name:` informs a name to the container
* `-v:` creates a storage space inside the container, but aside from the container files system, (*[medium.com/@BeNitinAgarwal/docker-containers-filesystem](https://medium.com/@BeNitinAgarwal/docker-containers-filesystem-demystified-b6ed8112a04a)*)
* `${pwd}:` project source directory

Command to start this project container: `docker run -itd --name robot_container -v ${pwd}/features:/opt/robotframework/tests -v ${pwd}/output:/opt/robotframework/reports run_robot`

#### 02.1. Inspect container
```bash
docker inspect <container_name>
```

## 03. Run command inside container
The command bellow only works inside a running container, *[docker exec](https://docs.docker.com/engine/reference/commandline/exec/)*.
```bash
docker exec <options> <container_name> <command>
```
`options`: tags can be used to refine commands inside the docker. *[Options list](https://docs.docker.com/engine/reference/commandline/exec/#options)*.
Command to run all tests suites: `docker exec -it robot_container python3 -m robot -d /opt/robotframework/reports /opt/robotframework/tests`

#### 03.1. Stop container
```bash
docker container stop <nome_do_container>
```

#### 03.2. Remove container
```bash
docker container rm <nome_do_container>
```

---
**Solutions for some possible problmes that can show up:**
| | Problem | Solution |
|---|---|---|
| 1 | invalid reference | The issue was solved by informing the volumes' local windows directory using linux path nomenclature, that is, using slash `/` instead of backslash `\`. Since you are using linux nomenclature, there is no need to use quotes in the command. |
| 2 | unable to find image `<image>` locally | This problem was resolved by removing the image version tag (using `<image>` instead of `<image>:latest`). |
| 3 | "robot": executable file not found in $PATH: unknown | Adding `python3 -m` in the command used to run the robot files, so the container can understand that this command needs to use `python3` to work and, through `-m` tag, it will run a module, in this case the module it is the robot.
---