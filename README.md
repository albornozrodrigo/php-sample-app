
# PHP/MySQL APP - Instruções para deploy



## Iniciando



Estas instruções irão possibilitar que você rode a aplicação em um ambiente local para fins de desenvolvimento.



### Pré requisitos

Tecnologias que você precisa ter instaladas para rodar a aplicação.

```

Docker

```

### Instalando

Clone o repositório.

```

https://github.com/albornozrodrigo/php-sample-app.git

```



### Rodando

Dê permissão aos arquivos.

```

chmod 775 ./deploy.sh

```

```

chmod 775 ./backend/deploy.sh

```

```

chmod 775 ./frontend/deploy.sh

```

Execute o bash file passando quatro variáveis, sendo:
1. **Versão do backend**
2. **Versão do frontend**
3. **Usuário do DockerHub**
4. **Senha do DockerHub**

As duas últimas são opcionais, caso não sejam passadas, o push para o repositório não será feito.
```

./deploy.sh 0.3 0.2 albornoz 123456

```

Para realizar o deploy de apenas uma aplicação, basta rodar o mesmo comando anterior, mudando apenas o diretório e passando apenas a versão do respectivo projeto:

```

./backend/deploy.sh 0.2 albornoz 123456

```

```

./frontend/deploy.sh 0.3 albornoz 123456

```



### Acessando

Para testar a aplicação acesse um dos endereços abaixo.

```

http://localhost

```

```

http://192.168.99.100/

```


## Authors

*  **Rodrigo Albornoz**