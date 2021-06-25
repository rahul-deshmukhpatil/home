# General grep for the commands
#####################################################
alias g='grep --color -inr '
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias bb='cd ~/bitbucket'

alias lss='ls -lS | head'
alias lssh='ls -lS | head'
alias lst='ls -lt | head'
alias lsth='ls -lt | head'

alias codingtests='cd ~/bitbucket/codingtests'
alias codility='cd ~/bitbucket/codingtests/codility'
alias csharp='cd ~/bitbucket/Notes-and-Docs/c#'
alias screenrc='vim ~/.screenrc'


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
function rld() {source $HOME/.bashrc;}

# python source script
#############################################################
export PYTHONSTARTUP=~/.pystartup


# cd commands
#############################################################
function home { cd ~/bitbucket/home;}
function bashrc { vim ~/bitbucket/home/bashrc; rld;}


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

    echo $gdo_files | grep "\.py" | xargs autopep8 --in-place
    echo $gdo_files | grep "\.py" | xargs flake8
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
		echo "please-check-if-you-are-working-on-master-branch"
	fi

}

function gpush()
{
	ans="Y"
	if [ "$1" != "" ];
	then
		echo "Push to remote: "
		read ans
	fi


	if [ "$ans" != "Y" ];
	then
		echo "[input: $ans] : Not pushing to remote "
		return
	fi

	branch=`get_branch`
	case $branch in
		'master') its_master_branch=true ;;
		*)	its_master_branch=false ;;
	esac
	
	keyword_found=$(git remote show origin | grep -c deshmukhpatil)
	case $keyword_found in
		0) its_not_personal_repo=true ;;
		*) its_not_personal_repo=false ;;
	esac

	if [[ $its_master_branch && its_not_personal_repo ]];
	then
		echo "[input: $branch] not pushing to master"
		return
	fi

	git push origin $branch
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
	echo "Commit message : " 
	message="$@"

	if [[ $message == "" ]];
	then
		message="no commit message"
	fi
	message="-m $message"

	pep8_flake8
	if [[ $? -ne 0 ]]
	then
		echo "Failed pep8 or flake8"
		return -1
	fi

	git add -u
	git commit "$message"
	gpush "Y"
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
	find . -name $@
}

function commands
{
	commands_file="$HOME/commands.txt"
	if [ "$#" -eq 0 ];
	then
		vim $commands_file
		exit 0
	else
		ag $1 $commands_file
	fi
}
