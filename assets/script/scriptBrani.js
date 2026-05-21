document.addEventListener("DOMContentLoaded", () => {
    const container = document.getElementById('container-brani');

    fetch('RiceviBrani.php')
        .then(response => {
            if (!response.ok) {
                throw new Error("Errore nel recupero dei dati");
            }
            return response.json();
        })
        .then(brani => {
            // Svuotiamo il testo "Caricamento..."
            container.innerHTML = '';

            if (brani.length === 0) {
                container.innerHTML = '<p class="nessun-brano">Non ci sono brani disponibili al momento.</p>';
                return;
            }

            // Cicliamo ogni brano e creiamo la card
            brani.forEach(brano => {
                const card = document.createElement('div');
                card.className = 'card-brano';

                // Generiamo il contenuto della card usando i dati estratti dal database
                card.innerHTML = `
                    <div class="card-body">
                        <h3 class="brano-titolo">${brano.titolo_brano}</h3>
                        <p class="brano-artista"><strong>Artista:</strong> ${brano.nome_arte || 'Sconosciuto'}</p>
                        <p class="brano-album"><strong>Album:</strong> ${brano.nome_album || 'Singolo'}</p>
                        <div class="card-footer">
                            <span class="brano-durata">⏱ ${brano.durata_formattata}</span>
                            <span class="brano-ascolti">🎧 ${brano.ascolti} ascolti</span>
                        </div>
                    </div>
                `;

                container.appendChild(card);
            });
        })
        .catch(error => {
            console.error('Errore:', error);
            container.innerHTML = '<p class="errore">Impossibile caricare i brani. Controlla la console.</p>';
        });
});