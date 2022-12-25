#!/bin/bash
perc=0
iterations=10
folder=fails/

COM_COLOR="\033[0;34m"
OBJ_COLOR="\033[0;36m"
OK_COLOR="\033[0;32m"
ERROR_COLOR="\033[0;31m"
WARN_COLOR="\033[0;33m"
PURPLE="\033[0;35m"
RESET="\033[0m"
BOLD="\033[1m"
PURPLE_BOLD="\033[1;35m"
OK_COLOR_BOLD="\033[0;32m"
ERROR_COLOR_BOLD="\033[0;31m"
WARN_COLOR_BOLD="\033[0;33m"

if [ "$#" -gt 1 ]; then
	printf "Invalid input!\n"
	exit
elif [ "$#" -lt 1 ]; then
	philo=../philo
else
    philo=$1
fi

if [ -d "${folder}" ]; then
    rm -rf ${folder};
fi

mkdir ${folder}

if [ ! -x "${philo}" ]; then
    make re
fi

if ! command ${philo} 5 200 100 100 &> /dev/null; then
    printf "\e[1;1H\e[2J"
    printf "Couldn't execute \"${philo}\"!\n"
    exit 1
fi

visualizer () {
    printf "\n\n${COM_COLOR}Visualize failed tests\t[0]${RESET}\n\n"
    printf "${BOLD}Keep failed tests\t\t\t\t[1]${RESET}\n\n"
    printf "${BOLD}Delete failed tests\t\t\t\t[2]${RESET}\n\n"
    read -r -n 1 -p $'Please choose:' test
    printf "\n"
    	case $test in
		0)
            $(bash visualizer.sh)
			;;
        1)
            exit 0
			;;
    	2)
            rm -rf fails
			;;
		$'\e')
            printf "\e[1;1H\e[2J"
			exit 0
			;;
		*)
            printf "\e[1;1H\e[2J"
			printf "${WARN_COLOR}Invalid input!\n${RESET}"
			tests
			;;
	esac
}

tests () {
    text
	read -r -n 1 -p $'\n\nPlease choose:' test
	printf "\n"
	case $test in
		0)
            printf "\e[1;1H\e[2J"
			uneven_live
            even_live
            uneven_die
            even_die
			;;
		1)
            printf "\e[1;1H\e[2J"
			uneven_live
			;;
		2)
            printf "\e[1;1H\e[2J"
			even_live
			;;
		3)
            printf "\e[1;1H\e[2J"
            uneven_live
			even_live
			;;
		4)
            printf "\e[1;1H\e[2J"
            uneven_die
			;;
		5)
            printf "\e[1;1H\e[2J"
			even_die
			;;
		6)
            printf "\e[1;1H\e[2J"
            uneven_die
			even_die
			;;
        7)
            printf "\e[1;1H\e[2J"
            own_test
            exit 0
            ;;
		$'\e')
            printf "\e[1;1H\e[2J"
			exit 0
			;;
		*)
            printf "\e[1;1H\e[2J"
			printf "${WARN_COLOR}Invalid input!\n${RESET}"
			tests
			;;
	esac
}

die () {
    count_false=0
    count_correct=0
    printf "\t${WARN_COLOR}$1 $2 $3 $4 $5${RESET}\n"
    for (( i=1; i <= $iterations; i++)) ; do
        printf "$i\t"
        lines=$($philo $1 $2 $3 $4 $5 > test)
        if [ $(tail -n 1 test | grep -c died) -ne 0 ]; then
            printf "${OK_COLOR}Pass${RESET}\t"
            printf "${OK_COLOR}[✓]${RESET}\t"
            printf "$(tail -n 1 test)\n"
            (( count_correct++ ))
        else
            printf "${ERROR_COLOR}Fail${RESET}\t"
            printf "${ERROR_COLOR}[x]${RESET}\t"
            printf "$(tail -n 1 test)\n"
            cat test > ${folder}$1-$2-$3-$4-$5_$i
            (( count_false++ ))
        fi
    done
    print_perc `awk -v count="$count_correct" -v tests="$iterations" 'BEGIN {print 100 / tests * count}'`
}

