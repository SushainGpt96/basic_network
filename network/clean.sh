docker rm -f $(docker ps -aq)
docker image prune
docker volume prune
docker ps -a
docker image