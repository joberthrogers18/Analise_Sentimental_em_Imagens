## Analise de Sentimento em Imagens

### 1 - Autor

**Nome:** Joberth Rogers Tavares Costa      
**Matrícula:** 160128013
**Curso:** Engenharia de Software (Bacharel) **Universidade de Brasília**
### 2 - Descrição
Este repositório reúne todos os scripts desenvolvidos  durante a execução do trabalho de conclusão de curso  voltado para a classificação de sentimento em imagens usando as técnicas de Deep Learning (DL). 

### 3 - Execução

#### 3.1 - Requisitos

    - jupter notebook ou anaconda
    - docker
#### 3.2 Etapas para executar

- Primeiro clone o repositório.

##### 3.2.1 Instalando container do CUDA Toolkit

- Configure o repositório mais estável e chave GPG:
    
```
distribution=$(. /etc/os-release;echo $ID$VERSION_ID) \
&& curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | sudo apt-key add - \
&& curl -s -L https://nvidia.github.io/nvidia-docker/$distribution/nvidia-docker.list | sudo tee /etc/apt/sources.list.d/nvidia-docker.list
```

Instale o pacote nvidia-docker2 (e dependências) depois de atualizar a lista de pacotes:

```
sudo apt-get update
```

```
sudo apt-get install -y nvidia-docker2
```

Reinicie o daemon do Docker para concluir a instalação:

```
sudo systemctl restart docker
```

Após o sucesso dos comandos acima, teste usando:

```
sudo docker run --rm --gpus all nvidia/cuda:11.0-base nvidia-smi
```
##### 3.2.2 Buildando o container do tensoflow com jupyter

- Builde usando o comando:

```
sudo docker run --gpus all -it --rm -v $(realpath /caminho/para/diretorio/dos/notebooks):/tf/notebooks -p 8888:8888 -t jupyter-workspace tensorflow/tensorflow:nightly-gpu-jupyter
```

- Entre no container com o comando:

```
sudo docker exec -it jupyter-workspace bash && cd notebooks
```

- Instale todas as dependências com o comando:

```
pip3 install -r requirements.txt
```

- Acesse os notebooks acessando o link abaixo em seu browser: 

```
http://localhost:8888/?token=token_fornecido_terminar_de_builda_o_container
```

Referências:
- https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/install-guide.html
- https://www.tensorflow.org/install/docker
- https://www.tensorflow.org/install/gpu
- https://hub.docker.com/r/tensorflow/tensorflow/tags/?page=1&ordering=last_updated