Rebol [
	Title: "Test-framework"
	File: %test-framework.r
	Author: "Ladislav Mecir"
	Date: 21-Jan-2013/0:34:30+1:00
	Purpose: "Test framework"
]

do %line-numberq.r
do %catch-any.r

make object! compose [
	(unless value? 'transcode [[transcode: :load]])

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

	; checksums
	interpreter-checksum: none
	test-checksum: none

	; to remember whether to log only failures
	; (logging failures only is not crash proof)
	failures-only: none

	; for r2 and r3 compatibility:
	unless value? 'spec-of [spec-of: :third]
	read-binary: either find spec-of :read /binary [
		func [source [port! file! url! block!]] [read/binary source]
	] [
		:read
	]

	exceptions: make object! [
		return: "return/exit out of the test code"
		error: "error was caused in the test code"
		break: "break or continue out of the test code"
		throw: "throw out of the test code"
		quit: "quit out of the test code"
	]

	whitespace: charset [#"^A" - #" " "^(7F)^(A0)"]
	source-end: none
	parse-source: [
		any [
			source-end: ["{" | {"}] (
				set/any 'source-end second transcode/next source-end
			) :source-end
			|	"[" parse-source "]"
			|	"(" parse-source ")"
			|	";" [thru newline | to end]
			|	"]" :source-end break
			|	")" :source-end break
			|	skip
		]
	]

	parse-test-sources: func [
		test-file [string! binary!]
		test-file-name [file!]
		emit-test [any-function!]
		/local flags position stop vector value next-position
	] [
		flags: copy []
		unless binary? test-file [test-file: to binary! test-file]
		parse/all test-file [
			any [
				some whitespace
				|	";" [thru newline | to end]
				|	copy vector ["[" parse-source "]"] (
						emit-test flags to string! vector
						flags: copy []
					)
				|	end break
				|	position: (
						case [
							any [
								error? try [
									set/any [value next-position] transcode/next position
								]
								none? next-position
							] [stop: [:position]]
							issue? get/any 'value [
								append flags value
								stop: [end skip]
							]
							any [file? get/any 'value url? get/any 'value] [
								parse-test-file value :process-vector
								print ["file:" mold test-file-name]
								log ["^/file: " mold test-file-name "^/^/"]
								stop: [end skip]
							]
							path? get/any 'value [stop: [end skip]]
							'else [stop: [:position]]
						]
					) stop break
				|	:next-position
			]
		]
	]

	parse-test-file: func [
		test-file [file! url!]
		emit-test [any-function!]
		/local current-dir test-file-name
	] [
		current-dir: what-dir
		print ["file:" mold test-file]
		log ["^/file: " mold test-file "^/^/"]
		test-file-name: test-file
		if error? try [
			if file? test-file [
				test-file-name: test-file: clean-path test-file
				change-dir first split-path test-file
			]
			test-file: read test-file
		] [
			dialect-failures: dialect-failures + 1
			log [{^/"failed, dialect: cannot access the file"^/}]
			exit
		]

		unless parse-test-sources test-file test-file-name :emit-test [
			dialect-failures: dialect-failures + 1
			log [
				"^/file: " test-file-name
				" line: " line-number? position
				{ "failed, dialect: file parsing unsuccessful"^/}
			]
		]

		change-dir current-dir
	]

	allowed-flags: none
	crash-markers: none
	process-vector: func [
		flags [block!]
		source [string!]
		/local test-block exception
	] [
		unless empty? intersect crash-markers flags [
			crashes: crashes + 1
			exit
		]

		unless empty? exclude flags allowed-flags [
			skipped: skipped + 1
			exit
		]

		unless failures-only [log [source]]
		if error? try [test-block: load source] [
			test-failures: test-failures + 1
			log either failures-only [
				[source "^/"]
			] [[{ "failed, cannot load test source"^/}]]
			exit
		]

		error? set/any 'test-block catch-any test-block 'exception
		test-block: case [
			exception [rejoin ["failed, " exceptions/:exception]]
			not logic? get/any 'test-block ["failed, not a logic value"]
			:test-block ["succeeded"]
			true ["failed"]
		]

		either test-block = "succeeded" [
			successes: successes + 1
			unless failures-only [log [{ "} test-block {"^/}]]
		] [
			test-failures: test-failures + 1
			log either failures-only [
				[source "^/"]
			] [reduce [{ "} test-block {"^/}]]
		]
	]

	set 'do-tests func [
		{Executes tests in the FILE}
		file [file! url!] {test file}
		flags [block!] {which flags to accept}
		crash-flags [block!] {crash-marking flags}
		log-file-prefix [file!]
		/only-failures
		/local summary interpreter
	] [
		allowed-flags: flags
		crash-markers: crash-flags
		
		failures-only: only-failures

		; calculate checksums
		case [
			#"/" = first system/options/boot [
				interpreter-checksum: checksum/method read-binary
					system/options/boot 'sha1
			]
			string? system/script/args [
				interpreter-checksum: checksum/method read-binary
					to-rebol-file system/script/args 'sha1
			]
			none [
				interpreter-checksum: to binary! "none"
			] 
		]
		test-checksum: checksum/method read-binary file 'sha1
		
		log-file: log-file-prefix
		repeat i length? version: system/version [
			append log-file "_"
			append log-file mold version/:i
		]
		foreach checksum reduce [interpreter-checksum test-checksum] [
			append log-file "_"
			append log-file copy/part skip mold checksum 2 6
		]
		append log-file ".log"
		log-file: clean-path log-file

		if exists? log-file [delete log-file]
		
		successes: test-failures: crashes: dialect-failures: skipped: 0

		parse-test-file file :process-vector

		summary: rejoin [
			"^(line)"
			"system/version: " system/version
			"^(line)"
			"interpreter-checksum: " interpreter-checksum
			"^(line)"
			"test-checksum: " test-checksum
			"^(line)"
			"Total: " successes + test-failures + crashes + dialect-failures
				+ skipped
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
		]

		log [summary]

		reduce [log-file summary]
	]

	total-tests: 0

	set 'do-recover func [
		{Executes tests in the FILE and recovers from crash}
		file [file! url!] {test file}
		flags [block!] {which flags to accept}
		crash-flags [block!] {crash-marking flags}
		log-file-prefix [file!]
		/only-failures
		/local summary interpreter last-vector value position next-position
		test-sources
	] [
		allowed-flags: flags
		crash-markers: crash-flags
		
		failures-only: only-failures

		; calculate checksums
		case [
			all [file? system/options/boot #"/" = first system/options/boot] [
				interpreter-checksum: checksum/method read-binary
					system/options/boot 'sha1
			]
			string? system/script/args [
				interpreter-checksum: checksum/method read-binary
					to-rebol-file system/script/args 'sha1
			]
			none [
				interpreter-checksum: to binary! "none"
			] 
		]
		test-checksum: checksum/method read-binary file 'sha1
		
		log-file: log-file-prefix
		repeat i length? version: system/version [
			append log-file "_"
			append log-file mold version/:i
		]
		foreach checksum reduce [interpreter-checksum test-checksum] [
			append log-file "_"
			append log-file copy/part skip mold checksum 2 6
		]
		append log-file ".log"
		log-file: clean-path log-file

		successes: test-failures: crashes: dialect-failures: skipped: 0

		either case [
			not exists? log-file [
				parse-test-file file :process-vector
				true
			]
			all [
				parse/all read log-file [
					(
						last-vector: none
						stop: [end skip]
					)
					any [
						any whitespace
						[
							position: "file:"
							some whitespace
							next-position:
							"%"
							(set/any [value next-position] transcode/next next-position)
							:next-position
							[
								some whitespace
								{"} thru {"}
								; dialect failure
								(dialect-failures: dialect-failures + 1)
								|	some whitespace
									"line:"
									some whitespace
									next-position:
									(set/any [value next-position] transcode/next next-position)
									:next-position
									{"} thru {"}
									; dialect failure
									(dialect-failures: dialect-failures + 1) 
								|
							]
							|	copy last-vector ["[" parse-source "]"]
								any whitespace
								[
									end (
										; crash found
										crashes: crashes + 1
										log [{ "crashed"^/}]
										stop: none
									)
									|	{"} copy value to {"} skip
										; test result found
										(
											parse/all value [
												"succeeded"
												(successes: successes + 1)
												|	"failed"
													(test-failures: test-failures + 1)
												|	"crashed"
													(crashes: crashes + 1)
												|	(do make error! "invalid test result")
											]
										)
								]
							|	"system/version:"
								to end
								(last-vector: stop: none)
						] position: stop break
						|	:position
					]
				]
				last-vector
				test-sources: find/last/tail read file last-vector
			] [
				parse-test-sources test-sources file :process-vector
				parse-test-sources head test-sources file func [flags source] [
					total-tests: total-tests + 1
				]
				true
			]
			'else [false]
		] [
			summary: rejoin [
				"^(line)"
				"system/version: " system/version
				"^(line)"
				"interpreter-checksum: " interpreter-checksum
				"^(line)"
				"test-checksum: " test-checksum
				"^(line)"
				"Total: " total-tests
				"^(line)"
				"Succeeded: " successes
				"^(line)"
				"Test-failures: " test-failures
				"^(line)"
				"Crashes: " crashes
				"^(line)"
				"Dialect-failures: " dialect-failures
				"^(line)"
				"Skipped: " total-tests - successes - test-failures - crashes
					- dialect-failures
			]
	
			log [summary]
	
			reduce [log-file summary]
		] [
			reduce [log-file "testing already complete"]
		]
	]
]
