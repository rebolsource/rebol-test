Rebol [
	Title: "Test-framework"
	File: %test-framework.r
	Author: "Ladislav Mecir"
	Date: 1-Nov-2010/13:35:13+1:00
	Purpose: "Test framework"
]

#include-check %line-numberq.r

make object! compose [
	(unless value? 'transcode [[transcode: :load]])

	log-file: none
	
	log: func [report [block!]] [
		write/append log-file to binary! rejoin report
	]

	; counters
	skipped: none
	test-failures: none
	dialect-failures: none
	succeeded: none

	failures: none

	do-block: func [
		{Evaluate a block, helper function for DO-TEST.}
		block "block to evaluate"
		result [word!] "will contain the result"
		test-out [word!]
	] [
		error? set/any result do block
		set test-out "test done"
	]

	; if catch/quit is available, use it as a guard
	inner-block: [
		error? catch [
			error? loop 1 [
				error? error: try [
					do-block block 'result 'test-out
					unless test-out [
						test-out: "return/exit out of the test code"
					]
				]
				unless test-out [test-out: "error was caused in the test code"]
			]
			unless test-out [
				test-out: "break or continue out of the test code"
			]
		]
		unless test-out [test-out: "throw out of the test code"]
	]
	unless error? try [catch/quit []] [
		inner-block: compose/deep [
			catch/quit [(inner-block)]
			unless test-out [test-out: "quit out of the test code"]
		]
	]

	do-test: func [
		{
			Evaluate BLOCK. Guard against "Throw out", "Break out",
			"Exit out", "Quit out" and "ordinary" errors.
		}
		[throw]
		block [block!] {Block to evaluate}
		/local result test-out error
	] append inner-block [
		case [
			test-out <> "test done" [reduce ["failed, " test-out]]
			not value? 'result [["failed, returned #[unset!]"]]
			error? :result [["failed, returned error"]]
			not logic? :result [["failed, not a logic value"]]
			:result [["succeeded"]]
			true [["failed"]]
		]
	]

	whitespace: charset [#"^A" - #" " "^(7F)^(A0)"]
	source-end: none
	source-check: none
	parse-source: [
		(source-check: none)
		any [
			source-check
			[
				source-end: ["{" | {"}] (
					set/any 'source-end second transcode/next source-end
				) :source-end
				| "[" parse-source "]" (source-check: none)
				| "(" parse-source ")" (source-check: none)
				| ";" [thru newline | to end]
				| "]" :source-end (source-check: [end skip])
				| ")" :source-end (source-check: [end skip])
				| skip
			]
		]
	]

	parse-test-file: func [
		test-file [file! url!]
		emit-test [any-function!]
		/local flags path position flag source current-dir failure
		test-file-name
	] [
		current-dir: what-dir
		print ["file:" test-file]
		log ["^/file: " test-file "^/^/"]
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
		]

		flags: copy []
		unless binary? test-file [test-file: to binary! test-file]
		unless parse/all test-file [
			(failure: none)
			any whitespace
			any [
				failure
				[
					position: ";" [to newline | to end]
					| "[" parse-source "]" source-end: (
						emit-test flags to string! copy/part position source-end
						flags: copy []
					) | ["{" | {"}] (
						failure: [end skip]
					) :position | "#" (
						set/any [flag position] transcode/next position
						append flags flag
					) :position | skip (
						if error? try [
							set/any [path position] transcode/next position
							case [
								any [file? path url? path] [
									parse-test-file path :process-vector
									print ["file:" test-file-name]
									log ["^/file: " test-file-name "^/^/"]	
								]
								path? path []
								true [failure: [end skip]]
							]
						] [failure: [end skip]]
					) :position
				]
				any whitespace
			]
		] [
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
	process-vector: func [
		flags [block!]
		source [string!]
		/local test-block
	] [
		unless empty? exclude flags allowed-flags [
			skipped: skipped + 1
			exit
		]
		unless failures [log [source]]
		if error? try [test-block: load source] [
			test-failures: test-failures + 1
			log either failures [
				[source "^/"]
			] [
				[{ "failed, cannot load test source"^/}]
			]
			exit
		]
		test-block: do-test test-block
		either test-block = ["succeeded"] [
			succeeded: succeeded + 1
			unless failures [log [{ "} test-block {"^/}]]
		] [
			test-failures: test-failures + 1
			log either failures [
				[source "^/"]
			] [
				[{ "} test-block {"^/}]
			]
		]
	]

	set 'do-tests func [
		{Executes tests in the FILE}
		file [file! url!] {test file}
		flags [block!] {which flags to accept}
		log-file-prefix [file!]
		/only-failures
	] [
		allowed-flags: flags
		failures: only-failures
		log-file: log-file-prefix
		repeat i length? version: system/version [
			append log-file "_"
			append log-file mold version/:i
		]
		append log-file ".log"
		log-file: clean-path log-file

		if exists? log-file [delete log-file]
		succeeded: test-failures: dialect-failures: skipped: 0

		parse-test-file file :process-vector

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
		log [
			"^(line)"
			now
			" "
			rebol/version
			" Total: " succeeded + test-failures + dialect-failures + skipped
			" Succeeded: " succeeded
			" Test failures: " test-failures
			" Dialect failures: " dialect-failures
			" Skipped: " skipped
		]
		#[unset!]
	]
]
