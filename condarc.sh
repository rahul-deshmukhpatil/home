alias install_jupyter='conda install -c conda-forge notebook'

alias db='sudo -u postgres psql' 
alias sql='sudo -u postgres psql' 

alias 388='source activate py388'


function creq()
{
	conda install -c conda-forge --file requirements.txt
	conda install -c conda-forge --file requirements-dev.txt
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
	source ~/pypyenv/$project-pypy/bin/activate
}

function conda_create()
{
	cond
	prefix=$1
	envName=`get_currdir_or_name $2`

  if [[ $prefix == 'pypy' ]];
  then
  	envName="pypy-$envName"
    # echo "DEFAULT PYPY ISNTALLATION" && conda create -n $envName pypy
    echo "DOWNLOADED PYTHON ISNTALLATION" && conda create -n $envName "$HOME/pypy3.9-v7.3.9-linux64/bin/pypy3.9" 
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
    conda_create "non-pypy" $@
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
