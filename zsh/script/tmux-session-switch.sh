#!/usr/bin/env bash

[[ -n "$TMUX" ]] && change="switch-client" || change="attach-session"
session=$(tmux list-sessions -F "#{session_name}" 2>/dev/null | fzf --exit-0) &&  tmux $change -t "$session" || echo "No sessions found."
