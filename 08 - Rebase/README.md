# 08 — Interaktiv Rebase: Squash commits 🫸🫷

## Uppgift

Använd `git rebase -i` för att squasha 8 commits till 3 (en per prefix: `chore:`, `fix:`, `ci:`).

## Starta

```bash
bash setup.sh
```

## Startläge

```
main
 │
 ● initial project setup
 ● chore: add linting configuration notes
 ● chore: update dependency versions
 ● chore: remove unused imports
 ● fix: resolve token refresh loop
 ● fix: add null check for user lookup
 ● fix: increase request timeout to 30s
 ● ci: add node_modules caching step
 ● ci: add Slack notification on failure
```

9 commits totalt (1 initial + 3 chore + 3 fix + 2 ci).

## Mål

```
main
 │
 ● initial project setup
 ● chore: ...                   ← 3 chore-commits squashade till 1
 ● fix: ...                     ← 3 fix-commits squashade till 1
 ● ci: ...                      ← 2 ci-commits squashade till 1
```

- 4 commits totalt (1 initial + 3 squashade)
- Alla 8 filer ska fortfarande finnas kvar
- Commit-meddelanden ska börja med `chore:`, `fix:` respektive `ci:`

## Kommandon att använda

```bash
git log --oneline                  # se alla commits
git rebase -i HEAD~8               # starta interaktiv rebase
```

I editorn: ändra `pick` till `squash` (eller `s`) för de commits du vill slå ihop.
Behåll `pick` på den första i varje grupp.

## Kör tester

```bash
bash run_tests.sh
```
