document.addEventListener("DOMContentLoaded", function() {
    var dropdownIcon = document.getElementById('dropdownIcon');
    var dropdownMenu = document.getElementById('dropdownMenu');

    // Toggle dropdown menu
    dropdownIcon.addEventListener('click', function() {
        var expanded = dropdownMenu.style.display === "block";
        dropdownMenu.style.display = expanded ? "none" : "block";
        dropdownIcon.setAttribute("aria-expanded", !expanded);
        dropdownMenu.setAttribute("aria-hidden", expanded);
    });

    // Close the dropdown and mobile menu if the user clicks outside of them
    window.addEventListener('click', function(event) {
        if (!event.target.closest('.header__icons')) {
            dropdownMenu.style.display = "none";
            dropdownIcon.setAttribute("aria-expanded", "false");
            dropdownMenu.setAttribute("aria-hidden", "true");
        }
    });

    // Handle Enter or Space key for accessibility
    dropdownIcon.addEventListener('keydown', function(event) {
        if (event.key === 'Enter' || event.key === ' ') {
            event.preventDefault();
            var expanded = dropdownMenu.style.display === "block";
            dropdownMenu.style.display = expanded ? "none" : "block";
            dropdownIcon.setAttribute("aria-expanded", !expanded);
            dropdownMenu.setAttribute("aria-hidden", expanded);
        }
    });

    // Handle Escape key to close the menu
    window.addEventListener('keydown', function(event) {
        if (event.key === 'Escape') {
            dropdownMenu.style.display = "none";
            dropdownIcon.setAttribute("aria-expanded", "false");
            dropdownMenu.setAttribute("aria-hidden", "true");
        }
    });
});

document.addEventListener("DOMContentLoaded", function() {
    var userGreeting = document.getElementById('userGreeting');
    var usernameSpan = document.getElementById('username');
    if (user) {
        usernameSpan.textContent = user.username; // Sostituisci 'username' con il campo appropriato dell'oggetto User
        userGreeting.style.display = 'block'; // Mostra il saluto
    } else {
        userGreeting.style.display = 'none'; // Nascondi il saluto se l'utente non è autenticato
    }
});