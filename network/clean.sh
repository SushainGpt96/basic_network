# docker rm -f $(docker ps -aq)
# docker image prune
# docker volume prune
# docker ps -a
# docker image

if [ -d "channel-artifacts" ]; then
  rm -Rf channel-artifacts && rm -Rf crypto-config
fi

