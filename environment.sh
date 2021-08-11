containers_running=$(docker ps | grep tensor)
if [ -z "$containers_running" ]
then
    container_search=$(
        docker ps -a | grep tensor | head -1
    )

    if [ -z "$container_search" ]
    then
        container_id=$(
            docker run --gpus all -it -v $(pwd):/tf/notebooks -p 8888:8888 -d tensorflow/tensorflow:nightly-gpu-jupyter
        )
        docker exec -it $container_id pip3 install -r notebooks/requirements.txt
        logs=$(docker logs $container_id | grep 'http://127.0.0.1:8888/?token=' )
        re="^(.*)=(.*)$"
        [[ $logs =~ $re ]] && token="${BASH_REMATCH[2]}"
        tput setaf 9; echo "LINK PARA ACESSA NOTEBOOKS"
        tput setaf 9; echo "http://0.0.0.0:8888/?token=$token"
        tput setaf 9; echo "http://127.0.0.1:8888/?token=$token"
    else
        re="^(.*)tensorflow/tensorflow:nightly-gpu-jupyter(.*)$"
        [[ $container_search =~ $re ]] && container_id="${BASH_REMATCH[1]}"
        docker start $container_id
        logs=$(docker logs $container_id | grep 'http://127.0.0.1:8888/?token=' )
        re_log="^(.*)=(.*)$"
        [[ $logs =~ $re_log ]] && token="${BASH_REMATCH[2]}"
        tput setaf 9; echo "LINK PARA ACESSA NOTEBOOKS"
        tput setaf 9; echo "http://0.0.0.0:8888/?token=$token"
        tput setaf 9; echo "http://127.0.0.1:8888/?token=$token"
    fi
else
    echo "Container já está sendo executado!"
fi
