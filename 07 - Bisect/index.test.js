const { execSync } = require("child_process");
const fs = require("fs");
const path = require("path");

function run(cmd) {
  return execSync(cmd, { cwd: __dirname, encoding: "utf-8" }).trim();
}

describe("07 - Bisect", () => {
  const badCommitFile = path.join(__dirname, ".bad_commit");
  let expectedHash;

  beforeAll(() => {
    expectedHash = fs.readFileSync(badCommitFile, "utf-8").trim();
  });

  test("bisect is not still in progress", () => {
    const bisecting = fs.existsSync(path.join(__dirname, ".git", "BISECT_LOG"));
    expect(bisecting).toBe(false);
  });

  test("student is on the main/master branch (ran git bisect reset)", () => {
    const branch = run("git rev-parse --abbrev-ref HEAD");
    expect(["main", "master"]).toContain(branch);
  });

  test("student identified the bad commit in answer.txt", () => {
    const answerFile = path.join(__dirname, "answer.txt");
    expect(fs.existsSync(answerFile)).toBe(true);

    const answer = fs.readFileSync(answerFile, "utf-8").trim();
    expect(answer).toBe(expectedHash);
  });

  test("student reverted the bad commit (not just manually edited)", () => {
    const log = run("git log --oneline");
    const topCommit = log.split("\n")[0].toLowerCase();
    expect(topCommit).toMatch(/revert/);
  });

  test("node index.js runs without error", () => {
    let exitCode = 0;
    try {
      execSync("node index.js", { cwd: __dirname, encoding: "utf-8" });
    } catch (e) {
      exitCode = e.status;
    }
    expect(exitCode).toBe(0);
  });
});