Rebol [
	Title: "Core tests run"
	File: %core-tests-run.r
	Author: "Ladislav Mecir"
	Date: 1-Nov-2010/14:21:20+1:00
	Purpose: "Core tests"
]

include %test-framework.r

; example doing REBOL/Core tests
; using appropriate flags depending on the interpreter version

do-core-tests: does [
	; check if we run R3 or R2
	either in system 'catalog [
		flags: [#64bit #r3only #r2crash #r3]
		print "Testing..."
		do-tests/only-failures %core-tests.r flags %cpl
	] [
		flags: [#32bit #r3crash #r2only]
		print "Testing..."
		do-tests/only-failures %core-tests.r flags %cpl
	]
]

do-core-tests
