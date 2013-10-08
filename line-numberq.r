Rebol [
	Title: "Line number"
	File: %line-numberq.r
	Copyright: [2012 "Saphirion AG"]
	License: {
		Licensed under the Apache License, Version 2.0 (the "License");
		you may not use this file except in compliance with the License.
		You may obtain a copy of the License at

		http://www.apache.org/licenses/LICENSE-2.0
	}
	Author: "Ladislav Mecir"
	Purpose: "Compute the line number"
]

line-number?: func [
	s [string! binary!]
	/local t line-number
] [
	line-number: 1
	t: head s
	parse/all t [
		any [
			(if greater-or-equal? index? t index? s [return line-number])
			[[crlf | cr | lf] (line-number: line-number + 1) | skip] t:
		]
	]
]
