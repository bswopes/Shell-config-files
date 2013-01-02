# If not an interactive shell, just exit.
case $- in 
  *i*);;
  *) return 0;; 
esac

[ -e ~/Dropbox/shell/onload.sh ] && sh ~/Dropbox/shell/onload.sh

#################
# History stuff #
#################

shopt -s histappend
export HISTSIZE=5000
export HISTCONTROL=ignoreboth:erasedups
export HISTTIMEFORMAT='%F %T '
export HISTIGNORE="pwd:history:ls"

#####################
# Color Definitions #
#####################

[ -f .shell_colors ] && source .shell_colors

##########
# Prompt #
##########

PROMPTHOST=`echo $HOSTNAME | sed -e 's/\.local//' -e 's/\.\w*\.com//'`

# Set exit status in prompt. Write history to file. Send data to terminal for title.
function cmdstatus {
 EXITSTATUS=$?
 if [ ${UID} -eq 0 ]
 then 
  PS1="${On_Red}${BWhite}\u@${PROMPTHOST}${Color_Off}:${BGreen}\w${Color_Off}\$ "
 else
  if [ -z "${WORKHOST}" ]
  then
   PS1="${BBlack}[ \d \t ] [ \w ]\n${Green}${PROMPTHOST}${Color_Off} \$ "
  else
   PS1="${BBlack}[ \d \t ] [ \w ]\n${WORKHOST}${Green}${PROMPTHOST}${Color_Off} \$ "
  fi
 fi

 HAPPY="\n${BBlack}[ ${BBlue}$EXITSTATUS ${BBlack}]"
 SAD="\n${BGreen}[ ${BRed}$EXITSTATUS ${BGreen}]"
 CONFUSED="\n${BGreen}[ ${BPurple}$EXITSTATUS ${BGreen}]"

 if [ $EXITSTATUS -eq "0" -o $EXITSTATUS -eq "130" ] 
  then export PS1="$HAPPY $PS1"; 
 elif [ $EXITSTATUS -eq "127" ] 
  then export PS1="$CONFUSED $PS1";
 else 
  export PS1="$SAD $PS1";
 fi
}
export PROMPT_COMMAND='cmdstatus; history -a; echo -ne "\033]0;${USER}@${PROMPTHOST}: ${PWD}\007\a";'

###########
# CD Path #
###########

# Set cdpath based on location... 
CDPATH='.:~'
[ -d /Applications/ ] && CDPATH=$CDPATH':/Applications/'
export CDPATH

# For MacPorts
[ -d /opt/local/bin -a -d /opt/local/sbin ] && export PATH=/opt/local/bin:/opt/local/sbin:$PATH

# For Python Framework
[ -d /Library/Frameworks/Python.framework/Versions/3.3/bin ] && export PATH=/Library/Frameworks/Python.framework/Versions/3.3/bin:$PATH

###########
# Aliases #
###########

[ -f .work_aliases ] && source .work_aliases
[ -f .home_aliases ] && source .home_aliases

alias suro="export SUDO_PS1=\"${BRed}\u@${PROMPTHOST}${Color_Off} : ${BBlue}\w${Color_Off} # \" && sudo -s"
which vim >/dev/null && alias vi='vim'
ls -F --color &>/dev/null && alias ls='ls -F --color' || alias ls='ls -FG'
alias clear="clear && printf %b '\033[3J'" 
alias cg='crontab -l | grep -i' 
alias whatismyip='curl http://automation.whatismyip.com/n09230945.asp'

# If we have exclude-dirs, use it
grep --exclude-dir=x .profile /dev/null &> /dev/null
HAVE_EXCLUDE_DIRS=`test $? == 1 && echo true || echo false`
if $HAVE_EXCLUDE_DIRS; then   
  GREP_OPTIONS='--exclude-dir=".svn" --color=auto -s'; 
else 
  GREP_OPTIONS='--exclude=".svn" --color=auto -s'; 
fi
export GREP_OPTIONS;

# autocomplete for hostnames in known_hosts
[ -e ~/.ssh/known_hosts ] && complete -W "$(echo `cat ~/.ssh/known_hosts | cut -f 1 -d ' ' | sed -e s/,.*//g | uniq | grep -hv "\["`;)" ssh 
#[ -e ~/.ssh/known_hosts ] && complete -W "$(echo `cat ~/.ssh/known_hosts | cut -f 1 -d ' ' | sed -e s/,.*//g | uniq | grep -hv "\["`;)" scp 

[ -e ~/Dropbox/shell/aliases.sh ] && source ~/Dropbox/shell/aliases.sh
#[ -e /opt/local/bin/fortune ] && /opt/local/bin/fortune
