local DISABLE_COLOR = false

local function ansi_mode(...): string
	return if DISABLE_COLOR then "" else `\x1b[{table.concat({ ... }, ";")}m`
end

local RESET = ansi_mode(0)
local DIM = ansi_mode(2, 3, 90)

local NUMBER = ansi_mode(1, 36)
local STRING = ansi_mode(1, 33)
local KEYWORD = ansi_mode(1, 35)

local function tint_dim(text: string)
	return DIM .. tostring(text) .. RESET
end

local function tint_number(text: string): string
	return NUMBER .. text .. RESET
end

local function tint_string(text: string): string
	return STRING .. text .. RESET
end

local function tint_keyword(text: string): string
	return KEYWORD .. text .. RESET
end

local paint = table.freeze({
	tint = function(text: string | number, ...: string): string
		return ansi_mode(...) .. text .. RESET
	end,
	bind = function(...: string): (string | number) -> string
		local code = ansi_mode(...)

		return function(text: string | number): string
			return code .. tostring(text) .. RESET
		end
	end,
	syntax = function(snippet: string): string
		local new = snippet
			:gsub("0?[xXbB]?%d*%.?%d*[eE]?%-?%d+", tint_number)
			:gsub('".-"', tint_string)
			:gsub("'.-'", tint_string)
			:gsub("function", tint_keyword)
			:gsub("end", tint_keyword)
			:gsub("true", tint_keyword)
			:gsub("false", tint_keyword)
			:gsub("nil", tint_keyword)
			:gsub("%-%-.-\n", tint_dim)

		return new
	end,
})

return paint
