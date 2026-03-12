const { simpleGit } = require("simple-git");

const git = simpleGit();

describe("rebase -i squash tests", () => {
	let log;

	beforeAll(async () => {
		log = await git.log();
	});

	it("current branch is main", async () => {
		const status = await git.status();
		expect(status.current).toBe("main");
	});

	it('there is exactly 1 commit starting with "chore:"', () => {
		const choreCommits = log.all.filter((c) =>
			c.message.startsWith("chore:"),
		);
		expect(choreCommits).toHaveLength(1);
	});

	it('there is exactly 1 commit starting with "fix:"', () => {
		const fixCommits = log.all.filter((c) => c.message.startsWith("fix:"));
		expect(fixCommits).toHaveLength(1);
	});

	it('there is exactly 1 commit starting with "ci:"', () => {
		const ciCommits = log.all.filter((c) => c.message.startsWith("ci:"));
		expect(ciCommits).toHaveLength(1);
	});

	it("total commit count is 4 (1 initial + 3 squashed)", () => {
		expect(log.all).toHaveLength(4);
	});

	it("all created files still exist after rebase", () => {
		const fs = require("fs");
		const path = require("path");
		const expectedFiles = [
			"linting.md",
			"deps.md",
			"cleanup.md",
			"auth-fix.md",
			"null-check.md",
			"timeout-fix.md",
			"ci-cache.md",
			"ci-notify.md",
		];
		for (const file of expectedFiles) {
			const filePath = path.join(__dirname, file);
			expect(fs.existsSync(filePath)).toBe(true);
		}
	});

	it("the initial commit is still present", () => {
		const initial = log.all.find((c) =>
			c.message.includes("initial project setup"),
		);
		expect(initial).toBeDefined();
	});
});
