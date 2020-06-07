# shorten prompt
PS1='\[\033[01;32m\]\u:\W\[\033[00m\]$ '

SSH_ENV="$HOME/.ssh/environment"

function start_agent {
	echo "Init new SSH agen.."
	/usr/bin/ssh-agent | sed 's/^echo/#echo/' > "${SSH_ENV}"
	echo succeeded
	chmod 600 "${SSH_ENV}"
	. "${SSH_ENV}" > /dev/null
	/usr/bin/ssh-add;
}

if [ -f "${SSH_ENV}" ]; then
	. "${SSH_ENV}" > /dev/null
	ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || { 
		start_agent;
}
else
	start_agent;
fi

# call bashrc if there is any
# https://github.com/microsoft/WSL/issues/2067
if [[ -f ~/.bashrc ]] ; then
	. ~/.bashrc
fi
