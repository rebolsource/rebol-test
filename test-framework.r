Rebol [
	Title: "Test-framework"
	File: %test-framework.r
	Author: "Ladislav Mecir"
	Date: 19-Nov-2010/15:00:45+1:00
	Purpose: "Test framework"
]

do %line-numberq.r
do %catch-any.r

make object! compose [
	(unless value? 'transcode [[transcode: :load]])

	log-file: none
	
	log: func [report [block!]][
		write/append log-file to binary! rejoin report
	]

	; counters
	skipped: none
	test-failures: none
	crashes: none
	dialect-failures: none
	succeeded: none

	failures: none

	exceptions: make object! [
		return: "return/exit out of the test code"
		error: "error was caused in the test code"
		break: "break or continue out of the test code"
		throw: "throw out of the test code"
		quit: "quit out of the test code"
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
	][
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
		][
			dialect-failures: dialect-failures + 1
			log [{^/"failed, dialect: cannot access the file"^/}]
			exit
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
		][
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
	][
		unless empty? intersect crash-markers flags [
			crashes: crashes + 1
			exit
		]

		unless empty? exclude flags allowed-flags [
			skipped: skipped + 1
			exit
		]

		unless failures [log [source]]
		if error? try [test-block: load source][
			test-failures: test-failures + 1
			log either failures [
				[source "^/"]
			][[{ "failed, cannot load test source"^/}]]
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
			succeeded: succeeded + 1
			unless failures [log [{ "} test-block {"^/}]]
		][
			test-failures: test-failures + 1
			log either failures [
				[source "^/"]
			][reduce [{ "} test-block {"^/}]]
		]
	]

	set 'do-tests func [
		{Executes tests in the FILE}
		file [file! url!] {test file}
		flags [block!] {which flags to accept}
		crash-flags [block!] {crash-marking flags}
		log-file-prefix [file!]
		/only-failures
	][
		allowed-flags: flags
		crash-markers: crash-flags
		
		failures: only-failures
		
		log-file: log-file-prefix
		repeat i length? version: system/version [
			append log-file "_"
			append log-file mold version/:i
		]
		append log-file ".log"
		log-file: clean-path log-file

		if exists? log-file [delete log-file]
		
		succeeded: test-failures: crashes: dialect-failures: skipped: 0

		parse-test-file file :process-vector

		log [
			"^(line)"
			rebol/version
			" "
			now
			" Total: " succeeded + test-failures + crashes + dialect-failures
				+ skipped
			" Succeeded: " succeeded
			" Test-failures: " test-failures
			" Crashes: " crashes
			" Dialect-failures: " dialect-failures
			" Skipped: " skipped
		]
		reduce [
			log-file succeeded test-failures crashes dialect-failures skipped
		]
	]
]
