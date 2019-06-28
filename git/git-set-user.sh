#!/bin/bash

# This script define the required user configuration based on the remote origin url
# When the origin match one of the rule, it will update the local git config with the proper user.name or user.email
#
# To add a managed domain, use :
# - git config --global --add credentials.domain my-domain.com
# Then, add your username and email :
# - git config --global credentials.my-domain.com.email zaphod.beeblebrox@gov.galaxy
# - git config --global credentials.my-domain.com.name "Zaphod Beeblebrox"
#
# To use it :
# - domain automatically determined thanks the 'origin' remote URL : git set-user
# - domain manually specified : git set-user my-domain.com

if [ "$1" == "" ]; then
    remote=`git remote get-url --push origin`
else
    remote=$1
fi

if [ $? -eq 0 ]; then

    git config --get-all credentials.domain | while read -r domain ; do
        if [[ $remote == *$domain* ]]; then
            name=`git config --get credentials.${domain}.name`
            if [ $? -eq 0 ]; then
                echo "Configuring user.name as $name"
                git config user.name "$name"
            fi

            email=`git config --get credentials.${domain}.email`
            if [ $? -eq 0 ]; then
                echo "Configuring user.email as $email"
                git config user.email "$email"
            fi

            signingkey=`git config --get credentials.${domain}.signingkey`
            if [ $? -eq 0 ]; then
                echo "Configuring user.signingkey as $signingkey"
                git config user.signingkey "$signingkey"
                git config commit.gpgsign true
            else
                git config --unset commit.gpgsign
            fi
            exit 0
        fi
    done

else
    echo "Cannot find remote"
fi
