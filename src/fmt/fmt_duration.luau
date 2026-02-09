local SUFFIX_MICRO = "µ"
local SUFFIX_MILLI = "m"

local MILLISECOND = 1e-3
local MICROSECOND = 1e-6

local function fmt_duration(seconds: number)
	if seconds < 100 * MICROSECOND then
		return `{math.ceil(seconds / MICROSECOND * 100) / 100}{SUFFIX_MICRO}s`
	elseif seconds < 100 * MILLISECOND then
		return `{math.ceil(seconds / MILLISECOND * 100) / 100}{SUFFIX_MILLI}s`
	end

	return `{math.ceil(seconds * 100) / 100}s`
end

return fmt_duration
