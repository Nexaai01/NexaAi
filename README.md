# NexaAI

All-in-one responsive AI creation dashboard starter.

## Included
- Dark / Light mode
- Responsive mobile/tablet/desktop UI
- Login/signup demo mode
- AI Chat UI
- Text to Image UI
- Text to Video UI
- Prompt Generator
- AI Writer
- Gallery / Favorites / History
- Credits system
- Supabase PostgreSQL schema + RLS
- Cloudflare Worker AI gateway starter

## Run locally
Open `index.html` in a browser. Use "Try Demo Mode".

## Connect Supabase
1. Create a free Supabase project.
2. Open SQL Editor and run `schema.sql`.
3. Put your Project URL and anon key into `config.js`.
4. Replace demo auth in `app.js` with Supabase Auth calls (the UI is already prepared).

## Deploy free
### Cloudflare Pages
Create a Pages project from this folder/repository. Build command can be empty for this static version; output directory is `/`.
### Worker
Deploy `worker.js` as a Cloudflare Worker and put its URL in `config.js`.
Store AI provider secrets in Worker environment variables, not in frontend code.

## Important
Hosting/database free tiers do not mean unlimited AI generation. Real image/video/model APIs can charge per generation. Add server-side credits and rate limits before public launch.
