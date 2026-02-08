# Basic Unit Testing Library (er)
`butler` is a small collection of utility functions that make writing unit tests simple.

## Example Usage
```luau
local butler = require("path/to/butler")
local unit, test, expect = butler.unit, butler.test, butler.expect

local maths_unit = unit("maths", {
	test("addition", function()
		expect(2 + 2):to_equal(4)
		expect(1 + -1):to_equal(0)
		expect(-1 + -2):to_never_equal(-6)
	end),
	test("subtraction", function()
		expect(10 - 1):to_equal(9)
		expect(9 - -1):to_equal(10)
		expect(-5 - -3):to_equal(-2)
	end),
	test("multiplication", function()
		expect(10 * 20):to_equal(200)
		expect(20 * -13):to_equal(-260)
		expect(-10 * -1):to_equal(10)
	end),
	test("division", function()
		expect(10 / 2):to_equal(5)
		expect(2 / -4):to_be_near(-0.5, 0.1)
		expect(-2 / -2):to_equal(1)
	end),
})

local results = butler.run_units({ maths_unit })
local formatted = butler.format_results(results)

print(formatted)
```

*Example output:*
```
═════════════════════════════ Status of 4 test(s) ══════════════════════════════

✅  maths ▸ addition - 9.01µs
✅  maths ▸ subtraction - 2.5µs
✅  maths ▸ division - 6.71µs
✅  maths ▸ multiplication - 1.51µs

══════════════════════════════ 4 passed, 0 failed ══════════════════════════════
```
*Example error output:*
```
════════════════════════════ Errors from 1 test(s) ═════════════════════════════

❌  maths ▸ division
Expectation not met, because:
does not equal 0
   │
23 │ expect(1):to_equal(0)
   │

═════════════════════════════ Status of 4 test(s) ══════════════════════════════

✅  maths ▸ subtraction - 2.61µs
✅  maths ▸ addition - 9.2µs
❌  maths ▸ division - 0.14ms
✅  maths ▸ multiplication - 1.31µs

══════════════════════════════ 3 passed, 1 failed ══════════════════════════════
```

---

`butler` is based off of dphfox's [tiniest](https://github.com/dphfox/tiniest).
