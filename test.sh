#!/bin/bash

percent=0
count_correct_all=0
count_false_all=0
iterations=10
times_to_eat=10
folder=fails/
tempfile=tempfile

function cleanup()
{
    rm -f $tempfile
    if [ -z "$(ls -A fails)" ]; then
        rm -rf fails
    fi
}
trap cleanup EXIT

while getopts gi:t: OPTION; do
  case "$OPTION" in
    i)
      iterations="$OPTARG"
      ;;
    t)
      times_to_eat="$OPTARG"
      ;;
    g)
      printf "GitHub repo testing to be implemented.\n"
      ;;
    ?)
      printf "script usage: $0 [-i iterations] [-t times_to_eat] [path]\n" >&2
      exit 1
      ;;
  esac
done
shift "$(($OPTIND -1))"

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
BH_OK_COLOR="\e[1;92m"

DEFCL="\033[0m"
DEL_R="\033[A\r"
DEL_K="\033[K\r"

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

print_loading_bar () {
    printf "LOADING\t"
    for (( x=10; x <= $1; x+=10)) ; do
    {
        if (( $1 % 10 == 0 )) ; then
            printf "${BH_OK_COLOR}#${RESET}"
        fi
    }
    done
}

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
        q)
            printf "\e[1;1H\e[2J"
			exit 0
            ;;
		*)
            printf "\e[1;1H\e[2J"
			printf "${WARN_COLOR}Invalid input!\n${RESET}"
			visualizer
			;;
	esac
}

normal_hardcore () {
    printf "\e[1;1H\e[2J"
    printf "\n${COM_COLOR}42 Philosophers Tester${RESET}\t$(date +%Y/%m/%d)\nIterations: ${iterations}\n\n"
    printf "${PURPLE_BOLD}Mandatory tests (eval sheet)\t\t[0]${RESET}\n\n"
    printf "Normal tests\t\t\t\t[1]\n"
    printf "Hardcore tests (a lot)\t\t\t[2]\n\n"
    printf "Exit Tester\t\t\t\t[ESC]\n\n"
	read -r -n 1 -p $'\n\nPlease choose:' test
	printf "\n"
	case $test in
		0)
            printf "\e[1;1H\e[2J"
			mandatory_tests
			;;
		1)
            printf "\e[1;1H\e[2J"
			normal_tests
			;;
        2)
            printf "\e[1;1H\e[2J"
			hardcore_tests
			;;
		$'\e')
            printf "\e[1;1H\e[2J"
			exit 0
			;;
        q)
            printf "\e[1;1H\e[2J"
			exit 0
            ;;
		*)
            printf "\e[1;1H\e[2J"
			printf "${WARN_COLOR}Invalid input!\n${RESET}"
			normal_hardcore
			;;
	esac
}

normal_tests () {
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
        q)
            printf "\e[1;1H\e[2J"
			exit 0
            ;;
		*)
            printf "\e[1;1H\e[2J"
			printf "${WARN_COLOR}Invalid input!\n${RESET}"
			normal_tests
			;;
	esac
}

hardcore_tests () {
    text
	read -r -n 1 -p $'\n\nPlease choose:' test
	printf "\n"
	case $test in
		0)
            printf "\e[1;1H\e[2J"
			uneven_live
            uneven_live_extended
            even_live
            even_live_extended
            uneven_die
            uneven_die_extended
            even_die
            even_die_extended
			;;
		1)
            printf "\e[1;1H\e[2J"
			uneven_live
            uneven_live_extended
			;;
		2)
            printf "\e[1;1H\e[2J"
			even_live
            even_live_extended
			;;
		3)
            printf "\e[1;1H\e[2J"
            uneven_live
            uneven_live_extended
			even_live
            even_live_extended
			;;
		4)
            printf "\e[1;1H\e[2J"
            uneven_die
            uneven_die_extended
			;;
		5)
            printf "\e[1;1H\e[2J"
			even_die
            even_die_extended
			;;
		6)
            printf "\e[1;1H\e[2J"
            uneven_die
            uneven_die_extended
			even_die
            even_die_extended
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
        q)
            printf "\e[1;1H\e[2J"
			exit 0
            ;;
		*)
            printf "\e[1;1H\e[2J"
			printf "${WARN_COLOR}Invalid input!\n${RESET}"
			hardcore_tests
			;;
	esac
}

