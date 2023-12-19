Introducción:
En este proyecto vas a poder desarrollar una aplicación básica con ObjectScript y que será desplegada en una instancia de IRIS dockerizada. La versión de IRIS utilizada corresponde con la última publicada dentro de la Comunidad de Desarrolladores de InterSystems.

El objetivo de nuestra aplicación es gestionar la base de datos de una inmobiliaria

# 1. Objetos
En este tema vamos a repasar como definir clases y propiedades así como definir métodos, tanto de clase como de instancia. Podremos probar nuestro código accediendo al terminal con el siguiente comando dentro del terminal de Visual Studio Code:
> $ docker-compose exec iris iris session iris -U LEARNING


## 1.1. Definición de clases
Primeramente vamos a implementar las clases cuyo esqueleto puedes encontrar en la ruta  **/src/LEARNING/Object**

### Certificado
Clase de tipo %SerialObject que contendrá la información del certificado energético para cada vivienda.
- Clasificación: de tipo String.
- Consumo: de tipo Integer.
- Emisiones: de tipo String.

### Vivienda
Dicha clase contendrá la información de las viviendas a la venta que son gestionadas por la inmobiliaria. Esta contendrá las siguientes propiedades:
- Habitaciones: de tipo Integer.
- Ascensor: de tipo Boolean.
- Garaje: de tipo Boolean.
- Superficie: de tipo Integer.
- Aseos: de tipo Integer.
- Precio: de tipo Integer.
- PrecioObjetivo: de tipo Integer.
- CertificadoEnergetico: de tipo Certificado.

### Comercial
Responsable de guardar la información del comercial responsable de la venta de las viviendas.
- Nombre: de tipo String.
- Apellidos: de tipo String.
- DNI: de tipo Integer.

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

## 1.2. Métodos de instancia y métodos de clase
Nuestra inmobiliaria está interesada en conocer una valoración objetiva del valor de la vivienda, para ello ha creado una tabla Lookup con el precio medio del metro cuadrado en cada zona de la ciudad. Puedes echar un vistazo al fichero **/src/Lookup/ValorZona.xml**.

Crea un método instancia llamado **CalculaPrecioEstimado** que acepte un atributo por referencia llamado **precioEstimado** de tipo Integer. Este método deberá calcular el precio estimado para la vivienda conforme a sus características y la zona en la que se encuentra. El cálculo obtenido se grabará en la propiedad **PrecioObjetivo** y en la variable pasada por referencia **precioEstimado**

Puedes copiar el cálculo del precio de aquí:

**Cálculo**
> set ..PrecioObjetivo = ..Superficie * ^Ens.LookupTable("ValorZona",..CodigoPostal) 
> if (..Garaje)
> {
>   set ..PrecioObjetivo = ..PrecioObjetivo * 1.1
> }
> if (..Ascensor)
> {
>   set ..PrecioObjetivo = ..PrecioObjetivo * 1.05
> }

## Ejercicio 2
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
> LEARNING>do vivienda1.CalculaPrecioEstimado(.precioEstimado)
> 
> LEARNING>w precioEstimado
>
> 536844

## Ejercicio 3
Ahora vamos a probar a crear un método de clase que nos sirva para consultar el precio medio del suelo para un determinado código postal. El método de clase se denominará **ConsultaPrecioSuelo** y admitirá un parámetro **codigoPostal** de tipo String y una variable por referencia **resultadoPrecio** de tipo Integer en la que el método nos devolverá el resultado de la consulta.
Para obtener el valor de la Lookup table sólo tienes que llamar al siguiente método:

**Consulta**
> ^Ens.LookupTable("ValorZona",..VariablePorReferencia)

Si has implementado correctamente el método los siguientes comandos deberían devolveros el mismo resultado:

**Invocación**
> LEARNING>do ##class(LEARNING.Object.Vivienda).ConsultaPrecioSuelo("28002",.resultadoPrecio)
>
> LEARNING>w resultadoPrecio
> 
> 4150

