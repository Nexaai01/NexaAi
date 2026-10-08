-- NexaAI Supabase schema
create table if not exists public.profiles (
  id uuid primary key references auth.users(id) on delete cascade,
  full_name text,
  avatar_url text,
  plan text not null default 'free',
  credits integer not null default 250,
  created_at timestamptz not null default now()
);

create table if not exists public.generations (
  id bigint generated always as identity primary key,
  user_id uuid not null references auth.users(id) on delete cascade,
  type text not null check (type in ('chat','image','video','prompt','writer')),
  prompt text not null,
  result_url text,
  metadata jsonb not null default '{}'::jsonb,
  created_at timestamptz not null default now()
);

create table if not exists public.favorites (
  user_id uuid not null references auth.users(id) on delete cascade,
  generation_id bigint not null references public.generations(id) on delete cascade,
  created_at timestamptz not null default now(),
  primary key(user_id,generation_id)
);

alter table public.profiles enable row level security;
alter table public.generations enable row level security;
alter table public.favorites enable row level security;

create policy "profiles own row" on public.profiles for all using (auth.uid()=id) with check (auth.uid()=id);
create policy "generations own rows" on public.generations for all using (auth.uid()=user_id) with check (auth.uid()=user_id);
create policy "favorites own rows" on public.favorites for all using (auth.uid()=user_id) with check (auth.uid()=user_id);

create or replace function public.handle_new_user()
returns trigger language plpgsql security definer set search_path = public as $$
begin
  insert into public.profiles(id,full_name) values(new.id, coalesce(new.raw_user_meta_data->>'full_name','Nexa User'));
  return new;
end; $$;

drop trigger if exists on_auth_user_created on auth.users;
create trigger on_auth_user_created after insert on auth.users for each row execute procedure public.handle_new_user();