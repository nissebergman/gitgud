const fs = require("fs");

describe('git tests', () => {
	it('file catfileout.txt exist and contains commit contents', () => {
		const content = fs.readFileSync('catfileout.txt', 'utf-8')
		expect(content).toContain('tree')
		expect(content).toContain('author')
		expect(content).toContain('committer')
	})
	it('file blob.txt exists and contains the content of the committed file', () => {
		const content = fs.readFileSync('blob.txt', 'utf-8')
		expect(content).toContain('sparre')
	})
})