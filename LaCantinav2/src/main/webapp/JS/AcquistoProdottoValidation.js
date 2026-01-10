document.addEventListener("DOMContentLoaded", function () {
    const form = document.querySelector("form[action$='/order-now']");

    if (!form) {
        console.error("Form di acquisto non trovato!");
        return;
    }

    form.addEventListener("submit", function(event) {
        // rimuoviamo errori precedenti
        document.querySelectorAll(".error-message").forEach(e => e.remove());

        let valid = true;

        // Regex utili
        const onlyLetters = /^[A-Za-zÀ-ÖØ-öø-ÿ\s]+$/;
        const cardRegex = /^\d{13,19}$/; // numero carta
        const cvvRegex = /^\d{3,4}$/;     // CVV
        const capRegex = /^\d{5}$/;       // CAP
        const scadenzaRegex = /^(0[1-9]|1[0-2])\/\d{4}$/; // MM/YYYY

        // Controlliamo i campi della carta
        const numeroCarta = document.getElementById("insert-indirizzo-carta");
        if (!cardRegex.test(numeroCarta.value.trim())) {
            showError(numeroCarta, "Il numero della carta deve contenere 13-19 cifre.");
            valid = false;
        }

        const intestatario = document.getElementById("insert-intestatario");
        if (!onlyLetters.test(intestatario.value.trim())) {
            showError(intestatario, "L'intestatario può contenere solo lettere e spazi.");
            valid = false;
        }

        const scadenza = document.getElementById("insert-scadenza");
        if (!scadenzaRegex.test(scadenza.value.trim())) {
            showError(scadenza, "La scadenza deve essere nel formato MM/YYYY.");
            valid = false;
        }

        const cvv = document.getElementById("insert-cvv");
        if (!cvvRegex.test(cvv.value.trim())) {
            showError(cvv, "Il CVV deve contenere 3 o 4 cifre.");
            valid = false;
        }

        // Controlliamo i campi di spedizione
        const indirizzo = document.getElementById("insert-indirizzo");
        if (indirizzo.value.trim() === "") {
            showError(indirizzo, "L'indirizzo è obbligatorio.");
            valid = false;
        }

        const cap = document.getElementById("insert-cap");
        if (!capRegex.test(cap.value.trim())) {
            showError(cap, "Il CAP deve contenere 5 cifre.");
            valid = false;
        }

        const citta = document.querySelector("input[name='insert-citta']");
        if (!onlyLetters.test(citta.value.trim())) {
            showError(citta, "La città può contenere solo lettere e spazi.");
            valid = false;
        }

        const provincia = document.querySelector("input[name='insert-provincia']");
        if (!onlyLetters.test(provincia.value.trim())) {
            showError(provincia, "La provincia può contenere solo lettere e spazi.");
            valid = false;
        }

        if (!valid) {
            event.preventDefault(); // blocca invio se ci sono errori
        }
    });

    function showError(input, message) {
        const error = document.createElement("div");
        error.className = "error-message";
        error.style.color = "red";
        error.style.fontSize = "0.9em";
        error.textContent = message;
        input.parentNode.insertBefore(error, input.nextSibling);
    }
});