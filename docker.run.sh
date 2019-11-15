docker run -d \
       --network host \
       --name vscode \
       -e GIT_REPO=https://github.com/praqma-training/docker-katas \
       -e GIT_SUBDIR=. \
       -e PASSWORD=praqma \
       -e CODE_PORT=8080 \
       -v ~/.kube/config:/home/coder/.kube/config \
       -v /var/run/docker.sock:/var/run/docker.sock \
       praqma/vscode:1.39.2
