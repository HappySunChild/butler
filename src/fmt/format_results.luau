local types = require("../types")

local format_duration = require("./format_duration")

type FormattedResult = {
	test: types.Test,
	result: types.TestRunResult,
	icon: string,

	full_label: string,
	annotations: string,
}

local LINE_LENGTH = 80
local DIVIDER = "═"
local MARGIN_LINE = "│"
local ARROW = "▸"

local PASS_EMOJI = "✅"
local FAIL_EMOJI = "❌"

local function title(text: string)
	local divider_count = (LINE_LENGTH - string.len(text) - 2) / 2
	local divider_lhs = string.rep(DIVIDER, math.floor(divider_count))
	local divider_rhs = string.rep(DIVIDER, math.ceil(divider_count))

	return `{divider_lhs} {text} {divider_rhs}`
end

local function format_results(units_results: types.UnitsRunResult): string
	local lines = {}

	local pretty_results: { FormattedResult } = {}

	for _, unit_result in units_results.individual_units do
		for test, test_result in unit_result.individual do
			local status_emoji = if test_result.status == "pass" then PASS_EMOJI else FAIL_EMOJI
			local annotations = {
				"",
				format_duration(test_result.duration),
			}

			table.insert(pretty_results, {
				test = test,
				result = test_result,
				icon = status_emoji,

				full_label = `{unit_result.label} {ARROW} {test.label}`,
				annotations = table.concat(annotations, " - "),
			})
		end
	end

	-- ERRORS

	if units_results.total_tally.fail > 0 then
		table.insert(lines, title(`Errors from {units_results.total_tally.fail} test(s)`))
		table.insert(lines, "")

		for _, pretty in pretty_results do
			local err = pretty.result.error

			if err == nil then
				continue
			end

			table.insert(lines, `{pretty.icon}  {pretty.full_label}`)
			table.insert(lines, err.message)

			local snippet = err.code

			if snippet ~= nil then
				local line = tostring(err.line or "??")
				local empty_margin = string.rep(" ", #line + 1) .. MARGIN_LINE

				local formatted_snippet = snippet:gsub("[^\n\r]+[\n\r]", function(line: string)
					return `{line}{empty_margin} `
				end)

				table.insert(lines, empty_margin)
				table.insert(lines, `{line} {MARGIN_LINE} {formatted_snippet}`)
				table.insert(lines, empty_margin)
			end
		end

		table.insert(lines, "")
	end

	-- STATUS

	table.insert(lines, title(`Status of {#pretty_results} test(s)`))
	table.insert(lines, "")

	for _, pretty in pretty_results do
		table.insert(lines, `{pretty.icon}  {pretty.full_label}{pretty.annotations}`)
	end

	table.insert(lines, "")

	-- CONCLUSION

	local total_tally = units_results.total_tally

	table.insert(lines, title(`{total_tally.pass} passed, {total_tally.fail} failed`))

	return table.concat(lines, "\n")
end

return format_results
