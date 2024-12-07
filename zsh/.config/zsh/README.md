# Zsh Configuration

1. [Installation](#installation)
2. [Configuration](#configuration)
3. [Todo](#todo)

This is a very minimal zsh configuration that does not use any
frameworks or OH MY ZSH. Goals are on speed and usability.

**This is a very early version and there might be breaking changes along the way.**

## Installation

### Dependencies
 1. fzf
 2. bat
 3. ripgrep
 4. fd
 5. exa

To install simply clone this repo to your system:

```bash
git clone https://gitlab.com/Phandal/zsh-config.git ~/.config/zsh
```

If you are on an X11 system add this line to your `.Xprofile`:

```bash
export ZDOTDIR=~/.config/zsh
```

If you are on a system that does not use X11 use this:

```bash
echo export ZDOTDIR=~/.config/zsh >> ~/.zshenv
```

## Configuration

### Aliases
Aliases are located in the zsh_aliases file. To add more aliases just edit that file!

### Plugins
To add a plugin edit the `.zshrc` file under the plugins section and
add the git repo. For example:

```bash
zsh_plug zsh-users/zsh-autosuggentions
```

Don't forget to relaunch the terminal or source the .zshrc file to see the changes.

## Todo
1. Make the plugins reload on change.
3. Make the prompt look better
