#!/bin/bash

echo "Beginning ISReader Python Easy Installation!"
echo "                                  _________       "
echo "                               NN           NN    "
echo "                             N                 N  "
echo "                            N      NNNNNNN      N "
echo "                          N      NN       N      N"
echo "NNNNNNN                  N      N          N     N"
echo "N     N                 N      N           N     N"
echo "N     N               N       N            N     N"
echo "                                                  "
echo "NNNN NN            NNNNNNNN                NNNNNNN"
echo "N     N           N      N                 N     N"
echo "N     N          N      N                  N     N"
echo "N      N       NN      N                   NNNNNNN"
echo " N      NNNNNNN      N                            "
echo "  N                 N                             "
echo "    NN           NN                               "
echo "       ---------                                  "
echo "This may take a couple minutes to install, grab some coffee :)"
echo ""
INITIALSTATE_AUTH_SVC=${INITIALSTATE_AUTH_SVC:="auth"}
SUDO=''

# if this script is being run by root user
# then we need to modify file saving commands
# to make sure ownership is correct
if [ "$EUID" -eq 0 ]; then
	SUDO="sudo -u $SUDO_USER"
fi


function check_for_easy_install {
    if hash easy_install 2>/dev/null; then
        easy_install_version=$(easy_install --version)
        echo "Found easy_install: $easy_install_version"
    else
        echo "easy_install not found, installing now..."

        if hash apt-get 2>/dev/null; then
        	if [[ $1 -eq '-v' ]]; then
        		apt-get -y install python-setuptools
        	else
				apt-get -y install python-setuptools > /dev/null
        	fi
        else
        	echo "no apt-get, using curl..."
        	if [[ $1 -eq '-v' ]]; then
        		curl https://bootstrap.pypa.io/ez_setup.py -o - | python
        	else
        		curl https://bootstrap.pypa.io/ez_setup.py -o - | python > /dev/null
        	fi
        fi
    fi
}

function check_for_pip {
	if hash pip 2>/dev/null; then
		pip_version=$(pip --version)
		echo "Found pip: $pip_version"
		pip_version_array=(${pip_version//" "/ })
		pip_version_num=${pip_version_array[1]}
		pip_version_num_array=(${pip_version_num//./ })
		pip_major_version=${pip_version_num_array[0]}
		pip_minor=${pip_version_num_array[1]}
		pip_minor_version_array=(${pip_minor//"rc"/ })
		pip_minor_version=${pip_minor_version_array[0]}

		echo "pip major version: $pip_major_version"
		echo "pip minor version: $pip_minor_version"

	else
		echo "pip not found, installing now..."
		if [[ $1 -eq '-v' ]]; then
			easy_install pip
		else
			easy_install pip > /dev/null
		fi
	fi
}

function check_for_isreader {
	isreader=$(pip freeze | grep ISReader)
	if [ -z "$isreader" ]; then
		echo "ISReader not found, installing..."

		pip install ISReader
	else
		echo "ISReader found, updating..."

		pip install --upgrade ISReader
	fi

	isreader_version=$(python -c "import ISReader.version; print(ISReader.version.__version__)")


	if [[ $isreader_version == "" ]] ; then
		echo "No ISReader found..."
		exit 1
	else
		echo "Found ISReader: $isreader_version"
		isreader_version_array=(${isreader_version//" "/ })
		isreader_version_num=${isreader_version_array[0]}
		isreader_version_num_array=(${isreader_version_num//./ })
		isreader_major_version=${isreader_version_num_array[0]}
		isreader_minor=${isreader_version_num_array[1]}
		isreader_minor_version_array=(${isreader_minor//"rc"/ })
		isreader_minor_version=${isreader_minor_version_array[0]}

		echo "isreader major version: $isreader_major_version"
		echo "isreader minor version: $isreader_minor_version"
	fi
}

check_for_easy_install
check_for_pip
check_for_isreader
