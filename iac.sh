#!/bin/bash

#declarando as variaveis que serão utilizadas
declare -a users=(carlos maria joao debora sebastiana roberto josefina amanda rogerio)
declare -a groups=(GRP_ADM GRP_VEN GRP_SEC)
declare -a dirs=(/publico /adm /ven /sec)

echo "Criando os grupos..."
for group in "${groups[@]}"; do
  sudo groupadd "$group"
done

echo "Criando os usuarios"
for user in "${users[@]}"; do
  sudo useradd "$user"
  password=$(openssl passwd -crypt abc,123)
  sudo usermod --password "$password" "$user"
done

echo "Adicionando os usuarios a seus respectivos grupos"
sudo usermod -a -G GRP_ADM carlos maria joao
sudo usermod -a -G GRP_VEN debora sebastiana roberto
sudo usermod -a -G GRP_SEC josefina amanda rogerio

echo "Criando os diretorios..."
for dir in "${dirs[@]}"; do
  sudo mkdir "$dir"
  sudo chown root:root "$dir"
done

echo "Linkando os grupos a seus respectivos diretorios..."
sudo chgrp GRP_ADM /publico /adm
sudo chgrp GRP_VEN /publico /ven
sudo chgrp GRP_SEC /publico /sec

echo "Ajustando permissoes...."
sudo chmod 770 /publico /adm /ven /sec
sudo chmod 777 /publico

echo "Corre pro abraço :) "
