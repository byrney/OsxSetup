
#
# Must haves brew
#
for brew in "bash-completion" git tmux ripgrep vim fzf ; do
    inst_brew "$brew"
done

#
# Must haves cask
#
for cask in macvim google-chrome alfred flux hammerspoon  unison nvalt ; do
    inst_cask "$cask"
done

# Show the ~/Library folder
chflags nohidden ~/Library
