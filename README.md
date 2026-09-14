# WhatsApp QR Redirect — wa.brownspharmacy.co.ke

A tiny Nginx container that permanently redirects your subdomain to your
WhatsApp chat link. Your printed QR code encodes this subdomain — never the
raw wa.me link — so you can change the destination number anytime without
reprinting anything.

## 1. Push this folder to a Git repo

```bash
cd wa-redirect
git init
git add .
git commit -m "WhatsApp redirect service"
git branch -M main
git remote add origin <your-empty-github-repo-url>
git push -u origin main
```

(Coolify can also deploy from a private repo if you connect your GitHub
account in Coolify's settings — no need to make it public.)

## 2. Create the app in Coolify

1. In Coolify: **+ New Resource → Application → Public/Private Repository**.
2. Point it at the repo you just pushed.
3. Build pack: **Dockerfile** (Coolify should auto-detect it since there's a
   `Dockerfile` at the repo root).
4. Port: **80** (matches the `EXPOSE 80` in the Dockerfile).

## 3. Set the domain

In the app's **Domains** tab, add:

```
https://wa.brownspharmacy.co.ke
```

Coolify will automatically request a Let's Encrypt SSL certificate for it
**once your DNS A record is pointing at your VPS's IP** — make sure that's
already set up before deploying, or the certificate step will fail (just
retry it once DNS propagates).

## 4. Set the environment variables

In the app's **Environment Variables** tab:

| Key | Value |
|---|---|
| `WHATSAPP_NUMBER` | `254116052052` |
| `WHATSAPP_MESSAGE` | `Hi%2C%20I%20saw%20your%20poster` (optional — URL-encoded, leave blank for no pre-filled text) |

To change your WhatsApp number in the future: update `WHATSAPP_NUMBER` here
and hit **Redeploy** — no code changes needed. Your printed QR codes stay
valid forever since they only point to your domain, not the number itself.

## 5. Deploy

Click **Deploy**. Once it's live, test both:

- `https://wa.brownspharmacy.co.ke` (redirects to WhatsApp)
- `https://wa.brownspharmacy.co.ke/health` (should show `ok`)

## 6. Generate the QR code

Once the redirect is confirmed working, generate a QR code encoding:

```
https://wa.brownspharmacy.co.ke
```

This is the URL to put on your posters — not the raw `wa.me` link.
