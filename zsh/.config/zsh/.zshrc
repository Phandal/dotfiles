# Sourcing
source $ZDOTDIR/zsh_aliases
source $ZDOTDIR/zsh_exports
source $ZDOTDIR/zsh_functions
source $ZDOTDIR/zsh_keybinds
source $ZDOTDIR/zsh_options
source $ZDOTDIR/zsh_plugins
source $ZDOTDIR/zsh_prompt

# fzf Sourcing
if [ -f /data/data/com.termux/files/usr/share/fzf/key-bindings.zsh ]
then
  source /data/data/com.termux/files/usr/share/fzf/key-bindings.zsh
  source /data/data/com.termux/files/usr/share/fzf/completion.zsh
elif [ -f /usr/share/doc/fzf/examples/key-bindings.zsh ]
then
  source /usr/share/doc/fzf/examples/key-bindings.zsh
  source /usr/share/doc/fzf/examples/completion.zsh
elif [ -d /opt/homebrew/Cellar/fzf ]
then
  source $(fd -i completion.zsh /opt/homebrew/Cellar/fzf/)
  source $(fd -i key-bindings.zsh /opt/homebrew/Cellar/fzf/)
else
  source /usr/share/fzf/completion.zsh
  source /usr/share/fzf/key-bindings.zsh
fi

# opam configuration
[[ ! -r ~/.opam/opam-init/init.zsh ]] || source ~/.opam/opam-init/init.zsh  > /dev/null 2> /dev/null
