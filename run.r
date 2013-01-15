Rebol [
	Title: "Core tests run"
	File: %run.r
	Author: "Ladislav Mecir"
	Date: 15-Jan-2013/16:21:19+1:00
	Purpose: "Core tests"
]

do %test-framework.r

; Example runner for the REBOL/Core tests which chooses
; appropriate flags depending on the interpreter version.

do-core-tests: has [
	flags crash-flags result log-file summary
] [
	; Check if we run R3 or R2.
	set [flags crash-flags] pick [
		[[#64bit #r3only #r3 #r2crash #test2crash] [#r3crash #test3crash]]
		[[#32bit #r2only #r3crash #test3crash] [#r2crash #test2crash]]
	] found? in system 'catalog

	print "Testing ..."
	result: do-tests/only-failures %core-tests.r flags crash-flags %u
	set [log-file summary] result

	print ["Done, see the log file:" log-file]
	print summary
]

do-core-tests
