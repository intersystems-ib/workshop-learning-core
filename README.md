Introducción:
En este proyecto vas a poder desarrollar una aplicación básica con ObjectScript y que será desplegada en una instancia de IRIS dockerizada. La versión de IRIS utilizada corresponde con la última publicada dentro de la Comunidad de Desarrolladores de InterSystems.

El objetivo de nuestra aplicación es gestionar la base de datos de una inmobiliaria

#Objetos
En este tema vamos a repasar como definir clases y propiedades así como definir métodos, tanto de clase como de instancia. Podremos probar nuestro código accediendo al terminal con el siguiente comando dentro del terminal de Visual Studio Code:
> $ docker-compose exec iris iris session iris -U LEARNING


##Definición de clases
Primeramente vamos a implementar las clases cuyo esqueleto podréis encontrar en la ruta  **/src/LEARNING/Object**

###Vivienda
Dicha clase contendrá la información de las viviendas a la venta que son gestionadas por la inmobiliaria. Esta contendrá las siguientes propiedades:
- Habitaciones: de tipo Integer.
- Ascensor: de tipo Boolean.
- Garaje: de tipo Boolean.
- Código Postal: de tipo String.
- Superficie: de tipo Integer.
- Aseos: de tipo Integer.
- Precio: de tipo Integer.

###Comercial
Responsable de guardar la información del comercial responsable de la venta de las viviendas.
- Nombre: de tipo String.
- Apellidos: de tipo String.

###Ciudad
Información de la ciudad en la que se ubica la vivienda.
- Nombre: de tipo String.
- Población: de tipo Integer.

##Ejercicio 1.
Crea dos instancias de la clase Vivienda, la primera con el código postal 28001 y la segunda con el código postal 28008

##Métodos de clase y de instancia
##Clases persistentes y de tipo serial


