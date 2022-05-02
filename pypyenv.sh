#!/bin/bash

function create_pypy()
{
	env_name=$(basename $PWD)

	# shellcheck disable=SC2088
	pypy_installation="$HOME/Downloads/pypy3.8-v7.3.8-linux64/bin/pypy3.8"
	# pypy_installation="$HOME/Downloads/pypy3.9-v7.3.8-linux64/bin/pypy3.9"
	virtenv_dir="$HOME/pypyenv/$env_name"

	virtualenv -p $pypy_installation $virtenv_dir
	source $virtenv_dir/bin/activate

	venv_python="$virtenv_dir/bin/python3"
	$venv_python -m ensurepip
	pip install --upgrade pip
	$venv_python -mpip install -U pip wheel setuptools
	$venv_python -mpip install pygments
	$venv_python -mpip install -r requirements-dev.txt
	$venv_python -mpip install -r requirements.txt
}
