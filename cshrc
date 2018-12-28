#
# $HOME/.cshrc:
#	environment configuration for interactive csh-based shells.
#
# A new copy of this file can be retrieved by executing
# '/usr/local/bin/new_dots' at a shell prompt.
#
# Note on Software: Course software (such as Synopsys, Cadence, etc.)
# is now set up through the '.software' file in your home directory.
# See that file to set up your environment for such software.
# If you do NOT have a '.software' file, you can run the following 
# command to get one:
#
#	/usr/local/bin/new_soft
#

#####
# PATH MANIPULATION
#
# If you prefer /usr/ucb in front of /usr/bin in your $PATH under
# Solaris, (i.e. the "old" CSE path), uncomment the following line:
#setenv UCBFIRST 1
#
# If you don't set UCBFIRST above, /usr/ucb will not appear in your
# $PATH at all.  If you would like it to be there (after /usr/bin),
# uncomment the following line:
#setenv UCBINPATH 1

#
# END PATH MANIPULATION
#####

#####
# CSE DEFAULTS
#
# It is strongly encouraged that you do not change the 'CSE DEFAULTS'
# section of this file.  If you do so, ensure that you're fully aware
# of the consequences.
#

# Set configuration file directory
set confdir = /usr/local/user_conf


# Include the default rcfile.
if ( -r $confdir/cshrc.def ) source $confdir/cshrc.def

#
# END CSE DEFAULTS
#####

#####
# PERSONAL ADDITIONS
#
# This is where you should make your own customizations to your
# environment.  See the csh(1) man page under Solaris for
# proper syntax.
#

# Add personal bin directory to the binary search path.
if (-d ~/bin) set path = (~/bin $path)

# Add '.' to the path, so you don't have to use './' to execute
# things in the current working directory.  Point of personal preference,
# enabled by default.  Comment to disable.
set path = ($path .)

# Add personal man directory to the manual page search path.
switch (`uname -s`)
        case "Linux":
                if ( ! $?MANPATH ) then
                        setenv MANPATH ""
                else
                        if (-d $HOME/man) setenv MANPATH $HOME/man:$MANPATH
                endif
	 case "SunOS":
			if (-d $HOME/man) setenv MANPATH $HOME/man:$MANPATH
endsw
# Add own man path info here
# setenv MANPATH <your path>:$MANPATH

# Some common environment variables
#setenv PAGER   'less'
#setenv MORE    '-cs'
#setenv LESS    '-c -d -e -i -q -s -w'
#setenv EDITOR  'vi'
#setenv EDITOR	'vim'
 
# If we're not an interactive shell, skip the rest of the script.
if (! $?prompt) exit

# Get asynchronous notification about finished jobs.
set notify
 
# The number of commands to save in the history.
set history = 500
 
# Stop the shell from checking for new mail.
set mail
 
# Source user-created alias file if it exists
if (-r $HOME/.alias.csh) source $HOME/.alias.csh

# Examples of aliases for convenience.

# Change default behavior of 'ls(1)' command on Solaris.
# Linux does some of these by default
switch (`uname -s`)
	case "SunOS":
		alias ls	'ls -F'
		if ($?UCBFIRST) then
			alias ll	'ls -lg'
			alias la	'ls -lga'
		else
			alias ll	'ls -l'
			alias la	'ls -la'
		endif
		alias l.	'la'
		alias tar	'gtar'
		breaksw
	case "Linux":
		alias la	'l.'
		breaksw
endsw

alias lh	'll -h'
 
# This is like "cd ..", but it follows symlinks backwards.
alias up	'cd "$cwd:h"'
alias realpath 'readlink -fms' #added_CYAN
alias l 'ls -lart'
# Customize the prompt.
#set prompt = "`hostname` \!%~ "
set prompt = '[%{\033[31m%}%n@%m:%c%{\033[0m%}%L]\n%# '
# Limits the sizes of core dumps created by program faults to zero.
limit coredumpsize 0

#echo "working"
#setenv TEST blablabla
#
# END PERSONAL ADDITIONS
#####
echo "#################################################"
echo "############ Welcome cxm2114 to tcsh ############"
echo "#################################################"
