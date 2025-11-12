$(document).ready(function() {
const body = document.querySelector('body'),
      sidebar = body.querySelector('nav'),
      toggle = body.querySelector(".toggle"),
      searchBtn = body.querySelector(".search-box"),
      modeSwitch = body.querySelector(".toggle-switch"),
      modeText = body.querySelector(".mode-text");
toggle.addEventListener("click" , () =>{
    sidebar.classList.toggle("close");
})
document.addEventListener('DOMContentLoaded', function() {
    const navLinks = document.querySelectorAll('.nav-link a');
    console.log('navLinks:', navLinks);
    
    const homeSection = document.getElementById('homeSection');

    console.log('navLinks:', navLinks); // Verifica se navLinks è correttamente selezionato
    console.log('homeSection:', homeSection); // Verifica se homeSection è correttamente selezionato

    // Verifica se homeSection è stato trovato correttamente
    if (homeSection) {
        navLinks.forEach(link => {
            link.addEventListener('click', function(event) {
                event.preventDefault(); // Previeni il comportamento predefinito del link
                const section = this.getAttribute('data-section');
                console.log('Link clicked:', section); // Log per verificare se l'evento di clic è intercettato
                loadSectionContent(section);
            });
        });
    } else {
        console.error('Element with id "homeSection" not found.');
    }

    function loadSectionContent(section) {
        console.log('Loading section:', section); // Log per verificare se la funzione è chiamata
        const xhr = new XMLHttpRequest();
        xhr.open('GET', `${section}.jsp`, true);
        xhr.onload = function() {
            console.log('XHR status:', xhr.status); // Log dello stato della richiesta XHR
            if (xhr.status === 200) {
                console.log('Content loaded'); // Log se il contenuto è stato caricato con successo
                homeSection.innerHTML = xhr.responseText;
            } else {
                console.log('Error loading content'); // Log se c'è un errore
                homeSection.innerHTML = 'Errore nel caricamento della sezione';
            }
        };
        xhr.send();
    }
});

document.getElementById('updateForm').addEventListener('submit', function(event) {
    var inputs = this.querySelectorAll('input');

    inputs.forEach(function(input) {
        if (input.value === '') {
            if (input.type === 'number') {
                input.value = null;
            } else if (input.type === 'text') {
                input.value = null;
            }
        }
    });
});


})

