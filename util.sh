#----------------------------------------------------------------------------------
printRed() {
    echo -e "\e[31m${1}\e[39m"
}

printGreen() {
    echo -e "\e[32m${1}\e[39m"
}

#------------------------------------------------------------------------------------

checkVarInConf() {
    local VAR_NAME="$1"
    if [ -z "${!VAR_NAME}" ]; then
        echo "$VAR_NAME variable is not found in .conf file"
        exit 1
    fi
}

checkDirExists() {
    local VAR_NAME="$1"
    if [ ! -d "${!VAR_NAME}" ]; then
        echo "Directory specified as $VAR_NAME (${$VAR_NAME}) does not exist"
        exit 2
    fi
}

mvt () {     
    checkVarInConf TRASH_DIR
    rand_suffix=$(date +%s%N)
    tmp_file="${1}${rand_suffix}"
    mv "$1" "${tmp_file}"
    mv "${tmp_file}" ${TRASH_DIR}
}
