#!/usr/bin/env bash
set -euo pipefail

# === CONFIGURABLE VARIABLES ===
session="work"

# Define project directories
proj_root="$HOME/git/work/projects/InfrastructureLinux"
dotfiles_dir="$HOME/git/ebdruplab/dotfiles"
dir_semaphore="$proj_root/ansible-semaphore"
dir_nginx_auto="$proj_root/ansible-nginx_automation"

# Define tmux layouts
layout1='bcbf,171x44,0,0,2'  # Layout: Single pane (full window), width=171, height=44, starts at (0,0), pane id=2
layout2='bcc4,171x44,0,0,7'  # Layout: Single pane (full window), width=171, height=44, starts at (0,0), pane id=7
layout3='f726,171x44,0,0[171x22,0,0,3,171x21,0,23,4]'  # Layout: Two panes split vertically, top pane 22 rows, bottom pane 21 rows
layout4='bcc3,171x44,0,0,6'  # Layout: Single pane (full window), width=171, height=44, starts at (0,0), pane id=6
layout5='bcc2,171x44,0,0,5'  # Layout: Single pane (full window), width=171, height=44, starts at (0,0), pane id=5

# === CHECK IF SESSION EXISTS ===
if ! tmux has-session -t "$session" 2>/dev/null; then
  # Create new session detached
  tmux new-session -d -s "$session" -n 'ansible-semaphore'

  # --- Window 1 ---
  # Layout format: Single full window
  tmux select-layout -t "$session:1" "$layout1"
  tmux send-keys -t "$session:1" "cd \"$dir_semaphore\" && clear" C-m

  # --- Window 2 ---
  # Layout format: Single full window
  tmux new-window -t "$session:2" -n 'ansible-nginx_automation'
  tmux select-layout -t "$session:2" "$layout2"
  tmux send-keys -t "$session:2" "cd \"$dir_nginx_auto\" && clear" C-m

  # --- Window 3 ---
  # Layout format: Two vertical split panes
  tmux new-window -t "$session:3" -n 'Dual'
  tmux split-window -v -t "$session:3"
  tmux select-layout -t "$session:3" "$layout3"

  # --- Window 4 ---
  # Layout format: Single full window
  tmux new-window -t "$session:4" -n 'ssh'
  tmux select-layout -t "$session:4" "$layout4"

  # --- Window 5 ---
  # Layout format: Single full window
  tmux new-window -t "$session:5" -n 'Terminal'
  tmux select-layout -t "$session:5" "$layout5"

  # --- Window 6 ---
  # Layout format: Single full window
  tmux new-window -t "$session:6" -n 'dotfiles'
  tmux select-layout -t "$session:6" "$layout1"
  tmux send-keys -t "$session:6" "cd \"$dotfiles_dir\" && clear" C-m

  # Focus back to the first window
  tmux select-window -t "$session:1"
fi

# Attach to the tmux session
tmux attach-session -t "$session"
