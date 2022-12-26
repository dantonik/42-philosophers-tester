#!/bin/bash

WARN_COLOR="\033[0;33m"
RESET="\033[0m"

docker run --rm -ti -v $PWD/../..:/test memory-test:0.1 bash -c "cd /test/; make re && clear && printf '\n${WARN_COLOR}Command example:${RESET} valgrind --tool=helgrind ./philo <ARGS>\n\n' && bash"

clear
printf "\n${WARN_COLOR}Do you want to clean up (prune) Docker?${RESET}\n\n"
bash cleanup.sh