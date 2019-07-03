#!/bin/sh
. ./greetings.sh

#This script allows a user to setup a local git repository from scratch or by cl#oning an existing remote git repository.

create_repo() {
	#Ask the user for information on where to setup the project
	echo "Enter the name of your git project:" && read PROJECT_NAME
	echo "Enter the path to where the project should be created:" && 
	read PROJECT_PATH
	

	#create and initialize the git repository
	FULL_PATH="${PROJECT_PATH}/${PROJECT_NAME}"
	mkdir -p "${FULL_PATH}"
	cd "${FULL_PATH}"
	git init

	#Setup README.md
	touch "./README.md"
	echo "Provide a description of your project here. Remember to erase"                 "this line." > "./README.md"
	${EDITOR:-vi} "./README.md"

	#Setup .gitignore
	touch "./.gitignore"
	echo "Specify the files you want git to ignore here. Remember to erase"              "this line." > "./.gitignore"
	${EDITOR:-vi} "./.gitignore"

	#Setup remotes for the local git repository
	echo "Enter the name of the remote:[Enter to skip]" && read REMOTE_NAME
	if [ "${REMOTE_NAME}" != "" ]; then
		echo "Enter URL of the remote for this local git repository:"           	     "[Enter to skip]" && read REMOTE_URL
		#This while loop will stop only when the user skips the remote		        #name and url. One without the other might lead to an invalid 
		#command.
		while [ "${REMOTE_URL}" != "" ] || [ "${REMOTE_NAME}" != "" ]
		do	
		git remote add "${REMOTE_NAME}" "${REMOTE_URL}"
		echo "Enter the name of the remote:[Enter to skip]"             		      && read REMOTE_NAME
		echo "Enter URL of the remote for this local git repository:"                        "[Enter to skip]" && read REMOTE_URL

		done
	fi
	echo "\nDone"

}

clone_repo() {
	#Ask for what and where to clone to
	echo "Enter the URL of the remote git repository:" && read URL	
	echo "Enter the name of the local git repository:" && read PROJECT_NAME
	echo "Enter the path to where the project should be created:" &&
        read PROJECT_PATH


        #clone the git repository
        FULL_PATH="${PROJECT_PATH}/${PROJECT_NAME}"
	git clone "${URL}" "${FULL_PATH}"

	echo "\nDone"
}

echo "`time_of_day_greeting` `whoami`. Lets get your local git repository setup."
echo "Select from the following options:"
echo "1) Initialize a new local git repository."
echo "2) Clone a remote git repository."
read OPTION

if [ "$OPTION" = "1" ]; then
	create_repo
elif [ "$OPTION" = "2" ]; then
	clone_repo
else 
	echo "Goodbye!"
fi


