#!/bin/bash

# Certifique-se de que os arquivos pkglist_pacman.txt e pkglist_aur.txt
# estejam na mesma pasta que este script ou na sua pasta home.

echo "Verificando e atualizando a base de dados do Pacman..."
sudo pacman -Syu --noconfirm

echo "Instalando pacotes do Pacman a partir de pkglist_pacman.txt..."

# Instala pacotes do Pacman, evitando reinstalar o que já existe
sudo pacman -S --needed --noconfirm - < ~/pkglist_pacman.txt
echo "Sincronizando espelhos novamente após instalação de pacotes Pacman..."
sudo pacman -Syu --noconfirm

# --- Verificação e instalação do Yay, se necessário ---
if ! command -v yay &> /dev/null
then
    echo "Yay não encontrado. Instalando Yay..."
    sudo pacman -S --noconfirm --needed git base-devel # Instala dependências do Yay
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si --noconfirm
    cd ..
    rm -rf yay
    echo "Yay instalado com sucesso."
else
    echo "Yay já está instalado."
fi

echo "Instalando pacotes do AUR via Yay a partir de pkglist_aur.txt..."
# Instala pacotes do AUR, --noconfirm aqui é útil para automação
yay -S --needed --noconfirm - < ~/pkglist_aur.txt

echo "Removendo pacotes órfãos remanescentes (se houver)..."
sudo pacman -Rns $(pacman -Qdtq) --noconfirm 2>/dev/null || true

echo "Processo de reinstalação de pacotes concluído!"
echo "Pode ser necessário reiniciar o sistema para algumas mudanças surtirem efeito."
