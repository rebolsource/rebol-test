Rebol [
	Title: "Core tests run"
	File: %core-tests-run.r
	Author: "Ladislav Mecir"
	Date: 18-Nov-2010/11:23:15+1:00
	Purpose: "Core tests"
]

do %test-framework.r

; Example runner for the REBOL/Core tests which chooses
; appropriate flags depending on the interpreter version.

do-core-tests: has [
	flags crash-flags result log-file
	succeeded test-failures crashes dialect-failures skipped
] [
	; Check if we run R3 or R2.
	set [flags crash-flags] pick [
		[[#64bit #r3only #r2crash #r3] [#r3crash #test3crash]]
		[[#32bit #r3crash #r2only #test3crash] [#r2crash #test2crash]]
	] found? in system 'catalog

	print "Testing ..."
	result: do-tests/only-failures %core-tests.r flags crash-flags %cpl
	set [log-file succeeded test-failures crashes dialect-failures skipped]
		result

	print ["Done, see the log file:" log-file]
	print [
		now
		rebol/version
		"Total:" succeeded + test-failures + dialect-failures + skipped
		"Succeeded:" succeeded
		"Test failures:" test-failures
		"Crashes:" crashes
		"Dialect failures:" dialect-failures
		"Skipped:" skipped
	]
]

do-core-tests
