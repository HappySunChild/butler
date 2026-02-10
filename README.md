# Basic Unit Testing Library (er)
`butler` is a small collection of utility functions that make writing unit tests simple.

## Example Usage
```luau
local butler = require("@butler/butler")
local butler_chrono = require("@butler/hooks/butler_chrono")
local butler_pretty = require("@butler/hooks/butler_pretty")

local configured =
	butler({ hooks = { butler_chrono, butler_pretty({ hooks = { butler_chrono } }) } })
local unit, test, expect = configured.unit, configured.test, configured.expect

local maths_unit = unit("maths", {
	test("addition", function()
		expect(2 + 2):to_equal(4)
		expect(1 + -1):to_equal(0)
		expect(-1 + -2):to_never_equal(-5)
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
	test("division", function(remark: (string) -> ())
		expect(10 / 2):to_equal(5)
		expect(2 / -4):to_be_near(-0.5, 0.1)
		expect(-2 / -2):to_equal(1)
		expect(math.isnan(0 / 0)):to_equal(true)
		expect(nil):to_never_exist()
	end),
})

configured.run_units({ maths_unit })

```

*Example output:*
```
═════════════════════════════ Status of 4 test(s) ══════════════════════════════

✅ maths ▸ addition - 9.01µs
✅ maths ▸ subtraction - 2.5µs
✅ maths ▸ division - 6.71µs
✅ maths ▸ multiplication - 1.51µs

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

✅ maths ▸ subtraction - 2.61µs
✅ maths ▸ addition - 9.2µs
❌ maths ▸ division - 0.14ms
✅ maths ▸ multiplication - 1.31µs

══════════════════════════════ 3 passed, 1 failed ══════════════════════════════
```

*Example remark output:*
```
════════════════════════════ Remarks from 1 test(s) ════════════════════════════

✅ maths ▸ bench addition
    • total trials: 1000000
    • avg time per operation: 0.01µs

═════════════════════════════ Status of 5 test(s) ══════════════════════════════

✅ maths ▸ addition - 11.91µs
✅ maths ▸ subtraction - 1.01µs
✅ maths ▸ multiplication - 1.01µs
✅ maths ▸ division - 20.51µs
✅ maths ▸ bench addition - 3.48ms

══════════════════════════════ 5 passed, 0 failed ══════════════════════════════

Total Duration: 3.52ms

════════════════════════════════════════════════════════════════════════════════
```
---

`butler` is based off of dphfox's [tiniest](https://github.com/dphfox/tiniest).
