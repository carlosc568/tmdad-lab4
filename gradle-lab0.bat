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
apply plugin: 'org.springframework.boot'
apply plugin: 'idea'
apply plugin: 'eclipse-wtp'
apply plugin: 'war'

group = 'es.unizar.tmdad'
version = '2018'
sourceCompatibility = 1.8

repositories {
	mavenCentral()
}

ext {
    boostrapVersion = '4.0.0'
	fontawesomeVersion = '5.0.6'
}

dependencies {
	compile('org.springframework.boot:spring-boot-starter-social-twitter') {
		exclude group: 'org.springframework.boot', module: 'spring-boot-starter-tomcat'
	}
	compile('org.springframework.boot:spring-boot-starter-thymeleaf') {
		exclude group: 'org.springframework.boot', module: 'spring-boot-starter-tomcat'
	}
	compile('org.springframework.boot:spring-boot-starter-web') {
		exclude group: 'org.springframework.boot', module: 'spring-boot-starter-tomcat'
	}
    compile('org.springframework.boot:spring-boot-devtools')
    {
		exclude group: 'org.springframework.boot', module: 'spring-boot-starter-tomcat'
	}
    compile("org.webjars:bootstrap:${boostrapVersion}")
	compile("org.webjars:font-awesome:${fontawesomeVersion}")
	providedRuntime('org.springframework.boot:spring-boot-starter-undertow')
	providedCompile('javax.servlet:javax.servlet-api')
	testCompile('org.springframework.boot:spring-boot-starter-test')
}
