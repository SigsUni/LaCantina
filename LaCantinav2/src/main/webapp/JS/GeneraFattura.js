function creaFattura() {
    // Dati di esempio per la fattura
    var numeroOrdine = "ORD12345";
    var dataOrdine = new Date().toLocaleDateString('it-IT'); // Data odierna nel formato locale
    var cliente = "Mario Rossi";
    var indirizzo = "Via Roma, 10 - Milano";
    var prodotti = [
        { nome: "Prodotto 1", quantita: 2, prezzoUnitario: 50 },
        { nome: "Prodotto 2", quantita: 1, prezzoUnitario: 100 },
        { nome: "Prodotto 3", quantita: 3, prezzoUnitario: 30 }
    ];

    // Costruzione della stringa HTML per la fattura
    var htmlFattura = `
        <div class="fattura">
            <h2>Fattura n. ${numeroOrdine}</h2>
            <p><strong>Data ordine:</strong> ${dataOrdine}</p>
            <p><strong>Cliente:</strong> ${cliente}</p>
            <p><strong>Indirizzo:</strong> ${indirizzo}</p>
            <table>
                <thead>
                    <tr>
                        <th>Prodotto</th>
                        <th>Quantità</th>
                        <th>Prezzo unitario</th>
                        <th>Importo</th>
                    </tr>
                </thead>
                <tbody>
    `;

    var importoTotale = 0;

    // Iterazione sui prodotti e calcolo dell'importo totale
    prodotti.forEach(function(prodotto) {
        var importoProdotto = prodotto.quantita * prodotto.prezzoUnitario;
        importoTotale += importoProdotto;
        htmlFattura += `
            <tr>
                <td>${prodotto.nome}</td>
                <td>${prodotto.quantita}</td>
                <td>${prodotto.prezzoUnitario} €</td>
                <td>${importoProdotto} €</td>
            </tr>
        `;
    });

    // Chiusura della tabella e visualizzazione dell'importo totale
    htmlFattura += `
                </tbody>
            </table>
            <p><strong>Importo totale:</strong> ${importoTotale} €</p>
        </div>
    `;

    // Mostra la fattura nel DOM (esempio: console.log)
    console.log(htmlFattura);
}
