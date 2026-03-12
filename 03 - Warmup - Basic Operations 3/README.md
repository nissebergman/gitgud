# 03 — Uppvärmning: Branch, Commit, Merge & Delete

## Uppgift

Skapa en branch, gör commits på den, mergea tillbaka till `main` och ta sedan bort branchen.

## Starta

```bash
./setup.sh
```

## Startläge

```
main
 │
 ● add main.md with lyrics
```

`main` har 1 commit med `main.md` ("små grodorna små grodorna").

## Mål

```
main
 │
 ● add main.md with lyrics
 ● add branch.md with lyrics
 ● update main.md with more lyrics
```

Alla 3 commits på `main`. Branchen `branch` ska vara borttagen.
`main.md` ska innehålla "små grodorna små grodorna\når lustiga att se".
`branch.md` ska innehålla "en sockerbagare han bor i staden".

## Steg

1. Skapa en ny branch som heter `branch` och byt till den.
2. Skapa filen `branch.md` med texten "en sockerbagare han bor i staden" och committa.
3. Lägg till en ny rad i `main.md` med texten "är lustiga att se" och committa.
4. Byt tillbaka till `main`.
5. Mergea `branch` in i `main`.
6. Ta bort branchen `branch`.

## Kör tester

```bash
bash run_tests.sh
```
