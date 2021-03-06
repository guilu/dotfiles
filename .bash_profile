# Load the shell dotfiles, and then some:
# * ~/.path can be used to extend `$PATH`.
# * ~/.extra can be used for other settings you don’t want to commit.
for file in ~/.{path,bash_prompt,exports,aliases,functions,extra}; do
	[ -r "$file" ] && source "$file"
done
unset file

# init z   https://github.com/rupa/z
if [ -e ~/code/z/z.sh ]; then
    . ~/code/z/z.sh
fi

# init rvm
if [ -e ~/.rvm/scripts/rvm ]; then
    . ~/.rvm/scripts/rvm
fi

# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob

# Append to the Bash history file, rather than overwriting it
shopt -s histappend

# Autocorrect typos in path names when using `cd`
shopt -s cdspell

# Enable some Bash 4 features when possible:
# * `autocd`, e.g. `**/qux` will enter `./foo/bar/baz/qux`
# * Recursive globbing, e.g. `echo **/*.txt`
for option in autocd globstar; do
	shopt -s "$option" 2> /dev/null
done

# Add tab completion for SSH hostnames based on ~/.ssh/config, ignoring wildcards
[ -e "$HOME/.ssh/config" ] && complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2 | tr ' ' '\n')" scp sftp ssh

# Add tab completion for `defaults read|write NSGlobalDomain`
# You could just use `-g` instead, but I like being explicit
complete -W "NSGlobalDomain" defaults

# Add `killall` tab completion for common apps
complete -o "nospace" -W "Contacts Calendar Dock Finder Mail Safari iTunes SystemUIServer Terminal Twitter" killall

# Autocomplete Grunt commands
which grunt > /dev/null && eval "$(grunt --completion=bash)"

# If possible, add tab completion for many more commands
[ -f /usr/local/etc/bash_completion ] && source /usr/local/etc/bash_completion


#git completion...
if [ -e ~/.git-completion.sh ]; then
    . ~/.git-completion.sh
fi

#git-flow completion
if [ -e ~/.git-flow-completion.sh ]; then
    . ~/.git-flow-completion.sh
fi

#symfony2 completion
if [ -e ~/code/symfony2-autocomplete/sf2-completion.sh ]; then
    . ~/code/symfony2-autocomplete/sf2-completion.sh
fi

#autocomplete for 'g' as well (g shoud be in .aliases)
complete -o default -o nospace -F _git g

