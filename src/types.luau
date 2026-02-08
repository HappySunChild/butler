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

export type TestBody = (remark: (string) -> ()) -> ()
export type Test = {
	label: string,
	body: TestBody,
}
export type TestRunResult = {
	duration: number,
	status: "pass" | "fail",
	remarks: { string },

	error: Error?,
}

return nil
