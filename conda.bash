CONDAPREFIX="$HOME/miniconda3"

function install_miniconda(){
    local installer
    installer="$(mktemp -t setup).sh"
    curl -o "$installer" 'https://repo.continuum.io/miniconda/Miniconda3-latest-MacOSX-x86_64.sh'
    bash "$installer" -b -p "$CONDAPREFIX"
}

function once_miniconda() {
    local title="miniconda"
    local cmd="install_miniconda"
    local check="test -d $CONDAPREFIX"
    once "$title" "$check" "$cmd"
}

once_miniconda
inst_conda jedi