die () {
    count_false=0
    count_correct=0
    loading_bar_count=0
    printf "\t${WARN_COLOR}$1 $2 $3 $4 $5${RESET}\n"
    for (( i=1; i <= $iterations; i++)) ; do
        print_loading_bar $(awk -v count="$loading_bar_count" -v tests="$iterations" 'BEGIN {print 100 / tests * count}')
        lines=$($philo $1 $2 $3 $4 $5 > ${tempfile})
        end_line=$(tail -n 1 ${tempfile})
        if [ $(tail -n 1 ${tempfile} | grep -c died) -ne 0 ]; then
            printf "\e[2K \r$i\t${OK_COLOR}Pass${RESET}\t"
            printf "${OK_COLOR}[✓]${RESET}\t"
            printf "$(tail -n 1 ${tempfile})\n"
            (( count_correct++ ))
            (( count_correct_all++ ))
        else
            printf "\e[2K \r$i\t${ERROR_COLOR}Fail${RESET}\t"
            printf "${ERROR_COLOR}[x]${RESET}\t"
            printf "$(tail -n 1 ${tempfile})\n"
            cat ${tempfile} > ${folder}$1-$2-$3-$4-$5_$i
            (( count_false++ ))
            (( count_false_all++ ))
        fi
        (( loading_bar_count++ ))
    done
    print_percent `awk -v count="$count_correct" -v tests="$iterations" 'BEGIN {print 100 / tests * count}'`
}

live () {
    count_false=0
    count_correct=0
    loading_bar_count=0
    printf "\t${WARN_COLOR}$1 $2 $3 $4 $5${RESET}\n"
    for (( i=1; i <= $iterations; i++)) ; do
        print_loading_bar $(awk -v count="$loading_bar_count" -v tests="$iterations" 'BEGIN {print 100 / tests * count}')
        lines=$($philo $1 $2 $3 $4 $5 > ${tempfile})
        end_line=$(tail -n 1 ${tempfile})
        if [ $(tail -n 1 ${tempfile} | grep -c died) -ne 0 ]; then
            printf "\e[2K \r$i\t${ERROR_COLOR}Fail${RESET}\t"
            printf "${ERROR_COLOR}[x]${RESET}\t"
            printf "$(tail -n 1 ${tempfile})\n"
            cat ${tempfile} > ${folder}$1-$2-$3-$4-$5_$i
            (( count_false++ ))
            (( count_false_all++ ))
        else
            printf "\e[2K \r$i\t${OK_COLOR}Pass${RESET}\t"
            printf "${OK_COLOR}[✓]${RESET}\t"
            printf "$(tail -n 1 ${tempfile})\n"
            (( count_correct++ ))
            (( count_correct_all++ ))
        fi
        (( loading_bar_count++ ))
    done
    print_percent `awk -v count="$count_correct" -v tests="$iterations" 'BEGIN {print 100 / tests * count}'`
}

print_percent () {
    if [ $1 -gt 89 ]; then
        printf "\t${OK_COLOR_BOLD}$1 %% correct${RESET}\n" 
    elif [ $1 -gt 69 ]; then
        printf "\t${WARN_COLOR_BOLD}$1 %% correct${RESET}\n" 
    else
        printf "\t${ERROR_COLOR_BOLD}$1 %% correct${RESET}\n"
    fi
    printf "____________________________________________\n"
}

mandatory_tests () {
    printf "${OBJ_COLOR}Mandatory tests${RESET}\n\n"
    die 1 800 200 200 $times_to_eat
    live 5 800 200 200 7
    live 4 410 200 200 $times_to_eat
    die 4 310 200 100 $times_to_eat
}

uneven_live () {
    printf "${OBJ_COLOR}Testing uneven numbers - they shouldn't die${RESET}\n\n"
    live 5 800 200 200 $times_to_eat
    live 5 610 200 200 $times_to_eat
    live 199 610 200 200 $times_to_eat
}

uneven_live_extended () {
    printf "${OBJ_COLOR}Testing uneven numbers (overkill) - they shouldn't die${RESET}\n\n"
    live 5 610 200 100 $times_to_eat
    live 5 601 200 200 $times_to_eat
    live 31 610 200 100 $times_to_eat
    live 31 610 200 200 $times_to_eat
    live 31 605 200 200 $times_to_eat
    live 31 601 200 200 $times_to_eat
    live 131 610 200 100 $times_to_eat
    live 131 610 200 200 $times_to_eat
    live 131 605 200 200 $times_to_eat
    live 131 601 200 200 $times_to_eat
    live 199 610 200 100 $times_to_eat
    live 199 610 200 200 $times_to_eat
    live 199 605 200 200 $times_to_eat
    live 199 601 200 200 $times_to_eat
}

