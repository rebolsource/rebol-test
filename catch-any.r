Rebol [
	Title: "Catch-any"
	File: %catch-any.r
	Author: "Ladislav Mecir"
	Date: 1-Nov-2010/18:04:55+1:00
	Purpose: "Catch any REBOL exception"
]

make object! [
	body: [
		error? set/any 'result catch [
			error? set/any 'result loop 1 [
				error? result: try [
					set exception 'return
					error? set/any 'result do block
					set exception none
					return get/any 'result
				]
				set exception 'error
				return result
			]
			set exception 'break
			return get/any 'result
		]		
	]
	; if catch/quit is available, use it as a guard
	unless error? try [catch/quit []] [
		body: compose/deep [
			catch/quit [(body)]
			set exception 'quit
			#[unset!]
		]
	]

	set 'catch-any func [
		{catches any REBOL exception}
		block [block!] {block to evaluate}
		exception [word!] {used to return the exception type}
		/local result
	] body
]