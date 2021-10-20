# docker-django

## packaging
- django
- MongoDB

## usage

```
docker run -it --rm --volume "${PWD}:/work" ghcr.io/hiracchi/docker-django:latest -p 8000:8000 <command>
