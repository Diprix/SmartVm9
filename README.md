TRY HERE: https://smartvm.oscardiprimio.it

## SMART VENDING MACHINE

## TEAM DI SVILUPPO

Oscar Di Primio 

## GENERAL DESCRIPTION

Si vuole realizzare un sistema smart che consenta di acquistare prodotti da distributori
automatici mediante l’utilizzo di un’apposita interfaccia web.

Dopo la registrazione e l’accesso l’utente potrà connettersi ad una macchinetta, ricaricare il
credito del proprio account e vedere la lista delle proprie transazioni.

Le macchinette saranno sempre raggiungibili e mostreranno i prodotti disponibili, il loro stato e
il credito dell’utente quando quest’ultimo si connetterà. Per semplicità si è deciso di permettere
l’acquisto di prodotti soltanto tramite app, non è quindi prevista la possibilità di usare soldi
contanti.

## MOCKUP IDEA:

Funzionalità di base

- Vista utente consumatore (Smartphone)
- Vista macchinetta

```
Un’interfaccia che permette all’utente di connettersi ad una macchinetta inserendo il codice
identificativo della stessa.
```
```
Un’interfaccia che simula il funzionamento di un distributore automatico semplificato.
```

Funzionalità Interfaccia Cliente

- Registrazione e Accesso al servizio
- Collegamento macchinetta
- Ricarica conto
- Disconnessione macchinetta
- Vista transazioni recenti
- Logout

Funzionalità macchinetta

- Visualizzare prodotti disponibili
- Visualizzare lo stato della macchinetta
- Visualizzare il credito della macchinetta
- Permettere all’utente di selezionare un prodotto mediante l’apposito tastierino

```
Lo stato della macchinetta può essere:
```
- READY: indica che la macchinetta è libera e pronta per essere utilizzata.
    Questo stato viene rappresentato con la scritta READY sul display della macchinetta.
    In questo stato la macchinetta non consente interazioni con il tastierino.
- BUSY: indica che un utente è connesso alla macchinetta.
    Questo stato viene rappresentato mostrando il credito dell’utente sul display della
    macchinetta
    In questo stato la macchinetta consente l’acquisto di prodotti.
- SERVICE: indica che un tecnico sta operando sulla macchinetta
    Questo stato viene rappresentato con la scritta SERVICE sul display della macchinetta.
    In questo stato la macchinetta non consente interazioni con il tastierino.
    In questo stato la macchinetta non accetta connessioni da parte degli utenti
    consumatori.

## SYSTEM ARCHITECTURE

Tecnologie utilizzate:

1. Ho utilizzato un’architettura MVC per la realizzazione di questo software
2. Classi Java Servlet, per l’accettazione di richieste http;
3. Classi Java Model per la gestione degli oggetti;
4. File JSP per l’elaborazione delle informazioni ottenute dai controller
5. HTML, CSS e JavaScript, per la gestione dell’interfaccia utente;
6. Apache Tomcat (9 e 10), per il deployment della web application.
7. DB relazionale MySQL per la memorizzazione dei dati degli utenti
8. JSON per il passaggio di grandi quantità di dati tra server e client


## FUNCTIONAL REQUIREMENTS

Generali:

- Dovranno essere controllati e gestiti tutti i possibili errori;
- Dovranno essere verificati tutti i dati (eventuali) inseriti dall’utente;
- La pagina MACCHINETTA verrà aggiornata periodicamente;
- Il Sistema è progettato per essere facilmente scalabile;
- La Home Page dell’utente CUSTOMER è pensata principalmente per dispositivi
    mobile.

Lato CUSTOMER:

- Il Sistema dovrà consentire la registrazione e l’accesso degli utenti (CUSTOMER);
- Dopo il LOGIN:
    o Il Sistema dovrà consentire la connessione ad una macchinetta da parte
       dell’utente (CUSTOMER);
    o Il Sistema dovrà impedire che un utente possa connettersi ad una macchinetta
       già occupata da un altro utente.
    o Il Sistema dovrà consentire la ricarica del conto da parte dell’utente
    o Il Sistema mostrerà all’utente lo storico delle sue transazioni (almeno le più
       recenti)
    o Il Sistema dovrà consentire la disconnessione dell’utente dalla macchinetta
    o Il Sistema mostrerà all’utente il credito residuo

Lato DISTRIBUTORE:

