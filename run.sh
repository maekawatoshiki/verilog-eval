#!/bin/bash -eu

if [ "${BUILD:-}" = "1" ]; then
    echo -e "\033[0;34mBuilding image...\033[0m"
    docker build --build-arg GID=$(id -g) --build-arg UID=$(id -u) --build-arg USER=user -f Dockerfile.dev -t verilogeval .
else
    echo -e "\033[0;34mUsing built image...\033[0m"
fi

docker run \
    --gpus all \
    -it --rm \
    -w /work \
    --mount type=bind,source="${PWD}",target="/work" \
    --mount type=bind,source="${HOME}/.cache/huggingface",target="/hf_home" \
    verilogeval $@
