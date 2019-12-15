#!/bin/bash

# -----------------------------------------------------------------
#
# Upload the TeX Live ISO image.
#
# -----------------------------------------------------------------
#
# Uploads to a S3 bucket all relevant LFS information of the project.
# Uploads all the work-packages/wp/data folders, the
# docker-persistent-volumes, the rsync configs in the root, and an
# arbitrary set of folders and files.
#
# Keep in mind that at the target bucket local paths will be replicated
# from the git/project-family whatevertheproject level, so beware of 
# possible project name conflicts, that should exist because the paths
# are sync with the dev machines, GitLab, and the LFS S3 bucket. The
# selected bucket should be one only used to store data coming from 
# /home/git projects.
#  
# -----------------------------------------------------------------

# Arbitrary folders to upload, in the form
# (docker/backups whatever/whatever/folder)
FOLDERS=(

)
# Arbitrary files to upload, in the form
# (docker/backups/file whatever/whatever/folder/file)
FILES=(texlive-iso/texlive2019-20190410.iso)
# Exclude this files from all uploads
EXCLUDES=("*.DS_Store" ".gitignore")
# Target LFS bucket
TARGET_BUCKET=$GIT_LFS_S3_BUCKET
# S3 storage class
STORAGE_CLASS=STANDARD_IA





# ---

# Help function

help(){
cat <<EOF
Uploads LFS data to S3, check script config. By default the script is 
run dry and without delete.

    ./s3-datascience-lfs-upload.sh -o -d -h

Usage:
    -o        Perform the operation (DRYRUN false).
    -d        DELETE true... use with caution!!!
    -h        This help.
EOF

return 0
}


# Default values

DRYRUN=true

DELETE=false


# Options processing

POS=0

while getopts odh opt ; do
	case "$opt" in
	    h) help
          exit 0
	        ;;
	    o) DRYRUN=false
	        ;;
      d) DELETE=true
          ;;
	    ?) help
          exit 0
	        ;;
	esac
done


# Interactive documentation, if any

if [ "$DRYRUN" = true ]; then 

    DRYRUN="--dryrun"

else

    DRYRUN=

fi


# Add excludes to an AWS command stored in an AWS_COMMAND env

insert_excludes(){

    if [ ! -z "${EXCLUDES}" ] ; then

        for E in "${EXCLUDES[@]}" ; do
    
            AWS_COMMAND="${AWS_COMMAND} --exclude \"${E}\" "

        done

    fi

}


# Delete option

if [ "$DELETE" = true ]; then DELETE="--delete"; else DELETE="" ; fi


# Get the project-family/project path

WP1=${PWD##*/}

cd ..

WP0=${PWD##*/}

cd $WP1

GIT_PROJECT_PATH=$WP0/$WP1


# A little clean up

TARGET_BUCKET=`dirname $TARGET_BUCKET`//`basename $TARGET_BUCKET`


# Uploads work packages data folders

if [ -d "./work-packages" ] ; then

  for FOLDER in $(find ./work-packages -maxdepth 2 -name data) ; do

    echo
    echo --------------------
    echo Uploading folder $FOLDER
    echo --------------------
    echo

    DESTINATION=$TARGET_BUCKET/$GIT_PROJECT_PATH/${FOLDER#*/}

    AWS_COMMAND="aws s3 sync ${DELETE} ${DRYRUN} \
      --storage-class ${STORAGE_CLASS} \
      ${FOLDER} ${DESTINATION}"

    insert_excludes

    eval $AWS_COMMAND

  done


  # Uploads work packages docker-persistent-volumes

  for FOLDER in $(find ./work-packages -name docker-persistent-volumes) ; do

    echo
    echo --------------------
    echo Uploading folder $FOLDER
    echo --------------------
    echo

    DESTINATION=$TARGET_BUCKET/$GIT_PROJECT_PATH/${FOLDER#*/}

    AWS_COMMAND="aws s3 sync ${DELETE} ${DRYRUN} \
      --storage-class ${STORAGE_CLASS} \
      ${FOLDER} ${DESTINATION}"

    insert_excludes

    eval $AWS_COMMAND

  done

fi


# Uploads the docker-persistent-volumes

if [ -d "./docker-persistent-volumes" ]; then

    echo
    echo --------------------
    echo Uploading folder main docker-persistent-volumes
    echo --------------------
    echo

    AWS_COMMAND="aws s3 sync $DELETE $DRYRUN --storage-class $STORAGE_CLASS \
        ./docker-persistent-volumes \
        $TARGET_BUCKET/$GIT_PROJECT_PATH/docker-persistent-volumes"

    insert_excludes

    eval $AWS_COMMAND

fi


# Uploads the rsync configs

aws s3 sync $DELETE $DRYRUN \
    --exclude "*" \
    --include "rsync-*.sh" \
    --storage-class $STORAGE_CLASS \
    . $TARGET_BUCKET/$GIT_PROJECT_PATH/


# Uploads arbitrary folders

if [ ! -z "${FOLDERS}" ] ; then

    for FOLDER in "${FOLDERS[@]}" ; do

        echo
        echo --------------------
        echo Uploading folder $FOLDER
        echo --------------------
        echo

        DESTINATION=$TARGET_BUCKET/$GIT_PROJECT_PATH/$FOLDER

        AWS_COMMAND="aws s3 sync $DELETE $DRYRUN \
            --storage-class $STORAGE_CLASS \
            $FOLDER $DESTINATION"

        insert_excludes

        eval $AWS_COMMAND

    done

fi


# Uploads arbitrary files

if [ ! -z "${FILES}" ] ; then

    for FILE in "${FILES[@]}" ; do

        echo
        echo --------------------
        echo Uploading file $FILE
        echo --------------------
        echo

        DESTINATION=$TARGET_BUCKET/$GIT_PROJECT_PATH/$FOLDER

        aws s3 sync $DELETE $DRYRUN \
            --exclude "*" \
            --include "${FILE}" \
            --storage-class $STORAGE_CLASS \
            . $TARGET_BUCKET/$GIT_PROJECT_PATH/

    done

fi
