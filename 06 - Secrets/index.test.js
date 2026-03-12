const { simpleGit } = require("simple-git");
const { execSync } = require("child_process");
const fs = require("fs");
const path = require("path");

const git = simpleGit();
const SECRET = 'ghp_s3cr3tK3y9x7Qm2Lp4Rv8Tw1Yz6Bh0Jf';

describe('secrets purge tests', () => {
	it('config.env still exists', () => {
		const filePath = path.join(__dirname, 'config.env')
		expect(fs.existsSync(filePath)).toBe(true)
	})

	it('config.env does NOT contain the secret in the working tree', () => {
		const content = fs.readFileSync(path.join(__dirname, 'config.env'), 'utf-8')
		expect(content).not.toContain(SECRET)
	})

	it('has at least 10 commits (history was not destroyed)', async () => {
		const log = await git.log()
		expect(log.all.length).toBeGreaterThanOrEqual(10)
	})

	it('secret does NOT appear in ANY commit diff in history', () => {
		const result = execSync(
			`git log --all -p -S "${SECRET}" --format="%H" || true`,
			{ cwd: __dirname, encoding: 'utf-8' }
		)
		expect(result.trim()).toBe('')
	})

	it('secret does NOT appear in any blob across all revisions', () => {
		const result = execSync(
			`git rev-list --all | xargs -I {} git grep -l "${SECRET}" {} -- 2>/dev/null || true`,
			{ cwd: __dirname, encoding: 'utf-8' }
		)
		expect(result.trim()).toBe('')
	})
})
