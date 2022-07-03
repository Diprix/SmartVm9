class VendingMachine {
    constructor() {
        this.display = null;
        this.selectVals();
    }

    /*
    Gestione del tastierino
    Consente di inserire un codice composto da due caratteri
    All'inserimento del terzo il display viene resettato
     */
    selectVals() {

        this.display = document.getElementById("selection_display");

        const buttons = document.getElementsByClassName("btn");

        // Aggiungo unazione per ogni tasto del tastierino
        for (let i = 0; i < buttons.length; i++) {

            buttons[i].addEventListener("click", e => {

                // Controllo lunghetta codice inserito
                // Se il contenuto di display e' maggiore di 2 non posso piu inserire caratteri.
                // (Utile per bloccare l'iterazione dell'utente)

                if (this.display.value.length < 2) {
                    this.display.value += e.srcElement.innerHTML;
                }

                if (this.display.value.length == 2) {

                    if (this.validate()) { //Controllo se e' la scelta esiste
                        return this.getSelectedItem(); // Recupero il prodotto
                    }
                    return this.resetVals();
                }
            });
        }
    }

    // Controllo se il codice inserito e' presente tra le opzioni presenti
    validate() {
        const options = document.getElementsByClassName("option");
        for (let i = 0; i < options.length; i++) {
            if (options[i].innerHTML == this.display.value) {
                console.log(this.display.value);
                return this.display.value;
            }
        }
    }

    // Pulisco il display
    resetVals() {
        console.log("reset");
        this.display.value = "";
    }

    // Recupero il prodotto e avvio la procedura di l'acquisto
    getSelectedItem() {
        console.log("Recupero il prodotto con codice: ", this.display.value);
        // this.getPosition();
        buy(this.display.value);

        // Resetto il display dopo l'acquisto
        this.resetVals();
    }



}
new VendingMachine();

