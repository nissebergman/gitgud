const { simpleGit } = require("simple-git");

const git = simpleGit();

describe('git tests', () => {
	it('two branches besides main exists', async () => {
		const branches = await git.branch()
		expect(branches.all.length).toBe(3)
	})
	it('one branch is named "first-branch"', async () => {
		const branches = await git.branch()
		expect(branches.all).toContain('first-branch')
	})
	it('one branch is named "second-branch"', async () => {
		const branches = await git.branch()
		expect(branches.all).toContain('second-branch')
	})
	it('commit message on "first-branch" starts with "A:"', async () => {
		const log = await git.log({ from: 'main', to: 'first-branch' })
		expect(log.latest.message).toMatch(/^A:/)
	})
	it('commit message on "second-branch" starts with "B:"', async () => {
		const log = await git.log({ from: 'main', to: 'second-branch' })
		expect(log.latest.message).toMatch(/^B:/)
	})
	
})