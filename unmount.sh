docker-compose down -v
# remove containers
docker rm -vf $(docker ps -a -q)

# remove images
docker rmi -f $(docker images -a -q)