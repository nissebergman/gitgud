const { simpleGit } = require("simple-git");
const fs = require("fs");
const path = require("path");

const git = simpleGit();

describe("01 - Warmup - Basic Operations 1", () => {
	it("should only have the main branch", async () => {
		const branches = await git.branch();
		expect(branches.all).toEqual(["main"]);
	});

	it("should have exactly 2 commits", async () => {
		const log = await git.log();
		expect(log.all.length).toBe(2);
	});

	it('second commit message should start with "A:"', async () => {
		const log = await git.log();
		const latestMessage = log.latest.message;
		expect(latestMessage.startsWith("A:")).toBe(true);
	});

	it("content.md should exist", () => {
		const filePath = path.join(__dirname, "content.md");
		expect(fs.existsSync(filePath)).toBe(true);
	});
});