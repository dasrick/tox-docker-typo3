#!/usr/bin/env bash

function msgStart() {
    # msgStart "TYPE" "STORY_MSG" "TASK_MSG"

    # TYPE -------------------------------------------------------------------------------------------------------------
    type=$1
    if [[ $type == "" ]]
    then
        echo "No type specified (story, task)"
        exit 1
    fi
    if [ $type == "story" ]
    then
      type_color="\e[1;35m"
    else
      type_color="\e[1;37m"
    fi

    # STORY-MSG --------------------------------------------------------------------------------------------------------
    shift
    story_msg=$1
    if [[ $story_msg == "" ]]
    then
        echo "No story_msg specified"
        exit 1
    fi

    # TASK-MSG ---------------------------------------------------------------------------------------------------------
    shift
    task_msg=$1
    task_msg_xxl=
    if [[ $task_msg == "" ]]
    then
        echo "No task_msg specified"
        exit 1
    fi
    if [[ $task_msg != "" ]]
    then
        task_msg_xxl="\e[1;33m $task_msg \e[0m START "
    fi

    printf "\e[1;33m==>$type_color  $story_msg $task_msg_xxl \e[0m \n"

    printf "\e[1;31m";  # RED for error stuff
}

function msgDone() {
    # msgStop "TYPE" "STORY_MSG" "TASK_MSG" "ELAPSED_TIME"

    # TYPE -------------------------------------------------------------------------------------------------------------
    type=$1
    if [[ $type == "" ]]
    then
        echo "No type specified (story, task)"
        exit 1
    fi
    if [ $type == "story" ]
    then
      type_color="\e[1;35m"
    else
      type_color="\e[1;37m"
    fi

    # STORY-MSG --------------------------------------------------------------------------------------------------------
    shift
    story_msg=$1
    if [[ $story_msg == "" ]]
    then
        echo "No story_msg specified"
        exit 1
    fi

    # TASK-MSG ---------------------------------------------------------------------------------------------------------
    shift
    task_msg=$1
    task_msg_xxl=
    if [[ $task_msg == "" ]]
    then
        echo "No task_msg specified"
        exit 1
    fi
    if [[ $task_msg != "" ]]
    then
        task_msg_xxl="\e[1;33m $task_msg \e[1;32m DONE"
    fi

    # ELAPSED_TIME -----------------------------------------------------------------------------------------------------
    shift
    ELAPSED_TIME=$1

    printf "\e[1;33m==>$type_color  $story_msg $task_msg_xxl \e[0m %02d:%02d\n" $(($ELAPSED_TIME/60)) $(($ELAPSED_TIME%60))
}

#function typo3_cms () {
#    TYPO3_COMPOSER_AUTOLOAD="On" TYPO3_CONTEXT="Production" php /var/www/html/htdocs/bin/typo3cms $1 $2 $3 $4
#}
#
#
#function cli_dispatch () {
#    TYPO3_COMPOSER_AUTOLOAD="On" TYPO3_CONTEXT="Production" php /var/www/html/htdocs/typo3/cli_dispatch.phpsh $1 $2 $3 $4 $5 $6 $7 $8
#}
