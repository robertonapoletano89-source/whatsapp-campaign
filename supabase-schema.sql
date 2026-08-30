-- WhatsApp Campaign / Supabase
-- Eseguire nel SQL Editor del proprio progetto.
-- NON inserisce dati demo.

create table if not exists public.contacts (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  nome text not null default '',
  cognome text not null default '',
  telefono text not null default '',
  azienda text not null default '',
  data text not null default '',
  ora text not null default '',
  email text not null default '',
  note text not null default '',
  created_at timestamptz not null default now()
);

create table if not exists public.saved_messages (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  name text not null,
  text text not null default '',
  created_at timestamptz not null default now()
);

create table if not exists public.campaigns (
  id bigint primary key,
  user_id uuid not null references auth.users(id) on delete cascade,
  name text not null,
  date text not null,
  sent integer not null default 0,
  total integer not null default 0,
  status text not null default 'In corso',
  message text not null default '',
  recipients jsonb not null default '[]'::jsonb,
  created_at timestamptz not null default now()
);

alter table public.contacts enable row level security;
alter table public.saved_messages enable row level security;
alter table public.campaigns enable row level security;

drop policy if exists "contacts_select_own" on public.contacts;
drop policy if exists "contacts_insert_own" on public.contacts;
drop policy if exists "contacts_update_own" on public.contacts;
drop policy if exists "contacts_delete_own" on public.contacts;

create policy "contacts_select_own" on public.contacts for select to authenticated using ((select auth.uid()) = user_id);
create policy "contacts_insert_own" on public.contacts for insert to authenticated with check ((select auth.uid()) = user_id);
create policy "contacts_update_own" on public.contacts for update to authenticated using ((select auth.uid()) = user_id) with check ((select auth.uid()) = user_id);
create policy "contacts_delete_own" on public.contacts for delete to authenticated using ((select auth.uid()) = user_id);

drop policy if exists "messages_select_own" on public.saved_messages;
drop policy if exists "messages_insert_own" on public.saved_messages;
drop policy if exists "messages_update_own" on public.saved_messages;
drop policy if exists "messages_delete_own" on public.saved_messages;

create policy "messages_select_own" on public.saved_messages for select to authenticated using ((select auth.uid()) = user_id);
create policy "messages_insert_own" on public.saved_messages for insert to authenticated with check ((select auth.uid()) = user_id);
create policy "messages_update_own" on public.saved_messages for update to authenticated using ((select auth.uid()) = user_id) with check ((select auth.uid()) = user_id);
create policy "messages_delete_own" on public.saved_messages for delete to authenticated using ((select auth.uid()) = user_id);

drop policy if exists "campaigns_select_own" on public.campaigns;
drop policy if exists "campaigns_insert_own" on public.campaigns;
drop policy if exists "campaigns_update_own" on public.campaigns;
drop policy if exists "campaigns_delete_own" on public.campaigns;

create policy "campaigns_select_own" on public.campaigns for select to authenticated using ((select auth.uid()) = user_id);
create policy "campaigns_insert_own" on public.campaigns for insert to authenticated with check ((select auth.uid()) = user_id);
create policy "campaigns_update_own" on public.campaigns for update to authenticated using ((select auth.uid()) = user_id) with check ((select auth.uid()) = user_id);
create policy "campaigns_delete_own" on public.campaigns for delete to authenticated using ((select auth.uid()) = user_id);

create index if not exists contacts_user_id_idx on public.contacts(user_id);
create index if not exists messages_user_id_idx on public.saved_messages(user_id);
create index if not exists campaigns_user_id_idx on public.campaigns(user_id);

grant select, insert, update, delete on public.contacts to authenticated;
grant select, insert, update, delete on public.saved_messages to authenticated;
grant select, insert, update, delete on public.campaigns to authenticated;
