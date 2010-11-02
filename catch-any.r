Rebol [
	Title: "Catch-any"
	File: %catch-any.r
	Author: "Ladislav Mecir"
	Date: 2-Nov-2010/6:39:25+1:00
	Purpose: "Catch any REBOL exception"
]

set 'catch-any func [
	{catches any REBOL exception}
	block [block!] {block to evaluate}
	exception [word!] {used to return the exception type}
	/local result
] either rebol/version >= 2.100.0 [[
	catch/quit [
		set/any 'result catch [
			set/any 'result loop 1 [
				result: try [
					; this applies, if RETURN (or EXIT)
					; is evaluated in the BLOCK
					set exception 'return
					set/any 'result do block
					
					; we get here if no exception was encountered
					set exception none
					return get/any 'result
				]
				; we get here if an error was triggered
				set exception 'error
				return result
			]
			; we get here if BREAK or CONTINUE was called
			set exception 'break
			return get/any 'result
		]
		; we get here if THROW was called
		set exception 'throw
		return get/any 'result
	]
	; we get here if QUIT was called
	set exception 'quit
	#[unset!]
]] [[
	error? set/any 'result catch [
		error? set/any 'result loop 1 [
			error? result: try [
				; this applies, if RETURN (or EXIT)
				; is evaluated in the BLOCK
				set exception 'return
				set/any 'result do block
				
				; we get here if no exception was encountered
				set exception none
				return get/any 'result
			]
			; we get here if an error was triggered
			set exception 'error
			return result
		]
		; we get here if BREAK or CONTINUE was called
		set exception 'break
		return get/any 'result
	]
	; we get here if THROW was called
	set exception 'throw
	return get/any 'result
]]
