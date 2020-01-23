# VS Code-server
Run VS Code on a Docker host or Kubernetes as Pods with tools and access to the cluster

## Running VS Code on a Docker host
### Building the container
If you want to build locally, you can simply run `./docker.build.sh`. If you want to push the Docker image to the Docker hub registry, edit the file `docker.build.sh` and change the organization from Praqma to one you have access to.

If you want to contribute a change to [praqma/vscode](https://hub.docker.com/repository/docker/praqma/vscode), see [Contributing](#Contributing).

### Running the container on a Docker host
Before running the container, edit the ```file docker.run.sh``` and change ```GIT_REPO``` to a repository you want cloned, ```PASSWORD``` to a password of your choice, ```CODE_PORT``` to the port you want VS Code to run on. Then run the start script:

```
./docker.run.sh
```

Open a browser and point it to localhost:[the port you chose]. If you didn't change anything, that would be localhost:5050

You will be met with a screen asking for a password:
![VSCode password screen](media/VSCode-password.png)

If you didn't change the password in ```docker.run.sh``` simply type ```praqma``` and hit ```Enter IDE```.

You should now see the VS Code  like this:
![VSCode screenshot](media/VSCode-screenshot.png)


## Deploying to Kubernetes
### Editing the YAML
#### Namespace
If you want to use a different namespace then workshopctl, then edit all files and change that field.

#### Ingress
First we need to edit the YAML. Start by editing the ```k8s-deploy/ingress.yaml```. Change the host field under rules to the url you want. I'm using MetalLB and Traefik with nip.io. If you dont have a DNS to point to the service, simply change the IP in the current hostname to the IP that is you Ingress controller. Then nip.io will resolve it to that.

#### Password
The password for VS Code is stored in a secret. Edit the file ```k0s-deploy/secret.yaml``` and change to password to whatever you want. Remember, it needs to be base64 encoded:

```
echo -n "new_Password" | base64
```

#### Deploy to Kubernetes
Now apply the YAML by running the script from the top folder.

```
./kubectl.apply.sh
```

Now open a browser and go to the url specified in the ```k8s-deploy/ingress.yaml``` file.


# Contributing
Create a branch, and make any change you want. Every commit you push will automatically be tested on [CircleCI](https://app.circleci.com/github/praqma-training/code-server/pipelines). Alternatively, you can run the tests locally. The only requirement is to have Docker installed, and then running the script: 
```bash
$ cd docker-images
$ ./test-with-dgoss.sh
Sending build context to Docker daemon  10.75kB
[ ...Docker build stuff goes here... ]
Successfully built 00da90588af1
Successfully tagged praqma/vscode:tmp
INFO: Creating docker container
INFO: Copy goss files into container
INFO: Starting docker container
INFO: Container ID: d68dcd2b
INFO: Found goss_wait.yaml, waiting for it to pass before running tests
INFO: Sleeping for 0.2
INFO: Container health
PID                 USER                TIME                COMMAND
22624               1000                0:00                dumb-init /entrypoint.sh
22663               1000                0:00                code-server --cert --host=0.0.0.0 --port=8080 --auth=password --disable-telemetry
22726               1000                0:00                /usr/local/bin/code-server --cert --host=0.0.0.0 --port=8080 --auth=password --disable-telemetry
INFO: Running Tests
Process: code-server: running: matches expectation: [true]
Port: tcp:8080: listening: matches expectation: [true]
Port: tcp:8080: ip: matches expectation: [["0.0.0.0"]]
HTTP: https://localhost:8080/login: status: matches expectation: [200]


Total Duration: 0.036s
Count: 4, Failed: 0, Skipped: 0
INFO: Deleting container
```

When you are confident that your change is ready, either merge it to `master` (if you are an aproved contributor), or create a pull request. In general, we prefer getting feedback from others before merging to `master`.

Whenever a change is pushed to `master`, Docker Hub automatically picks it up and updates `praqma/vscode:latest`.

### (Optional) Build an image with a version-tag
Docker Hub will automatically create a tagged Docker image if a tag is pushed to GitHub.
### The Release Candidate

1. Use Git to checkout a specific commit from the master branch.
1. Use `git tag v1.0.0-rc.1` to tag the commit.
    > Of course, we create a release candidate before we make a release!
1. Push the tag to your GitHub repository with `git push --tags`
1. Go to Docker Hub, a build should trigger and an image tagged `1.0.0-rc.1`
  should be available shortly.

### The Release

1. Run the release candidate docker container and verify that it's good.
1. Use Git to checkout the release candidate commit, `git checkout v1.0.0-rc.1`
1. Tag the commit as a version `git tag v1.0.0`.
1. Push the tag to you GitHub repository, `git push --tags`
1. You can inspect the build and image shortly after on Docker Hub.