if [ -f .env ]; then
    set -o allexport
    source .env
    set +o allexport
else
    echo "${RED}Fichier .env manquant. Abandon.${NC}"
    exit 1
fi

if [[ "$DOWNLOAD_NO_DATA_DUMP" == 1 || "$DOWNLOAD_EVERYTHING" == 1 || "$DOWNLOAD_DAILY" == 1 ]]; then
    #Importer La structure vide
    export LOCAL_PATH=$NO_DATA_LOCAL_PATH
    export REMOTE_PATH=$NO_DATA_REMOTE_PATH
    ./jintonus/download_dump.sh
fi

if [[ "$DOWNLOAD_DUMP_DAILY" == 1 || "$DOWNLOAD_EVERYTHING" == 1 || "$DOWNLOAD_DAILY" == 1 ]]; then
    #Importer DAILY
    export LOCAL_PATH=$DAILY_LOCAL_PATH
    export REMOTE_PATH=$DAILY_REMOTE_PATH
    ./jintonus/download_dump.sh
fi

if [[ "$DOWNLOAD_DUMP_STRUCT" == 1 || "$DOWNLOAD_EVERYTHING" == 1 || "$DOWNLOAD_DAILY" == 1 ]]; then
    #Importer STRUCT
    export LOCAL_PATH=$STRUCT_LOCAL_PATH
    export REMOTE_PATH=$STRUCT_REMOTE_PATH
    ./jintonus/download_dump.sh
fi

if [[ "$DOWNLOAD_DUMP_CLIENT" == 1 || "$DOWNLOAD_EVERYTHING" == 1 ]]; then
    ##Importer CLIENT
    export LOCAL_PATH=$CLIENT_LOCAL_PATH
    export REMOTE_PATH=$CLIENT_REMOTE_PATH
    ./jintonus/download_dump.sh
fi

if [[ "$DOWNLOAD_DUMP_ALL" == 1 || "$DOWNLOAD_EVERYTHING" == 1 ]]; then
    ##Importer ALL
    export LOCAL_PATH=$ALL_LOCAL_PATH
    export REMOTE_PATH=$ALL_REMOTE_PATH
    ./jintonus/download_dump.sh
fi