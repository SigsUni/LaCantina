document.addEventListener("DOMContentLoaded", function () {
    const form = document.getElementById("formNuovoProdotto");

    if (!form) {
        console.error("Form nuovo prodotto non trovato!");
        return;
    }

    form.addEventListener("submit", function(event) {
        // rimuove eventuali errori precedenti
        document.querySelectorAll(".error-message").forEach(e => e.remove());

        let valid = true;

        const nome = form.querySelector("input[name='insert-nome']");
        const descrizione = document.getElementById("insert-descrizione");
        const stock = document.getElementById("insert-stock");
        const prezzo = document.getElementById("insert-prezzo");
        const immagine = document.getElementById("insert-immagine");

        const onlyLetters = /^[A-Za-zÀ-ÖØ-öø-ÿ0-9\s]+$/; // lettere, numeri e spazi
        const imageRegex = /\.(jpg|jpeg|png)$/i; // estensioni valide

        // --- Nome ---
        if (!nome.value.trim() || !onlyLetters.test(nome.value.trim())) {
            showError(nome, "Nome prodotto non valido (solo lettere, numeri e spazi).");
            valid = false;
        }

        // --- Descrizione ---
        if (!descrizione.value.trim()) {
            showError(descrizione, "La descrizione non può essere vuota.");
            valid = false;
        }

        // --- Stock ---
        const stockVal = parseInt(stock.value);
        if (isNaN(stockVal) || stockVal < 0) {
            showError(stock, "Lo stock deve essere un numero intero maggiore o uguale a 0.");
            valid = false;
        }

        // --- Prezzo ---
        const prezzoVal = parseFloat(prezzo.value);
        if (isNaN(prezzoVal) || prezzoVal < 0) {
            showError(prezzo, "Il prezzo deve essere maggiore o uguale a 0.");
            valid = false;
        }

        // --- Immagine ---
        if (!immagine.value.trim() || !imageRegex.test(immagine.value.trim())) {
            showError(immagine, "Inserisci un'immagine valida (.jpg, .jpeg, .png).");
            valid = false;
        }

        // blocca submit se non valido
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