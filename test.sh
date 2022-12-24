#!/bin/bash
perc=0
test_amount=10
iterations=10
philo=./philo

COM_COLOR="\033[0;34m"
OBJ_COLOR="\033[0;36m"
OK_COLOR="\033[0;32m"
ERROR_COLOR="\033[0;31m"
WARN_COLOR="\033[0;33m"
NO_COLOR="\033[0m"

printf "\e[1;1H\e[2J"
printf "\n${COM_COLOR}Philo Tester${NO_COLOR}\t$(date +%Y/%m/%d)\n\n"

perc_correct_die () {
    count_false=0
    count_correct=0
    for (( i=0; i < $test_amount; i++))  ; do
        printf "$i\t"
        lines=$($philo $1 $2 $3 $4 $5 | wc -l)
        if (( $lines > $6 )) ; then
            printf "${ERROR_COLOR}Damn${NO_COLOR} $lines\t"
            printf "${ERROR_COLOR}[x]${NO_COLOR}\n"
            (( count_false++ ))
        else
            printf "${OK_COLOR}Yay${NO_COLOR} $lines\t"
            printf "${OK_COLOR}[✓]${NO_COLOR}\n"
            (( count_correct++ ))
        fi
    done
    perc=$(awk -v count="$count_correct" -v tests="$test_amount" 'BEGIN {print 100 / tests * count}')
}

test_live() {
    lines=$($philo $1 $2 $3 $4 $5)
    printf "$lines\n"
}

perc_correct_live () {
    count_false=0
    count_correct=0
    for (( i=0; i < $test_amount; i++)) ; do
        printf "$i\t"
        lines=$($philo $1 $2 $3 $4 $5| wc -l)
        if (( $lines < $6 )) ; then
            printf "${ERROR_COLOR}Damn${NO_COLOR} $lines\t"
            printf "${ERROR_COLOR}[x]${NO_COLOR}\n"
            (( count_false++ ))
        else
            printf "${OK_COLOR}Yay${NO_COLOR} $lines\t"
            printf "${OK_COLOR}[✓]${NO_COLOR}\n"
            (( count_correct++ ))
        fi
    done
    perc=$(awk -v count="$count_correct" -v tests="$test_amount" 'BEGIN {print 100 / tests * count}')
}

test_live 5 800 200 200 10 245

for (( i=1; i <= $iterations; i++))
do
    printf "${OBJ_COLOR}Testing uneven numbers - they shouldn't die${NO_COLOR}\n"
    printf "${WARN_COLOR}5 800 200 200${NO_COLOR} (10)\n"
    perc_correct_live 5 800 200 200 10 245 # 20 490
	printf "$perc %% correct\n"
	printf "______________________\n"
    printf "${WARN_COLOR}5 610 200 200${NO_COLOR} (10)\n"
    perc_correct_live 5 610 200 200 10 245 #20 490
    printf "$perc %% correct\n"
	printf "______________________\n"
    printf "${WARN_COLOR}199 610 200 200${NO_COLOR} (10)\n"
    perc_correct_live 199 610 200 200 10 10000 #20 20000
    printf "$perc %% correct\n"
	printf "______________________\n"

    printf "${OBJ_COLOR}Testing even numbers - they shouldn't die${NO_COLOR}\n"
    printf "${WARN_COLOR}4 410 200 200${NO_COLOR} (10)\n"
    perc_correct_live 4 410 200 200 10 200 #20 390
    printf "$perc %% correct"
	printf "______________________"
    printf "${WARN_COLOR}198 610 200 200${NO_COLOR} (10)\n"
    perc_correct_live 198 610 200 200 10 9800 #20 20000
    printf "$perc %% correct"
	printf "______________________"
    printf "${WARN_COLOR}198 610 200 200${NO_COLOR} (10)\n"
    perc_correct_live 198 800 200 200 10 10000 #20 20000
    printf "$perc %% correct"
	printf "______________________"

    printf "${OBJ_COLOR}Testing even numbers - one should die${NO_COLOR}\n"
    printf "3 599 200 200 (10)"
    perc_correct_die 3 599 200 200 10 20
	printf "$perc %% correct"
	printf "______________________"
    printf "31 599 200 200"
    perc_correct_die 31 599 200 200 10 220
    printf "$perc %% correct"
	printf "______________________"
    printf "131 596 200 200"
    perc_correct_die 131 596 200 200 10 920
    printf "$perc %% correct"
	printf "______________________"

    printf "${OBJ_COLOR}Testing uneven numbers - one should die${NO_COLOR}\n"
    printf "4 310 200 100"
    perc_correct_die 4 310 200 100 10 25
    printf "$perc %% correct"
	printf "______________________"
    printf "1 800 200 200"
    perc_correct_die 1 800 200 100 10 1
    printf "$perc %% correct"
	printf "______________________"

done