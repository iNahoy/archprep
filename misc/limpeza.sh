#!/bin/bash

echo "Limpando paccache"
sudo paccache -rk1
echo "Limpando cache do pacman"
sudo pacman -Scc
echo "Limpando cache do yay"
yay -Scc
echo "Limpando pacotes orfãos"
sudo pacman -Rns $(pacman -Qdtq)
echo "Agora só continuar limpando com o bleachbit pra deixar tudo na melhor!"
