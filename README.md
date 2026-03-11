# Porcelain vs plumbing.

In Git, commands are divided into high-level ("porcelain") commands and low-level ("plumbing") commands. The porcelain commands are the ones that you will use most often as a developer to interact with your code. Some porcelain commands are:

git status
git add
git commit
git push
git pull
git log

git apply
git commit-tree
git hash-object

git cat-file -p to find:

- Commit (first numbers of hash)
- Tree (within commit)
- Blob (within tree)
- Contents (within blob)

# A file can be in one of several states in a Git repository. Here are a few important ones:

untracked: Not being tracked by Git
staged: Marked for inclusion in the next commit
committed: Saved to the repository's history
The git status command shows you the current state of your repo. It will tell you which files are untracked, staged, and committed.

# Git log

git --no-pager log -n 1

# Everything in terminal

# 01

## verify.bat

# base

## setup (windows/linux/mac)

## verify all

git commit --fixup + git rebase --autosquash
git rebase --onto

Recovering From Mistakes

Advanced Git users should be able to undo almost anything.

Topics:

git reflog

Recovering lost commits

Detached HEAD recovery

Difference between:

git reset --soft

git reset --mixed

git reset --hard

git restore vs git checkout

Critical skill:

“Nothing is lost in Git until garbage collection.”

`git rerere`

git format-patch

git apply

git am

Advanced:

git log -S (pickaxe search for code changes)

Example:

git log -S "myFunction"

6. Stashing (Advanced Use)

People often only know the basics.

Include:

git stash -p

git stash --include-untracked

Named stashes

Applying vs popping

Stashing specific paths

7. Worktrees (Very Advanced & Very Useful)

Often missing from workshops but powerful.

git worktree allows multiple working directories from one repo.

Example:

git worktree add ../feature-x feature-x

Use cases:

Working on multiple branches simultaneously

Avoid constant checkout

If I Were Designing an "Advanced Git Workshop"

I'd include these core advanced pillars:

Rewriting history (rebase -i)

Debugging history (bisect, blame, pickaxe)

Recovery (reflog, resets)

Complex merges

Patch workflows

Worktrees

Hooks

Secret removal from history (git filter-repo)

Add task with git merge. One basic, one hell!
