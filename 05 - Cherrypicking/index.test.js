const { simpleGit } = require("simple-git");
const fs = require("fs");
const path = require("path");

const git = simpleGit();

describe('cherry-pick tests', () => {
	it('current branch is main', async () => {
		const status = await git.status()
		expect(status.current).toBe('main')
	})

	it('feature branch exists', async () => {
		const branches = await git.branch()
		expect(branches.all).toContain('feature')
	})

	it('feature branch has commits starting with A:, B:, and C:', async () => {
		const log = await git.log({ from: 'main', to: 'feature' })
		const messages = log.all.map(c => c.message)
		expect(messages.some(m => m.startsWith('A:'))).toBe(true)
		expect(messages.some(m => m.startsWith('B:'))).toBe(true)
		expect(messages.some(m => m.startsWith('C:'))).toBe(true)
	})

	it('main has a cherry-picked commit starting with "B:"', async () => {
		const log = await git.log()
		const hasB = log.all.some(c => c.message.startsWith('B:'))
		expect(hasB).toBe(true)
	})

	it('main does NOT have a commit starting with "A:"', async () => {
		const log = await git.log()
		const hasA = log.all.some(c => c.message.startsWith('A:'))
		expect(hasA).toBe(false)
	})

	it('main does NOT have a commit starting with "C:"', async () => {
		const log = await git.log()
		const hasC = log.all.some(c => c.message.startsWith('C:'))
		expect(hasC).toBe(false)
	})

	it('B.md exists on main (from the cherry-picked commit)', () => {
		const filePath = path.join(__dirname, 'B.md')
		expect(fs.existsSync(filePath)).toBe(true)
	})

	it('A.md does NOT exist on main', () => {
		const filePath = path.join(__dirname, 'A.md')
		expect(fs.existsSync(filePath)).toBe(false)
	})

	it('C.md does NOT exist on main', () => {
		const filePath = path.join(__dirname, 'C.md')
		expect(fs.existsSync(filePath)).toBe(false)
	})
})