buildscript {
    ext {
        springBootVersion = '1.5.10.RELEASE'
    }
    repositories {
        mavenCentral()
    }
    dependencies {
        classpath("org.springframework.boot:spring-boot-gradle-plugin:${springBootVersion}")
    }
}

apply plugin: 'java'
apply plugin: 'eclipse-wtp'
apply plugin: 'idea'
apply plugin: 'org.springframework.boot'
apply plugin: 'war'

group = 'es.unizar.tmdad'
version = '2018'
sourceCompatibility = 1.8
jar.baseName = "tmdad-lab3-twitter-rabbitmq"

repositories {
    mavenCentral()
}

ext {
    boostrapVersion = '4.0.0'
    fontawesomeVersion = '5.0.6'
    mustacheVersion = '2.3.0'
    
}

dependencies {
    compile("org.springframework.boot:spring-boot-starter-web")
    {
		exclude group: 'org.springframework.boot', module: 'spring-boot-starter-tomcat'
	}
    compile("org.springframework.boot:spring-boot-starter-social-twitter")
    {
		exclude group: 'org.springframework.boot', module: 'spring-boot-starter-tomcat'
	}
    compile("org.springframework.boot:spring-boot-starter-thymeleaf")
    {
		exclude group: 'org.springframework.boot', module: 'spring-boot-starter-tomcat'
	}
    compile("org.springframework.boot:spring-boot-starter-websocket")
    {
		exclude group: 'org.springframework.boot', module: 'spring-boot-starter-tomcat'
	}
    compile("org.springframework.boot:spring-boot-starter-integration")
    {
		exclude group: 'org.springframework.boot', module: 'spring-boot-starter-tomcat'
	}
    compile("org.springframework.boot:spring-boot-starter-amqp")
    {
		exclude group: 'org.springframework.boot', module: 'spring-boot-starter-tomcat'
	}
    compile("org.springframework:spring-messaging")
    compile("org.springframework.integration:spring-integration-java-dsl")
    compile("org.springframework.integration:spring-integration-amqp")
    compile("com.googlecode.concurrentlinkedhashmap:concurrentlinkedhashmap-lru:1.4.2")
    compile("org.webjars:bootstrap:${boostrapVersion}")
    compile("org.webjars:font-awesome:${fontawesomeVersion}")
    compile("org.webjars.bower:mustache:${mustacheVersion}")
    compile("org.webjars:stomp-websocket:2.3.1-1")
    compile("org.webjars:sockjs-client:0.3.4-1")
    compile("commons-beanutils:commons-beanutils:1.9.2")
    providedRuntime('org.springframework.boot:spring-boot-starter-undertow')
	providedCompile('javax.servlet:javax.servlet-api')
    testCompile("org.springframework.boot:spring-boot-starter-test")
}
