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

  Para evitar conflictos con Openshift, ha sido necesario modificar el archivo gradle.bat, excluyeno el módulo de tomcat y añadiendo un   provideRuntime y un providedCompile. En [gradle_lab0.bat](https://github.com/carlosc568/tmdad-lab4/gradle_lab0.bat) se encuentra el     archivo gradle final.

   ```
   $C:\> oc start-build lab0 --from-file=lab0-twitter-resst-2018.war
   ```

6. Crear una ruta para la aplicación desplegada:

   ```
   $C:\> oc expose svc mysample
   ```
  
   ```
   $C:\> oc get routes
   NAME      HOST/PORT                                                     PATH      SERVICES   PORT       TERMINATION   WILDCARD
   lab0      lab0-tmdad-lab4.193b.starter-ca-central-1.openshiftapps.com             lab0       8080-tcp                 None
   
   ```
Una vez desplegado, la práctica 0 ya estará disponible en el siguiente enlace: http://lab0-tmdad-lab4.193b.starter-ca-central-1.openshiftapps.com/lab0-twitter-resst-2018/
![Screenshot](lab0.png)
