#!/bin/bash

# vesper
alias vesper='cd ~/bitbucket/vesper2'
alias v='cd ~/bitbucket/vesper2/vesper'
alias v2='cd ~/bitbucket/vesper2'

function gt()
{
	xdg-open https://kite.trade/connect/login?api_key=jb6sff8xaht3horv&v=3
}

function vt()
{
	app=$1
	if [ "$app" == "" ]; then
		pgrep -a -f vesper.apps
		return 0
	fi

	project_dir=~/bitbucket/vesper2

	cd $project_dir
	source scripts/pre_start.sh
	shift 1

	date=`date '+%Y%m%d'`
	logsDir="$project_dir/../test"
	rm "$logsDir/$date/$app/$app/*"

	if [ -f "vesper/apps/$app.py" ];
	then
		python3 -m vesper.apps.$app  -a $app -i $app -l $logsDir $@
	else
		python3 -m unittest -f tests.$app -a $app -i $app -l $logsDir $@
	fi

}

function lcd()
{
	dir=$1
	latest=$(ldir $dir)
	cd $latest
}

function vl()
{
	dir=$1
	filename=$(lfile $dir)
	vim $filename
}

function logs_impl()
{
	base_dir=$1
	date=`date '+%Y%m%d'`
	latest=$(ldir $base_dir/$date)
	echo "cd: $base_dir : $latest"
	cd $latest
	zcat *.gz| head -1
	ls -l 
}

function logs() { logs_impl ~/bitbucket/db/; }
function tlogs() { logs_impl ~/bitbucket/test/; }
function plogs() { logs_impl ~/bitbucket/test/; }
function ulogs() { logs_impl ~/bitbucket/vesper2/test/logs/; }

function pycache()
{
	 rm  -rf __pycache__
	 rm  -rf */__pycache__
	 rm  -rf */*/__pycache__
}
