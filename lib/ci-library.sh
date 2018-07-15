# Based upon 
# https://github.com/Alexpux/MINGW-packages/blob/master/ci-library.sh
# and https://github.com/episource/archlinux-overlay


PACKAGES=()

# Print a colored log message
function _log() {
    local type="${1}"
    shift
    local msg="${@}"
    
    local normal='\e[0m'
    local red='\e[1;31m'   
    local green='\e[1;32m'
    local yellow='\e[1;33m'
    local cyan='\e[1;36m'
    
    case "${type}" in
        failure) echo -e "$red$msg$normal" ;;
        success) echo -e "$green$msg$normal" ;;
        build_step) echo -e "$green$msg$normal" ;;
        command) echo -e "$cyan$msg$normal" ;;
        message) echo -e "$msg" ;;
    esac
}

# Execute command and stop execution if the command fails
function _do() {
    CMD=$@
    _log command "$CMD"
    $CMD || { _log failure "FAILED: $CMD"; exit 1; }
    return $?
}

# Ensure that the given environment variable has been defined and is not empty
function _ensure-var() {
    local -n VARNAME=$1
    if [[ -z ${VARNAME+x} ]]; then
        _log failure "Environment variable $1 not defined."
        exit 1
    fi
}


# Package provides another (ignoring version constraints)
function _package_provides() {
    local package="${1}"
    local another_without_version="${2%%[<>=]*}"
    local pkgname provides
    _package_info "${package}" pkgname provides
    for pkg_name in "${pkgname[@]}";  do [[ "${pkg_name}" = "${another_without_version}" ]] && return 0; done
    for provided in "${provides[@]}"; do [[ "${provided}" = "${another_without_version}" ]] && return 0; done
    return 1
}

# Get package information
function _package_info() {
    local package="${1}"
    local properties=("${@:2}")
    for property in "${properties[@]}"; do
        local -n nameref_property="${property}"
        nameref_property=($(
            source "${package}/PKGBUILD"
            declare -n nameref_property="${property}"
            echo "${nameref_property[@]}"))
    done
}

# Add package to build after required dependencies
function _build_add() {
    local package="${1}"
    local depends makedepends
    for sorted_package in "${sorted_packages[@]}"; do
        [[ "${sorted_package}" = "${package}" ]] && return 0
    done
    echo "${1}"
    _package_info "${package}" depends makedepends
    for dependency in "${depends[@]}" "${makedepends[@]}"; do
        for unsorted_package in "${PACKAGES[@]}"; do
            [[ "${package}" = "${unsorted_package}" ]] && continue
            _package_provides "${unsorted_package}" "${dependency}" && _build_add "${unsorted_package}"
        done
    done
    sorted_packages+=("${package}")
}

# Convert lines to array
_as_list() {
    local -n nameref_list="${1}"
    local filter="${2}"
    local strip="${3}"
    local lines="${4}"
    local result=1
    nameref_list=()
    while IFS= read -r line; do
        test -z "${line}" && continue
        result=0
        [[ "${line}" = ${filter} ]] && nameref_list+=("${line/${strip}/}")
    done <<< "${lines}"
    return "${result}"
}

# Changes since master or from head
function _list_changes() {
    local list_name="${1}"
    local filter="${2}"
    local strip="${3}"
    local git_options=("${@:4}")
    #_as_list "${list_name}" "${filter}" "${strip}" "$(git log "${git_options[@]}" master.. | sort -u)" ||
    #_as_list "${list_name}" "${filter}" "${strip}" "$(git log "${git_options[@]}" HEAD^.. | sort -u)"
    _as_list "${list_name}" "${filter}" "${strip}" "$(git diff-tree "${git_options[@]}" HEAD)"
}

# Added commits
function list_commits()  {
    _list_changes commits '*' '#*::' --pretty=format:'%ai::[%h] %s'
}

# Changed recipes
function list_packages() {
    local _packages
    local _orders
    _list_changes _packages '*/PKGBUILD' '%/PKGBUILD' --no-commit-id --pretty=format: --name-only -r || return 1
    for _package in "${_packages[@]}"; do
        PACKAGES+=("${_package}")
    done
    
    # check if there are some .order file
    _list_changes _orders '*.order' '%' --no-commit-id --pretty=format: --name-only -r || return 1    
    for _order in "${_orders[@]}"; do
        exec 3<$_order
        while read -u3 _line; do
            [[ $_line =~ ^[:blank:]*$ ]] && continue

            local comment_re="^[:blank:]*#"
            [[ $_line =~ $comment_re ]] && continue

            PACKAGES+=("${_line}")
        done
    done
    return 0
}

function set_packages() {
    PACKAGES=$1
}

function print_packages() {
    for p in "${PACKAGES[@]}"; do
        echo "${p}"
    done
}


# extracts all 'validpgpkeys' from the PKGBUILDs
# extracts all 'validpgpkeys' listed in the PKGBUILDs belonging to $PACKAGES
function get_validpgpkeys() {
    _VALIDPGPKEYS=()
    for p in "${PACKAGES[@]}"; do
        local validpgpkeys=()
        _package_info "$p" validpgpkeys
        _VALIDPGPKEYS+=$validpgpkeys
    done
    
    echo "${_VALIDPGPKEYS[@]}"
}

# Sort packages by dependency
#   reorders $PACKAGES such that dependencies are built first
function sort_packages_by_dependency() {
    local sorted_packages=()
    for p in "${PACKAGES[@]}"; do
        echo "ciao"
        _build_add "${p}"
    done
    PACKAGES=("${sorted_packages[@]}")
}

# determine the repository to build against
function get_repository() {
    # save the current branch as the default repository
    local current_repo=$CI_COMMIT_REF_NAME

    if [ "$current_repo" == "master" ]; then
    current_repo="stable"
    fi

    # verify if a manual override is present in the git comment
    GIT_COMMIT_MESSAGE=$(git rev-list --format=%B --max-count=1 HEAD)
    # extract the text between brackets, ex. [stable], [testing]
    tokens=$(echo $GIT_COMMIT_MESSAGE | cut -d "[" -f2 | cut -d "]" -f1)

    for token in $tokens;
    do
        case "$token" in
        "stable")
            current_repo="stable"
            ;;
        "testing")
            current_repo="testing"
            ;;
        "staging" | "unstable")
            current_repo="staging"
            ;;
        *)
            ;;
        esac
    done

    echo "$current_repo"
}
