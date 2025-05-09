# Pasos para el build

Para crear una nueva tag:

- descargar desde el **CTAN** la versión TeX Live deseada en
  formato ISO. La última vez la sacamos del Torrent. Ver la
  versión y meterla en **assets/texlive** con el nombre
  **texlive_tlYYYY.iso**;

- configurar el año de la compilación **texlive** en la env var
  del Dockerfile;

- descargar también desde **Pandoc** el **.deb** de la
  distribución binaria que queramos instalar y ponerla en
  **assets/pandoc** ;

- primero creamos una imagen base sobre la que instalaremos
  manualmente la ISO posteriormente. Se llama
  **latex_manual_install:tlYYYY** y se crea con **make
  base_installation_image**;

- montamos la ISO con **make iso_mount**;

- con **make manual_install** creamos el contenedor no volátil
  con nombre **latex_install_container_tlYYYY** e instalamos el
  TeX Live con el script **install-tl**. Asegurarse de que el
  tamaño de página es A4 e instalar con **I**;

- ejecutar después de instalar el TeX Live el script
  **/ext/assets/scripts/texlive-postinstall.sh**;

- cuando la imagen esté lista, salir del contenedor de
  instalación manual y hacer commit con **make commit**;

- hacer push o save con el make apropiado.

- limpiar los assets de builds con **make clean**.
