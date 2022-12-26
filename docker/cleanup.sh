#!/bin/bash

# WARNING! This will remove:
#   - all stopped containers
#   - all networks not used by at least one container
#   - all volumes not used by at least one container
#   - all dangling images
#   - all dangling build cache
docker system prune --volumes
clear