
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Distributore</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>

    <link rel="stylesheet" href="distributore.css">
</head>
<body onload="loadMachine()">


<div class="machine">

    <div class="items" id="product-list">

        <div class="shelf" id="one">
            <p class="option A1">A1</p>
            <p class="option A2">A2</p>
            <p class="option A3">A3</p>
        </div>
        <div class="shelf" id="two">
            <p class="option B4">B4</p>
            <p class="option B5">B5</p>
            <p class="option B6">B6</p>
        </div>
        <div class="shelf" id="three">
            <p class="option C7">C7</p>
            <p class="option C8">C8</p>
            <p class="option C9">C9</p>
        </div>




    </div>

    <div class="order">
        <div class="container">

            <p id="idMachine" style="color: white; margin-bottom: 2em">ID: ${idMachine}</p>

            <input type="text" class="visualize" id="credit_display" readonly>

            <input type="text" class="visualize" id="selection_display" readonly>

            </input>
            <div class="buttons">
                <button class="btn letter" value="A">A</button>
                <button class="btn letter" value="B">B</button>
                <button class="btn letter" value="C">C</button>
                <button class="btn number" value="1">1</button>
                <button class="btn number" value="2">2</button>
                <button class="btn number" value="3">3</button>
                <button class="btn number" value="4">4</button>
                <button class="btn number" value="5">5</button>
                <button class="btn number" value="6">6</button>
                <button class="btn number" value="7">7</button>
                <button class="btn number" value="8">8</button>
                <button class="btn number" value="9">9</button>
            </div>
        </div>
        <div class="coins">
            <div class="money">
                <div class="circle"></div> <%-- Disattivare questo prima di abilitare il QRCODE --%>

                <%-- QRCODE --%>
<%--            <img src="https://chart.googleapis.com/chart?cht=qr&chl=${idMachine}&chs=80x80&chld=L|0" class="qr-code img-thumbnail img-responsive" />--%>

            </div>
        </div>
    </div>

    <div class="grab">
        <div class="rectangle">
            <div class="tests">

            </div>
        </div>
    </div>

</div>








