# 04 — Cherry-pick 🍒

## Uppgift

Skapa en feature-branch med tre commits och cherry-picka **bara en** av dem till `main`.

## Starta

```bash
./setup.sh
```

## Startläge

```
main
 │
 ● initial project setup
```

## Mål

```
main                         feature
 │                             │
 ● initial project setup       ├── ● A: ...  (A.md)
 ● B: ...  (B.md)             ├── ● B: ...  (B.md)
                               └── ● C: ...  (C.md)
```

- `feature`-branchen ska ha 3 commits: `A:`, `B:`, `C:` (med filerna `A.md`, `B.md`, `C.md`)
- `main` ska ha cherry-pickad **enbart** `B:`-committen
- `B.md` ska finnas på `main`, men **inte** `A.md` eller `C.md`

## Kommandon att använda

```bash
git checkout -b feature
# skapa A.md, committa med "A: ..."
# skapa B.md, committa med "B: ..."
# skapa C.md, committa med "C: ..."
git checkout main
git log feature --oneline       # hitta B:-committens hash
git cherry-pick <hash>
```

## Kör tester

```bash
./run_tests.sh
```
