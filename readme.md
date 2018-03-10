# Schommunity
### Sistema colaborativo para alunos e corpo docente

Projeto com objetivo de aproximar os alunos e professores de uma instituição, provendo uma ferramenta que facilita a comunicação de forma geral.

O sistema contempla funcionalidades administrativas como:

* Cadastro instituições de ensino (onde todo usuário deve ser vinculado para uso do sistema)
* Gestão de cursos para instituições, disciplinas para cursos, salas de aulas para disciplinas
* Cadastro de usuários (alunos, professores, coordenadores e diretores)

As principais funcionalidades do sistema são:

* Modelo de postagem dentro das salas de aula (fórum)
  * Permite que dentro de cada postagem os usuários incluam comentários
  * Serão exibidas somente para os usuários que pertencem a sala de aula, professor da sala e coodenador do curso

* Chat
  * Permite que todos usuários que tem algum tipo de vinculo (salas de aula), possam trocar mensagens entre sí.

## Requisitos para instalação

* Ruby v2.3.0
* PostgreSQL v9.6
* Elasticsearch v2.4.5
* Gem bundler pré instalada
* ImageMagick

## Instalação do sistema

1. Clonar o projeto
2. Acessar a pasta e instalar a gems com o seguinte comando:
```sh
$ bundle install
```
3. Renomear arquivo ``database.yml.duplicate`` para ``database.yml`` (localizado dentro da pasta ``/config``) e editar as configurações de acordo com seu banco de dados postgres instalado.
4. Iniciar o servico do banco de dados PostgreSQL.
5. Executar os seguintes comandos para instalar o banco de dados, fazer o setup inicial e alimentar com dados padrões:
```sh
$ bundle exec rake db:setup
```
6. Iniciar o serviço ``Elasticsearch``
7. Iniciar o projeto com o comando abaixo:
```sh
$ rails s
```

Realizado os passos acima, o projeto estará rodando.

## Usando o sistema

Para usar o sistema, abra o navegador e acesse ``localhost:3000``, a tela de login irá ser carregada. O único usuário pré criado é o administrador com email ``admin@admin.com`` e senha ``qwerty``.

A partir deste momento, você deverá fazer a configuração da estrutura da instituição, definindo um acesso do tipo ``diretor`` que posteriormente será utilizado para acessar o sistema já dentro do cadastro da instituição, onde será possível cadastrar professores e alunos para atribuí-los as salas de aula.

## Extras
* Todos os cadastros de usuários assim que inseridos no banco de dados, receberão um e-mail com um token para cadastrar a senha, para tal funcionalidade foi utilizado [Devise](https://github.com/plataformatec/devise) e [Devise Invitable](https://github.com/scambra/devise_invitable)
* Além de enviar o token para o usuário, o sistema indexa o cadastro deste usuário, permitindo uma busca mais rápida nos datatables, realizada pelo [Searchkick](https://github.com/ankane/searchkick)
* A gestão de permissionamento foi construido com [CanCanCan](https://github.com/CanCanCommunity/cancancan)
* O sistema não utiliza subdomínios para controle de acesso as instituições
