#!/bin/bash

if [ -z "$1" ]; then
    echo "Enter role name: "
    read NEW_ROLE_NAME
else
    NEW_ROLE_NAME=$1
fi

if [ -z "$2" ]; then
    if [ -z "$GITHUB_USER" ]; then
        echo "Enter github user: "
        read GITHUB_USER
    fi
else
    GITHUB_USER="$2"
fi

if [ "$ROLE_IN_COLLECTION" != "true" ]; then # So I can skip this when using the template for a role in a collection
    if [ -z "$GALAXY_API_KEY" ]; then
        echo "Enter galaxy api key: "
        read GALAXY_API_KEY
    fi
fi

if [ "$ROLE_IN_COLLECTION" != "true" ]; then
    # Assumes repo is named ansible_role_${NEW_ROLE_NAME}
    gh secret set GALAXY_API_KEY -R ${GITHUB_USER}/ansible_role_${NEW_ROLE_NAME} -a actions -b ${GALAXY_API_KEY}
else
    if [ "$ROLE_IN_COLLECTION" == "true" ]; then
        rm -r ./.github ./.gitlab-ci.yml
    fi
fi

find defaults handlers meta molecule tasks tests vars LICENSE README.md \
    -type f -exec sed -i -e "s/diademiemi/${GITHUB_USER}/g" -e "s/template/${NEW_ROLE_NAME}/g" {} + # Do not run this more than once

# Remove this section from README.md
sed -i "/Role Structure/Q" README.md

mv ansible_role_template.code-workspace ansible_role_${NEW_PROJECT_NAME}.code-workspace

rm ./replace.sh
