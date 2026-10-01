create table if not exists public.league (
  id text primary key,
  data jsonb not null,
  updated_at timestamptz not null default now()
);

alter table public.league enable row level security;

create policy "league_select" on public.league
  for select to anon, authenticated using (true);

create policy "league_insert" on public.league
  for insert to anon, authenticated with check (true);

create policy "league_update" on public.league
  for update to anon, authenticated using (true) with check (true);

create policy "league_delete" on public.league
  for delete to anon, authenticated using (true);

alter table public.league replica identity full;

do $$
begin
  alter publication supabase_realtime add table public.league;
exception
  when duplicate_object then null;
end $$;
