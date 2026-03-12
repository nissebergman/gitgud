const { simpleGit } = require("simple-git");
const fs = require("fs");
const path = require("path");

const git = simpleGit();
const fileExists = (name) => fs.existsSync(path.join(__dirname, name));

describe('git tests', () => {
	it('only main branch exists', async () => {
		const branches = await git.branch()
		expect(branches.all.length).toBe(1)
	})
	it('branch has been merged into main', async () => {
		const allCommits = await git.raw(['rev-list', '--all', '--count'])
		const mainCommits = await git.raw(['rev-list', 'main', '--count'])
		expect(allCommits.trim()).toBe(mainCommits.trim())
	})
	it('main branch has 3 commits total', async () => {
		const log = await git.log()
		expect(log.all.length).toBe(3)
	})
	it('main branch contains main.md', async () => {
		expect(fileExists("main.md")).toBe(true)
	})
	it('main branch contains branch.md', async () => {
		expect(fileExists("branch.md")).toBe(true)
	})
	it('file main.md contains correct lyrics', async () => {
		const content = fs.readFileSync(path.join(__dirname, 'main.md'), 'utf8')
		expect(content.trim()).toBe('små grodorna små grodorna\när lustiga att se')
	})
	it('file branch.md contains correct lyrics', async () => {
		const content = fs.readFileSync(path.join(__dirname, 'branch.md'), 'utf8')
		expect(content.trim()).toBe('en sockerbagare han bor i staden')
	})
})