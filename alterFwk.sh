#!/bin/bash
# alterFwk.sh - Deleta do arquivo fwk.properties as linhas com ManageAccess ou ManageServices e insere linha com portalce_ds caso não exista.
#
# Site:       https://github.com/DaltonSoares
# E-mail:     daltonsoares0@gmail.com
# Autor:      Dalton A Soares
# Manutenção: Dalton A Soares

#------------------------------------------------------------------------"
# Histórico: 
#------------------------------------------------------------------------"

#------------------------------------------------------------------------"
#   Testado em: GNU bash, versão 5.0.3(1)-release (x86_64-pc-linux-gnu)
#------------------------------------------------------------------------"

#-------------------------------VARIÁVEIS--------------------------------"
varDate=`date +%Y%m%d%H%M%S`
#------------------------------------------------------------------------"

#-------------------------------EXECUÇÃO----------------------------------"

for i in `find $PWD -name "*fwk.properties*" 2>/dev/null | grep -v old`; 
    do
	diretorio=$(dirname $i)
	echo "Acessando o dir: $diretorio"
	echo "|---------------------------------------------------------------------|"
        cd $diretorio        
        cp -p fwk.properties fwk.properties.old_$varDate
        sed '/ManageAccess/d' fwk.properties >> novo1.properties #/d - delete, deleta a linha com ManageAccess
        sed '/ManageServices/d' novo1.properties >> novo2.properties
        rm -rf fwk.properties
        rm -rf novo1.properties
        mv novo2.properties fwk.properties
        chmod 755 fwk.properties

        varPortalce_ds=`cat fwk.properties | grep portalce_ds | grep -v "#" | wc -l`
        varLinhaPortalce_ds=`cat fwk.properties | grep portalce_ds | grep -v "#"`

        if [ $varPortalce_ds -ge 1 ]; then
            echo "Já existe um valor apontando para portalce_ds"
            echo $varLinhaPortalce_ds
            echo ""
            echo ""
            echo ""
          else
            echo "Não foi encontrado nenhum valor apontando para portalce_ds"
            echo "|--------------------------------------------------------|"
            echo "Adicionando a tag properties.service.datasource=portalce_ds"
            echo "properties.service.datasource=portalce_ds" >> fwk.properties
	    echo ""
	    echo ""
	    echo ""
        fi    
    done
#------------------------------------------------------------------------"
