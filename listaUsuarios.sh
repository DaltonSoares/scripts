#!/usr/bin/env bash
#
# listaUsuarios.sh - Lista usuários do /etc/passwd
#
# Site:       https://github.com/DaltonSoares
# Autor:      Dalton A Soares
# Manutenção: Dalton A Soares
#
# ------------------------------------------------------------------------ #
#  Este programa irá listar os usuários do /etc/passwd
#  podendo ordenar os nomes e colocar em maiúsculo.
#
#  Exemplos:
#      $ ./listaUsuarios.sh -s -m
#
# ------------------------------------------------------------------------ #
# Histórico:
#
#   v1.0 28/12/2020, Dalton:
#       - Início do programa
# ------------------------------------------------------------------------ #
# Testado em:
#   bash 4.4.19
# ------------------------------------------------------------------------ #



# ------------------------------- VARIÁVEIS ----------------------------------------- #

USUARIOS="$(cat /etc/passwd | cut -d : -f 1)"
# $0 pega o nome do script com ./ já o basename deixa apenas o nome do script.
MENSAGEM_USO="
        $(basename $0) - [OPCOES]

        -h - Menu de ajuda
        -v - Versão
        -s - Ordenar saída
        -m - Maiúsculo
"
VERSAO=1.0
USUARIOS_ORDENADOS=0
USUARIOS_MAIUSCULOS=0

# ------------------------------- EXECUÇÃO ----------------------------------------- #

# -n valida se $1 não é nulo.
while [[ -n $1 ]]; do

   case $1 in

        -h) echo "$MENSAGEM_USO"  && exit 0  ;;

        -v) echo "Versão: $VERSAO" && exit 0 ;;

        -s) USUARIOS_ORDENADOS=1             ;;

        -m) USUARIOS_MAIUSCULOS=1            ;;

        *)  echo "$USUARIOS" & exit 0        ;;

   esac
   shift
done

[[ "$USUARIOS_ORDENADOS" = 1 ]]  && USUARIOS=$(echo "$USUARIOS" | sort)
[[ "$USUARIOS_MAIUSCULOS" = 1 ]] && USUARIOS=$(echo "$USUARIOS" | tr [a-z] [A-Z])

echo "$USUARIOS"
# --------------------------------------------------------------------------------- #
