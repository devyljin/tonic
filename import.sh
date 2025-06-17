#!/bin/bash
if [ -f .env ]; then
    set -o allexport
    source .env
    set +o allexport
else
    echo "${RED}Fichier .env manquant. Abandon.${NC}"
    exit 1
fi
gum style --border normal --margin "1" --padding "1 2" --border-foreground 212 "Gestionnaire d'imports du $(gum style --foreground 212 'Jin Tonic Manager')v.1 !"

#, commencez par rentrer votre passphrase SSH (celle-ci n'est pas sauvegardée).

export SSH_PASS=$(gum input    --prompt.foreground "#0FF" \
                               --placeholder "Entrez la passphrase de votre Clé OpenSSL,(laissez vide si vous ne souhaitez)" \
                               --prompt "(☞ ಠ_ಠ)☞ " \
                               --width 80 \
                               --password \
  )


gum confirm "Voulez vous Télécharger l'ensemble des dump depuis le serveur ?" --affirmative "IMPORTER TOUT !" --negative "Non, je vais faire mon choix." && DOWNLOAD_EVERYTHING=1 || DOWNLOAD_EVERYTHING=0
export DOWNLOAD_EVERYTHING
if [[ "$DOWNLOAD_EVERYTHING" == 0 ]]; then
  gum confirm "Voulez vous faire un téléchargement journalier ?" --affirmative "Importer les bases journalières" --negative "Non, je vais faire mon choix." && DOWNLOAD_DAILY=1 || DOWNLOAD_DAILY=0
  export DOWNLOAD_DAILY
fi
if [[ "$DOWNLOAD_EVERYTHING" == 0 && "$DOWNLOAD_DAILY" == 0 ]]; then
       #!/bin/bash

       clear
       echo "Quelles données voulez vous récuperer depuis le serveur ?"

       DOWNLOAD_ALL_DUMP_CHOICE="Télécharger le dump de toute la base de donnée"
       DOWNLOAD_DAILY_DUMP_CHOICE="Télécharger le dump avec les données Juriste"
       DOWNLOAD_CLIENT_DUMP_CHOICE="Télécharger le dump comportant les données client"
       DOWNLOAD_STRUCT_DUMP_CHOICE="Télécharger le dump de la structure de Joomla"

       # Choix multiples avec gum
       ACTIONS=$(gum choose --cursor-prefix "[ ] " --selected-prefix "[✓] " --no-limit \
         "$DOWNLOAD_ALL_DUMP_CHOICE" "$DOWNLOAD_DAILY_DUMP_CHOICE" "$DOWNLOAD_CLIENT_DUMP_CHOICE" "$DOWNLOAD_STRUCT_DUMP_CHOICE")

       clear
       echo "Tu as choisi :"
       # Boucle ligne par ligne sur les choix sélectionnés
       while IFS= read -r action; do
         echo "- $action"
         # Exemple de gestion :
         case "$action" in
           "$DOWNLOAD_ALL_DUMP_CHOICE")
             export DOWNLOAD_DUMP_ALL=1
             ;;
           "$DOWNLOAD_DAILY_DUMP_CHOICE")
             export DOWNLOAD_DUMP_DAILY=1
             ;;
           "$DOWNLOAD_CLIENT_DUMP_CHOICE")
             export DOWNLOAD_DUMP_CLIENT=1
             ;;
          "$DOWNLOAD_STRUCT_DUMP_CHOICE")
             export DOWNLOAD_DUMP_STRUCT=1
             ;;
           *)
             echo "-> Action inconnue."
             ;;
         esac
       done <<< "$ACTIONS"
fi





gum confirm "Voulez vous reconstruire entierement votre base de donnée depuis les données serveur ?" --affirmative "Oui" --negative "Non, je vais faire mon choix." && IMPORT_EVERYTHING=1 || IMPORT_EVERYTHING=0
export IMPORT_EVERYTHING
if [[ "$IMPORT_EVERYTHING" == 0 ]]; then
  gum confirm "Voulez vous faire une actualisation journaliere de votre base ?" --affirmative "Importer les bases journalières" --negative "Non, je vais faire mon choix." && IMPORT_DAILY=1 || IMPORT_DAILY=0
  export IMPORT_DAILY
fi


if [[ "$IMPORT_EVERYTHING" == 0 && "$IMPORT_DAILY" == 0 ]]; then

       clear
       echo "Quelles données voulez vous importer dans votre base de donnée ?"

       IMPORT_DAILY_DUMP_CHOICE="Importer le dump avec les données Juriste"
       IMPORT_CLIENT_DUMP_CHOICE="Importer le dump comportant les données client"
       IMPORT_STRUCT_DUMP_CHOICE="Importer le dump de la structure de Joomla"

       # Choix multiples avec gum
       ACTIONS=$(gum choose --cursor-prefix "[ ] " --selected-prefix "[✓] " --no-limit \
         "$IMPORT_DAILY_DUMP_CHOICE" "$IMPORT_CLIENT_DUMP_CHOICE" "$IMPORT_STRUCT_DUMP_CHOICE")

       clear
       echo "Tu as choisi :"
       # Boucle ligne par ligne sur les choix sélectionnés
       while IFS= read -r action; do
         echo "- $action"
         # Exemple de gestion :
         case "$action" in
           "$IMPORT_DAILY_DUMP_CHOICE")
             export IMPORT_DUMP_DAILY=1
             ;;
           "$IMPORT_CLIENT_DUMP_CHOICE")
             export IMPORT_DUMP_CLIENT=1
             ;;
           "$IMPORT_STRUCT_DUMP_CHOICE")
             export IMPORT_DUMP_STRUCT=1
             ;;
           *)
             echo "-> Action inconnue."
             ;;
         esac
       done <<< "$ACTIONS"
fi

./jintonus/download_agent.sh
clear
./jintonus/import_agent.sh
clear

NICE_MEETING_YOU=$(gum style --height 5 --width 50 --padding '1 3' --border double --border-foreground 212 "Bon, il semblerai que vous ayez tout installé.... et qu'on doive donc deja se quitter ...")
CHEW_BUBBLE_GUM=$(gum style --height 5 --width 50 --padding '1 3' --border double --border-foreground 212 "N'oubliez pas de pactiser avec $(gum style --foreground "#ff0000" "Devil Jin"). Bonne journée ! ¯\_(ツ)_/¯")
TONIC_POSTCARD=$(gum style --height 5 --width 50 --padding '1 3' --border double --border-foreground 212 "$(gum style --foreground 212 "Tonic") v1.0 by $(gum style --foreground "#ff0000" "Jin from scratch")")
gum join --horizontal "$NICE_MEETING_YOU" "$CHEW_BUBBLE_GUM" "$TONIC_POSTCARD"

