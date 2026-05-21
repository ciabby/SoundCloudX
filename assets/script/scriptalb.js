fetch('RiceviAlbum.php') // Senza "../", perché l'HTML che lo chiama è già in docs/
    .then(response => response.json())
    .then(album => {
        const select = document.getElementById('album');
        select.innerHTML = '<option value="">-- Scegli un album --</option>';
        
        album.forEach(album => {
            const option = document.createElement('option');
            option.value = album.id_album;  // Prende l'id estratto dalla query SQL
            option.textContent = album.titolo; // Prende il nome estratto dalla query SQL
            select.appendChild(option);
        });
    })
    .catch(error => console.error('Errore:', error));