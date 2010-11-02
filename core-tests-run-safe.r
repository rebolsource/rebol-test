Rebol [
	Title: "Core tests run safe"
	File: %core-tests-run-safe.r
	Author: "Ladislav Mecir"
	Date: 2-Nov-2010/3:18:02+1:00
	Purpose: "Core tests"
]

do %test-framework.r

; example doing REBOL/Core tests
; using appropriate flags depending on the interpreter version

do-core-tests: does [
	; check if we run R3 or R2
	either in system 'catalog [
		flags: [#64bit #r3only #r2crash #r3]
		print "Testing..."
		do-tests %core-tests.r flags %cps
	] [
		flags: [#32bit #r3crash #r2only #test3crash]
		print "Testing..."
		do-tests %core-tests.r flags %cps
	]
]

do-core-tests
