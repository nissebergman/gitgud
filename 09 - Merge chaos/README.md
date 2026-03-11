# 09 — Merge Chaos: Lös konflikter i tre branches 💥🔀💥

## Uppgift

Mergea tre feature-branches till `main` och lös alla merge-konflikter.
Slutresultatet ska vara en fungerande `server.js` som kombinerar alla features.

## Starta

```bash
bash setup.sh
```

## Startläge

```
main
 │
 ● initial project setup
 ├─── feature/auth       ● feat: add authentication system
 ├─── feature/api        ● feat: add API improvements and products endpoint
 └─── feature/database   ● feat: add database connection pooling
```

Alla tre branches ändrar `server.js` och `config.json` på olika sätt → konflikter vid merge.

## Mål

```
main
 │
 ● initial project setup
 ● feat: add authentication system        (merge feature/auth)
 ● feat: add API improvements ...         (merge feature/api, konflikter lösta)
 ● feat: add database connection pooling  (merge feature/database, konflikter lösta)
```

Krav på `server.js`:

- Importerar `./auth`, `./api`, `./database`
- Har routes: `/api/login`, `/api/users`, `/api/products`, `/api/health`, `/api/status`
- Använder `authenticate`, `paginate`, `createPool`/`pool`
- Giltig JavaScript (inga syntaxfel)

Krav på `config.json`:

- `auth.jwtSecret`, `api.rateLimit`, `database.poolSize`, `database.ssl: true`

Filer som ska finnas: `auth.js`, `api.js`, `database.js`

Inga merge-konfliktmarkörer (`<<<<<<<`, `=======`, `>>>>>>>`) i någon fil.

## Kommandon att använda

```bash
git merge feature/auth
git merge feature/api              # → konflikter i server.js och config.json
# redigera filerna, lös konflikterna
git add .
git commit                         # slutför merge
git merge feature/database         # → fler konflikter
# redigera, lös, stagea, committa
```

## Kör tester

```bash
bash run_tests.sh
```
