# 03 — Uppvärmning: Merge & Delete Branch

## Uppgift

Mergea en branch till `main` och ta sedan bort branchen.

## Starta

```bash
bash setup.sh
```

## Startläge

```
main           branch
 │               │
 ● add main.md   ├── ● add branch.md with lyrics
                 └── ● update main.md with more lyrics
```

`main` har 1 commit med `main.md` ("små grodorna små grodorna").
`branch` har 2 commits: `branch.md` ("en sockerbagare han bor i staden") och en uppdatering av `main.md` ("är lustiga att se").

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

## Kommandon att använda

```bash
git merge branch
git branch -d branch
```

## Kör tester

```bash
bash run_tests.sh
```
