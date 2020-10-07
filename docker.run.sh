#Running VS Code as a container

docker run -d \
       --network host \
       --name vscode \
       -e GIT_REPO=https://github.com/eficode-training/docker-katas \
       -e GIT_SUBDIR=. \
       -e PASSWORD=praqma \
       -e CODE_PORT=5050 \
       -v ~/.kube/config:/home/coder/.kube/config \
       -v /var/run/docker.sock:/var/run/docker.sock \
       --restart always \
       praqma/vscode:3.5.0
