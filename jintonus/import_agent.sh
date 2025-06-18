#!/bin/bash
if [ -f .env ]; then
    set -o allexport
    source .env
    set +o allexport
else
    echo "${RED}Fichier .env manquant. Abandon.${NC}"
    exit 1
fi

if [[ "$IMPORT_EVERYTHING" == 1 ]]; then
    gum spin --spinner meter --title "Import en de toutes les données cours..." -- docker exec -i "$DB_CONTAINER_NAME" mysql -u "$DB_USER" -p"$DB_PASSWORD" "$DB_NAME" < $ALL_LOCAL_PATH
else
    if [[ "$IMPORT_NO_DATA_DUMP" = 1 ]]; then
            gum spin --spinner monkey --title "Import de la structure de base de données (sans données)..." -- docker exec -i "$DB_CONTAINER_NAME" mysql -u "$DB_USER" -p"$DB_PASSWORD" "$DB_NAME" < $NO_DATA_LOCAL_PATH
    fi
    if [[ "$IMPORT_DAILY" = 1 || "$IMPORT_DUMP_STRUCT" = 1 ]]; then
        gum spin --spinner globe --title "Import des données de structure Joomla en cours..." -- docker exec -i "$DB_CONTAINER_NAME" mysql -u "$DB_USER" -p"$DB_PASSWORD" "$DB_NAME" < $STRUCT_LOCAL_PATH
    fi
    if [[ "$IMPORT_DAILY" == 1 || "$IMPORT_DUMP_DAILY" = 1 ]]; then
        gum spin --spinner moon --title "Import des données Juriste en cours..." -- docker exec -i "$DB_CONTAINER_NAME" mysql -u "$DB_USER" -p"$DB_PASSWORD" "$DB_NAME" < $DAILY_LOCAL_PATH
    fi
    if [[ "$IMPORT_DUMP_CLIENT" = 1 ]]; then
          gum spin --spinner  --title "Import des données Client en cours..." -- docker exec -i "$DB_CONTAINER_NAME" mysql -u "$DB_USER" -p"$DB_PASSWORD" "$DB_NAME" < $CLIENT_LOCAL_PATH
    fi
fi
