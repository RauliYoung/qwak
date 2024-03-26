#!/bin/bash

. functions.sh
############################################################
# Help                                                     #
############################################################

Help () 
{
    echo "qwak data handler"
    echo 
    echo "Syntax: scriptTemplate [-h|-p]"
    echo "options:"
    echo "p: Expects a function name followed by two parameters."
    echo "   The function will then be executed with the provided parameters."
    echo
    echo "Available functions:"
    ListFunctions
}

ListFunctions()
{
declare -F | awk '{print $3}'
}

animate_qwak() {
    
    frames=("                         __     "
            "  ________  _  _______  |  | __ "
            " / ____/\ \/ \/ /\__  \ |  |/ / "
            "< <_|  | \     /  / __ \|    <  "
            " \__   |  \/\_/  (____  /__|_ \ "
            "    |__|              \/     \/ ")
    delay=0.1
    clear
    for frame in "${frames[@]}"; do
        echo "$frame"
        sleep "$delay"
    done
    echo
}

hello()
{
    echo $1 $2
}
############################################################
# Main program                                             #
############################################################

animate_qwak

#Variables


while getopts ":hp:" option; do
    case $option in
        h) 
            Help
            exit;;
        p)
            shift $((OPTIND - 1))

            if [ "$(type -t "$OPTARG")" = "function" ]; then
                "$OPTARG" "${@}"
                exit
            else
                echo "Error: '$OPTARG' is not a valid function." >&2
                exit 1
            fi
            ;;
        \?)
            echo "qwak -h for list of commands and help"
            exit;;
    esac
done