even_live () {
    printf "${OBJ_COLOR}Testing even numbers - they shouldn't die${RESET}\n"
    live 4 410 200 100 $times_to_eat
    live 4 410 200 200 $times_to_eat
    live 198 610 200 200 $times_to_eat
    live 198 800 200 200 $times_to_eat
}

even_live_extended () {
    printf "${OBJ_COLOR}Testing even numbers (overkill) - they shouldn't die${RESET}\n"
    live 50 410 200 100 $times_to_eat
    live 50 410 200 200 $times_to_eat
    live 50 405 200 200 $times_to_eat
    live 50 401 200 200 $times_to_eat
    live 130 410 200 100 $times_to_eat
    live 130 410 200 200 $times_to_eat
    live 130 405 200 200 $times_to_eat
    live 130 401 200 200 $times_to_eat
    live 198 410 200 100 $times_to_eat
    live 198 410 200 200 $times_to_eat
    live 198 405 200 200 $times_to_eat
    live 198 401 200 200 $times_to_eat
}

even_die () {
    printf "${OBJ_COLOR}Testing even numbers - one should die${RESET}\n"
    die 3 599 200 200 $times_to_eat
    die 31 599 200 200 $times_to_eat
    die 131 596 200 200 $times_to_eat
}

even_die_extended () {
    printf "${OBJ_COLOR}Testing even numbers - one should die${RESET}\n"
    die 4 310 200 100 $times_to_eat
    die 50 396 200 200 $times_to_eat
    die 50 399 200 200 $times_to_eat
    die 50 400 200 200 $times_to_eat
    die 130 396 200 200 $times_to_eat
    die 130 399 200 200 $times_to_eat
    die 130 400 200 200 $times_to_eat
    die 198 396 200 200 $times_to_eat
    die 198 399 200 200 $times_to_eat
    die 198 400 200 200 $times_to_eat
}

uneven_die () {
    printf "${OBJ_COLOR}Testing uneven numbers - one should die${RESET}\n"
    die 4 310 200 100 $times_to_eat
    die 1 800 200 100 $times_to_eat
}

uneven_die_extended () {
    printf "${OBJ_COLOR}Testing uneven numbers - one should die${RESET}\n"
    die 3 596 200 200 $times_to_eat
    die 3 599 200 200 $times_to_eat
    die 3 600 200 200 $times_to_eat
    die 31 596 200 200 $times_to_eat
    die 31 599 200 200 $times_to_eat
    die 31 600 200 200 $times_to_eat
    die 131 596 200 200 $times_to_eat
    die 131 599 200 200 $times_to_eat
    die 131 600 200 200 $times_to_eat
    die 199 596 200 200 $times_to_eat
    die 199 599 200 200 $times_to_eat
    die 199 600 200 200 $times_to_eat
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
    printf "\n${COM_COLOR}42 Philosophers Tester${RESET}\t$(date +%Y/%m/%d)\nIterations: ${iterations}\n\n"
    printf "${PURPLE_BOLD}All tests\t\t\t\t[0]${RESET}\n\n"
    printf "Uneven numbers that shouldn't die\t[1]\n"
    printf "Even numbers that shouldn't die\t\t[2]\n"
    printf "${PURPLE_BOLD}All numbers that shouldn't die\t\t[3]${RESET}\n\n"
    printf "Uneven numbers that should die\t\t[4]\n"
    printf "Even numbers that should die\t\t[5]\n"
    printf "${PURPLE_BOLD}All numbers that should die\t\t[6]${RESET}\n\n"
    printf "${PURPLE}Own tests\t\t\t\t[7]${RESET}\n"
    printf "Exit Tester\t\t\t\t[ESC]\n\n"
}

normal_hardcore
rm -f test
printf "\n${BOLD}RESULT: passed: ${count_correct_all}\tfailed: ${count_false_all}${RESET}\n"
print_percent `awk -v count="$count_correct_all" -v tests_fail="$count_false_all" 'BEGIN {print 100 / (count + tests_fail) * count}'`

if [ -z "$(ls -A fails)" ]; then
   rm -rf fails
fi

# if [ -d "fails" ]; then
#     visualizer
# fi