</body>
    <script>
        const queryString = window.location.search;
        console.log(queryString);
        const urlParams = new URLSearchParams(queryString);

        const id = urlParams.get('idMachine');
        console.log(id);


        cicleCount = 0;


        // Aggiorno la macchinetta ogni 2 secondi
        setInterval(function() {
            loadMachine()
        }, 2000);

        // Funzione che formatta il credito come #,##
        function parseCredit(credit) {
            let amountString = ""+credit;

            if(amountString.includes(".")){
                if(amountString.split(".")[1].length < 2){
                    amountString = amountString + "0";
                }
            } else {
                amountString = amountString + ".00"
            }



            amountString = amountString.replace(".", ",");

            return amountString;
        }

        // Funzione principale che carica i prodotti della machhinetta dal DB
        function loadMachine(){
            const xhttp = new XMLHttpRequest();
            xhttp.onload = function() {

                // Elaboro il JSON ricevuto dal server
                const json = this.responseText
                const obj = JSON.parse(json);


                // Scrivo l'ID
                document.getElementById("idMachine").innerHTML = "ID: " + obj.idMachine;

                // Scrivo il credito della macchinetta
                document.getElementById("credit_display").value = parseCredit(obj.credit) + " €";

                // Gestisco lo stato della macchinetta
                if(obj.status == "ready"){
                    document.getElementById("selection_display").value = "READY"; //Scrivo READY sul display della macchinetta

                    // Se lo stato e' diverso da READY ( e diverso dagli altri stati predefiniti ), significa che un utente e' connesso, stato = ID_UTENTE.
                    // Se lo stato e' diverso da READY e precedentemente era READY allora un utente si e' connesso, quindi pulisco il display.
                    // Resettandolo, sblocco il controllo sulla lungezza del contenuto del display (vedi: distributore.js riga 25)

                } else if(obj.status != "ready" && document.getElementById("selection_display").value == "READY"){
                    document.getElementById("selection_display").value = "";

                } else if(obj.status == "service"){
                    document.getElementById("selection_display").value = "SERVICE"; //Scrivo SERVICE sul display della macchinetta

                } else if(obj.status == "off"){
                    document.getElementById("selection_display").value = "*FUORI SERVIZIO*"; //Scrivo *FUORI SERVIZIO* sul display della macchinetta

                }

                // Se un utente e' connesso, avvio un timer di 1 min,
                // allo scadere del minuto di inattivita l'utente verra disconnesso.
                if(obj.status != "ready" && obj.status != "service" && obj.status != "off"){

                    //incremento contatore per disconnessione automatica di un utente
                    ++cicleCount
                    console.log(cicleCount)
                    if(cicleCount == 30){ // dopo 1 min esegui la disconnessione
                        disconnect();
                        cicleCount = 0;
                    }
                }

                // Inserisco le opzioni della macchinetta
                // Diventeranno le varie posizioni dove andranno i prodotti
                document.getElementById("product-list").innerHTML = '<div class="shelf" id="one">\n' +
                    '            <p class="option A1">A1</p>\n' +
                    '            <p class="option A2">A2</p>\n' +
                    '            <p class="option A3">A3</p>\n' +
                    '        </div>\n' +
                    '        <div class="shelf" id="two">\n' +
                    '            <p class="option B4">B4</p>\n' +
                    '            <p class="option B5">B5</p>\n' +
                    '            <p class="option B6">B6</p>\n' +
                    '        </div>\n' +
                    '        <div class="shelf" id="three">\n' +
                    '            <p class="option C7">C7</p>\n' +
                    '            <p class="option C8">C8</p>\n' +
                    '            <p class="option C9">C9</p>\n' +
                    '        </div>';

                // Inserisco i prodotti nella macchinetta
                for(var i = 0; i < obj.products.length; i++){


                    $(".items").append('<div class="item"> ' +

                        // Controllo la quantita dei prodotti,
                        // se la quantita e' 0 allora inserisco un prodotto senza immagine cosi da riempire un posto nella matrice 3x3
                        productObj(obj.products[i]) +

                        '</div>');
                }

                $(".items").append('<div class="selector"></div>');

                // Inserisco le etichette con i prezzi dei prodotti
                for(var i = 0; i < obj.products.length; i++){
                    $(".selector").append('<p class="picker p'+obj.products[i].selection+'">€ '+ parseCredit(obj.products[i].price) +'</p>');
                }

            }
            xhttp.open("GET", "${pageContext.request.contextPath}/checkstatus?idMachine=" + id, true);
            xhttp.send();
        }

        function productObj(product) {

                if(product.qty <= 0) {
                    return '<img class="image e'+product.selection+'">';
                } else {
                    return '<img class="image e'+product.selection+'" src="${pageContext.request.contextPath}/assets/images/'+product.productID+'.png" alt="'+product.selection+'">'
                }
        }

        function buy(input){
            console.log("ACQUISTO");
            console.log("id", id);
            console.log("input", input);

            //reset counter auto disconnect
            cicleCount = 0;


            $.post(
                "${pageContext.request.contextPath}/buy",
                {
                    idMachine: id,
                    selection: input,
                },
                function(data, status){
                    console.log("PROVA ACQUISTO");

                    if(status == "success"){
                        console.log("HAI COMPRATO");


                        // Elaboro il prodotto ricevuto dal server
                        const json = data
                        const obj = JSON.parse(json);

                        const product = obj;

                        // Inserisco il prodotto nella parte bassa della macchinetta,
                        // per simularne l'acquisto. Cliccandolo si rimuovera.
                        $(".tests").append('<div class="item" id="purchased" onclick="this.remove()"> ' +

                            '<img class="image '+product.selection+'" src="${pageContext.request.contextPath}/assets/images/' + product.productID + '.png" alt="'+product.selection+'">' +

                            '</div>');


                    }
                }
            )
        }

        // Disconnessione macchinetta
        // Usato per la disconnessione automatica
        function disconnect(){
            console.log("DISCONNETTI");
            console.log(id);


            const xhttp = new XMLHttpRequest();

            xhttp.open("GET", "${pageContext.request.contextPath}/disconnect?idMachine="+id, true);
            xhttp.send();


        }




    </script>

<script src="distributore.js"></script>

</html>