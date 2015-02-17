# Gebrauchtwagen
Netbeans, xampp, jdk, github herunterladen installieren
Github starten -> Repository einbinden -> auf die Festplatte clonen
Im XAMPP Control Panel MySql und Apache starten
Admin bei Mysql
neue Datenbank autotest anlegen
autotest auswählen -> importieren -> datei auswählen im ordner sql im projekt -> ok -> fertig
im Control Panel bei Tomcat Config auswählen und dann tomcat-users
Diese Datei muss dann so aussehen:

<?xml version="1.0" encoding="UTF-8"?>
<tomcat-users>
    <role rolename="tomcat"/>
    <role rolename="role1"/>
    <role rolename="manager-gui"/>
    <role rolename="manager-script"/>
    <user password="tomcat" roles="tomcat,role1,manager-gui,manager-script" username="both"/>
    <user password="tomcat" roles="role1" username="role1"/>
    <user password="tomcat" roles="tomcat,manager-gui,manager-script,admin" username="tomcat"/>
</tomcat-users>


Überprüfen über Tomcat Admin -> Manager App -> User: tomcat Pass: tomcat -> kein Fehler? fertig!

Netbeans starten -> open Project -> zum Github Ordner -> Projekt auswählen
dann sagt er was mit fehlendem server.
Einfach im linken oberen Projekt Bereich mit rechtsklick auf Gebrauchtwagen -> Resolve Missing Server -> Add Server
-> Apache Tomcat -> Server Location: *Pfad zu xampp*\xampp\tomcat -> Nutzerdaten eingeben -> fertig


sollte es Probleme beim starten geben einfach folgende zeilen in der *Pfad zu xampp*\xampp\tomcat\bin\catalina.bat entfernen.

set "JAVA_OPTS=%JAVA_OPTS% %LOGGING_CONFIG%"

if not "%LOGGING_MANAGER%" == "" goto noJuliManager
set LOGGING_MANAGER=-Djava.util.logging.manager=org.apache.juli.ClassLoaderLogManager
:noJuliManager
set "JAVA_OPTS=%JAVA_OPTS% %LOGGING_MANAGER%"