- Il Sistema aggiornerà il contenuto della pagina ogni 2 secondi;
- Il Sistema verifica se lo stato della macchinetta è cambiato;
- Se lo stato è READY (nessun cliente collegato) il Sistema impedita l’interazione con la
    macchinetta;
- Se lo stato è diverso da READY (un utente è collegato):
    o Il Sistema caricherà il credito dell’utente connesso mostrandolo nel display
       della macchinetta;
    o Il Sistema impedirà la connessione di un secondo utente;
    o Il Sistema consentirà l’interazione dell’utente con la macchinetta;
    o Il Sistema verificherà se il credito è sufficiente prima di completare l’acquisto
       da parte dell’utente;
    o Se il credito non è sufficiente il Sistema non consentirà l’acquisto
    o Il Sistema aggiornerà il credito dopo ogni acquisto completato con successo;
    o Il Sistema registrerà tutte le transazioni effettuate dall’utente
    o Il Sistema consentirà la disconnessione dell’utente;
    o Il Sistema aggiornerà il credito residuo dell’utente;
    o IL Sistema riporta lo stato della macchinetta su READY;
- La Sistema disconnetterà automaticamente l’utente dopo un minuto di inattività;
- Se lo stato è SERVICE (tecnico collegato) il Sistema impedirà l’interazione con la
    macchinetta e la connessione di utenti CUSTOMER;


## DATA MODEL

## MACHINE:

- STATUS: rappresenta lo stato della macchinetta; questo sarà READY se la
    macchinetta è disponibile altrimenti sarà uguale all’ID dell’utente collegato.
    Con questo sistema posso contemporaneamente sapere se la macchinetta è libera o
    occupata e in caso da chi è occupata.
    Posso utilizzare questo campo anche per indicare stati della macchinetta come
    Manutenzione o Non funzionante, utile per implementazioni future.
- CREDIT: rappresenta il credito della macchinetta; quando un utente si collega il credito
    dell’utente viene caricato nel credito della macchinetta.
    Durante la disconnessione il credito dell’utente viene aggiornato con il credito residuo
    della macchinetta.

## TRANSACTION:

- REF_SELECTION: rappresenta un riferimento all’id dello stock; con questa
    informazione posso risalire al prodotto acquistato dall’utente.

## STOCK:

- SELECTION: rappresenta il codice da inserire nella macchinetta per acquistare quel
    prodotto


## NOTE

La macchinetta e home utente sono due client separati indipendenti.

Il server serve entrambi i client contemporaneamente.

Per accedere alla macchinetta usare il seguente link:

localhost: 8080/SmartVendingMachineProject_war_exploded/machine/distributore.jsp?idMachine=

1234 è l’id della macchinetta, cambiandolo si potrà cambiare macchinetta.

ESEMPI ID MACCHINETTE [1234, 2468]

La schermata dell’utente (CUSTOMER, ADMIN, TECHNICAL) sono raggiungibili da :

localhost:8080/SmartVendingMachineProject_war_exploded/

Dopo il login il sistema indirizzerà l’utente della schermata adatta.

Utenti preinseriti (per tutti gli utenti password: **password** )

- CUSTOMER: mario.rossi@hotmail.it
- ADMIN: luigi.verdi@smartvm.it
- TECHNICAL: gianluca.bianchi@gmail.it

PS: L’interfaccia del cliente è stata realizzata e ottimizzata per dispositivi mobili (smartphone)
pertanto, per una migliore esperienza, consiglio di provare il software utilizzando il proprio
smartphone connesso in rete locale o utilizzando un emulatore.

PPS: Al momento non sono previste le funzionalità extra Tecnico e Admin anche se il software
è predisposto per gestirle al meglio. Se ne avrò la possibilità in termini di tempo implementerò
anche le interfacce TECHNICAL e ADMIN.

## DOCKER

Prerequisiti: Docker + Docker Compose.

1. Avvio stack:
```
docker compose up --build
```

2. App:
- Home: http://localhost:8080/smartwm.smartvm9/
- Macchinetta: http://localhost:8080/smartwm.smartvm9/machine/distributore.jsp?idMachine=1234

Note:
- Il DB MySQL viene inizializzato con `src/main/webapp/smartVM-populated.sql`.
- Credenziali DB: `smartVM` / `smartVM22` (configurate in `docker/tomcat-context.xml`).


