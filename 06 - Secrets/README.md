# 06 — Secrets: Rensa känslig data ur historiken 🔒

## Uppgift

En GitHub-token (börjar på `ghp`) committades av misstag.
Den togs bort i en senare commit, men **finns kvar i git-historiken**.
Rensa bort hemligheten från **alla** commits, diffs och blobs — utan att förstöra historiken.

## Starta

```bash
./setup.sh
```

## Startläge

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

## Kör tester

```bash
./run_tests.sh
```
