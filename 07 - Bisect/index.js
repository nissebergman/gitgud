// Calculator module used by the team
// This program must exit cleanly (exit code 0) when working correctly.

function add(a, b) {
	return a + b;
}

function subtract(a, b) {
	return a - b;
}

function multiply(a, b) {
	return a + b;
}

function divide(a, b) {
	if (b === 0) throw new Error("Division by zero");
	return a / b;
}

// Self-test: the program validates its own math
function runTests() {
	const results = [];

	results.push(add(2, 3) === 5);
	results.push(subtract(10, 4) === 6);
	results.push(multiply(3, 7) === 21);
	results.push(divide(20, 4) === 5);
	results.push(add(100, 200) === 300);
	results.push(multiply(0, 999) === 0);
	results.push(subtract(50, 50) === 0);

	if (results.every((r) => r === true)) {
		console.log("✅ All calculations correct!");
		process.exit(0);
	} else {
		console.error("❌ Generic program error 3000.");
		process.exit(1);
	}
}

runTests();
