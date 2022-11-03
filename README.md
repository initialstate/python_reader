Python Data Reader
===============

![repo linter workflow](https://github.com/initialstate/python_reader/actions/workflows/is-repo-lint.yml/badge.svg)

This is a Python module currently built for python >= 2.7

See the documentation for the [Initial State Read API](https://initialstatereadapi.docs.apiary.io/).

## Installation

### Using the automated script

On a Unix based system: (including Raspberry Pi, Mac OS X, Ubuntu) 

```
\curl -sSL https://get.initialstate.com/python-reader -o - | sudo bash
```

If you don't have `curl` you should get it:

```
sudo apt-get install curl
```

```
sudo yum install curl
```


### Using Package Management
The package is hosted in PyPI under the package name [ISReader](https://pypi.python.org/pypi/ISReader).

#### If you don't have `pip`:

1. (*optional*) Check if you have python setup tools installed:

	```
	$ easy_install --version
	```
	
	if you don't see a version number come back, you should install setuptools:
	
	```
	$ sudo apt-get install python-setuptools
	```
	

2. (*optional*) Check if you have pip installed:

	```
	$ pip --version
	```
	
	if you don't see a version number after running the above command, install pip using easy_install:
	
	```
	$ sudo easy_install pip
	```

#### I've got `pip` what next?:


```
$ sudo pip install ISReader
```

> This command installs the ISReader module


## Basic Usage

After getting the ISReader module, usage is really simple:

```python
from ISReader.Reader import Reader

# create Reader instance
reader = Reader(access_key="YOUR_ACCESS_KEY", bucket_key="YOUR_BUCKET_KEY")

# get latest events for all stream keys
all_latest_events = reader.get_latest()

# get latest events for specific stream keys
signal_keys = ['signal_a', 'signal_b']
events = reader.get_latest(keys=signal_keys)
```
