# 07 — Bisect: Hitta buggen med binärsökning 🔍

## Uppgift

Programmet `index.js` är trasigt. Någonstans bland ~50 commits introducerades en bugg.
Använd `git bisect` för att hitta exakt vilken commit som orsakade felet, revertera den och spara svaret.

## Starta

```bash
bash setup.sh
```

## Startläge

```
main
 │
 ● initial project setup        ← index.js funkar (exit code 0)
 ● ...  (~50 commits)
 ● <senaste>                    ← index.js är trasig (exit code 1)
```

## Mål

```
main
 │
 ● initial project setup
 ● ...
 ● <senaste>
 ● Revert "..."                 ← buggen reverterad
```

- `answer.txt` ska innehålla hela hashen för den trasiga committen
- Senaste committen på `main` ska vara en revert
- `node index.js` ska köras utan fel (exit code 0)
- Bisect ska vara avslutat (inte pågående)

## Kommandon att använda

```bash
node index.js                              # bekräfta att det är trasigt

git bisect start
git bisect bad                             # nuvarande commit är trasig
git log --oneline | tail -1                # hitta första committen
git bisect good <första-commit-hash>

# för varje steg:
node index.js                              # funkar? → git bisect good
                                           # kraschar? → git bisect bad

# när bisect hittar den trasiga committen:
echo "<hash>" > answer.txt
git bisect reset
git revert <hash>
git add answer.txt
git commit -m "add bisect answer"
```

## Kör tester

```bash
bash run_tests.sh
```
