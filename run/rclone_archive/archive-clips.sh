#!/bin/bash -eu

log "Moving clips to rclone archive..."

source /root/.teslaCamRcloneConfig

FILE_COUNT=$(find "$CAM_MOUNT"/TeslaCam/SavedClips/* -type f | wc -l)

rclone --config /root/.config/rclone/rclone.conf move "$CAM_MOUNT"/TeslaCam/SavedClips "$drive:$path" --create-empty-src-dirs --delete-empty-src-dirs >> "$LOG_FILE" 2>&1 || echo ""

FILES_REMAINING=$(find "$CAM_MOUNT"/TeslaCam/SavedClips/* -type f | wc -l)
NUM_FILES_MOVED=$((FILE_COUNT-FILES_REMAINING))

log "Moved $NUM_FILES_MOVED file(s)."
/root/bin/send-push-message "TeslaUSB:" "Moved $NUM_FILES_MOVED dashcam file(s)."


log "Finished moving clips to rclone archive"
