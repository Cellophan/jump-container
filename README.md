# jump-container
A container to pop into an non-attachable network

Start with:

    docker run --rm -v $HOME/.ssh/id_rsa.pub:$HOME/.ssh/id_rsa.pub:ro --name test cell/jump-container:latest

Access with:

    ssh -CD 1080 -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -o ProxyCommand="docker exec -i test nc 127.0.0.1 22" 127.0.0.1

