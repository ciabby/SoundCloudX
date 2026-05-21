fetch('RiceviArtisti.php') // Senza "../", perché l'HTML che lo chiama è già in docs/
    .then(response => response.json())
    .then(artisti => {
        const select = document.getElementById('artista');
        select.innerHTML = '<option value="">-- Scegli un artista --</option>';
        
        artisti.forEach(artista => {
            const option = document.createElement('option');
            option.value = artista.id_artista;  // Prende l'id estratto dalla query SQL
            option.textContent = artista.nome_arte; // Prende il nome estratto dalla query SQL
            select.appendChild(option);
        });
    })
    .catch(error => console.error('Errore:', error));