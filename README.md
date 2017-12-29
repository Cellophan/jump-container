# jump-container
A container to pop into an non-attachable network

Start with:

    docker stack deploy -c docker-compose.yml blah

Access with:

    ssh -D 1080 -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -o ProxyCommand="docker exec -i $(docker ps --format '{{ .Names }}' | grep jump) nc 127.0.0.1 22" 127.0.1

