## Machine Setup ##

The machine setup is used to get an empty OSX installation up to where it
needs to be. It depends heavily on brew.sh and brew cask to install
everything but it installs these first so it should automate the process of
building a new osx install.

### OSX Configuration ###

A collection of dev friendly osx defaults are in 

    Setup/osx-defaults.bash

this is largely cribbed from https://mths.be/osx. I'd recommend reading
through it before running it.

### Software Install ###

The software Setup files are in the Setup folder. There is one generic script,
mbpsetup.sh that is used to bootstrap brew and cask and then do the
installation.

I keep a script per machine which contains the command to bootstrap. So
`kat.bash` is my laptop and `keira.bash` is kerri's.

This means I can be up and running with a new Mac by typing:

    git clone 'https://github.com/byrney/OsxSetup.git'
    cd OsxSetup && bash kat.bash

There are several 'category scripts' that can be used to set up base
system, dev tools, image manipulation and so on.

Then there are scripts for controlling which machines get what. For example
kat.bash and keira.bash set up two of my machines. These are just a list of
categories to install. kat.bash might look like this

    #!/bin/bash -eu
    bash mbpsetup.sh base.bash utils.bash dev.bash

### How it works ###

mbpsetup installs xcode commandline tools, homebrew and homebrew cask and then
sources each of the files on the commandline.

It provides functions to install brew packages, casks or gems if they
have not been installed before. If they already exist they don't get run
again. This is crucial to being able to maintain the script and add
new packages over time without reinstalling existing packages  (or failing
part way because they are already there).

Each of the category scripts simply calls the functions in mbpsetup. So a
script to install image tools would look like this:

    inst_brew imagemagick
    inst_brew exiftool
    inst_cask picasa


