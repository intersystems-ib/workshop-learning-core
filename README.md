Introducción:
En este proyecto vas a poder desarrollar una aplicación básica con ObjectScript y que será desplegada en una instancia de IRIS dockerizada. La versión de IRIS utilizada corresponde con la última publicada dentro de la Comunidad de Desarrolladores de InterSystems.

El objetivo de nuestra aplicación es gestionar la base de datos de una inmobiliaria

# Objetos
En este tema vamos a repasar como definir clases y propiedades así como definir métodos, tanto de clase como de instancia. Podremos probar nuestro código accediendo al terminal con el siguiente comando dentro del terminal de Visual Studio Code:
> $ docker-compose exec iris iris session iris -U LEARNING


## 1. Definición de clases
Primeramente vamos a implementar las clases cuyo esqueleto podréis encontrar en la ruta  **/src/LEARNING/Object**

### Vivienda
Dicha clase contendrá la información de las viviendas a la venta que son gestionadas por la inmobiliaria. Esta contendrá las siguientes propiedades:
- Habitaciones: de tipo Integer.
- Ascensor: de tipo Boolean.
- Garaje: de tipo Boolean.
- CodigoPostal: de tipo String.
- Superficie: de tipo Integer.
- Aseos: de tipo Integer.
- Precio: de tipo Integer.
- PrecioObjetivo: de tipo Integer.

### Comercial
Responsable de guardar la información del comercial responsable de la venta de las viviendas.
- Nombre: de tipo String.
- Apellidos: de tipo String.

### Ciudad
Información de la ciudad en la que se ubica la vivienda.
- Nombre: de tipo String.
- Población: de tipo Integer.

## Ejercicio 1
Crea dos instancias de la clase Vivienda, la primera con el código postal 28001 y la segunda con el código postal 28008, no es necesario que definas ninguna propiedad más.

**Ejemplo**
> LEARNING> set vivienda1 = ##class(LEARNING.Object.Vivienda).%New()
>
> LEARNING> set vivienda1.CodigoPostal = 28001

Por el momento no será necesario que persistas estas viviendas en la base de datos, dejémoslas en memoria. Si todo ha funcionado correctamente ejecutando *w vivienda1* debería mostrar el siguiente mensaje:

**Resultado**
> 1@LEARNING.Object.Vivienda

Perfecto, puedes borrar las instancias creadas ejecutando el comando *kill*

## 2. Métodos de instancia y métodos de clase
Nuestra inmobiliaria está interesada en conocer una valoración objetiva del valor de la vivienda, para ello ha creado una tabla Lookup con el precio medio del metro cuadrado en cada zona de la ciudad. Puedes echar un vistazo al fichero **/src/Lookup/ValorZona.xml**.

Crea un método instancia llamado **CalculaPrecioBasico** que acepte un atributo por referencia llamado **precioEstimado** de tipo Integer. Este método deberá calcular el precio estimado para la vivienda conforme a sus características y la zona en la que se encuentra. El cálculo obtenido se grabará en la propiedad **PrecioObjetivo** y en la variable pasada por referencia **precioEstimado**

Puedes copiar el cálculo del precio de aquí:

**Cálculo**
> ..Superficie * ^Ens.LookupTable("ValorZona",..CodigoPostal) * (1.1 * ..Garaje) * (1.05 * ..Ascensor)

## Ejercicio 2.1
Debes crear una nueva instancia de la clase **LEARNING.Object.Vivienda** con los siguientes valores en sus propiedades:
- Habitaciones: 3
- Ascensor: 1
- Garaje: 1
- CodigoPostal: 28002
- Superficie: 112
- Aseos: 2
- Precio: 390000
A continuación debes obtener el precio estimado para dicha vivienda. Si lo has hecho correctamente el valor estimado será:

**Resultado**
> 536844

## Ejercicio 2.2
Ahora vamos a probar a crear un método de clase que nos sirva para consultar el precio medio del suelo para un determinado código postal. El método de clase se denominará **ConsultaPrecioSuelo** y admitirá un parámetro **codigoPostal** de tipo String y una variable por referencia **resultadoPrecio** de tipo Integer en la que el método nos devolverá el resultado de la consulta.
Para obtener el valor de la Lookup table sólo tienes que llamar al siguiente método:

**Consulta**
> ^Ens.LookupTable("ValorZona",..VariablePorReferencia)

Si habéis implementado correctamente el método los siguientes comandos deberían devolveros el mismo resultado:

**Invocación**
> LEARNING>do ##class(LEARNING.Object.Vivienda).ConsultaPrecioSuelo("28002",.resultadoPrecio)
>
> LEARNING>w resultadoPrecio
> 4150
