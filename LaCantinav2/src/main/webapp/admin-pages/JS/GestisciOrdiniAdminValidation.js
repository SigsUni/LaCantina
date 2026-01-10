document.addEventListener("DOMContentLoaded", function () {
    const form = document.querySelector("form[action$='/modifica-dati']");

    if (!form) {
        console.error("Form modifica dati non trovato!");
        return;
    }

    form.addEventListener("submit", function(event) {
        // rimuoviamo eventuali errori precedenti
        document.querySelectorAll(".error-message").forEach(e => e.remove());

        let valid = true;

        // regex utili
        const onlyLetters = /^[A-Za-zÀ-ÖØ-öø-ÿ\s]+$/;
        const capRegex = /^\d{5}$/;
        const indirizzoRegex = /^[A-Za-zÀ-ÖØ-öø-ÿ\s]+,\s*\d+$/; // "Via Roma, 12"

        // ---- CAMPI ----
        const indirizzo = document.getElementById("insert-indirizzo");
        if (!indirizzoRegex.test(indirizzo.value.trim())) {
            showError(indirizzo, "L'indirizzo deve essere nella forma 'Via NomeVia, NumeroCivico'.");
            valid = false;
        }

        const cap = document.getElementById("insert-cap");
        if (!capRegex.test(cap.value.trim())) {
            showError(cap, "Il CAP deve contenere 5 cifre.");
            valid = false;
        }

        const citta = document.getElementById("insert-citta");
        if (!onlyLetters.test(citta.value.trim())) {
            showError(citta, "La città può contenere solo lettere e spazi.");
            valid = false;
        }

        const provincia = document.getElementById("insert-provincia");
        if (!onlyLetters.test(provincia.value.trim())) {
            showError(provincia, "La provincia può contenere solo lettere e spazi.");
            valid = false;
        }

        // Se ci sono errori, blocchiamo l'invio
        if (!valid) {
            event.preventDefault();
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