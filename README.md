# Docker Building Process of an Image for Text Workflows based on TeX Live

This repo contains the process and tools to create a Docker image for working with TeX Live. It is a manual process not governed entirely by a Dockerfile.


## Steps

This build process is pretty much time and resource consuming. **Consider running it on a workstation**.

Steps to build the image:

- download the desired TeX Live ISO image from **CTAN**. It is not in the **docker** folder because they are really big and there is no point in incoporating it into the Docker build context. Copy it to the **texlive folder** and rename it to **texlive.iso**;

- download the latest release of **Pandoc** from its page. Copy it to the **docker/assets folder** and rename to **pandoc.deb**;

- run the **texlive/00-mount-iso.sh** script. It will mount the ISO into the **texlive-mount-point** folder;

- create a base image for working the TeX Live installation by running the **docker/00** script;

- configure the **common context** with the name of the TeX Live distribution;

- create a non-volatile container running **docker/10** and install and configure in it TeX Live. This container mounts the ISO image. In the latest release (2020), there was an **install-tl** script. Default configuration was accepted (just hit the option to start install, **I** if I recall correctly);

- run the **15-texlive-postinstall.sh** script to post-configure the installation;

- when happy, exit the container and execute script **20** to commit changes to a new image called **malkab/text-workflows**;




- push image with **30**;

- clean up: delete installation container and unmount ISO;

- document new versions used and create Docker tag.
