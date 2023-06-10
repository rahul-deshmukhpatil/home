#!/bin/bash

# vesper
alias vesper='cd ~/bitbucket/vesper2'
alias v='cd ~/bitbucket/vesper2/vesper'
alias v2='cd ~/bitbucket/vesper2'
alias vb='cd ~/bitbucket/vectorbtpro'
alias bt='cd ~/bitbucket/backtrader'
alias fy='cd ~/bitbucket/feynman'
alias sd='cd /media/rahul/new/sandbox/sandbox-template/'

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


function get_prod_or_test()
{
  env=$1
  dirname='test'
  if [[ $env == 'p' || $env == 'prod' ]];
  then
    dirname='prod'
  fi
  echo $dirname
}

function get_logs_or_db()
{
  env=$1
  dirname='logs'
  if [[ $env == 'd' || $env == 'db' ]];
  then
    dirname='db'
  fi
  echo $dirname
}

function vl()
{
  dirname=$(get_prod_or_test $1)
	date=`date '+%Y%m%d'`
  ls -t ~/bitbucket/$dirname/logs/$date/*/*/*.log | xargs vi -p
}

alias vlt='vl t'
alias vlp='vl p'

function zcd()
{
  dirname=$(get_prod_or_test $1)
  logs_db=$(get_logs_or_db $2)
	date=$(date '+%Y%m%d')

	if [[ $logs_db == "" ]];
	then
	  cd ~/bitbucket/$dirname
	else
	  cd ~/bitbucket/$dirname/$logs_db/$date/mktdata/zerodha/
	fi
}

alias pd='zcd p d'
alias pl='zcd p l'
alias td='zcd t d'
alias tl='zcd t l'

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
