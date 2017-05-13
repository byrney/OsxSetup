brew tap homebrew/science
inst_brew matplotlib
if [[ ! -L "/Library/Python/2.7/site-packages/matplotlib-override" ]] ; then
    sudo ln -s /System/Library/Frameworks/Python.framework/Versions/2.7/Extras/lib/python /Library/Python/2.7/site-packages/matplotlib-override
fi
inst_cask qgis
