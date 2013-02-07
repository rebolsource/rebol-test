Rebol [
	Title: "Log diff"
	File: %log-diff.r
	Author: "Ladislav Mecir"
	Date: 6-Feb-2013/17:14:56+1:00
	Purpose: "Test framework"
]

do %test-parsing.r

make-diff: func [
	old-log [file!]
	new-log [file!]
	diff-file [file!]
	/local old-log-contents new-log-contents
	old-test old-result new-test new-result
	new-successes new-failures new-crashes
	progressions regressions removed
] [
	collect-log old-log-contents: copy [] old-log
	collect-log new-log-contents: copy [] new-log

	sort/skip old-log-contents 2
	sort/skip new-log-contents 2

	; counter initialization
	new-successes:
	new-failures:
	new-crashes:
	progressions:
	regressions:
	removed:
	0

	; cycle initialization
	set [old-test old-result] old-log-contents
	old-log-contents: skip old-log-contents 2

	set [new-test new-result] new-log-contents
	new-log-contents: skip new-log-contents 2

	while [any [old-test new-test]] [
		case [
			all [
				new-test
				any [
					none? old-test
					old-test > new-test
					all [
						old-test = new-test
						old-result = 'skipped
						new-result <> 'skipped
					]
				]
			] [
				; fresh test
				write/append diff-file rejoin [
					new-test
					" "
					switch new-result [
						succeeded [
							new-successes: new-successes + 1
							"succeeded"
						]
						failed [
							new-failures: new-failures + 1
							"failed"
						]
						crashed [
							new-crashes: new-crashes + 1
							"crashed"
						]
					]
					"^/"
				]				
			]
			all [
				old-test
				any [
					none? new-test
					new-test > old-test
					all [
						new-test = old-test
						new-result = 'skipped
						old-result <> 'skipped
					]
				]
			] [
				; removed test
				removed: removed + 1
				write/append diff-file rejoin [
					old-test
					" removed^/"
				]
			]
			old-result = new-result []
			; having different results
			(
				write/append diff-file new-test
				any [
					old-result = 'succeeded
					all [
						old-result = 'failed
						new-result = 'crashed
					]
				]
			) [
				; regression
				regressions: regressions + 1
				write/append diff-file rejoin [" regression, " new-result "^/"]
			]
			'else [
				; progression
				progressions: progressions + 1
				write/append diff-file rejoin [" progression, " new-result "^/"]
			]
		]
		if all [old-test any [none? new-test old-test <= new-test]] [
			; we need to move the old-log-contents position
			if old-test = pick old-log-contents 1 [
				print old-test
				do make error! {duplicate test in old-log}
			]
			set [old-test old-result] old-log-contents
			old-log-contents: skip old-log-contents 2
		]
		if all [new-test any [none? new-test new-test <= old-test]] [
			; we need to move the new-log-contents position
			if new-test = pick new-log-contents 1 [
				print new-test
				do make error! {duplicate test in new-log}
			]
			set [new-test new-result] new-log-contents
			new-log-contents: skip new-log-contents 2
		]
	]
]

make-diff first to-rebol-file first system/script/args to-rebol-file second system/script/args %diff.r
