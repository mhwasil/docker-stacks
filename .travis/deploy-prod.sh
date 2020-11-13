# Deploy Dev environment

env | grep DOCKER
echo "$DOCKER_TOKEN" | docker login --username "$DOCKER_USERNAME" --password-stdin
VERSION=$(git rev-parse --short HEAD)

make -C ../minimal-notebook build
make push -C ../minimal-notebook push
docker run -it --rm -d -p 8880:8888 digiklausur/minimal-notebook:latest

make -C ../notebook build
make push -C ../notebook push
docker run -it --rm -d -p 8881:8888 digiklausur/notebook:$VERSION

make -C ../restricted-notebook build
make push -C ../restricted-notebook push
docker run -it --rm -d -p 8882:8888 digiklausur/restricted-notebook:$VERSION

make -C ../ngshare build
make push -C ../ngshare push
docker run -it --rm -d -p 8883:8888 digiklausur/ngshare:$VERSION

make -C ../hub build
make push -C ../hub push

docker ps
docker images
