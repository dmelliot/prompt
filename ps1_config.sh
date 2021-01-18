# Define some base colors
bold_red="\[\e[01;31m\]"
bold_green="\[\e[01;32m\]"
bold_orange="\[\e[01;33m\]"
bold_blue="\[\e[01;34m\]"
bold_purple="\[\e[01;35m\]"
bold_cyan="\[\e[01;36m\]"
red="\[\e[31m\]"
green="\[\e[32m\]"
orange="\[\e[33m\]"
blue="\[\e[34m\]"
purple="\[\e[35m\]"
cyan="\[\e[36m\]"
clear="\[\e[00m\]"

# Map colors to parts of prompt
color_user=$green
color_at_symbol=$blue
color_host=$green
color_pwd=$orange
color_jobs=$purple
color_prompt_symbol=$green
color_git_branch=$cyan

# If user is root, update some of these mappings
if [ $(id -u) -eq 0 ]; then
	color_user=$red
	color_host=$red
	color_at_symbol=$orange
	color_pwd=$orange
fi

# Build background jobs summary section
__ps1_get_jobs() {
	jobs_output=`jobs`
	if [ "$jobs_output" ]; then
		echo -e "${color_jobs}$jobs_output\\\n"
	fi
}

# Safely get the git branch (only if the function is defined)
__ps1_get_git_branch() {
	declare -F -f __git_ps1 > /dev/null && __git_ps1
}


# Define prompt command to build PS1 on demand
PROMPT_COMMAND='__ps1_exit_code=$?;PS1="\n`__ps1_get_jobs;`${color_user}\u${color_at_symbol}@${color_host}\h${clear} ${color_pwd}\w${color_git_branch}`__ps1_get_git_branch`
${color_prompt_symbol}\$${clear} "'

