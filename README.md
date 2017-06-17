# tox-docker-typo3

[![Build Status](https://travis-ci.org/dasrick/tox-docker-typo3.svg?branch=master)](https://travis-ci.org/dasrick/tox-docker-typo3)

playgound for TYPO3 for docker using docker-compose ...

***

## some specs

* based on TYPO3 7.6.*
* PHP FMP 7.1.2
* MySQL mysql:5.7.17
* Apache 2.4.25

## Requirements

* git
* docker (macOS users: min. version of docker 4 mac >= v17.04.0)


## Setup


### Initial Setup


#### Repository

Get the project repository.

    git clone git@bitbucket.org:dasrick/tox-docker-typo3.git


#### etc/hosts

Add the following line into your local etc hosts file

    127.0.0.1 tox-typo3.local


#### first run
 
Use the script to setup you local dev ... all steps of this script are described inside of *bin* folder ... later

    bin/firstRun

Now open the [Installer](https://tox-typo3.local/typo3/install/) and finish the setup (credentials see preset/.env-example).

## Usage


#### start

    docker-compose up -d
    
    # shortcut
    bin/start

#### stop

    docker-compose down
    
    # shortcut
    bin/stop

## Structur

need desciption for nearly every folder and file ;-)

    - docker
    - .editorconfig
    - .gitignore
    - docker-compose.yml
    - docker-compose-mac.yml
    - LICENSE
    - README.md

