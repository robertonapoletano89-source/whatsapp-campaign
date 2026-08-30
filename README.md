# WhatsApp Campaign — V12 CLOUD

Questa versione mantiene le funzioni già validate della V11 e aggiunge:

- gestione account più ordinata con email utente e logout;
- eliminazione contatti dalla rubrica, anche su Supabase;
- pulsanti Modifica/Elimina direttamente nella tabella;
- storico campagne più leggibile con stato e barra di avanzamento;
- campagne “In corso” e “Completate” riconoscibili;
- pulsante Riprendi/Apri campagna;
- ripresa della campagna usando gli UUID dei contatti quando disponibili;
- popup duplicati della V11 mantenuto;
- nessuna nuova modifica SQL richiesta.

## Importante
Non rieseguire le migrazioni SQL precedenti: il database Supabase già configurato va bene.

## Test consigliato
1. Login.
2. Modifica un contatto.
3. Elimina un contatto di prova.
4. Avvia una campagna con 2 contatti.
5. Interrompila dopo il primo.
6. Ricarica la pagina.
7. Premi “Riprendi” e verifica che continui dal punto corretto.
8. Logout e nuovo login.
