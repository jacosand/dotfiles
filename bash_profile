####################
#       PATH       #
####################

prompt_git() {
	local s='';
	local branchName='';

	# Check if the current directory is in a Git repository.
	git rev-parse --is-inside-work-tree &>/dev/null || return;

	# Check for what branch we’re on.
	# Get the short symbolic ref. If HEAD isn’t a symbolic ref, get a
	# tracking remote branch or tag. Otherwise, get the
	# short SHA for the latest commit, or give up.
	branchName="$(git symbolic-ref --quiet --short HEAD 2> /dev/null || \
		git describe --all --exact-match HEAD 2> /dev/null || \
		git rev-parse --short HEAD 2> /dev/null || \
		echo '(unknown)')";

	[ -n "${s}" ] && s=" [${s}]";

	echo -e "${1}${branchName}${2}${s}";
}

# Colors and bold markers
reset="\e[0m";
bold="\e[1m";
black="\e[30m";
red="\e[31m";
green="\e[32m";
yellow="\e[33m";
blue="\e[34m";
magenta="\e[35m";
cyan="\e[36m";
white="\e[97m";

# Highlight the user name when logged in as root
if [[ "${USER}" == "root" ]]; then
	userStyle="${bold}${red}";
else
	userStyle="${reset}${cyan}";
fi;

hostStyle="${reset}${cyan}";
pathStyle="${bold}${green}";
resetStyle="${reset}${white}";

# Set the terminal prompt
PS1="\[${resetStyle}\][";
PS1+="\[${userStyle}\]\u"; # username
PS1+="\[${hostStyle}\]@";
PS1+="\[${hostStyle}\]\h"; # host
PS1+="\[${resetStyle}\]] ";
PS1+="\[${pathStyle}\]\w"; # working directory
#PS1+="\$(prompt_git \"\[${resetStyle}\] on \[${magenta}\]\" \"\[${blue}\]\")"; # Git repository details
PS1+="\n";
PS1+="\[${resetStyle}\]\$ "; # `$` (and reset color)
export PS1;

PS2="\[${resetStyle}\]\$ ";
export PS2;

# Use Vim-mode at shell prompt
set -o vi


####################
#     ALIASING     #
####################

# Easier navigation: .., ..., ...., .....
alias ~="cd ~"
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."

# Shortcuts
alias d="cd ~/Dropbox"
alias dl="cd ~/Downloads"
alias dt="cd ~/Desktop"
alias g="git"
alias v="vim"
alias hr="cd ~/Dropbox/Houk\ Research"

# Detect which `ls` flavor is in use
if ls --color > /dev/null 2>&1; then # GNU `ls`
	colorflag="--color"
else # macOS `ls`
	colorflag="-G"
fi

alias ls='ls ${colorflag}'
alias ll='ls -alh ${colorflag}'

# Always enable colored `grep` output
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'


####################
#     SETTINGS     #
####################

# Make vim default editor
export EDITOR=vim


####################
#   LOCAL CONFIG   #
####################

[ -r ~/.bash_local ] && [ -f ~/.bash_local ] && source ~/.bash_local


