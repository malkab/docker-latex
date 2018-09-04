# ¿Qué es PostgreSQL y PostGIS?

PostgreSQL es un sistema gestor de base de datos de software libre. PostgreSQL está diseñada con una __arquitectura cliente-servidor__, lo que la convierte en un sistema gestor de bases de datos distribuído y multiusuario. Esto quiere decir que el sistema gestor de bases de datos suele instalarse en un servidor central al que los usuarios se conectan utilizando diversos programas clientes. Varios usuarios pueden conectarse simultáneamente y utiizar la base de datos a la vez, sin peligro de que interfieran los unos con los otros. Obviamente, nadie nos impide instalar tanto el programa cliente como el programa servidor en la misma máquina.

PostgreSQL es un sistema gestor de bases de datos relacionales __orientado a objetos__. Esto quiere decir que el usuario tiene la posibilidad de crear nuevos tipos de datos que después puede utilizar para crear las estructuras de sus bases de datos. PostgreSQL viene equipada de serie con una enorme cantidad de tipos de datos, como por ejemplo números de todos los tamaños, enteros y decimales, o sofisticados tipos para manejar fechas. Imaginemos que necesitaramos un tipo de dato que no existiera por defecto en PostgreSQL, por ejemplo para identificar un taxón biológico con su género y su especie. PostgreSQL permite crear dicho tipo de datos compuesto por dos datos que trabajan conjuntamente.

This is a 10\euro.

This is a $\rho$ greek letter.


## \LaTeX\ Font Sizes

This are \LaTeX\ font sizes:

- __tiny:__ \tiny this is tiny; \normalsize
- __scriptsize:__ \scriptsize this is scriptsize; \normalsize
- __footnotesize:__ \footnotesize this is footnotesize; \normalsize
- __small:__ \small this is small; \normalsize
- __normalsize:__ \normalsize this is normalsize;
- __large:__ \large this is large; \normalsize
- __Large:__ \Large this it Large; \normalsize
- __LARGE:__ \LARGE this is LARGE; \normalsize
- __huge:__ \huge this is huge; \normalsize
- __Huge:__ \Huge this is Huge; \normalsize

All of them should be followed by a __normalsize__ to return to normality.

