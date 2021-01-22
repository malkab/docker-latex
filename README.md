# Docker Building Process of an Image for Text Workflows based on TeX Live

This repo contains the process and tools to create a Docker image for working with TeX Live. It is a manual process not governed entirely by a Dockerfile.


## Tags

This image has the following tags:

- **tl2019:** TeX Live for 2019, Pandoc version 2.8.1;

- **tl2020:** TeX Live for 2020, Pandoc version 2.11.3. This tag includes ImageMagick for image processing.


## Build Steps

This build process is pretty much time and resource consuming. **Consider running it on a workstation**.

Steps to build the image:

- download the desired TeX Live ISO image from **CTAN**. It is not in the **docker** folder because they are really big and there is no point in incoporating it into the Docker build context. Copy it to the **texlive folder** and rename it to **texlive.iso**;

- download the latest release of **Pandoc** from its page. Copy it to the **docker/assets folder** and rename to **pandoc.deb**;

- run the **texlive/000-mount-iso.sh** script. It will mount the ISO into the **texlive-mount-point** folder;

- create a base image for working the TeX Live installation by running the **docker/000** script;

- configure the **common context** with the name of the TeX Live distribution;

- create a non-volatile container running **docker/010** and install and configure in it TeX Live. This container mounts the ISO image at **/texlive**. In the latest release (2020), there was an **install-tl** script. All default parameters were accepted except for the default paper size: set the option to use A4 by default. Then just hit the option to start install, **I**;

- run the **scripts/texlive-postinstall.sh** script to post-configure the installation;

- when happy, exit the container and execute script **020** to commit changes to a new image called **malkab/text-workflows**;

- push image with **030**;

- clean up: execute **040** to delete installation container and unmount ISO;

- document new versions used and create Docker tag.
