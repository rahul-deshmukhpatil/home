# General grep for the commands
#####################################################
alias g='grep --color -inr '
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias bb='cd ~/bitbucket'
alias h='cd ~/bitbucket/home'

alias lss='ls -lS | head'
alias lssh='ls -lS | head'
alias lst='ls -lt | head'
alias lsth='ls -lt | head'

alias codingtests='cd ~/bitbucket/codingtests'
alias codility='cd ~/bitbucket/codingtests/codility'
alias csharp='cd ~/bitbucket/Notes-and-Docs/c#'
alias screenrc='vim ~/.screenrc'
alias cppref='cd ~/bitbucket/Notes-and-Docs/c++/cppref'


#####################################################
#			SVN commands 							#
#####################################################

alias svu='svn -R revert *;sshpass -p $PASSWORD svn  up'
alias svd='rm .temp_svn_diff; svn  diff -x -w > .temp_svn_diff ; if [ -s .temp_svn_diff ]; then vim .temp_svn_diff; fi'
alias svr='svn revert -R *'
alias svi='sshpass -p $PASSWORD svn  info'

# svn  log now puts log into .log
##################################################
function svl {
    echo "sshpass -p $PASSWORD svn  log "$1" > .log"
    sshpass -p $PASSWORD svn  log "$1" > .log
    head .log
}

# svn blame
##################################################
function svb {
    ls "$@" | while read fileName
    do
		echo "sshpass -p $PASSWORD svn  blame $fileName > .$fileName.blame"
		sshpass -p $PASSWORD svn  blame $fileName > .$fileName.blame
    done
}


# function to find screenof pid
##############################################################
function  pid2screen {
	if [ "$#" -ne 1 ]; then
		echoerr "usage ./pid2screen <PID> will tell you in which screen PID is running"
		return 1;
	fi

	re='^[0-9]+$'
	if ! [[ $1 =~ $re ]] ; then
		echoerr "usage ./pid2screen <PID> will tell you in which screen PID is running"
   		echoerr "error: PID Not a number"; 
		return 1;
	fi

	
	screen -ls | cut -d "." -f  1 | while read PID; 
	do 
		pstree -p $PID | grep -q "$CHILD_PID" > /dev/null; 
		if [ "$?" == "0" ]; then 
			echo "$PID" > .pid2screenlog; 
		fi; 
	done  2>/dev/null; 
	tail .pid2screenlog
	rm .pid2screenlog
}

# screenrc functions
###############################################################
function welcome {
    echo "hi"
}

# Setting ulimit for core dump enabling
#############################################################
ulimit -c unlimited

# source self
#############################################################
function rld() { source $HOME/.zshrc; }

# python source script
#############################################################
export PYTHONSTARTUP=~/.pystartup


# cd commands
#############################################################
function home { cd ~/bitbucket/home;}
function bashrc { vim ~/bitbucket/home; rld;}


# apt commands
#############################################################
function apti { sudo aptitude install $@;}
function apts { sudo aptitude search $@;}
function aptu { sudo aptitude update $@;}

# formatting commands flake
#############################################################
function pep8_flake8()
{
    gdo_files=`gdo | grep "\.py"` 
	
	if [[ $gdo_files == "" ]];
	then
		return 0
	fi

    echo $gdo_files | grep "\.py" | xargs autopep8 --in-place --max-line-length 120
    echo $gdo_files | grep "\.py" | xargs flake8 --max-line-length 120
    echo $gdo_files | grep "\.py" | xargs black 
	return "$?"
}


# git comands
#############################################################
function current_branch_name()
{
    git branch | grep -v \* | head -1
}

alias ga='git add -u'
alias gd='git diff'
alias grh='git reset --hard'
alias gst='git status'
alias gclone='git clone'
alias gdt='git difftool'
function gdo()
{
    git diff --name-only --relative
}

alias gdom='git diff --name-only --relative master'
alias gpom='git push origin master'

alias gdm='git diff master'

function gfp()
{
	git fetch
	git pull
}

function gb()
{
	branch=$1
	if [[ $branch = "" ]]; then
		git branch
		return
	fi

	all_branches=`git branch | grep $branch | head -1`
	echo "All branches : $all_branches"
	branch=`echo $all_branches | head -1 | sed 's/ //g'`
	branch=`echo $branch | sed 's/*//g'`
	echo "checking out : $branch"
    git checkout $branch
}

function gcb()
{
	gb $@
	return 0
}

alias gl='git log'
alias glv='git log --decorate=full | vi -'

function gco()
{
	git checkout $@
}

function gp()
{
	git pull
}

function gcm()
{
	git checkout master
}

function gmom()
{
	branch=`get_branch`
	gcm
	gfp
	gco $branch
	git merge origin master
}

function get_branch()
{
	branch=`git branch | grep  '^* ' | sed 's/^\* //'`

	if [ "$branch" != "master" ];
	then
		echo "$branch"
	else
		echo "you-are-on-master"
	fi

}

function gpush()
{
	ans=$1
	[[ ! $ans ]]  && echo "Push to remote[Y?]:" && read ans

	[[ $ans != Y ]] && return

	branch=`get_branch`
	case $branch in
		you-are-on-master) its_master_branch=true ;;
		*)	its_master_branch=false ;;
	esac
	
	keyword_found=$(git remote show origin | grep -c deshmukhpatil)
	case $keyword_found in
		0) its_personal_repo=false ;;
		*) its_personal_repo=true ;;
	esac

	if $its_master_branch && $its_personal_repo;
	then
		git push origin master
		return
	fi

	# additional check for its not master branch
	[[ $branch != master ]] && git push origin $branch
}

function gdelete()
{
	branch=$1
	if [ "$branch" != "master" ];
	then
		git push -d origin $branch 
		git branch -D $branch 
	else
		echo "Trying to push directly to master !!!"
	fi
}

function gcommit()
{
	message="$@"

	if [[ $message == "" ]];
	then
		message="default commit message"
	fi
	echo "Commit message : " 
	message="-m $message"

	pep8_flake8
	if [[ $? -ne 0 ]]
	then
		echo "Failed pep8 or flake8"
		return -1
	fi

	gdo | grep -Fv -e "exchange.py" -e "ini" -e "cfg" | xargs git add -u
	git commit "$message"
	gfp
	gmom
	gpush Y
}

# smart functions
#############################################################
function ldir()
{
	dir=$1
	echo `find $dir -type d -printf "%T@ %p\n" | sort -n | cut -d ' ' -f 2 | tail -1`
}

function lfile()
{
	dir=$1
	echo `find $dir -type f -printf "%T@ %p\n" | sort -n | cut -d ' ' -f 2 | tail -1`
}


export EDITOR=vim

function rssh()
{
	ssh rahul@hpz820
}

function fn()
{
	[[ $2 != '' ]] && find $2 -name $1 && return;
	find . -name $@
}

function commands
{
	personal_commands=~/bitbucket/home/commands.txt
	commands_file="$HOME/commands.txt $personal_commands"

	files="$personal_commands $commands_file"
	[[ $# = 0 ]] && vim -O $files && return

	ag $1 $files 
}
