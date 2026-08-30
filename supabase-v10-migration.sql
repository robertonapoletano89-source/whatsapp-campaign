-- WhatsApp Campaign V10 - migrazione consigliata
-- Eseguire UNA VOLTA nel SQL Editor di Supabase.
-- Non cancella dati e non modifica le policy RLS.

-- Impedisce allo stesso utente di avere due contatti con lo stesso numero
-- ignorando spazi, +, parentesi e altri caratteri non numerici.
create unique index if not exists contacts_user_phone_unique_idx
on public.contacts (user_id, regexp_replace(telefono, '[^0-9]', '', 'g'))
where regexp_replace(telefono, '[^0-9]', '', 'g') <> '';
