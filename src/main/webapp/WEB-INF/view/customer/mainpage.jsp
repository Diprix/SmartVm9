
<%@ page import="it.diprix.smartwm.smartvm9.model.User" %>


<%@ page contentType="text/html;charset=UTF-8" language="java" %>


<link rel="stylesheet" href="${pageContext.request.contextPath}/public/css/customer.css">




<!-- Scharmata Ricarica Conto -->
<section id="payment" class="hide">
    <div class="paymentBody">

        <div class="card">
            <h1>Ricarica Conto</h1>
            <div class="paymentContainer">


                <div class="input-field button">
                    <input type="button" value="5€" onclick="reload(5)">
                </div>
                <div class="input-field button">
                    <input type="button" value="10€" onclick="reload(10)">
                </div>
                <div class="input-field button">
                    <input type="button" value="15€" onclick="reload(15)">
                </div>
                <div class="input-field button">
                    <input type="button" value="Altro" onclick="other()">
                </div>

            </div>
        </div>



    </div>
</section>

<!-- Scharmata Home -->
<section id="home" class="">
    <div class="homeContainer">
        <div class="sec_saldo">

            <label for="saldo">Il tuo saldo e' pari a</label>
            <p class="saldo" id="saldo"> ${user.parseCredit()} €</</p>

        </div>


        <div class="content">
            <img src="${pageContext.request.contextPath}/assets/images/borsellino.png" style="height: 50px;">
            <p class="txt">Paga tramite</p>
            <p class="txt_bold">borsellino</p>
            <div class="spacer"></div>
            <h1 style="color: #0059a2">Collegati</h1>
            <p class="txt">al distributore automatico</p>
            <div class="spacer"></div>

            <div>
                <button id="sx" class="btn" name="Continue" type="button" onclick="scan()">
                    <i class="material-icons">qr_code_2</i>

                    <button id="dx" class="btn" name="Continue" type="button" onclick="scan()">
                        <i class="material-icons">apps</i>
                    </button>
                </button>
            </div>
        </div>

        <div style="width: 500px" id="reader"></div>
    </div>

</section>

<!-- Scharmata Altro -->
<section id="other" class="hide">
    <div class="otherBody">
        <div class="card">
            <h1>Altro</h1>



            <div class="otherContainer">

                <div class="input-field button">
                    <input type="button" value="Logout" onclick="logout()">
                </div>

                <div class="input-field button">
                    <input id="execute" type="button" value="Ultime transazioni" onclick="transaction()">
                </div>

            </div>
        </div>

    </div>
</section>

<!-- Scharmata Lista Transazioni -->
<section id="transaction" class="hide">

</section>




<!-- Navbar -->
<nav class="nav">

    <a href="javascript:pageLoad('#payment')" class="nav__link">
        <i class="material-icons nav__icon">euro</i>
        <span class="nav__text">Ricarica</span>
    </a>

    <a href="javascript:pageLoad('#home')" class="nav__link nav__link--active">
        <img class="home-image" src="assets/images/coffee-cup.png" alt="home">
    </a>

    <a href="javascript:pageLoad('#other')" class="nav__link">
        <i class="material-icons nav__icon">more_horiz</i>
        <span class="nav__text">Altro</span>
    </a>

</nav>



