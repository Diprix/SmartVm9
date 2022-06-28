class VendingMachine {
    constructor() {
        this.display = null;
        this.selectVals();
    }

    selectVals() {
        // var yo = (this); // solution 2
        this.display = document.getElementById("selection_display");
        const buttons = document.getElementsByClassName("btn");
        for (let i = 0; i < buttons.length; i++) {
            //buttons[i].addEventListener('click', function(e) { //solution 2
            buttons[i].addEventListener("click", e => {


                if (this.display.value.length < 2) {
                    this.display.value += e.srcElement.innerHTML;
                }
                if (this.display.value.length == 2) {
                    // yo.validate(display); //solution 2
                    // this.validate(display); // solution 1
                    if (this.validate()) { //Controllo se è la scelta esiste
                        return this.getSelectedItem();
                    }
                    return this.resetVals();
                }
            });
        }
    }

    validate() {
        const options = document.getElementsByClassName("option");
        for (let i = 0; i < options.length; i++) {
            if (options[i].innerHTML == this.display.value) {
                console.log(this.display.value);
                return this.display.value;
            }
        }
    }

    resetVals() {
        console.log("reset");
        this.display.value = "";
    }

    getSelectedItem() {
        console.log("Getting drink " + this.display.value);
        // this.getPosition();
        buy(this.display.value);
        this.resetVals();
    }

    getPosition() {
        var item = document.getElementsByClassName("e" + this.display.value);
        // Position of selected .item
        const positionItem = item[0].getBoundingClientRect();

        console.log(
            positionItem.top,
            positionItem.right,
            positionItem.bottom,
            positionItem.left
        );
        // Position of .grab
        const grab = document.getElementsByClassName("grab");
        const positionGrab = grab[0].getBoundingClientRect();

        console.log(
            positionGrab.top,
            positionGrab.right,
            positionGrab.bottom,
            positionGrab.left
        );

        // Change position of Item
        item[0].style.position = "absolute";
        item[0].style.top = "100px";
        item[0].style.left = "-50px";

    }


}
new VendingMachine();