live () {
    count_false=0
    count_correct=0
    printf "\t${WARN_COLOR}$1 $2 $3 $4 $5${RESET}\n"
    for (( i=1; i <= $iterations; i++)) ; do
        printf "$i\t"
        lines=$($philo $1 $2 $3 $4 $5 > test)
        if [ $(tail -n 1 test | grep -c died) -ne 0 ]; then
            printf "${ERROR_COLOR}Fail${RESET}\t"
            printf "${ERROR_COLOR}[x]${RESET}\t"
            printf "$(tail -n 1 test)\n"
            cat test > ${folder}$1-$2-$3-$4-$5_$i
            (( count_false++ ))
        else
            printf "${OK_COLOR}Pass${RESET}\t"
            printf "${OK_COLOR}[✓]${RESET}\t"
            printf "$(tail -n 1 test)\n"
            (( count_correct++ ))
        fi
    done
    print_perc `awk -v count="$count_correct" -v tests="$iterations" 'BEGIN {print 100 / tests * count}'`
}

print_perc () {
    printf "____________________________________________\n"
    if [ $1 -gt 89 ]; then
        printf "\t${OK_COLOR_BOLD}$1 %% correct${RESET}\n" 
    elif [ $1 -gt 69 ]; then
        printf "\t${WARN_COLOR_BOLD}$1 %% correct${RESET}\n" 
    else
        printf "\t${ERROR_COLOR_BOLD}$1 %% correct${RESET}\n"
    fi
    printf "____________________________________________\n"
}

uneven_live () {
    printf "${OBJ_COLOR}Testing uneven numbers - they shouldn't die${RESET}\n\n"
    live 5 800 200 200 10
    live 5 610 200 200 10 245
    live 199 610 200 200 10 10000
}

even_live () {
    printf "${OBJ_COLOR}Testing even numbers - they shouldn't die${RESET}\n"
    live 4 410 200 200 10 200
    live 198 610 200 200 10 9800
    live 198 800 200 200 10 10000
}

even_die () {
    printf "${OBJ_COLOR}Testing even numbers - one should die${RESET}\n"
    die 3 599 200 200 10 20
    die 31 599 200 200 10 220
    die 131 596 200 200 10 920
}

uneven_die () {
    printf "${OBJ_COLOR}Testing uneven numbers - one should die${RESET}\n"
    die 4 310 200 100 10 25
    die 1 800 200 100 10 1
}

own_test () {
    read -r -p $'\n\nNumber_of_philosophers:' n_philos
    printf "\n$n_philos"
    read -r -p $'\n\nTime_to_die:' time_to_die
    printf "\n$n_philos $time_to_die"
    read -r -p $'\n\nTime_to_eat:' time_to_eat
    printf "\n$n_philos $time_to_die $time_to_eat"
    read -r -p $'\n\nTime_to_sleep:' time_to_sleep
    printf "\n$n_philos $time_to_die $time_to_eat $time_to_sleep"
    read -r -p $'\n\nNumber_of_times_each_philosopher_must_eat:' number_of_times_each_philosopher_must_eat
    printf "\n$n_philos $time_to_die $time_to_eat $time_to_sleep $number_of_times_each_philosopher_must_eat"
    read -r -n 1 -p $'\n\nShould die?\t[0]\nShouldn\'t die?\t[1]\n' should_die
    if [ $should_die -eq 0 ]; then
        die $n_philos $time_to_die $time_to_eat $time_to_sleep $number_of_times_each_philosopher_must_eat
    else
        live $n_philos $time_to_die $time_to_eat $time_to_sleep $number_of_times_each_philosopher_must_eat
    fi
}

text () {
    printf "\e[1;1H\e[2J"
    printf "\n${COM_COLOR}42 Philosophers Tester${RESET}\t$(date +%Y/%m/%d)\n\n"
    printf "${PURPLE_BOLD}All tests\t\t\t\t[0]${RESET}\n\n"
    printf "Uneven numbers that shouldn't die\t[1]\n"
    printf "Even numbers that shouldn't die\t\t[2]\n"
    printf "${PURPLE_BOLD}All numbers that shouldn't die\t\t[3]${RESET}\n\n"
    printf "Uneven numbers that should die\t\t[4]\n"
    printf "Even numbers that should die\t\t[5]\n"
    printf "${PURPLE_BOLD}All numbers that should die\t\t[6]${RESET}\n\n"
    printf "${PURPLE}Own tests\t\t\t\t[7]${RESET}\n\n"
}

tests

rm -f test

if [ -z "$(ls -A fails)" ]; then
   rm -rf fails
fi

# if [ -d "fails" ]; then
#     visualizer
# fi
