#!/bin/bash
if [ -f .env ]; then
    set -o allexport
    source .env
    set +o allexport
else
    echo "${RED}Fichier .env manquant. Abandon.${NC}"
    exit 1
fi
echo "LOCAL_PATH = $LOCAL_PATH"
echo "REMOTE_PATH = $REMOTE_PATH"
eval "$(ssh-agent -s)"
# Script Expect pour entrer automatiquement la passphrase
expect << EOF
spawn ssh-add "$SSH_PATH"
expect "Enter passphrase"
send "$SSH_PASS\r"
expect eof
EOF

sftp -oPort=$PORT $USER@$DB_HOST << EOF
  get $REMOTE_PATH $LOCAL_PATH
  bye
EOF
# Vérification du succès
if [ $? -eq 0 ]; then
  gum style --border normal --margin "1" --padding "1 2" --border-foreground 212 "Fichier téléchargé avec succès dans : $(gum style --foreground 212 $LOCAL_PATH) !"
else
  gum style --border normal --margin "1" --padding "1 2" --border-foreground "#ff0000" "Une erreur est survenue pendant le téléchargement du fichier $(gum style --foreground "#ff0000" $LOCAL_PATH) !"
fi

ssh-agent -k