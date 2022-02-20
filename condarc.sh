alias install_jupyter='conda install -c conda-forge notebook'

alias db='sudo -u postgres psql' 
alias sql='sudo -u postgres psql' 

alias 388='source activate py388'


function creq()
{
	conda install --file requirements.txt
	conda install --file requirements-dev.txt
}

function conl()
{
	conda env list
	conda list | ag -w dev

	if [[ "$@" != "" ]]; then
		conda list | ag -w $@
	fi
}

function cond()
{
	conda deactivate
}

function conr()
{
	echo "removing conda env $@"
	conda env remove -n $@
}

function get_currdir_or_name()
{	
	project="$1"
	if [ "$project" = "" ]; then
		project=`basename $PWD`
	fi
	echo $project
}

function conda_activate()
{
	project=$1
	current_env=`conl | grep '\*' | cut -d ' ' -f 1`
	
	echo "changing from $current_env to $project"	

	if [[ "$project" == "$current_env" ]];
	then
		return
	fi

	conda activate $project
	conl
}

function cona()
{
	project=`get_currdir_or_name $1`
  	conda_activate $project
}

function pcona()
{
	project=`get_currdir_or_name $1`
	project="pypy-$project "
	conda_activate $project
}

function conda_create()
{
	cond
	envName=`get_currdir_or_name $1`
	prefix=$2

  if [[ $prefix == 'pypy' ]];
  then
    conda create -n $envName pypy
    cona $envName
    creq
  else
    conda create -n $envName python=3.8
    cona $envName
    req
  fi

	conl
}

function pconc()
{
    conda_create 'pypy' $@
}

function conc()
{
    conda_create $@
}

function req()
{
	pip3 install -r requirements.txt
	pip3 install -r requirements-dev.txt
}

function local_pip_install()
{
	project=$HOME/work/$@
	pip3 install -e $project
	conl
}

function use_local_pip()
{
	local_pip_install $@
}

function clone()
{
	project=$1
	git clone rahul-deshmukhpatil@bitbucket.org/$project.git
}

PATH="$PATH;/home/rahul/miniconda3/bin"