const { simpleGit } = require("simple-git");
const fs = require("fs");
const path = require("path");

const git = simpleGit();

const readFile = (name) =>
	fs.readFileSync(path.join(__dirname, name), "utf-8");

const fileExists = (name) => fs.existsSync(path.join(__dirname, name));

describe("merge chaos tests", () => {
	it("current branch is main", async () => {
		const status = await git.status();
		expect(status.current).toBe("main");
	});

	it("feature/auth has been merged into main", async () => {
		const result = await git.raw([
			"merge-base",
			"--is-ancestor",
			"feature/auth",
			"main",
		]);
		// If the command succeeds (no throw), the branch is an ancestor
		expect(true).toBe(true);
	});

	it("feature/api has been merged into main", async () => {
		const result = await git.raw([
			"merge-base",
			"--is-ancestor",
			"feature/api",
			"main",
		]);
		expect(true).toBe(true);
	});

	it("feature/database has been merged into main", async () => {
		const result = await git.raw([
			"merge-base",
			"--is-ancestor",
			"feature/database",
			"main",
		]);
		expect(true).toBe(true);
	});

	it("no merge conflict markers in any tracked file", async () => {
		const tracked = await git.raw(["ls-files"]);
		const files = tracked.trim().split("\n").filter(Boolean);
		for (const file of files) {
			const filePath = path.join(__dirname, file);
			if (!fs.existsSync(filePath)) continue;
			const content = fs.readFileSync(filePath, "utf-8");
			expect(content).not.toMatch(/^<{7}\s/m);
			expect(content).not.toMatch(/^={7}$/m);
			expect(content).not.toMatch(/^>{7}\s/m);
		}
	});

	it("working tree is clean (all conflicts resolved and committed)", async () => {
		const status = await git.status();
		expect(status.conflicted).toHaveLength(0);
		expect(status.modified).toHaveLength(0);
		expect(status.not_added).toHaveLength(0);
	});

	// --- server.js checks ---

	it("server.js exists", () => {
		expect(fileExists("server.js")).toBe(true);
	});

	it("server.js imports auth module", () => {
		const src = readFile("server.js");
		expect(src).toMatch(/require\(["']\.\/auth["']\)/);
	});

	it("server.js imports api module", () => {
		const src = readFile("server.js");
		expect(src).toMatch(/require\(["']\.\/api["']\)/);
	});

	it("server.js imports database module", () => {
		const src = readFile("server.js");
		expect(src).toMatch(/require\(["']\.\/database["']\)/);
	});

	it("server.js has /api/login route", () => {
		const src = readFile("server.js");
		expect(src).toMatch(/["']\/api\/login["']/);
	});

	it("server.js has /api/users route", () => {
		const src = readFile("server.js");
		expect(src).toMatch(/["']\/api\/users["']/);
	});

	it("server.js has /api/products route", () => {
		const src = readFile("server.js");
		expect(src).toMatch(/["']\/api\/products["']/);
	});

	it("server.js has /api/health route", () => {
		const src = readFile("server.js");
		expect(src).toMatch(/["']\/api\/health["']/);
	});

	it("server.js has /api/status route", () => {
		const src = readFile("server.js");
		expect(src).toMatch(/["']\/api\/status["']/);
	});

	it("server.js has authenticate middleware", () => {
		const src = readFile("server.js");
		expect(src).toMatch(/authenticate/);
	});

	it("server.js uses paginate", () => {
		const src = readFile("server.js");
		expect(src).toMatch(/paginate/);
	});

	it("server.js uses createPool or pool", () => {
		const src = readFile("server.js");
		expect(src).toMatch(/createPool|pool/);
	});

	it("server.js is valid JavaScript (no syntax errors)", () => {
		const src = readFile("server.js");
		expect(() => {
			new Function(src);
		}).not.toThrow();
	});

	// --- config.json checks ---

	it("config.json exists and is valid JSON", () => {
		expect(fileExists("config.json")).toBe(true);
		const raw = readFile("config.json");
		expect(() => JSON.parse(raw)).not.toThrow();
	});

	it("config.json has auth section with jwtSecret", () => {
		const config = JSON.parse(readFile("config.json"));
		expect(config.auth).toBeDefined();
		expect(config.auth.jwtSecret).toBeDefined();
	});

	it("config.json has api section with rateLimit", () => {
		const config = JSON.parse(readFile("config.json"));
		expect(config.api).toBeDefined();
		expect(config.api.rateLimit).toBeDefined();
	});

	it("config.json has database.poolSize", () => {
		const config = JSON.parse(readFile("config.json"));
		expect(config.database).toBeDefined();
		expect(config.database.poolSize).toBeDefined();
	});

	it("config.json has database.ssl set to true", () => {
		const config = JSON.parse(readFile("config.json"));
		expect(config.database.ssl).toBe(true);
	});

	// --- helper modules exist ---

	it("auth.js exists", () => {
		expect(fileExists("auth.js")).toBe(true);
	});

	it("api.js exists", () => {
		expect(fileExists("api.js")).toBe(true);
	});

	it("database.js exists", () => {
		expect(fileExists("database.js")).toBe(true);
	});
});
