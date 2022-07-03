/*
HOME
 */
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

        var response = this.responseText
        if(response != "Macchinetta Occupata"){
            document.getElementById("main").innerHTML = this.responseText;
        } else if(response == "Macchinetta Occupata"){

            alert("La macchinetta selezionata è momentaneamente occupata o non attiva, riprova più tradi")
        }


    }
    xhttp.open("POST", "connect?idMachine="+idMachine, true);
    xhttp.send();


}

function disconnect(){
    console.log("DISCONNETTI");
    console.log(id_machine);

    const xhttp = new XMLHttpRequest();
    xhttp.onload = function() {

        document.getElementById("main").innerHTML = this.responseText;

    }
    xhttp.open("GET", "disconnect?idMachine="+id_machine, true);
    xhttp.send();


}

/** NON MI RICORDO CHE FA */
// function reload(){
//     $("#includedContent").load("${pageContext.request.contextPath}/customer/home.jsp");
// }

/*
PAYMENT
 */

function other() {
    let credit = prompt("Inserichi valore ricarica:", "");
    if (credit != null || credit != "") {
        if(credit > 0){
            reload(credit);
        } else if(credit != null && credit <= 0){
            alert("Inserisci un importo positivo");
        }
    }

}

function reload(credit){

    $.post(
        "CreditServlet",
        {
            credit: credit
        },
        function(data, status){
            if(status == "success"){
                console.log("HAI RICARICATO");
                alert("Hai caricato " + credit + "€ nel tuo conto")
                // console.log(data);

                document.getElementById("saldo").innerHTML = data + "€";
            }
        }
    )

}

/*
OTHER
 */

function logout(){

    console.log("LOGOUT")

    const xhttp = new XMLHttpRequest();
    xhttp.onload = function() {

        location.reload();

    }
    xhttp.open("GET", "logout", false);
    xhttp.send();
}

function transaction() {
    console.log('transaction');
    /*
    $(document).ready(function() {
        $("#execute").click(function() {
            $.post("TransactionServlet",
                function(data, status) {
                    if (status == "success")
                        // $("#transaction").html(data);

                });

        });
    });
    */


    const xhttp = new XMLHttpRequest();
    xhttp.onload = function() {

        $("section").addClass("hide");

        document.getElementById("transaction").innerHTML = this.responseText;

        $("#transaction").removeClass("hide");

    }
    xhttp.open("POST", "TransactionServlet", true);
    xhttp.send();
};



/*
NAVIGATION METHODS
 */

function pageLoad(pageId) {
    console.log('pageLoad');
    $(document).ready(function(){
        $("section").addClass("hide");
        $(pageId).removeClass("hide");

        $("a").click(function(){
            $("a").removeClass("nav__link--active");
            $(this).addClass("nav__link--active");

            console.log($(this).index());

        })
    })
};