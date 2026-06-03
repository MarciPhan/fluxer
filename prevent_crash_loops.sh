#!/bin/bash
# Safety script to prevent infinite container crash loops from exhausting the host CPU.

LOG_FILE="/root/fluxer/crash_preventer.log"
MAX_RESTARTS=20

echo "[$(date '+%Y-%m-%d %H:%M:%S')] Running crash loop prevention check..." >> "$LOG_FILE"

# Find all container IDs
containers=$(docker ps -a --format "{{.ID}}")

for container_id in $containers; do
    name=$(docker inspect --format '{{.Name}}' "$container_id" | sed 's/\///')
    status=$(docker inspect --format '{{.State.Status}}' "$container_id")
    restarts=$(docker inspect --format '{{.RestartCount}}' "$container_id")
    
    # Check if container is part of fluxer stack or discord bot
    if [[ "$name" =~ "fluxer" ]] || [[ "$name" =~ "discord" ]]; then
        # Condition 1: Container is actively in 'restarting' state
        # Condition 2: Container has restarted more than MAX_RESTARTS times and is not healthy
        if [ "$status" = "restarting" ] || { [ "$restarts" -gt "$MAX_RESTARTS" ] && [ "$status" != "running" ]; }; then
            echo "[$(date '+%Y-%m-%d %H:%M:%S')] WARNING: Container $name (ID: $container_id) is in a crash loop (Status: $status, Restarts: $restarts). Stopping container to save CPU." >> "$LOG_FILE"
            
            # Stop the container to break the loop
            docker stop "$container_id" >> "$LOG_FILE" 2>&1
            
            # Reset restart count so we don't trigger again immediately if manually started
            # Note: restarting/recreating resets this automatically, but stopping prevents CPU hogging.
        fi
    fi
done
