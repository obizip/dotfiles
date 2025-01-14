export DOCKER_HOST=$(docker context inspect rootless --format '{{.Endpoints.docker.Host}}')
