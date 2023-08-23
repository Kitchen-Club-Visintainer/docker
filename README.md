# Banco de Dados em Container

version: "3.1" versao do compose

>**services:** 
>
>Definindo os serviços que irão rodar junto no container
>
>> **db:** 
>>
>>Nome do serviço
>>
>>**image:** _postgres:14.2-alpine_ 
>>> Aqui nós definimos qual a imamgem do postgres que vamos utilizar no nosso container
>>
>>**restart:** _always_ 
>>
>>>definindo estratégia de restart do container
>>
>>**environment:**
>>>Definindo as variáveis de ambiente do nosso container.
>>> Nesse caso, vamos definir usuário e senha do banco de dados.
>>>> * **POSTGRES_USER é OPCIONAL**. Se nao setar POSTGRES_USER será usado o padrão "postgres"
>>>> * **POSTGRES_DB é OPCIONAL**. Se nao setar POSTGRES_DB será usado o nome do POSTGRES_USER
>>>
>>>**POSTGRES_PASSWORD:** _example_
>>
>>**volumes:**
>>
>> _- db-data:/var/lib/postgresql/data_ 
>>
>>> Aqui nós vamos fazer o mapeamento das volumes do container para **persistirmos os dados**.
>>> Primeiramente passamos o volume externo ao container _(que será criado após essa definição de services)_ e depois
>>> informamos onde, dentro do container, esse volume será espelhado.
>> 
>>**ports:**
>> 
>>_- "5432:5432"_
>>
>>> Estamos expondo na porta 5432 a porta interna 5432. Ou seja, o primeiro número é a porta externa do container e o 
>>> segundo número é a porta interna do container.
>
> **volumes**
> 
> Aqui vamos configurar os volumes do nosso container.
> Como vamos **persistir os dsdos do banco**, vamos utilizar esse recuros do DOCKER.
> 
>> **db_data:**
>>
>>> Utilizamos o mesmo nome que declaramos acima, quando definimos os volumes. Aqui vamos passar as especificações
>>> externas do volume do nosso container.
>> 
>>> **driver: local** 
>>> 
>>>> Se inspecionarmos o container que será criado a partir do docker-compose.yml, vamos observar que esse volume estará
>>>> presente fisicamente no S.O. no endereço `/var/lib/docker/volumes/docker_db-data/_data`

* FONTE: https://hub.docker.com/_/postgres
* Versão alpine é a versão mais leve, por isso foi usada no exemplo

## Referências:

Ref: [felipesilvamelo28](https://github.com/felipesilvamelo28/lab-spring-boot-kotlin-basico/tree/main/docker)

* https://hub.docker.com/_/postgres
* https://alpinelinux.org/
* https://medium.com/swlh/alpine-slim-stretch-buster-jessie-bullseye-bookworm-what-are-the-differences-in-docker-62171ed4531d
* https://geshan.com.np/blog/2021/12/docker-postgres/

## Iniciar o container

Para iniciarmos o container com o banco de dados, acessamos o terminal na pasta onde se encontra o `docker-compose.yml`
e entramos com o comando `sudo docker-compose up -d`.

_Obs:_
* _O comando `sudo` é utilizando no linux. Caso esteja rodando em outra plataforma, não é necessário._
* _O comando `-d` servirá para que o container seja criado em background._

Feito isso, o banco de dados estará disponível em `http://localhost:5432`

### Criação da Imagem

Quando subimos esse container com a imagem do postgres, instalamos na nossa máquina essa imagem.
Podemos verificar isso com o comando `sudo docker image`.

### Destruir o container

Para verificarmos os containers que estão rodando na nossa máquina, utilizamos o comando `sudo docker container ls -a`.
Esse comando listará todos os containers que estão ativos no momento.

Para destruirmos o container, basta utilizar o comando `sudo docker-compose down`.
Com esse comando, podemos passar o _CONTAINER ID_, caso exista mais de um container e desejamos destruir um em 
específico.

#### Destruir uma imagem em específico

Com o comando `docker image rmi <image_id>` podemos destruir uma imamgem específica que tenhamos criado.

### Possíveis Erros

Pode acontecer, no momento de subir o container com a imagem do bando de dados, da porta estar ocuada.
Nesse caso, podemos tentar fechar uma possível conexão do Postgres através do comando `sudo service postgresql stop`.

### Criação da Imagem

Quando subimos esse container com a imagem do postgres, instalamos na nossa máquina essa imagem.
Podemos verificar isso com o comando `sudo docker image`.

### Destruir o container

Para verificarmos os containers que estão rodando na nossa máquina, utilizamos o comando `sudo docker container ls -a`.
Esse comando listará todos os containers que estão ativos no momento.

Para destruirmos o container, basta utilizar o comando `sudo docker-compose down`.
Com esse comando, podemos passar o _CONTAINER ID_, caso exista mais de um container e desejamos destruir um em 
específico.

#### Destruir uma imagem em específico

Com o comando `docker image rmi <image_id>` podemos destruir uma imamgem específica que tenhamos criado.

# pgAdmin

## Instalar pgAdmin 4

1. Instala o Postgresql

`apt-get install postgresql`

2. Adiciona uma chave

`curl https://www.pgadmin.org/static/packages_pgadmin_org.pub | sudo apt-key add`

3. Cria repositório para o arquivo e atualiza

`sudo sh -c 'echo "deb https://ftp.postgresql.org/pub/pgadmin/pgadmin4/apt/$(lsb_release -cs) pgadmin4 main" > /etc/apt/sources.list.d/pgadmin4.list && apt update'`

4. Instala o pgadmin4

`sudo apt install pgadmin4`

### _Os comandos 5 e 6 são opcionais, dependendo do S.O._

5. Instala o pgadmin4 para usar no desktop

`sudo apt install pgadmin4-desktop`

6. Instala o pgadmin4 para usar no browser

`sudo apt install pgadmin4-web`

Abra e configure na web (você deve criar uma usuário e senha depois de executar o comando abaixo, e digitar no browser http://127.0.0.1/pgadmin4

`sudo /usr/pgadmin4/bin/setup-web.sh`

7. Acessar Postgres para mudar senha

***OBS*** não é preciso acessar o pgAdmin pelo terminal para definir a senha. Quando acessar pela primeira vez da maneira
convencional, haverá a opção de configurar a senha do banco de dados.

~~~
sudo -u postgres psql
postgres=# \password

# Digite a senha
postgres=# \q
~~~


## Acessar banco de dados

Podemos acessar o banco de dados através da ferramenta pgAdmin 4.

Para isso, vamos adicionar um servidor dentro de um banco de servidores no botão **Add New Server**

Podemos escolher o um nome da nossa escolha. Na aba ***Connection*** temos que colocar um endereço, no nosso caso será _localhost_
Como dafault, já virá configura com a porta 5432, que já configuramos acima.

Não configuramos o username, logo o nosso banco já estará configurado como _postgres_, conforme já vem definido no pgAdmin.
Em PASSWORD, vamos configurar conforme utilizamos em nosso arquivo.

Ao clicar para salvar, o pgAdmin 4 já fará uma conexão com o nosso banco de dados.