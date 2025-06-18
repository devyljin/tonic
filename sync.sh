#!/bin/bash
if [ -f .env ]; then
    set -o allexport
    source .env
    set +o allexport
else
    echo "${RED}Fichier .env manquant. Abandon.${NC}"
    exit 1
fi
gum style --border normal --margin "1" --padding "1 2" --border-foreground 212 "Gestionnaire de Synchronisation du $(gum style --foreground 212 'Jin Tonic Manager')v.1 !"

export SSH_PASS=$(gum input    --prompt.foreground "#0FF" \
                               --placeholder "Entrez la passphrase de votre Clé OpenSSL" \
                               --prompt "(☞ ಠ_ಠ)☞ " \
                               --width 80 \
                               --password \
  )
CONTINUE=1
while [ "$CONTINUE" -eq 1 ]; do
ENV_CHOOSEN=0
gum confirm "Sur quel environement voulez-vous travailler ?" --affirmative "Pre-Production" --negative "Production" && PROD=0 || PROD=1
if [[ "$PROD" == 1 ]]; then
ENSURE_PROD=$(gum input    --prompt.foreground "#ff0000" \
                               --placeholder "J'invoque les arcanes démoniaques du travail sur la prod !" \
                               --prompt "Tapez le numéro de la bête pour continuer vos bêtises (666):" \
                               --width 80 \
)
fi
if [[ "$ENSURE_PROD" == 666 && "$PROD" == 1 ]]; then
  echo "Vous l'aurez voulu...";
  gum style --border normal --margin "1" --padding "1 2" --border-foreground "#ff0000" "Vous travaillez desormais sur la $(gum style --foreground "#ff0000" 'PRODUCTION')."

  export EXCLUDE_FILE=$RSYNC_PROD_EXCLUDE_FILE
  export SSH_KEY=$RSYNC_PROD_SSH_KEY
  export REMOTE_PORT=$RSYNC_PROD_REMOTE_PORT
  export REMOTE_USER=$RSYNC_PROD_REMOTE_USER
  export REMOTE_HOST=$RSYNC_PROD_REMOTE_HOST
  export LOCAL_DIR=$RSYNC_PROD_LOCAL_DIR
  export REMOTE_DIR=$RSYNC_PROD_REMOTE_DIR
  export GIT_BRANCH=$PROD_GIT_BRANCH
  export DRY_RUN_LOG=$RSYNC_PROD_DRY_RUN_LOG_FILE
  ENV_CHOOSEN=1

  else
  gum style --border normal --margin "1" --padding "1 2" --border-foreground "#43eb34" "Vous travaillez desormais sur la $(gum style --foreground "#43eb34" 'PRE-PRODUCTION')."
  export EXCLUDE_FILE=$RSYNC_PREPROD_EXCLUDE_FILE
  export SSH_KEY=$RSYNC_PREPROD_SSH_KEY
  export REMOTE_PORT=$RSYNC_PREPROD_REMOTE_PORT
  export REMOTE_USER=$RSYNC_PREPROD_REMOTE_USER
  export REMOTE_HOST=$RSYNC_PREPROD_REMOTE_HOST
  export LOCAL_DIR=$RSYNC_PREPROD_LOCAL_DIR
  export REMOTE_DIR=$RSYNC_PREPROD_REMOTE_DIR
  export GIT_BRANCH=$PREPROD_GIT_BRANCH
  export DRY_RUN_LOG=$RSYNC_PREPROD_DRY_RUN_LOG_FILE
  ENV_CHOOSEN=1
fi
while [ "$ENV_CHOOSEN" -eq 1 ]; do

# Demande à l'utilisateur de choisir une option
CHOICE=$(gum choose "Comparer les changements" "Push (supprimer les fichier manquant)" "Push" "Pull depuis Git" "Je veux changer d'environement" "Quitter")

# Agir en fonction du choix
case "$CHOICE" in
  "Comparer les changements")
      ./jintonus/sync_push_diff.sh
      ;;
  "Push")
    ./jintonus/sync_push_no_del.sh
    ;;
  "Push (supprimer les fichier manquant)")
    ./jintonus/sync_push.sh
    ;;
  "Pull depuis Git")
    ./jintonus/sync_server_git_pull.sh
    ;;
  "Je veux changer d'environement")
    ENV_CHOOSEN=0
    ;;
  "Quitter")
    ENV_CHOOSEN=0
    CONTINUE=0
    ;;
  *)
    echo "❌ Choix invalide."
    CONTINUE=0
    ;;
esac
done

done
NICE_MEETING_YOU=$(gum style --height 5 --width 50 --padding '1 3' --border double --border-foreground 212 "Bon, il semblerai que vous n'avez plus besoin de moi.... et qu'on doive donc deja se quitter ...")
CHEW_BUBBLE_GUM=$(gum style --height 5 --width 50 --padding '1 3' --border double --border-foreground 212 "N'oubliez pas de pactiser avec $(gum style --foreground "#ff0000" "Devil Jin"). Bonne journée ! ¯\_(ツ)_/¯")
TONIC_POSTCARD=$(gum style --height 5 --width 50 --padding '1 3' --border double --border-foreground 212 "$(gum style --foreground 212 "Tonic") v1.0 by $(gum style --foreground "#ff0000" "Jin from scratch")")
gum join --horizontal "$NICE_MEETING_YOU" "$CHEW_BUBBLE_GUM" "$TONIC_POSTCARD"

