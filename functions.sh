# reusable functions

function file_exists() {
    [ -f "$1" ]
}

function command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# spinner for funsies

function spinner() {
    local pid=$1
    local delay=0.2
    local spinstr='/-\|'
    while kill -0 $pid 2>/dev/null; do
        for (( i=0; i<${#spinstr}; i++ )); do
            printf "\r [%c]  " "${spinstr:$i:1}"
            sleep $delay
        done
    done
    printf "\r"
}
function process_data() {
    local input_file="$1"
    local output_file="$2"
    local counter=1

    while IFS= read -r line; do
        printf "%d;%s\n" "$counter" "$line" >> "$output_file"
        ((counter++))
    done < "$input_file"
}