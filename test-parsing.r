Rebol [
	Title: "Test parsing"
	File: %test-parsing.r
	Author: "Ladislav Mecir"
	Date: 30-Jan-2013/12:11:48+1:00
	Purpose: "Test framework"
]

do %line-numberq.r

whitespace: charset [#"^A" - #" " "^(7F)^(A0)"]

; compatibility functions:
unless value? 'transcode [transcode: :load]

unless value? 'spec-of [spec-of: :third]

read-binary: either find spec-of :read /binary [
	func [source [port! file! url! block!]] [read/binary source]
] [
	:read
]

make object! [

	position: none
	success: none
	set 'test-source-rule [
		any [
			position: ["{" | {"}] (
				; handle string using TRANSCODE
				success: either error? try [
					set/any 'position second transcode/next position
				] [
					[end skip]
				] [
					[:position]
				]
			) success
			|	["{" | {"}] :position break
			|	"[" test-source-rule "]"
			|	"(" test-source-rule ")"
			|	";" [thru newline | to end]
			|	"]" :position break
			|	")" :position break
			|	skip
		]
	]

	set 'collect-tests func [
		collected-tests [block!] {collect the tests here (modified)}
		test-file [file! url!]
		/local flags position stop vector value next-position test-sources
		current-dir
	] [
		current-dir: what-dir
		print ["file:" mold test-file]

		either error? try [
			if file? test-file [
				test-file: clean-path test-file
				change-dir first split-path test-file
			]
			test-sources: read-binary test-file
		] [
			append collected-tests reduce [
				test-file 'dialect {^/"failed, cannot access the file"^/}
			]
			exit
		] [
			append collected-tests test-file
		]

		flags: copy []
		unless parse/all test-sources [
			any [
				some whitespace
				|	";" [thru newline | to end]
				|	copy vector ["[" test-source-rule "]"] (
						append/only collected-tests flags
						append collected-tests to string! vector
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
								collect-tests collected-tests value
								print ["file:" mold test-file]
								append collected-tests test-file
								stop: [end skip]
							]
							path? get/any 'value [
								append/only collected-tests value
								stop: [end skip]
							]
							'else [stop: [:position]]
						]
					) stop break
				|	:next-position
			]
		] [
			print ["position:" copy/part mold position 30]
			append collected-tests reduce [
				'dialect
				rejoin ["failed, line: " line-number? position]
			]
		]
	]
]