Una vez finalizados ambos ejercicios ejecutamos el comando **kill** para borrar de memoria las instancias creadas.
> LEARNING>kill


## 1.3. Herencia
Nuestra inmobiliaria quiere empezar a gestionar un tipo de viviendas más especializado como es el caso de los chalets, tenemos definida la clase **LEARNING.Object.Chalet** que extiende de **LEARNING.Object.Vivienda**. Necesita añadir unas nuevas propiedades que contemplen sus particularidades. Estas propiedades son:
- Jardin: de tipo Boolean.
- Piscina: de tipo Boolean.

También se necesita sobrescribir el método de instancia **CalculaPrecioEstimado** para que al precio calculado se le sume el criterio de la piscina y el jardín. Para ello se sumará al cálculo del precio estimado el resultado de la siguiente operación:

**Sobreescritura**
> if (..Piscina)
> {
>   set ..PrecioObjetivo = ..PrecioObjetivo * 1.2
> }
> if (..Jardin)
> {
>   set ..PrecioObjetivo = ..PrecioObjetivo * 1.15
> }


## Ejercicio 4
Vamos a crear un nuevo objeto, en este caso de la clase **LEARNING.Object.Chalet** con las siguientes características:
- Habitaciones: 4
- Ascensor: 0
- Garaje: 1
- CodigoPostal: 28004
- Superficie: 180
- Aseos: 3
- Precio: 463400
- Jardin: 1
- Piscina: 0

Con estos datos y el método de instancia **CalculaPrecioEstimado** sobreescrito deberías obtener el siguiente valor estimado:

**Resultado**
> LEARNING>do chalet1.CalculaPrecioEstimado(.precioEstimado)
> 
> LEARNING>w precioEstimado
>
> 876645

## 1.4. Relaciones entre clases
Para nuestra aplicación necesitamos relacionar las viviendas en nuestra base de datos con los comerciales que van a ser los encargados de gestionar su venta, de tal forma que una vivienda corresponda a un único comercial (y así evitar conflictos entre los comerciales) y un comercial pueda tener asignadas múltiples viviendas.
Recuerda que las relaciones se definen con la palabra clave **Relationship**, en las relaciones One-to-Many es necesario que las instancias de las clases relacionadas estén persistidas antes de guardar la relación, mientras que en las relaciones Parent-to-Children se requiere que la clase padre exista y la referencia en el hijo esté informada.

## Ejercicio 5
Deberás crear una relación que permita registrar la vinculación entre las clases Comercial y Vivienda de tal forma que permita conocer a qué comercial está asignada la vivienda y podamos obtener su lista de viviendas asignadas. Ten en cuenta que el sistema debe permitir registrar viviendas sin vinculación a ningún comercial.
También debes relacionar las ciudades con las viviendas, en este caso tampoco es obligatorio que la ciudad esté informada antes de grabar la vivienda.

**Tip**
> En las relaciones Many-to-One es necesario crear un índice en la clase con cardinalidad 1, en el caso de las relaciones Parent-to-Children dicho índice no es necesario.

Para empezar deberás crear una instancia de la clase **LEARNING.Object.Ciudad**, otra de la clase **LEARNING.Object.Vivienda** y finalmente de la clase **LEARNING.Object.Comercial**. Puedes usar como datos los siguientes:

**Ciudad**
- Nombre: "Madrid"
- Poblacion: 3500000

**Vivienda**
- Habitaciones: 3
- Ascensor: 1
- Garaje: 1
- CodigoPostal: 28002
- Superficie: 112
- Aseos: 2
- Precio: 390000

**Comercial**
- Nombre: Juan
- Apellidos: Gómez Martín
- DNI: 12345678A

Con las instancias creadas ya puedes asignar a la vivienda la ciudad y el comercial. ¡Ojo! Dependiendo el tipo de relación creada deberás informar las relaciones antes de persistir el objecto o no. Si has llamado vivienda1 a vuestra instancia podrás comprobar que ha funcionado correctamente ejecutando el siguiente comando:
> LEARNING> w vivienda1.Comercial.Nombre
>
> Juan
>
> LEARNING> w vivienda1.Ciudad.Nombre
>
> Madrid



