local function get_grade(percent: number): "A+" | "A" | "B" | "C" | "D" | "F"
	if percent >= 1 then
		return "A+"
	elseif percent >= 0.9 then
		return "A"
	elseif percent >= 0.8 then
		return "B"
	elseif percent >= 0.7 then
		return "C"
	elseif percent >= 0.6 then
		return "D"
	end

	return "F"
end

return get_grade
