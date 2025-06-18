#!/bin/bash

eval "$(ssh-agent -s)"
# Script Expect pour entrer automatiquement la passphrase
expect << EOF
spawn ssh-add "$SSH_PATH"
expect "Enter passphrase"
send "$SSH_PASS\r"
expect eof
EOF

ssh -i "$SSH_PATH" -p $REMOTE_PORT "$REMOTE_USER@$REMOTE_HOST" << EOF
cd "$REMOTE_DIR" || exit
git pull origin "$GIT_BRANCH"
EOF


ssh-agent -k