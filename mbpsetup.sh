#!/bin/bash -eu

export HOMEBREW_CASK_OPTS="--appdir=/Applications"
export HOMEBREW_NO_EMOJI=1
export HOMEBREW_NO_ANALYTICS=1

# Print a justified status message
#
#   $1 - name of the package
#   $2 - package status
function status(){
    local line='---------------------------------------------------'
    local title="$1"
    local stat="$2"
    printf "%s %s [%s]\n" "$title" "${line:${#title}}" "$stat"
}

# Perform an action once.
#
#    $1 - title of the action to print
#    $2 - command to check if this action has already been done
#    $3 - command to perform the action (only called if check is false)
#    $4 - (optional) command to execute after $3 (only called if $3 is success)
function once() {
    local title="$1"
    local check="$2"
    local cmd="$3"
    local post="${4:-""}"
    if eval "$check" > /dev/null ; then
        status "$title" "NOP"
    else
        status "$title" "START"
        $cmd
        if [[ -z "$post" ]] ; then
            $post
        fi
        status "$title" "END"
    fi
}

# install a homebrew package
#
#    $1 - name of package
function inst_brew() {
    local title="$1"
    local pkg="$1"
    local cmd="brew install $pkg"
    local check="brew list -local | grep -iw $pkg"
    once "$title" "$check" "$cmd"
}

# install a homebrew cask
#
#    $1 - name of cask
function inst_cask() {
    local title="$1"
    local pkg="$1"
    local cmd="brew cask install $pkg"
    local check="brew cask list | grep -iw $pkg"
    local post="${2:-""}"
    once "$title" "$check" "$cmd" "$post"
}

# install a ruby gem
#
#    $1 - name of gem
function inst_gem() {
    local title="$1"
    local pkg="$1"
    local cmd="/usr/local/bin/gem install $pkg"
    local check="/usr/local/bin/gem search -i $pkg"
    once "$title" "$check" "$cmd"
}

# Install a conda package  (need to run conda.bash first)
#
#
function inst_conda(){
    local conda="$HOME/miniconda3/bin/conda"
    local title="$1"
    local pkg="$1"
    local cmd="$conda install --yes $pkg"
    local check="$conda list | grep -qE ^$pkg"
    once "$title" "$check" "$cmd"
}

# Install homebrew, homebrew cask
#
function bootstrap() {
    export HOMEBREW_CASK_OPTS="--appdir=/Applications"
    export HOMEBREW_NO_EMOJI=1
    export HOMEBREW_NO_ANALYTICS=1
    export HOMEBREW_NO_AUOT_UPDATE=1
    #
    # brew now installs xcode itself if not present
    #once "xcode" "xcode-select -p" "xcode-select --install"
    if which -s brew ; then
        status "homebrew" "NOP"
    else
        status "homebrew" "START"
        ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" && brew update
        status "homebrew" "END"
    fi
}

bootstrap

for file in "$@" ; do
    source "$file"
done
