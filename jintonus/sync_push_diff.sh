#!/bin/bash

eval "$(ssh-agent -s)"
# Script Expect pour entrer automatiquement la passphrase
expect << EOF
spawn ssh-add "$SSH_PATH"
expect "Enter passphrase"
send "$SSH_PASS\r"
expect eof
EOF
rsync -avz --delete --dry-run --exclude-from="$EXCLUDE_FILE" \
      -e "ssh -i $SSH_KEY -p $REMOTE_PORT" \
      "$LOCAL_DIR" "$REMOTE_USER@$REMOTE_HOST:$REMOTE_DIR" > $DRY_RUN_LOG

ssh-agent -k

