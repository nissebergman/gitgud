# 07 — Bisect: Hitta buggen med binärsökning 🔍

## Uppgift

Programmet `index.js` är trasigt. Någonstans bland ~50 commits introducerades en bugg.

- Använd `git bisect` för att hitta exakt vilken commit som orsakade felet.
- Spara hela hashen på den commit som introducerar buggen i en fil vid namn `answer.txt`
- Revertera commiten från main.

## Starta

```bash
./setup.sh
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

## Kör tester

```bash
./run_tests.sh
```