# 2. API REST

En este tema vamos a repasar como configurar una API REST que podamos invocar desde cualquier sistema externo. En nuestro caso vamos a utilizar **POSTMAN** como herramienta. En la raíz del proyecto puedes encontrar un archivo llamado **workshop-learning-core.postman_collection.json** que deberás importar en el POSTMAN y que tiene configurado por defecto una serie de llamadas.

El proyecto por defecto va a configurar una aplicación web para las pruebas cuya dirección corresponderá con **http://localhost:52774/api/learning**. Cualquier invocación a esa URL se redirigirá a la clase **LEARNING.WS.Service**, la cual puedes ver que cuenta con una configuración básica y una serie de enrutamientos a unos métodos específicos que implementarás en los siguientes ejercicios.

## 2.1. Invocando llamadas GET
Nuestro proyecto debe de proporcionar la posibilidad de recuperar la información relativa a las clases que se almacenan en nuestro sistema, para ello debe implementar los enrutamientos necesarios para gestionar las llamadas de tipo GET que reciba. Estos tipos de llamadas recibirán un parámetro en su URL, por lo general un identificador que, como puedes observar en el método al que redirige, se pasará como parámetro de entrada.

## 2.2. Invocando llamadas PUT/POST
Al igual que en el caso de las llamadas GET ya disponemos en **LEARNING.WS.Service** de unos enrutamientos configurados para gestionar llamadas POST. Lo particular de estas llamadas es que la información que se remite a nuestro sistema viene en el cuerpo de la llamada. En los ejemplos incluidos estos datos vienen en formato JSON.

## Ejercicio 6
Implementa el método GetVivienda para poder retornar al POSTMAN los datos de la vivienda registrada con identificador 1. No olvides retornar la información de la vivienda en formato JSON. El resultado debería ser parecido a esta imagen:
![alt text](/images/getVivienda.png)

## Ejercicio 7
Implementa los métodos para poder registrar a los comerciales **SaveComercial** a las ciudades **SaveCiudad** y a las viviendas **SaveVivienda**. Puedes ver los atributos de objeto que se enviará desde el POSTMAN consultando el body de la llamada:
![alt text](/images/saveVivienda.png)
Como puedes ver en el caso de SaveVivienda la información de la ciudad y el comercial asignado a la vivienda vienen informados ya por su identificador en el sistema. Para probar este ejercicio debes asegurarte primero que hayas guardado una ciudad y un comercial antes de intentar guardar la vivienda.
Si en tu caso tu caso tanto el comercial como la vivienda tienen otros identificadores puedes modificar la llamada del POSTMAN para que se adapte a tu entorno.
Puedes echar un vistazo a la documentación oficial para ver como asignar referencias a otros objetos mediante el uso del ID [aquí](https://docs.intersystems.com/irislatest/csp/docbook/DocBook.UI.Page.cls?KEY=GOBJ_propmethods#GOBJ_propmethods_accessors_obj)

# 3. SQL

En este tema vas a poder repasar como ejecutar consultas de SQL sobre nuestra base de datos utilizando Dynamic SQL. Podrás ver como definir una SQL, utilizar la clase **%SQL.Statement** para la preparación y ejecución de la query y finalmente recorrer los resultados de la consulta.
Para nuestro proyecto va a ser necesario controlar que no registremos valores duplicados en el sistema, por lo que será necesario realizar una validación previa al registro que se realiza desde los métodos que reciben llamadas POST en nuestra clase **LEARNING.WS.Service**

## Ejercicio 8
Deberás incluir una comprobación previa para el método **SaveComercial** de la clase **LEARNING.WS.Service** para validar que no existe ningún comercial ya registrado con el DNI. Deberás utilizar la funcionalidad de Dynamic SQL para preparar y ejecutar la consulta. En caso de existir dicho comercial se deberá devolver un error 409 indicando que ya existe un comercial con ese DNI.
![alt text](/images/error409Comercial.png)