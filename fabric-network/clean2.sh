
# Docker part start
  echo "================================================================="
  echo "Displaying all running containers"
  echo "================================================================="
  # Displaying all running containers
  docker ps -a
  echo "================================================================="
  echo "Stopping all running containers"
  echo "================================================================="
  # Stop all the running containers
  docker stop $(docker ps -aq)
  echo "================================================================="
  echo "Removing all stopped containers"
  echo "================================================================="
  # Removing all the stopped containers
  docker rm $(docker ps -aq)
  echo "================================================================="
  echo "Clearing the volume space"
  echo "================================================================="
  # Cleaning up the stopped containers volumes
  echo "y" | docker volume prune
  echo "================================================================="
  echo "All stopped containers and volumes removed"
  docker ps -a
  docker images | grep dev-
  docker rmi -f $(docker images | awk '($1 ~ /dev-peer.*/) {print $3}')
  docker images
# Docker part end
export DOCKER_SOCK="${DOCKER_HOST:-/var/run/docker.sock}"

To delete all containers including its volumes use,

docker rm -vf $(docker ps -a -q)

To delete all the images

docker rmi -f $(docker images -a -q)


docker system prune --volumes

docker rm -f $(docker ps -aq) && docker rmi -f $(docker images | grep dev | awk '{print $3}') && docker volume prune

docker rm -f $(docker ps -a -q)
docker kill $(docker ps -q)
docker rm $(docker ps -aq)
docker rmi $(docker images dq-* -q)