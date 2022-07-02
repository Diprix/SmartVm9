
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
                <div class="circle"></div>
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


        setInterval(function() {
            loadMachine()
        }, 2000);

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

        function loadMachine(){
            const xhttp = new XMLHttpRequest();
            xhttp.onload = function() {

                const json = this.responseText
                const obj = JSON.parse(json);


                document.getElementById("idMachine").innerHTML = "ID: " + obj.idMachine;

                document.getElementById("credit_display").value = parseCredit(obj.credit) + " €";

                if(obj.status == "ready"){
                    document.getElementById("selection_display").value = "READY";
                } else if(obj.status != "ready" && document.getElementById("selection_display").value == "READY"){
                    document.getElementById("selection_display").value = "";

                } else if(obj.status == "service"){
                    document.getElementById("selection_display").value = "SERVICE";

                } else if(obj.status == "off"){
                    document.getElementById("selection_display").value = "*FUORI SERVIZIO*";

                }

                if(obj.status != "ready" && obj.status != "service" && obj.status != "off"){

                    //incremento contatore per disconnessione automatica di un utente
                    ++cicleCount
                    console.log(cicleCount)
                    if(cicleCount == 30){ // dopo 1 min esegui la disconnessione
                        disconnect();
                        cicleCount = 0;
                    }
                }

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

                for(var i = 0; i < obj.products.length; i++){


                    $(".items").append('<div class="item"> ' +

                        str(obj.products[i]) +

                        '</div>');
                }

                $(".items").append('<div class="selector"></div>');

                for(var i = 0; i < obj.products.length; i++){
                    $(".selector").append('<p class="picker p'+obj.products[i].selection+'">€ '+ obj.products[i].price +'</p>');
                }

            }
            xhttp.open("GET", "${pageContext.request.contextPath}/checkstatus?idMachine=" + id, true);
            xhttp.send();
        }

        function str(product) {

                if(product.qty <= 0) {
                    return '<img class="image e'+product.selection+'">';
                } else {
                    return '<img class="image e'+product.selection+'" src="${pageContext.request.contextPath}/assets/images/'+product.productID+'.png" alt="'+product.selection+'">'
                }
        }

        function buy(input){
            console.log("PROVA ACQUISTO");
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


                        const json = data
                        const obj = JSON.parse(json);

                        const product = obj;

                        $(".tests").append('<div class="item" id="purchased" onclick="this.remove()"> ' +

                            '<img class="image '+product.selection+'" src="../assets/images/' + product.productID + '.png" alt="'+product.selection+'">' +

                            '</div>');


                    }
                }
            )
        }

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