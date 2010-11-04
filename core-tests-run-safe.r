Rebol [
	Title: "Core tests run safe"
	File: %core-tests-run-safe.r
	Author: "Ladislav Mecir"
	Date: 2-Nov-2010/3:18:02+1:00
	Purpose: "Core tests"
]

do %test-framework.r

; Example runner for the REBOL/Core tests which chooses
; appropriate flags depending on the interpreter version.

do-core-tests: has [
	flags result log-file succeeded test-failures dialect-failures skipped
] [
	; Check if we run R3 or R2.
	flags: pick [
		[#64bit #r3only #r2crash #r3]
		[#32bit #r3crash #r2only #test3crash]
	] found? in system 'catalog

	print "Testing ..."
	result: do-tests %core-tests.r flags %cps
	set [log-file succeeded test-failures dialect-failures skipped] result

	print ["Done, see the log file:" log-file]
	print [
		now
		rebol/version
		"Total:" succeeded + test-failures + dialect-failures + skipped
		"Succeeded:" succeeded
		"Test failures:" test-failures
		"Dialect failures:" dialect-failures
		"Skipped:" skipped
	]
]

do-core-tests
