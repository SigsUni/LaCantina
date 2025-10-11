document.getElementById('prefNo')?.addEventListener('click', toggleFavorite);
document.getElementById('prefSi')?.addEventListener('click', toggleFavorite);

function toggleFavorite() {
    var icon = document.getElementById('prefNo') || document.getElementById('prefSi');
    var action = icon.classList.contains('bx-heart') ? 'add' : 'remove';
    var productId = document.getElementById('IDP').value;

    fetch('./ManageFavoritesServlet', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: `productId=${productId}&action=${action}`
    })
    .then(response => response.text())
    .then(data => {
        if (data === 'success') {
            if (action === 'add') {
                icon.classList.remove('bx-heart');
                icon.classList.add('bxs-heart');
                icon.id = 'prefSi';
            } else {
                icon.classList.remove('bxs-heart');
                icon.classList.add('bx-heart');
                icon.id = 'prefNo';
            }
        } else {
            console.error('Failed to update favorites');
        }
    })
    .catch(error => console.error('Error:', error));
}
