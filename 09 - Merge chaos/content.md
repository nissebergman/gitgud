### Merge Chaos — Triple Conflict Resolution 💥🔀💥

Three feature branches all modify the same files (`server.js` and `config.json`) in incompatible ways. You must merge **all three** into `main` and resolve every conflict.

#### Branches

| Branch             | What it does                                                                                                      |
| ------------------ | ----------------------------------------------------------------------------------------------------------------- |
| `feature/auth`     | Adds authentication middleware, `/api/login` route, protects `/api/users`, adds `auth.js`                         |
| `feature/api`      | Adds request validation, pagination on `/api/users`, `/api/products` route, improved error handler, adds `api.js` |
| `feature/database` | Replaces inline DB with connection pool, makes `/api/users` async, adds `/api/health` route, adds `database.js`   |

#### Conflicting Areas

- **`server.js`**: All three branches rewrite the imports, middleware, `/api/users` route, and server startup. Two branches add new routes. One changes the error handler. One changes the port.
- **`config.json`**: Auth adds an `auth` section. API adds an `api` section and changes the port to 4000 and logging level to debug. Database changes the host to `db.internal` and adds `poolSize` and `ssl`.

#### Your Task

1. Merge all three feature branches into `main`
2. Resolve every conflict so the final code includes **all** features working together
3. Make sure `server.js` is valid JavaScript with no syntax errors
4. Make sure `config.json` is valid JSON containing settings from all three branches

#### Expected Final State

`server.js` must have:

- Imports for `./auth`, `./api`, and `./database`
- The `authenticate` middleware function
- All 5 routes: `/api/login`, `/api/users`, `/api/products`, `/api/health`, `/api/status`
- References to `paginate` and `createPool`/`pool`

`config.json` must have:

- An `auth` section (with `jwtSecret`)
- An `api` section (with `rateLimit`)
- Database `poolSize` and `ssl: true`

#### Hints

1. Run `git log --oneline --all --graph` to visualize the branches
2. Start with `git merge feature/auth` — resolve conflicts, then commit
3. Then `git merge feature/api` — more conflicts, resolve and commit
4. Then `git merge feature/database` — final round of conflicts
5. After each merge, check for `<<<<<<<` markers: `grep -r "<<<<<<" .`
6. Use `node -c server.js` to check for syntax errors
7. Use `node -e "JSON.parse(require('fs').readFileSync('config.json'))"` to validate JSON
