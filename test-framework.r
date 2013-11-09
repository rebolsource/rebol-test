Rebol [
	Title: "Test-framework"
	File: %test-framework.r
	Copyright: [2012 "Saphirion AG"]
	License: {
		Licensed under the Apache License, Version 2.0 (the "License");
		you may not use this file except in compliance with the License.
		You may obtain a copy of the License at

		http://www.apache.org/licenses/LICENSE-2.0
	}
	Author: "Ladislav Mecir"
	Purpose: "Test framework"
]

do %test-parsing.r
do %catch-any.r

make object! compose [
	log-file: none

	log: func [report [block!]] [
		write/append log-file to binary! rejoin report
	]

	; counters
	skipped: none
	test-failures: none
	crashes: none
	dialect-failures: none
	successes: none

	exceptions: make object! [
		return: "return/exit out of the test code"
		error: "error was caused in the test code"
		break: "break or continue out of the test code"
		throw: "throw out of the test code"
		quit: "quit out of the test code"
	]

	allowed-flags: none

	process-vector: func [
		flags [block!]
		source [string!]
		/local test-block exception
	] [
		log [source]

		unless empty? exclude flags allowed-flags [
			skipped: skipped + 1
			log [{ "skipped"^/}]
			exit
		]

		if error? try [test-block: load source] [
			test-failures: test-failures + 1
			log [{ "failed, cannot load test source"^/}]
			exit
		]

		error? set/any 'test-block catch-any test-block 'exception

		test-block: case [
			exception [rejoin ["failed, " exceptions/:exception]]
			not logic? get/any 'test-block ["failed, not a logic value"]
			:test-block ["succeeded"]
			true ["failed"]
		]

		recycle

		either test-block = "succeeded" [
			successes: successes + 1
			log [{ "} test-block {"^/}]
		] [
			test-failures: test-failures + 1
			log reduce [{ "} test-block {"^/}]
		]
	]

	total-tests: 0

	process-tests: func [
		test-sources [block!]
		emit-test [any-function!]
		/local value flags
	] [
		parse test-sources [
			any [
				set flags block! set value skip (
					emit-test flags to string! value
				)
					|
				set value file! (log ["^/" mold value "^/^/"])
					|
			 	'dialect set value string! (
					log [value]
					dialect-failures: dialect-failures + 1
				)
			]
		]
	]

	set 'do-recover func [
		{Executes tests in the FILE and recovers from crash}
		file [file!] {test file}
		flags [block!] {which flags to accept}
		code-checksum [binary!]
		log-file-prefix [file!]
		/local interpreter last-vector value position next-position
		test-sources test-checksum guard
	] [
		allowed-flags: flags
		
		; calculate test checksum
		test-checksum: checksum/method read-binary file 'sha1
		
		log-file: log-file-prefix

		foreach checksum reduce [code-checksum test-checksum] [
			append log-file "_"
			append log-file copy/part skip mold checksum 2 6
		]

		append log-file ".log"
		log-file: clean-path log-file

		collect-tests test-sources: copy [] file

		successes: test-failures: crashes: dialect-failures: skipped: 0

		either case [
			not exists? log-file [
				print "new log"
				process-tests test-sources :process-vector
				true
			]
			all [
				parse/all read log-file [
					(
						last-vector: none
						guard: [end skip]
					)
					any [
						any whitespace
						[
							position: "%"
							(set/any [value next-position] transcode/next position)
							:next-position
								|
							; dialect failure?
							some whitespace
							{"} thru {"}
							(dialect-failures: dialect-failures + 1)
								|
							copy last-vector ["[" test-source-rule "]"]
							any whitespace
							[
								end (
									; crash found
									crashes: crashes + 1
									log [{ "crashed"^/}]
									guard: none
								)
									|
								{"} copy value to {"} skip
								; test result found
								(
									parse/all value [
										"succeeded"
										(successes: successes + 1)
											|
										"failed"
										(test-failures: test-failures + 1)
											|
										"crashed"
										(crashes: crashes + 1)
											|
										"skipped"
										(skipped: skipped + 1)
											|
										(do make error! "invalid test result")
									]
								)
							]
								|
							"system/version:"
							to end
							(last-vector: guard: none)
								|
							(do make error! "log file parsing problem")
						] position: guard break
							|
						:position
					]
				]
				last-vector
				test-sources: find/last/tail test-sources last-vector
			] [
				print ["recovering at:" successes + test-failures + crashes + dialect-failures + skipped]
				process-tests test-sources :process-vector
				true
			]
			'else [false]
		] [
			summary: rejoin [
				"^(line)"
				"system/version: " system/version
				"^(line)"
				"code-checksum: " code-checksum
				"^(line)"
				"test-checksum: " test-checksum
				"^(line)"
				"Total: " successes + test-failures + crashes + dialect-failures + skipped
				"^(line)"
				"Succeeded: " successes
				"^(line)"
				"Test-failures: " test-failures
				"^(line)"
				"Crashes: " crashes
				"^(line)"
				"Dialect-failures: " dialect-failures
				"^(line)"
				"Skipped: " skipped
				"^(line)"
			]
	
			log [summary]
	
			reduce [log-file summary]
		] [
			reduce [log-file "testing already complete"]
		]
	]
]
