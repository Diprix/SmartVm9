# SmartVm9
Smart>VM Tomcat 9

# Background Aziendale
Amministratore Condomini S.p.A. ha deciso di sviluppare una piattaforma per 
la gestione delle operazioni di contabilizzatione, archiviazione pratiche,
scadenziario, statistiche e il in-out con i clienti.
La scelta nasce da un problema di sicurezza poichè i dati devono restare 
interni all'azienda e sempre disponibili agli operatori, nonchè evitare il
salvataggio di file riservati su cloud pubblici da parte propri dipendi.

Dopo una software selection ha deciso di sviluppare internamente la propria 
soluzione per non legarsi ad una soluzione commerciale.

Le tecnologie da utilizzare sono da definire.

### WorkProject

Siete stati ingaggiati da "L'Amministratore Condomini S p A" per la realizzazione della nuova piattaforma 
tecnologica per la gestione della contabilità aziendale.

Dopo una lunga serie d' incontri con i referenti di business e con i tecnici de "LA CAMBIALE" S p A si è stabilito che:

* I concetti principali sono quello di Team di lavoro, di Bucket come contenitore di file

* Gli utenti potranno avere il proprio accesso riservato e condividere i dati non 
  riservati con il mainframe aziendale:
    * creare i clienti 
    * stabilire i canoni in abbonamento ed inserire i servizi e le competenze.
    * inviare notifiche hai clienti sulle scadenze.
    * registrare i corrispettivi.
    * generare report e statistiche.

* La soluzione deve essere cloud ready e rilasciabile su container docker

* La tecnologia di riferimento dovrà essere basata sullo stack Java Enterprise e sull'ecosistema
  Spring
  
* Al fine di non perdere opportunità di business, e dunque fatturato per l'azienda, è 
  indispensabile che il sistema sia progettato per garantire i più alti livelli di servizio
–
Gli aspetti di sicurezza sono molto importanti in quanto i documenti potrebbero essere
  utilizzati per operazioni di insider trading


## Requirements and Assumptions
#### Functional Requirements
[FR01]: Il sistema deve consentire agli utenti di creare clienti, causali.

[FR02]: Il sistema deve consentire agli utenti di creare schede contabili, 
        inserire i pagamenti e generare report.

[FR03]: Il sistema deve consentire agli utenti di inviare notifiche ai clienti.

[FR04]: Il sistema deve consentire agli utenti di caricare corrispettivi e gestire i movimenti per anno.


#### Non Functional Requirements
[NFR01]: Il sistema deve garantire un uptime continuativo 24 ore al giorno 7 gironi su 7

[NFR02]: E' necessario prendere in considerazione gli aspetti di sicurezza e logging per l'accesso alle risorse

[NFR03]: Lo stack tecnologico di riferimento è Spring Framework e i prodotti da utilizzare devono essere free o open-source

[NFR04]: Il sistema sarà dispiegato su una infrastruttura tradizionale, ma deve essere pronto a migrare su una infrastruttura
cloud a Container(in realtà  la soluzione sarà decisa dal team di sviluppo)

[NFR05]: Il sistema sarà utilizzabile tramite la totalità dei dispositivi portatili maggiormente diffusi, accessibile da web,
e utilizzabile come applicazione residente.


#### Business Assumptions

[BA01]: Il sistema è attualmente pensato per il mercato italiano ma si ipotizza in un futuro prossimo di aprire anche al mercato
europeo

[BA02]: Da indagini è atteso un trend crescente di documenti caricati


#### Integration Assumptions

[IA01]: Il sistema verrà rilasciato con accesso e autenticazione nativa Spring Autentication, ma anche la possibilità
di sistemi di autenticazione Push Service Cloud (google, facebook, apple...)

## Requirements and Assumptions
#### Technological Assumptions

[TA01]: L'architettura del sistema sara basata su Java EE 11 JDK 1.11 (AMAZON Corretto 11.2).

[TA02]: Lo strato di business sarà realizzato tramite la suite Spring.

[TA03]: Lo strato di presentation sarà basato su framewotk javascript con backend RESTful.

[TD04]: L'autenticazione e l'autorizzazione verrà garantita da SSO su protocollo OpenId Connect con token JWT

[TD05]: Il disaccopiamento tra frontend e backend verrà garantito dall'adozione di Api Gateway.

[TD04]: Lo strato di persistenza dell'applicativo sarà realizzato tramite JPA.

[TD06]: I moduli dovranno essere dispiegati o tramite Spring Boot su Tomcat Embedded e a questi moduli saranno
        delegati tutti gli aspetti di gestione del pool di connessioni http, jdbc , jms ,

[TD07]: Il database per l'archiviazione delle credenziali d'accesso sarà MongoDB.

[TD08]: Il database per l'archiviazione dei dati sarà Postgress.

[TD09]: Il sistema operativo dei server sarà CentOS o similari.


MockUps

![Alt text](src/main/resources/assets/images/Home.png?raw=true "NorthenLight")


![Alt text](src/main/resources/assets/images/ElencoClienti.png?raw=true "Clienti")


![Alt text](src/main/resources/assets/images/Report.png?raw=true "Report")


## Rest Api Documentation

#### Metodi pubblici

