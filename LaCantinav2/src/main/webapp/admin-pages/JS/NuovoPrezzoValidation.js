document.addEventListener("DOMContentLoaded", function () {
    const form = document.getElementById("ModifyPriceForm");

    if (!form) {
        console.error("Form modifica prezzo non trovato!");
        return;
    }

    form.addEventListener("submit", function(event) {
        document.querySelectorAll(".error-message").forEach(e => e.remove());

        let valid = true;

        const prezzoInput = document.getElementById("nuovo_prezzo");
        const prezzoVal = parseFloat(prezzoInput.value);

        if (isNaN(prezzoVal) || prezzoVal < 0) {
            showError(prezzoInput, "Il prezzo non può essere negativo.");
            valid = false;
        }

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