#hope-java

##Deployment to www.hopeonlus.it

Configure server in ~/.m2/settings.xml
```
<server>
    <id>mochahost-ftp-server</id>
    <username>USER</username>
    <password>PWD</password>
</server>
```

then run:
```
mvn clean install
mvn upload-single
```

this will copy the latest version into 'wars' folder.
 
N.B. if the version doesn't change it will overrride the previous file

the copy from 'war' to /jvm/apache-tomcat-7.0.23/domains/hopeonlus.it/ROOT.war must be done manually.
