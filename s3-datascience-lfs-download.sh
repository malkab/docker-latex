#!/bin/bash

# -----------------------------------------------------------------
#
# Document here the purpose of the script.
#
# -----------------------------------------------------------------
#
# Uploads to a S3 bucket all relevant LFS information of the project.
# Uploads all the work-packages/wp/data/000-in folders, the
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


# Delete option

if [ "$DELETE" = true ]; then DELETE="--delete"; else DELETE="" ; fi


# Get the project-family/project path

WP1=${PWD##*/}

cd ..

WP0=${PWD##*/}

cd $WP1

DESTINATION=${TARGET_BUCKET%/}/$WP0/$WP1


# Interactive documentation, if any

if [ "$DRYRUN" = true ]; then 

    DRYRUN="--dryrun"

else

    DRYRUN=

fi

aws s3 sync \
  --storage-class $STORAGE_CLASS \
  $DRYRUN \
  $DESTINATION \
  .
