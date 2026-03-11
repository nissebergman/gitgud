# 03 — Plumbing: Git-objekt under huven

## Uppgift

Använd `git cat-file` för att utforska gits interna objekt — commits, trees och blobs.
Spara resultaten i filer.

## Starta

```bash
bash setup.sh
```

## Startläge

```
main
 │
 ● initial project setup    ← content.md innehåller "sparre"
```

## Mål

Skapa filerna:

- **catfileout.txt** — innehållet från `git cat-file -p <commit-hash>` (ska innehålla `tree`, `author`, `committer`)
- **blob.txt** — innehållet från `git cat-file -p <blob-hash>` (ska innehålla `sparre`)

## Kommandon att använda

```bash
git log                           # hitta commit-hash
git cat-file -p <commit-hash>     # visa commit → hitta tree-hash
git cat-file -p <tree-hash>       # visa tree → hitta blob-hash
git cat-file -p <blob-hash>       # visa blob-innehållet
```

Spara output med `>`, t.ex:

```bash
git cat-file -p <commit-hash> > catfileout.txt
git cat-file -p <blob-hash> > blob.txt
```

## Kör tester

```bash
bash run_tests.sh
```
