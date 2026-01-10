document.addEventListener("DOMContentLoaded", function () {
    // selezioniamo il form
    const form = document.querySelector("form[action='user-login']");

    if (!form) {
        console.error("Form di login non trovato!");
        return;
    }

    form.addEventListener("submit", function (event) {
        const email = form.email.value.trim();

        // rimuoviamo eventuali errori precedenti
        const oldErrors = document.querySelectorAll(".error-message");
        oldErrors.forEach(e => e.remove());

        // regex per email
        const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

        if (!emailRegex.test(email)) {
            // email non valida → blocchiamo l'invio
            event.preventDefault();
            showError(form.email, "Inserisci un'email valida.");
        }
        // se l'email è valida → non facciamo preventDefault → il form viene inviato normalmente
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