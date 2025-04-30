#!/usr/bin/env bash
set -euo pipefail

# === CONFIGURABLE VARIABLES ===
session="ebdruplab"

# Define project directories
proj_root="$HOME/git/ebdruplab"

# Define tmux layouts
# Session 1
session1_name='ansible-collection_ebdruplap'
layout1='bcbf,171x44,0,0,2'  # Layout: Single pane (full window), width=171, height=44, starts at (0,0), pane id=2
session1_dir="$proj_root/ansible-collection_ebdruplap"

# Session 2
session2_name='CodeCabinet'
layout2='bcc4,171x44,0,0,7'  # Layout: Single pane (full window), width=171, height=44, starts at (0,0), pane id=7
session2_dir="$proj_root/CodeCabinet"

# Session 3
session3_name='dotfiles'
layout3='bcc3,171x44,0,0,6'  # Layout: Single pane (full window), width=171, height=44, starts at (0,0), pane id=6
session3_dir="$HOME/git/ebdruplab/dotfiles"

session4_name='Dual'
layout4='f726,171x44,0,0[171x22,0,0,3,171x21,0,23,4]'  # Layout: Two panes split vertically, top pane 22 rows, bottom pane 21 rows

# === CHECK IF SESSION EXISTS ===
# === CHECK IF SESSION EXISTS ===
if ! tmux has-session -t "$session" 2>/dev/null; then
  # Create session and first window
  tmux new-session -d -s "$session" -n "$session1_name"
  tmux select-layout -t "$session:1" "$layout1"
  tmux send-keys -t "$session:1" "cd \"$session1_dir\" && clear" C-m

  # --- Window 2 ---
  tmux new-window -t "$session:2" -n "$session2_name"
  tmux select-layout -t "$session:2" "$layout2"
  tmux send-keys -t "$session:2" "cd \"$session2_dir\" && clear" C-m

  # --- Window 3 ---
  tmux new-window -t "$session:3" -n "$session3_name"
  tmux select-layout -t "$session:3" "$layout3"
  tmux send-keys -t "$session:3" "cd \"$session3_dir\" && clear" C-m

  # --- Window 4 ---
  tmux new-window -t "$session:4" -n "$session4_name"
  tmux select-layout -t "$session:4" "$layout4"
  tmux send-keys -t "$session:4" "clear" C-m

  # --- Window 5 ---
  tmux new-window -t "$session:5" -n 'Terminal'
  tmux send-keys -t "$session:5" "clear" C-m

  # Focus back to the first window
  tmux select-window -t "$session:1"
fi

# Attach to the tmux session
tmux attach-session -t "$session"

