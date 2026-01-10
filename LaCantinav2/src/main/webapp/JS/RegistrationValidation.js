document.addEventListener("DOMContentLoaded", function () {

    const form = document.getElementById("registrationForm");

    if (!form) {
        console.error("Form non trovato!");
        return;
    }

    form.addEventListener("submit", function (event) {

        let nome = document.getElementById("nome").value.trim();
        let cognome = document.getElementById("cognome").value.trim();
        let email = document.getElementById("email").value.trim();
        let password = document.getElementById("password").value;

        let errorBox = document.getElementById("errorBox");
        errorBox.innerHTML = "";

        let errors = [];

        const onlyLetters = /^[A-Za-zÀ-ÖØ-öø-ÿ\s]+$/;
        const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        const passwordRegex = /^(?=.*[a-z])(?=.*[A-Z])(?=.*[\W_]).{8,}$/;

        if (!onlyLetters.test(nome)) {
            errors.push("Il nome deve contenere solo lettere.");
        }

        if (!onlyLetters.test(cognome)) {
            errors.push("Il cognome deve contenere solo lettere.");
        }

        if (!emailRegex.test(email)) {
            errors.push("Email non valida.");
        }

        if (!passwordRegex.test(password)) {
            errors.push("La password deve avere almeno 8 caratteri, una maiuscola, una minuscola e un carattere speciale.");
        }

        if (errors.length > 0) {
            event.preventDefault(); //blocca submit
            errorBox.innerHTML = errors.join("<br>");
        }
    });
});