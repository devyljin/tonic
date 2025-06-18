#!/bin/bash



spin() {
       local pid=$1
       local delay=0.1
       local spinstr='🧞‍♂️🧞🧞‍♀️🧞'
       local i=0
       while kill -0 "$pid" 2>/dev/null; do
           i=$(( (i+1) % 4 ))
           printf "\rJin Workin... %s" "${spinstr:$i:1}"
           sleep $delay
       done
       printf "\rJin is Devil.       \n"
}
if [ -f .env ]; then
    set -o allexport
    source .env
    set +o allexport
else
    echo "${RED}Fichier .env manquant. Abandon.${NC}"
    exit 1
fi
gum style --border normal --margin "1" --padding "1 2" --border-foreground 212 "Bienvenue sur le $(gum style --foreground 212 'Jin Tonic Manager')v.1 !"

sleep 3 &
task_pid=$!
spin $task_pid


docker-compose down
docker-compose up -d --build

git clone "$GIT_REPO_URL" $LOCAL_PROJECT_PATH

## Changement de branch provisoire, a retirer quand la main sera aux normes
cd $LOCAL_PROJECT_PATH
git checkout --force docker-ready
cd ..
#
cp -r ./override-no-commited/* $LOCAL_PROJECT_PATH
docker-compose up -d --build
docker-compose exec joomla bash -c "cd /var/www/html/components/com_agrume && composer install"

rm -rf $LOCAL_PROJECT_PATH/installation


## Changement de branch provisoire, a retirer quand la main sera aux normes
cd $LOCAL_PROJECT_PATH
git checkout --force docker-ready
cd ..
#

./import.sh