| METHOD | ACTION | URL |
| ------ | ------ | ------ |
| GET | SignIn | [/api/auth/signin](http://localhost:8082/api/auth/signin) |
| POST | SignIn | [/api/auth/signup](http://localhost:8082/api/auth/signup) |

#### Metodi con Autenticazione necessaria ( all for Account connected )

| METHOD | ACTION | URL |
| ------ | ------ | ------ |
| GET | List of payments | [/api/v1/payaments](http://localhost:8082/api/v1/payments) |
| GET | List of customers | [/api/v1/customers](http://localhost:8082/api/v1/customers) |
| GET | List of reaons | [/api/v1/reasons](http://localhost:8082/api/v1/reaons) |
| POST | Create a payment | [/api/v1/payament](http://localhost:8082/api/v1/payment) |
| POST | Create a customer | [/api/v1/customer](http://localhost:8082/api/v1/customer) |
| POST | Create a reason | [/api/v1/reason](http://localhost:8082/api/v1/reason) |
| GET | Retrive a payment | [/api/v1/payament/{id}](http://localhost:8082/api/v1/payment/) |
| GET | Retrive a customer | [/api/v1/customer/{id}](http://localhost:8082/api/v1/customer/) |
| GET | Retrive a reason | [/api/v1/reason/{id}](http://localhost:8082/api/v1/reaon/) |

Spring Boot Rest APIs for File Upload & Storage

Spring Boot App will provide APIs
Methods	Urls	Actions
POST	/upload	upload a File
GET	/files	get List of Files (name & url)
GET	/files/[filename]	download a File
## Upload Files

    GET /: Looks up the current list of uploaded files from the StorageService and loads it into a Thymeleaf template. It calculates a link to the actual resource by using MvcUriComponentsBuilder.

    GET /files/{filename}: Loads the resource (if it exists) and sends it to the browser to download by using a Content-Disposition response header.

    POST /: Handles a multi-part message file and gives it to the StorageService for saving.



```sh


```
### Ecosystem

![Alt text](src/main/resources/assets/logo/spring_icon.png?raw=true?v=4&s=200  "Spring Boot")
![Alt text](src/main/resources/assets/logo/mongo_icon.png?raw=true?v=4&s=200 "Mongo DB")
![Alt text](src/main/resources/assets/logo/java_icon.png?raw=true?v=4&s=200 "Java EE")
![Alt text](src/main/resources/assets/logo/maven_icon.png?raw=true?v=4&s=200 "Maven")
![Alt text](src/main/resources/assets/logo/jwt_icon.png?raw=true?v=4&s=200 "JWT")
![Alt text](src/main/resources/assets/logo/jpa_icon.png?raw=true?v=4&s=200 "JPA")
![Alt text](src/main/resources/assets/logo/postgres_icon.png?raw=true?v=4&s=200 "Postgres")
![Alt text](src/main/resources/assets/logo/angular_icon.png?raw=true?v=4&s=200 "Angular")
![Alt text](src/main/resources/assets/logo/flutter_icon.png?raw=true?v=4&s=200 "Flutter")


### _[www.dping.it/projects](https://www.dping.it/projects/)_
### _[GITHUB REPOSITORY](https://github.com/dping-it/northenLight.git)_

### References

For further reference, please consider the following sections:

* [Official Apache Maven documentation](https://maven.apache.org/guides/index.html)
* [Spring Boot Maven Plugin Reference Guide](https://docs.spring.io/spring-boot/docs/2.5.3/maven-plugin/reference/html/)
* [Create an OCI image](https://docs.spring.io/spring-boot/docs/2.5.3/maven-plugin/reference/html/#build-image)
* [Spring Security](https://docs.spring.io/spring-boot/docs/2.5.3/reference/htmlsingle/#boot-features-security)
* [Spring Boot DevTools](https://docs.spring.io/spring-boot/docs/2.5.3/reference/htmlsingle/#using-boot-devtools)
* [Spring Data JPA](https://docs.spring.io/spring-boot/docs/2.5.3/reference/htmlsingle/#boot-features-jpa-and-spring-data)
* [Rest Repositories](https://docs.spring.io/spring-boot/docs/2.5.3/reference/htmlsingle/#howto-use-exposing-spring-data-repositories-rest-endpoint)
* [Spring Web](https://docs.spring.io/spring-boot/docs/2.5.3/reference/htmlsingle/#boot-features-developing-web-applications)
* [Spring Data MongoDB](https://docs.spring.io/spring-boot/docs/2.5.3/reference/htmlsingle/#boot-features-mongodb)
* [Validation](https://docs.spring.io/spring-boot/docs/2.5.3/reference/htmlsingle/#boot-features-validation)
* [Java Mail Sender](https://docs.spring.io/spring-boot/docs/2.5.3/reference/htmlsingle/#boot-features-email)

### Guides

The following guides illustrate how to use some features concretely:

* [Securing a Web Application](https://spring.io/guides/gs/securing-web/)
* [Spring Boot and OAuth2](https://spring.io/guides/tutorials/spring-boot-oauth2/)
* [Authenticating a User with LDAP](https://spring.io/guides/gs/authenticating-ldap/)
* [Accessing Data with JPA](https://spring.io/guides/gs/accessing-data-jpa/)
* [Accessing JPA Data with REST](https://spring.io/guides/gs/accessing-data-rest/)
* [Accessing Neo4j Data with REST](https://spring.io/guides/gs/accessing-neo4j-data-rest/)
* [Accessing MongoDB Data with REST](https://spring.io/guides/gs/accessing-mongodb-data-rest/)
* [Accessing data with MySQL](https://spring.io/guides/gs/accessing-data-mysql/)
* [Building a RESTful Web Service](https://spring.io/guides/gs/rest-service/)
* [Serving Web Content with Spring MVC](https://spring.io/guides/gs/serving-web-content/)
* [Building REST services with Spring](https://spring.io/guides/tutorials/bookmarks/)
* [Accessing Data with MongoDB](https://spring.io/guides/gs/accessing-data-mongodb/)
