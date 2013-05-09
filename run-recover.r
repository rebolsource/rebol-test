Rebol [
	Title: "Core tests run with crash recovery"
	File: %run-recover.r
	Author: "Ladislav Mecir"
	Purpose: "Core tests"
]

do %test-framework.r

; Example runner for the REBOL/Core tests which chooses
; appropriate flags depending on the interpreter version.

do-core-tests: has [
	flags crash-flags result log-file summary interpreter-checksum
] [
	; Check if we run R3 or R2.
	set 'flags pick [
		[#64bit #r3only #r3]
		[#32bit #r2only]
	] found? in system 'catalog

	; calculate interpreter checksum
	case [
		all [file? system/options/boot #"/" = first system/options/boot] [
			interpreter-checksum: checksum/method read-binary
				system/options/boot 'sha1
		]
		string? system/script/args [
			interpreter-checksum: checksum/method read-binary
				to-rebol-file system/script/args 'sha1
		]
		'else [
			; use system/build
			interpreter-checksum: checksum/method to binary!
				mold system/build 'sha1
		] 
	]

	print "Testing ..."
	result: do-recover %core-tests.r flags interpreter-checksum
	set [log-file summary] result

	print ["Done, see the log file:" log-file]
	print summary
]

do-core-tests
