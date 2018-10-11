CONDAPREFIX="$HOME/miniconda3"

function install_miniconda(){
    local installer
    installer="$(mktemp -t setup).sh"
    curl -o "$installer" 'https://repo.continuum.io/miniconda/Miniconda3-4.5.4-MacOSX-x86_64.sh'
    bash "$installer" -b -p "$CONDAPREFIX"
    "${CONDAPREFIX}/bin/conda" config --set auto_update_conda false
    "${CONDAPREFIX}/bin/conda" config --add pinned_packages conda=4.5.4 --system
}

function once_miniconda() {
    local title="miniconda"
    local cmd="install_miniconda"
    local check="test -d $CONDAPREFIX"
    once "$title" "$check" "$cmd"
}

once_miniconda

