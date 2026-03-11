# 06 — Secrets: Rensa känslig data ur historiken 🔒

## Uppgift

En GitHub-token (`FEJK`) committades av misstag.
Den togs bort i en senare commit, men **finns kvar i git-historiken**.
Rensa bort hemligheten från **alla** commits, diffs och blobs — utan att förstöra historiken.

## Starta

```bash
bash setup.sh
```

## Startläge

```
main
 │
 ● initial project setup
 ● add team members list
 ● add project notes
 ● add environment config        ← hemligheten läggs till här
 ● add Charlie to team
 ● add deployment guide
 ● update project notes
 ● add changelog
 ● add Diana to team
 ● add monitoring step
 ● remove hardcoded token         ← filen uppdateras, men historiken har kvar hemligheten
 ● update changelog for v0.2.0
```

## Mål

```
main  (samma commits, ≥10 st, men hemligheten finns inte i någon commit/blob)
 │
 ● initial project setup
 ● ...
 ● update changelog for v0.2.0
```

- `config.env` ska fortfarande finnas
- `config.env` ska **inte** innehålla token i working tree
- Historiken ska ha ≥ 10 commits (inte raderad)
- Token ska **inte** dyka upp i någon diff eller blob i hela historiken

## Kommandon att använda

```bash
git log --oneline
git log --all -p -S "FEJK"    # hitta var hemligheten finns
git filter-repo --replace-text replacements.txt                    # skriv om historiken
```

Du kan behöva installera `git-filter-repo`:

```bash
brew install git-filter-repo
```

## Kör tester

```bash
bash run_tests.sh
```

echo "ghp*s3cr3tK3y9x7Qm2Lp4Rv8Tw1Yz6Bh0Jf==>\*\*\_REDACTED*\*\*" > ../replacements.txt

# Purge it from all history

git filter-repo --replace-text ../replacements.txt
