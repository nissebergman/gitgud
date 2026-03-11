### Interactive Rebase — Squash Commits 🫸🫷

Your git history has 8 commits on `main` (after the initial setup commit):

- 3 commits starting with `chore:`
- 3 commits starting with `fix:`
- 2 commits starting with `ci:`

**Your task:** Use `git rebase -i` to squash these into **3 commits** — one for each prefix:

1. One `chore:` commit (squash all 3 chore commits into one)
2. One `fix:` commit (squash all 3 fix commits into one)
3. One `ci:` commit (squash all 2 ci commits into one)

After rebasing, your history should have exactly **4 commits**:

- `initial project setup`
- One `chore: ...` commit
- One `fix: ...` commit
- One `ci: ...` commit

All files created by the original commits must still exist.

#### Hints

1. Run `git log --oneline` to see the current history
2. Run `git rebase -i HEAD~8` to start interactive rebase
3. In the editor, reorder commits so same-prefix commits are grouped together
4. Mark the first of each group as `pick` and the rest as `squash` (or `s`)
5. When prompted, write a single commit message for each squashed group
