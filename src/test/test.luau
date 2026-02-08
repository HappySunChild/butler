local types = require("../types")

local function test(label: string, body: types.TestBody): types.Test
	return {
		label = label,
		body = body,
	}
end

return test
