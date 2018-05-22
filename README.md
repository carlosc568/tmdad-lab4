# tmdad-lab4

## Desplegar war de la práctica 0

Pasos a realizar:

0. Crearse una cuenta en Openshift y crear un nuevo proyecto llamado tmdad.

1. Crear archivo war. Para ello añadir en el archivo gradle.bat de la práctica el siguiente plugin:
   ```
   puglin: 'war'
   ```
   Y ejecutar:
   
   ```
   gradle war
   ```
2. Descargar el binario `oc.exe` para Windows [openshift-origin-client-tools-VERSION-windows.zip](https://github.com/openshift/origin/releases)

3. Ejecutar con oc el comando para iniciar sesión con tus datos de servidor (https://console.starter-ca-central-1.openshift.com), usuario y contraseña

   ```
   $C:\> oc login
   ```

4. Añadir una instancia de cómputo donde se desplegará el war:
  
   ```
   $C:\> oc new-app wildfly:latest~. --name lab0
   ```
  
5. Una ve instanciada, desplegar el war de la práctica 0

     Para evitar conflictos con Openshift, ha sido necesario modificar el archivo gradle.bat, excluyeno el módulo de tomcat y añadiendo      un   provideRuntime y un providedCompile. En [gradle-lab0.bat](https://github.com/carlosc568/tmdad-lab4/blob/master/gradle-lab0.bat) se encuentra el     archivo gradle final.

   ```
   $C:\> oc start-build lab0 --from-file=lab0-twitter-resst-2018.war
   ```

6. Crear una ruta para la aplicación desplegada:

   ```
   $C:\> oc expose svc lab0
   ```
  
   ```
   $C:\> oc get routes
   NAME      HOST/PORT                                                     PATH      SERVICES   PORT       TERMINATION   WILDCARD
   lab0      lab0-tmdad-lab4.193b.starter-ca-central-1.openshiftapps.com             lab0       8080-tcp                 None
   
   ```
Una vez desplegado, la práctica 0 ya estará disponible en el siguiente enlace: http://lab0-tmdad-lab4.193b.starter-ca-central-1.openshiftapps.com/lab0-twitter-resst-2018/


![Screenshot](https://github.com/carlosc568/tmdad-lab4/blob/master/images/lab02.PNG)


![Screenshot](https://github.com/carlosc568/tmdad-lab4/blob/master/images/lab0.PNG)


## Desplegar práctica 3 en cluster local

Para esta segunda parte se ha usado Linux.

Pasos a seguir:

1. Instalar y configurar Docker.
Se han seguido los pasos del apartado 2 de la sección Linux del [enlace](https://github.com/openshift/origin/blob/master/docs/cluster_up_down.md#linux) proporcionado en el guión de la práctica.


2. Instalar de nuevo el binario oc en [openshift-origin-client-tools-v3.9.0-191fece-linux-64bit.tar.gz](https://github.com/openshift/origin/releases)

3. Crear cluster local

   Desde el directorio donde esté el binario oc descargado ejecutar
   
   ```
   $ ./oc cluster up
   ```
   
   Con este comando, se crea un cluster local de openshift. Se puede acceder a la GUI con la siguiente URL por defecto una vez            iniciado:
   https://localhost:8443.
   Se puede comprobar que se crea un proyecto llamado "myproject", el cual no tiene ningún tipo de limitaciones y con el que se puede        empezar a trabajar
   
   ![Screenshot](https://github.com/carlosc568/tmdad-lab4/blob/master/images/my%20project.png)
   
   Para conectarse, los credenciales por defecto son:
      * Servidor: https://localhost:8443
      * Username: developer
      * Password: (cualquier valor)
   
   ```
   $ ./oc login
   ```
   
 4. Crear contenedor de RabbitMQ
 
    Para crear el contenedor de RabbitMQ se ha usado el siguiente [enlace](https://github.com/jharting/openshift-rabbitmq- cluster)
    Descargar el archivo .yaml del enlace anterior y ejecutar el siguiente comando con oc:
    ```
    $ ./oc process -f rabbitmq-cluster-template.yaml NAMESPACE="$(./oc project --short)" | ./oc create -f -
    ```
    Una vez completado el deployment, exponerlo:

    ```
    $ ./oc expose svc rabbitmq-cluster

    $ ./oc get routes
    NAME               HOST/PORT                                     PATH      SERVICES           PORT      TERMINATION   WILDCARD
    rabbitmq-cluster   rabbitmq-cluster-myproject.127.0.0.1.nip.io             rabbitmq-cluster   amqp                    None
      ```
    Desde la GUI de Openshift se pueden editar las variables de entorno
    
    ![Screenshot](https://github.com/carlosc568/tmdad-lab4/blob/master/images/rabbitmq-env.png)
 
 5. Crear contenedor para la práctica 3.
 
    Al igual que con la práctica 0, hay que modificar el archivo gradle.bat de la misma manera (gradle-lab3.bat).
    También hay que cambiar las credenciales del servidor RabbitMQ por las del creado anteriormente.

    Ejecutar los mismos comandos que para la práctica 0, pero con el nombre del proyecto creado en local.
 
    ```
    $ ./oc new-app wildfly:latest~. --name lab3
    $ ./oc start-build lab3 --from-file=lab3-twitter-rabbitmqq-2018.war
    $ ./oc expose svc lab3
    $ ./oc get routes
    NAME               HOST/PORT                                     PATH      SERVICES           PORT       TERMINATION  WILDCARD
    lab3               lab3-myproject.127.0.0.1.nip.io                         lab3               8080-tcp                 None
    rabbitmq-cluster   rabbitmq-cluster-myproject.127.0.0.1.nip.io             rabbitmq-cluster   amqp                     None

    ```
    
    ![Screenshot](https://github.com/carlosc568/tmdad-lab4/blob/master/images/lab3-clusters.png)
    
    
    El despliege de la práctica 3 se encuentra en el siguiente enlace: http://lab3-myproject.127.0.0.1.nip.io/lab3-twitter-rabbitmqq-2018/
    
    A la hora de comprobar si la aplicación funcionaba, se encontró un problema a la hora de conectarse mediante Web Socket en el que no se conseguiá establecer la conexión y nada más abrir la aplicación, fallaba al conectar.
    
    ![Screenshot](https://github.com/carlosc568/tmdad-lab4/blob/master/images/error.png)
    
    Al encontrar este error y no poder solucionarlo no se ha proseguido a configurar el cluster de rabbitmq para conectarlo con el contenedor creado.
    
    ## TODO:
    * Fix Web Socket problem
    * Config Local RabbitMQ Cluster
    
