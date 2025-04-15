# Proceso de construcción de la imagen Docker para TeX Live

Como concepto general, hay que tener en cuenta que la instalación
de TeX Live hay que hacerla manualmente.


## Pasos para el build

Para crear una nueva tag:

- descargar desde el **CTAN** la versión TeX Live deseada en
  formato ISO. La última vez la sacamos del Torrent. Ver la
  versión y meterla en **assets/texlive** con el nombre
  **texlive_tlYYYY.iso**;

- descargar también desde **Pandoc** el **.deb** de la
  distribución binaria que queramos instalar y ponerla en
  **assets/pandoc** ;

- primero creamos una imagen base sobre la que instalaremos
  manualmente la ISO posteriormente. Se llama
  **latex_manual_install:tlYYYY** y se crea con **010**;

- montamos la ISO con **020**;

- con **030** creamos el contenedor no volátil con nombre
  **latex_install_container_tlYYYY** e instalamos el TeX Live con
  el script **install-tl**. Asegurarse de que el tamaño de página
  es A4 e instalar con **I**;

- ejecutar después de instalar el TeX Live el script **assets/scripts/texlive-postinstall.sh**;



- still inside the temporal installation container, run the **/ext-src/scripts/texlive-postinstall.sh** script to post-configure the installation and create users;

- when happy, exit the container and execute script **020** to commit changes to a new image called **malkab/latex**;

- push image with **030**;

- clean up: execute **040** to delete installation container and unmount ISO;

- test with **050**;

- document new versions used and create Docker tag.
