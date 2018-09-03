#!/bin/bash
varDate=`date +%Y%m%d%H%M%S`

for i in `find $PWD -name "*fwk.properties*" 2>/dev/null | grep -v old`; 
    do
	diretorio=$(dirname $i)
	echo "Acessando o dir: $diretorio"
	echo "|---------------------------------------------------------------------|"
        cd $diretorio        
        cp -p fwk.properties fwk.properties.old_$varDate
        sed '/ManageAccess/d' fwk.properties >> novo1.properties 
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
