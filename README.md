# Docker Building Process of an Image for Text Workflows based on TeX Live

This repo contains the process and tools to create a Docker image for
working with TeX Live. It is a manual process not governed entirely by a
Dockerfile.



## Steps

This build process is pretty much time and resource consuming.
**Consider running it on a workstation**. 

Steps to build the image:

- download the desired TeX Live ISO image and copy into the
  **texlive-iso** folder. It is not in the **docker** folder because
  they are really big and there is no point in incoporating it into the
  Docker build context;

- run the **00-mount-iso.sh** script. It will mount the ISO into the
  **texlive-mount-point** folder. Please note that the folder the ISO is
  mounted in within this folder varies between TeX Live releases;

- create a base image for working the TeX Live installation by running
  the **docker/00** script;

- create a non-volatile container named
  **text-workflows-install-container** and install and configure in it
  TeX Live. This container mounts the ISO image. Don't forget to run the
  **15-texlive-postinstall.sh** script to post-configure the installation;

- when happy, exit the container and execute script **20** to commit
  changes to a new image called **malkab/text-workflows**;

- push image with **30**;

- clean up: delete installation container and unmount ISO in Finder.
