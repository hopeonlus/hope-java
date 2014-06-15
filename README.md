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

then run
```
# upload website war file
mvn clean package wagon:upload-single -Pdeploy-website-war

#upload admin war file
mvn clean package wagon:upload-single -Pdeploy-admin-war
```

this will upload the latest version to ftp://204.93.157.98/jvm/apache-tomcat-7.0.23/domains/hopeonlus.it/ROOT.war_NEW
(or admin.war_NEW)

to deploy the new version, remove the old war and rename the new one to ROOT.new (manual operation via ftp)
