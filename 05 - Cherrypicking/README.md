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

## Kör tester

```bash
./run_tests.sh
```
