function connectMachine(idMachine) {
    if (idMachine != "") {
        $.get("TecnicalConnectionServlet?idMachine=" + idMachine,
            function (data, status) {
                if (status == "success")
                    if (data == 'Macchinetta Occupata') {
                        alert(data)
                    } else {
                        $("#connectionForm").addClass("hide");

                        document.getElementById("connectionTable").innerHTML = data;

                        $("#connectionTable").removeClass("hide");

                    }
            });
    }
}

function refill(idMachine, qty, idProduct, selection){
    console.log(idMachine);
    console.log(qty);
    console.log(idProduct);

    $.post(
        "RefillServlet",
        {
            idMachine: idMachine,
            qty: qty,
            selection: selection
        },
        function(data, status){
            if(status == "success"){
                console.log("REFILL ESEGUITO")
                //alert("Hai caricato " + credit + "€ nel tuo conto")

                document.getElementById(idProduct).innerText = "10";

                // console.log(data)
            }
        }
    )
}

function closeConnection(idMachine){

    const xhttp = new XMLHttpRequest();
    xhttp.onload = function() {


        $("#connectionTable").addClass("hide");
        $("#connectionForm").removeClass("hide");



    }
    xhttp.open("GET", "RefillServlet?idMachine=" + idMachine, true);
    xhttp.send();

}