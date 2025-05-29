#!/usr/bin/env bash
set -euo pipefail

SERVICE_NAME=custom_kanata.service
SRC="/home/kristian/.config/kanata/${SERVICE_NAME}"
DST="/etc/systemd/system/${SERVICE_NAME}"

if [[ ! -f "${SRC}" ]]; then
  echo "Error: ${SRC} not found."
  exit 1
fi

echo "Copying ${SRC} → ${DST} (requires sudo)…"
sudo cp "${SRC}" "${DST}"

echo "Reloading systemd daemon…"
sudo systemctl daemon-reload

echo "Enabling & starting ${SERVICE_NAME}…"
sudo systemctl enable --now "${SERVICE_NAME}"

echo "Done! ${SERVICE_NAME} is active:"
systemctl status "${SERVICE_NAME}" --no-pager

