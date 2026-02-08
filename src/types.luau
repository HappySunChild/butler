export type Error = {
	type: string,
	message: string,

	trace: string,
	line: number?,
	code: string?,
}

export type UnitRunResult = {
	label: string,
	duration: number,
	ordered_tests: { Test },

	individual: { [Test]: TestRunResult },
	tally: { pass: number, fail: number },
}
export type UnitsRunResult = {
	total_duration: number,
	total_tally: { pass: number, fail: number },

	individual_units: { UnitRunResult },
}
export type TestRunResult = {
	duration: number,

	status: "pass" | "fail",
	error: Error?,
}

export type Test = {
	label: string,
	body: (...any?) -> ...any?,
}

return nil
