# 02 — Uppvärmning: Grundläggande Git 2

## Uppgift

Skapa två nya branches från `main`, gör ändringar i varje och committa.

## Starta

```bash
bash setup.sh
```

## Startläge

```
main
 │
 ● initial project setup
```

## Mål

```
main
 │
 ● initial project setup
 ├─── first-branch
 │      ● A: ...
 └─── second-branch
        ● B: ...
```

Tre branches ska finnas: `main`, `first-branch` och `second-branch`.
Commit-meddelandet på `first-branch` ska börja med `A:` och på `second-branch` med `B:`.

## Kommandon att använda

```bash
git branch <namn>
git checkout <namn>     # eller: git switch <namn>
git add <fil>
git commit -m "A: ..."
```

## Kör tester

```bash
bash run_tests.sh
```
