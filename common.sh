#!/usr/bin/env bash

#------------------------------------------------------------------------------------
set -e  # Fail on first error

# Some useful global variables and constants
CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
SCRIPT_NAME="$0"

REAL_CURRENT_DIR=$(readlink -f "$CURRENT_DIR")
PROJECT_ROOT="$REAL_CURRENT_DIR"

source $PROJECT_ROOT/.conf
[ -z LOG4BASH_INITIALIZED ] && source $PROJECT_ROOT/log4bash.sh
source $PROJECT_ROOT/util.sh

#---------------------------------------------------------------------------------

checkVarInConf RAW_DATASETS_DIR
checkVarInConf PARSED_DATASETS_DIR

checkDirExists RAW_DATASETS_DIR
checkDirExists PARSED_DATASETS_DIR
#------------------------------------------------------------------------------------

displayGeneralDatasetInfoVerbose() {
    local _dataset="$1"
    echo
    echo "$_dataset  (Location $RAW_DATASETS_DIR/$_dataset)"
    if [ -d "$PARSED_DATASETS_DIR/$_dataset/parsed" ]; then
        printGreen "parsed"
    else
        printRed "not parsed"
    fi
    echo
}

getTokensNumberInRepr() {
    local _dataset_name="$1"
    local _repr_name="$2"
    local _result_var_name="$3"
    local _long_option="$4"

    local _parsed_dataset_dir="$PARSED_DATASETS_DIR/$_dataset_name"
    local _n_tokens_file="$_parsed_dataset_dir/metadata/$_repr_name/n_tokens"
    local _n_tokens="UNK"
    if [[ ! -f "$_n_tokens_file" ]]; then
        if [[ "$_long_option" == "-ll" ]]; then
            $CURRENT_DIR/wc $_dataset_name $_repr_name
            _n_tokens=$(tail -n 1 $_n_tokens_file)
        fi
    else
        _n_tokens=$(tail -n 1 $_n_tokens_file)
    fi
    printf -v "$_result_var_name" '%s' "$_n_tokens"
}

getVocabSize() {
    local _dataset_name="$1"
    local _repr_name="$2"
    local _result_var_name="$3"

    local _parsed_dataset_dir="$PARSED_DATASETS_DIR/$_dataset_name"
    local _vocabsize_file="$_parsed_dataset_dir/metadata/$_repr_name/vocabsize"
    local _vocabsize="UNK"

    if [[ ! -f "$_vocabsize_file" ]]; then
        if [[ "$_long_option" == "-ll" ]]; then
            log_info "Calculating vocabulary size in $_dataset_name ... It may take a while ..."
            log_debug "Looking at $_parsed_dataset_dir/repr/$_repr_name"

            cd ${PATH_TO_PROJECT}

            local _cmd="${PYTHON} logrec/dataprep/vocabsize.py --base-from ${PARSED_DATASETS_DIR} ${_dataset_name} ${_repr_name}"
            log_info "Running the following command:"
            printGreen "${_cmd}"
            ${_cmd}
            cd -
            _vocabsize=$(head -n 1 $_vocabsize_file | awk '{print $1}')
        fi
    else
        _vocabsize=$(head -n 1 $_vocabsize_file | awk '{print $1}')
    fi

    printf -v "$_result_var_name" '%s' "$_vocabsize"
}