This is an internal Markdown anchor that can be called [this way](#¿Qué es PostGIS?).

<a name="¿Qué es PostGIS?"></a>

## ¿Qué es PostGIS?

Es la orientación a objetos de la que dispone la PostgreSQL la que hace posible la creación de extensiones como __PostGIS__. Esta propiedad, que convierte a PostgreSQL en un potente sistema gestor de bases de datos, en lo que se basan los programadores para extender las funcionalidades del sistema hacia nuevos campos temáticos no contemplados en la instalación por defecto del sistema. __PostGIS__ no es más que una extensión sobre la PostgreSQL que extiende su funcionalidad hasta convertirla en un sistema gestor de bases de datos geográficas, es decir, un sistema capaz de entender la vertiente geométrica de la información geográfica.

__PostGIS__ es una complicada pieza de software que hace sobre una PostgreSQL lo siguiente:

- crea nuevos tipos de datos, como el tipo de datos __geometry__, para contemplar manejar datos geométricos vectoriales referenciados según un sistema de referencia;

- crea también, a partir de la versión 2, tipos de datos para el manejo de información ráster;

- incorpora a la estructura interna de la base de datos nuevas librerías de software libre geomático, entre ellas:

  - __Proj4:__ es la librería que se encarga de las transformaciones geodésicas;

  - __GDAL y OGR:__ son las librerías de interoperatividad, que nos permitirán importar información geográfica a la base de datos a partir de otros formatos;

  - __GEOS:__ posiblemente la más importante, GEOS es un motor topológico vectorial que permite rastrear y trabajar con información vectorial. Es el "cerebro" de la PostGIS, es lo que hace que la PostgreSQL pueda "pensar" topológicamente;

- implementa una serie de sistemas necesarios para el fluído funcionamiento de la base de datos geográfica, como por ejemplo índices espaciales capaces de indexar información geométrica y, por tanto, agilizar tremendamente los cálculos topológicos.

A partir de aquí designaremos al sistema __PostgreSQL / PostGIS__ simplemente como __PostGIS__.


## Instalación de un servidor PostGIS

El servidor de PostGIS es un programa autónomo que se suele instalar en un servidor centralizado. En una arquitectura cliente-sevidor, lo normal es que ningún usuario controle completamente el servidor, sino que éste esté en modo de espera a que le llegue alguna petición de trabajo. Los programas multiusuario instalados en máquinas servidoras se comunican a través de la red gracias a la infraestructura TCP/IP. En esta infraestructura, las máquinas organizan sus comunicaciones en base a __puertos__, que son, digamos, puestos de escucha individuales para organizar el tráfico de paquetes de datos que llegan a la máquina por la red. Imaginemos un centro de distribución postal en el que el primer paso es organizar los paquetes por su código postal. Ese es el papel, a grandes rasgos, que desempeñan los puertos TCP/IP en una máquina.

Por lo tanto, y dado que en una máquina servidora puede haber una infinidad de programas utilizando la red para comunicarse con el exterior, cada uno de ellos utiliza y escucha en un puerto determinado. Es necesario conocer dicho puerto para poder conectar, dentro de una máquina servidora determinada, con el programa correcto. Por tradición, la PostGIS utiliza el puerto __5432__, aunque puede utilizar cualquiera de los miles de puertos disponibles en una máquina.

Otra consideración a tener en cuenta a la hora de instalar un servidor PostGIS es la cuenta de superusuario. Al ser un servidor multiusuario, debe existir un usuario primigenio con poder de gestión de todo el sistema. Es lo que se conoce como el __"superusuario"__, que en los servidores PostGIS toma tradicionalmente el nombre de __postgres__. El superusuario, como cabe imaginar, tiene poder ilimitado en el control del sistema gestor de base de datos, pudiendo borrar bases de datos enteras con una simple instrucción. Por tanto, no es muy difícil imaginar que la contraseña de superusuario debe ser un secreto celosamente guardado si no queremos ver comprometida la seguridad de nuestro sistema. De hecho, de la seguridad de la máquina servidora al completo, puesto que el usuario puede ejecutar código arbitrario desde su cuenta de PostGIS, pudiendo crear potencialmente un verdadero caos y hacerse con el control completo de la máquina servidora.

Sabido esto, al arrancar el paquete de instalación de la __PostgreSQL__ (que no PostGIS, ya que primero hay que instalar la PostgreSQL para después instalar sobre ella la PostGIS), lo primero que pregunta es una contraseña para el superusuario __postgres__. Debemos escribir dos veces una contraseña bien segura en un caso de uso real, aunque en este caso, para los ejercicios a continuación, utilizaremos como contraseña el mismo nombre que el superusuario: __postgres__. Esto facilitará las cosas en el desarrollo de los ejercicios, pero es algo que nunca, nunca, debe hacerse en un sistema real en producción.

![Contraseña de superusuario](src/images/install01r.png)


## Clientes para conectarse a PostgreSQL

Esto es código Python:

\mlksidepar{This declares a Dictionary object}

```Python
# Definition

d = dict()

# Adding a key / value

d['key1'] = 'value1'

# Retrieving a value by its key

print(d['key1'])

# Delete a key

del d['key1']

try:
  print(d['key1'])
except KeyError:
  print('key1 does exists no longer!')

# Check if a key is present

d['key2'] = 'value2'

if 'key2' in d:
  print('key2 is in d!')

if 'key1' not in d:
  print('And key1 is not!')

# Iterator

d['key1'] = 'value1'
d['key3'] = 'value3'

for k, v in d.items():
  print('Key: '+k+', Value: '+v)

# Number of items in the dictionary

print('Number of items: '+str(len(d)))

# Parsing a dictionary from a string
a = "{'S': 1}"

import ast
d = ast.literal_eval(a)
print d["S"]
```

Y esto es código SQL:

``` {#code01 .sql .numberLines startFrom="1"}
/*

  context schema definition.

*/

\echo -----------------------
\echo Creating context schema
\echo -----------------------

\c {{c.dbname}} {{c.owneruser}} {{c.host}} {{c.port}}

begin;

-- Esquema

create schema context authorization {{c.owneruser}};

comment on schema context is
'Información contextual de referencia.';

grant usage on schema context to group {{c.usergroup}};

grant usage on schema context to {{c.geoserveruser}};

{%- for n in range(0, c.gridsuffix|count) %}

-- Tabla de la grid de {{c.gridsizes[n]}} m

create table context.grid_{{c.gridsuffix[n]}}(
  gid bigint,
  grd_fixid varchar(27),
  grd_floaid varchar(23),
  grd_inspir varchar(19),
  geom geometry(POLYGON, 25830)
);

comment on table context.grid_{{c.gridsuffix[n]}} is
'Rejilla de {{c.gridsizes[n]}} metros para Andalucía. Los códigos son heredados de la rejilla de referencia utilizada para su construcción, la de 250 metros del IECA (Instituto de Estadística y Cartografía de Andalucía), que a su vez se crea a partir de la rejilla oficial europea de 1 km.';

comment on column context.grid_{{c.gridsuffix[n]}}.gid is
'ID de la rejilla.';

comment on column context.grid_{{c.gridsuffix[n]}}.grd_fixid is
'Un código de la rejilla.';

comment on column context.grid_{{c.gridsuffix[n]}}.grd_floaid is
'Otro código de la rejilla.';

comment on column context.grid_{{c.gridsuffix[n]}}.grd_inspir is
'Otro código de la rejilla.';

comment on column context.grid_{{c.gridsuffix[n]}}.geom is
'Geometría de la rejilla, POLYGON, EPSG 25830.';

alter table context.grid_{{c.gridsuffix[n]}}
add constraint grid_{{c.gridsuffix[n]}}_pkey
primary key(gid);

create index grid_{{c.gridsuffix[n]}}_geom_gist
on context.grid_{{c.gridsuffix[n]}}
using gist(geom);
```

And this is a LaTeX formula:

\begin{equation}
x=\frac{-b\pm\sqrt{b^2-4ac}}{2a}
\end{equation}

More equations, in different sizes:

- __normal:__ $x^2 + 2xy + y^2$

- __displaystyle:__ $\displaystyle x^2 + 2xy + y^2$

- __scriptstyle:__ $\scriptstyle x^2 + 2xy + y^2$

- __scriptscriptstyle:__ $\scriptscriptstyle x^2 + 2xy + y^2$

- __textstyle:__ $\textstyle x^2 + 2xy + y^2$


## Some LaTeX Memoir Class Syntax

\autorows{c}{5}{1}{one, two, three, four, five, siz, seven, eight, nine, ten, eleven, twelve, thirteen}

This is a footnote[^1].

This is a footnote with a long note[^longnote].

[^1]: This is the real footnote.

[^longnote]: Multiline note

    Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec sed nunc quis purus luctus bibendum. Maecenas ut enim justo. Nunc bibendum rutrum ipsum, eget feugiat tellus tincidunt sit amet. Nullam tempor massa sed odio bibendum semper. Maecenas sit amet leo ut ipsum pellentesque aliquam. Vivamus finibus nisi eget metus aliquet, eget rhoncus ante laoreet. Curabitur a nunc tincidunt, imperdiet turpis eget, laoreet nibh. Nam gravida tempus pellentesque. Integer tristique eu eros non consequat. Nullam sollicitudin varius tincidunt. Cras felis purus, posuere nec rhoncus eu, venenatis a orci. Etiam tempus varius sem vel vulputate. Pellentesque ultrices dolor ac felis malesuada vestibulum. Aliquam rutrum orci metus, vitae egestas neque tempor nec.

    No code blocks allowed in footnotes.

    \begin{equation}
    \scriptstyle x=\frac{-b\pm\sqrt{b^2-4ac}}{2a}
	\end{equation}

    Ut vitae elementum nisl. Donec ultrices lobortis enim a varius. Mauris sit amet urna sed quam tincidunt vehicula eu quis lorem. Morbi ac iaculis libero. Curabitur ac viverra purus, ac congue justo. Curabitur gravida quam et metus consequat eleifend. Vivamus gravida interdum laoreet. Proin vulputate vitae lacus eu blandit. Quisque vel fringilla sem. Praesent rhoncus augue vel arcu gravida mattis. Nunc a risus tempor, dictum leo sed, vehicula diam.

This is again another normal paragraph. It is supplemented by a side note. \mlksidepar{This is the side note, written in raw \LaTeX. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec sed nunc quis purus luctus bibendum. Maecenas ut enim justo.}

Ut vitae elementum nisl. Donec ultrices lobortis enim a varius. Mauris sit amet urna sed quam tincidunt vehicula eu quis lorem. Morbi ac iaculis libero. Curabitur ac viverra purus, ac congue justo. Curabitur gravida quam et metus consequat eleifend. Vivamus gravida interdum laoreet. Proin vulputate vitae lacus eu blandit. Quisque vel fringilla sem. Praesent rhoncus augue vel arcu gravida mattis. Nunc a risus tempor, dictum leo sed, vehicula diam. \mlksidepar{Ut vitae elementum nisl. Donec ultrices lobortis enim a varius. Mauris sit amet urna sed quam tincidunt vehicula eu quis lorem. Morbi ac iaculis libero. Curabitur ac viverra purus, ac congue justo. Curabitur gravida quam et metus consequat eleifend.}


# Code

A big code experiment:\mlksidepar{This code is an example of Python code. Python should be a must for geocoders.}

This code is in __small__:

\footnotesize

``` {#code01 .python .numberLines startFrom="1"}
# Definition

d = dict()

# Adding a key / value

d['key1'] = 'value1'

# Retrieving a value by its key

print(d['key1'])

# Delete a key

del d['key1']

try:
  print(d['key1'])
except KeyError:
  print('key1 does exists no longer!')

# Check if a key is present

d['key2'] = 'value2'

if 'key2' in d:
  print('key2 is in d!')

if 'key1' not in d:
  print('And key1 is not!')

# Iterator

d['key1'] = 'value1'
d['key3'] = 'value3'

for k, v in d.items():
  print('Key: '+k+', Value: '+v)

# Number of items in the dictionary

print('Number of items: '+str(len(d)))

# Parsing a dictionary from a string
a = "{'S': 1}"

import ast
d = ast.literal_eval(a)
print d["S"]
```

\normalsize

Again normal size.
