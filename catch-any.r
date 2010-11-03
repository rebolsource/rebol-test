Rebol [
	Title: "Catch-any"
	File: %catch-any.r
	Author: "Ladislav Mecir"
	Date: 3-Nov-2010/4:58:46+1:00
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
					; RETURN or EXIT
					set exception 'return
					set/any 'result do block
					
					; no exception
					set exception none
					return get/any 'result
				]
				; an error was triggered
				set exception 'error
				return result
			]
			; BREAK or CONTINUE
			set exception 'break
			return get/any 'result
		]
		; THROW
		set exception 'throw
		return get/any 'result
	]
	; QUIT
	set exception 'quit
	#[unset!]
]] [[
	error? set/any 'result catch [
		error? set/any 'result loop 1 [
			error? result: try [
				; RETURN or EXIT
				set exception 'return
				set/any 'result do block
				
				; no exception
				set exception none
				return get/any 'result
			]
			; an error was triggered
			set exception 'error
			return result
		]
		; BREAK
		set exception 'break
		return get/any 'result
	]
	; THROW
	set exception 'throw
	return get/any 'result
]]
