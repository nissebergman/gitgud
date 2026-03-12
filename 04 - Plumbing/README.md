# 03 — Plumbing: Git-objekt under huven

## Uppgift

Använd BARA `git cat-file` för att utforska interna delar av git — commits, trees och blobs.
Spara resultaten i filer.

## Starta

```bash
./setup.sh
```

## Startläge

```
main
 │
 ● initial project setup content.md innehåller gömd sträng
```

## Mål

Skapa filerna:

- **catfileout.txt** — innehållet från `git cat-file -p <commit-hash>` (ska innehålla `tree`, `author`, `committer`)
- **blob.txt** — innehållet från `git cat-file -p <blob-hash>` (ska innehålla texten från content.md)

## Kör tester

```bash
bash run_tests.sh
```
