<%--  Created by IntelliJ IDEA.
  User: diprix
  Date: 28/05/22
  Time: 22:46
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>



<body overlay>


<div class="container">
    <section class="sec_saldo" onclick="reload()">

                <label for="saldo">Il tuo saldo è pari a</label>
                <p class="saldo" id="saldo"> ${user.parseCredit()}€</</p>

    </section>


    <section class="content">
        <img src="${pageContext.request.contextPath}/assets/images/borsellino.png" style="height: 50px;">
        <p class="txt">Paga tramite</p>
        <p class="txt_bold">borsellino</p>
        <div class="spacer"></div>
        <h1 style="color: #0059a2">Collegati</h1>
        <p class="txt">al distributore automatico</p>
        <div class="spacer"></div>

        <section>
            <button id="sx" class="btn" name="Continue" type="button" onclick="scan()">
                <i class="material-icons">qr_code_2</i>

                <button id="dx" class="btn" name="Continue" type="button" onclick="scan()">
                    <i class="material-icons">apps</i>
                </button>
            </button>
        </section>
    </section>

    <div style="width: 500px" id="reader"></div>
</div>

<script>
    var id_machine = ""
    function scan() {
        let idMachine = prompt("Inserichi codice macchinetta:", "");

        if (idMachine != null) {
            connect(idMachine);
            id_machine = idMachine;
        }

    }

    function connect(idMachine){
        const xhttp = new XMLHttpRequest();
        xhttp.onload = function() {
            console.log(this.responseText)

            var response = this.responseText
            if(response != "Macchinetta Occupata"){
                document.getElementById("main").innerHTML = this.responseText;
            } else if(response == "Macchinetta Occupata"){

                alert("La macchinetta selezionata è momentaneamente occupata o non attiva, riprova più tradi")
            }


        }
        xhttp.open("POST", "${pageContext.request.contextPath}/connect?idMachine="+idMachine, true);
        xhttp.send();


    }

    function disconnect(){
        console.log("DISCONNETTI");
        console.log(id_machine);

        const xhttp = new XMLHttpRequest();
        xhttp.onload = function() {

            if(this.responseText=="disconnected"){
                $("#main").load("${pageContext.request.contextPath}/customer/mainpage.jsp");

            }

            reload();
        }
        xhttp.open("GET", "${pageContext.request.contextPath}/disconnect?idMachine="+id_machine, true);
        xhttp.send();


    }


    function reload(){
        $("#includedContent").load("${pageContext.request.contextPath}/customer/home.jsp");
    }

</script>

