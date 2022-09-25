; Rebol []
; *****************************************************************************
; Title: Rebol core tests
; Copyright:
;     2012 REBOL Technologies
;     2013 Saphirion AG
; Author:
;     Carl Sassenrath, Ladislav Mecir, Andreas Bolka, Brian Hawley, John K
; License:
;     Licensed under the Apache License, Version 2.0 (the "License");
;     you may not use this file except in compliance with the License.
;     You may obtain a copy of the License at
;
;     http://www.apache.org/licenses/LICENSE-2.0
;
;     Unless required by applicable law or agreed to in writing, software
;     distributed under the License is distributed on an "AS IS" BASIS,
;     WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
;     See the License for the specific language governing permissions and
;     limitations under the License.
; *****************************************************************************
; datatypes/action.r
[action? :abs]
[not action? 1]
[action! = type? :abs]
; bug#1659
; implicit evaluation
[1 == do reduce [:abs -1]]
; indirect (word) implicit evaluation
[1 == abs -1]
; indirect (path) implicit evaluation
[
	b: reduce [:abs]
	1 == b/1 -1
]
; explicit evaluation
[1 == do :abs -1]
; indirect (word) explicit evaluation
; indirect (path) explicit evaluation
; datatypes/binary.r
[binary? #{00}]
[not binary? 1]
[binary! = type? #{00}]
[
	system/options/binary-base: 2
	"2#{00000000}" == mold #{00}
]
[
	system/options/binary-base: 64
	"64#{AAAA}" == mold #{000000}
]
[
	system/options/binary-base: 16
	"#{00}" == mold #{00}
]
[#{00} == 2#{00000000}]
[#{000000} == 64#{AAAA}]
[#{} == make binary! 0]
[#{00} == to binary! "^(00)"]
; minimum
[binary? #{}]
; alternative literal representation
[#{} == #[binary! #{}]]
; access symmetry
[
	b: #{0b}
	not error? try [b/1: b/1]
]
; bug#42
[
	b: #{0b}
	b/1 == 11
]
; case sensitivity
; bug#1459
[lesser? #{0141} #{0161}]
; datatypes/bitset.r
[bitset? make bitset! "a"]
[not bitset? 1]
[bitset! = type? make bitset! "a"]
; minimum, literal representation
[bitset? #[bitset! #{}]]
; TS crash
[bitset? charset reduce [to-char "^(A0)"]]
; datatypes/block.r
[block? [1]]
[not block? 1]
[block! = type? [1]]
; minimum
[block? []]
; alternative literal representation
[[] == #[block! []]]
[[] == make block! 0]
[[] == to block! ""]
["[]" == mold []]
; implicit evaluation
[
	a-block: [1 + 2]
	same? :a-block do reduce [:a-block]
]
; indirect (word) implicit evaluation
[
	a-block: [1 + 2]
	same? :a-block do [a-block]
]
; indirect (path) implicit evaluation
[
	a-block: [[1 + 2]]
	same? first :a-block a-block/1
]
; explicit evaluation
[do [true]]
; datatypes/char.r
[char? #"a"]
[not char? 1]
[char! = type? #"a"]
[#"^@" = #"^(00)"]
[#"^A" = #"^(01)"]
[#"^B" = #"^(02)"]
[#"^C" = #"^(03)"]
[#"^D" = #"^(04)"]
[#"^E" = #"^(05)"]
[#"^F" = #"^(06)"]
[#"^G" = #"^(07)"]
[#"^H" = #"^(08)"]
[#"^I" = #"^(09)"]
[#"^J" = #"^(0A)"]
[#"^K" = #"^(0B)"]
[#"^L" = #"^(0C)"]
[#"^M" = #"^(0D)"]
[#"^N" = #"^(0E)"]
[#"^O" = #"^(0F)"]
[#"^P" = #"^(10)"]
[#"^Q" = #"^(11)"]
[#"^R" = #"^(12)"]
[#"^S" = #"^(13)"]
[#"^T" = #"^(14)"]
[#"^U" = #"^(15)"]
[#"^V" = #"^(16)"]
[#"^W" = #"^(17)"]
[#"^X" = #"^(18)"]
[#"^Y" = #"^(19)"]
[#"^Z" = #"^(1A)"]
[#"^[" = #"^(1B)"]
[#"^\" = #"^(1C)"]
[#"^]" = #"^(1D)"]
[#"^!" = #"^(1E)"]
[#"^_" = #"^(1F)"]
[#" " = #"^(20)"]
[#"!" = #"^(21)"]
[#"^"" = #"^(22)"]
[#"#" = #"^(23)"]
[#"$" = #"^(24)"]
[#"%" = #"^(25)"]
[#"&" = #"^(26)"]
[#"'" = #"^(27)"]
[#"(" = #"^(28)"]
[#")" = #"^(29)"]
[#"*" = #"^(2A)"]
[#"+" = #"^(2B)"]
[#"," = #"^(2C)"]
[#"-" = #"^(2D)"]
[#"." = #"^(2E)"]
[#"/" = #"^(2F)"]
[#"0" = #"^(30)"]
[#"1" = #"^(31)"]
[#"2" = #"^(32)"]
[#"3" = #"^(33)"]
[#"4" = #"^(34)"]
[#"5" = #"^(35)"]
[#"6" = #"^(36)"]
[#"7" = #"^(37)"]
[#"8" = #"^(38)"]
[#"9" = #"^(39)"]
[#":" = #"^(3A)"]
[#";" = #"^(3B)"]
[#"<" = #"^(3C)"]
[#"=" = #"^(3D)"]
[#">" = #"^(3E)"]
[#"?" = #"^(3F)"]
[#"@" = #"^(40)"]
[#"A" = #"^(41)"]
[#"B" = #"^(42)"]
[#"C" = #"^(43)"]
[#"D" = #"^(44)"]
[#"E" = #"^(45)"]
[#"F" = #"^(46)"]
[#"G" = #"^(47)"]
[#"H" = #"^(48)"]
[#"I" = #"^(49)"]
[#"J" = #"^(4A)"]
[#"K" = #"^(4B)"]
[#"L" = #"^(4C)"]
[#"M" = #"^(4D)"]
[#"N" = #"^(4E)"]
[#"O" = #"^(4F)"]
[#"P" = #"^(50)"]
[#"Q" = #"^(51)"]
[#"R" = #"^(52)"]
[#"S" = #"^(53)"]
[#"T" = #"^(54)"]
[#"U" = #"^(55)"]
[#"V" = #"^(56)"]
[#"W" = #"^(57)"]
[#"X" = #"^(58)"]
[#"Y" = #"^(59)"]
[#"Z" = #"^(5A)"]
[#"[" = #"^(5B)"]
[#"\" = #"^(5C)"]
[#"]" = #"^(5D)"]
[#"^^" = #"^(5E)"]
[#"_" = #"^(5F)"]
[#"`" = #"^(60)"]
[#"a" = #"^(61)"]
[#"b" = #"^(62)"]
[#"c" = #"^(63)"]
[#"d" = #"^(64)"]
[#"e" = #"^(65)"]
[#"f" = #"^(66)"]
[#"g" = #"^(67)"]
[#"h" = #"^(68)"]
[#"i" = #"^(69)"]
[#"j" = #"^(6A)"]
[#"k" = #"^(6B)"]
[#"l" = #"^(6C)"]
[#"m" = #"^(6D)"]
[#"n" = #"^(6E)"]
[#"o" = #"^(6F)"]
[#"p" = #"^(70)"]
[#"q" = #"^(71)"]
[#"r" = #"^(72)"]
[#"s" = #"^(73)"]
[#"t" = #"^(74)"]
[#"u" = #"^(75)"]
[#"v" = #"^(76)"]
[#"w" = #"^(77)"]
[#"x" = #"^(78)"]
[#"y" = #"^(79)"]
[#"z" = #"^(7A)"]
[#"{" = #"^(7B)"]
[#"|" = #"^(7C)"]
[#"}" = #"^(7D)"]
[#"~" = #"^(7E)"]
[#"^~" = #"^(7F)"]
; alternatives
[#"^(null)" = #"^(00)"]
[#"^(line)" = #"^(0A)"]
[#"^/" = #"^(0A)"]
[#"^(tab)" = #"^(09)"]
[#"^-" = #"^(09)"]
[#"^(page)" = #"^(0C)"]
[#"^(esc)" = #"^(1B)"]
[#"^(back)" = #"^(08)"]
[#"^(del)" = #"^(7f)"]
[#"^(00)" = make char! 0]
[#"^(00)" = to char! 0]
[{#"a"} = mold #"a"]
; minimum
[char? #"^(00)"]
; maximum
[char? #"^(ff)"]
; datatypes/closure.r
[closure? closure [] ["OK"]]
[not closure? 1]
#r3only
[closure! = type? closure [] ["OK"]]
; minimum
[closure? closure [] []]
; literal form
#r3only
[closure? first [#[closure! [[] []]]]]
; return-less return value tests
[
	f: closure [] []
	unset? f
]
[
	f: closure [] [:abs]
	:abs = f
]
[
	a-value: #{}
	f: closure [] [a-value]
	same? a-value f
]
[
	a-value: charset ""
	f: closure [] [a-value]
	same? a-value f
]
[
	a-value: []
	f: closure [] [a-value]
	same? a-value f
]
[
	a-value: none!
	f: closure [] [a-value]
	same? a-value f
]
[
	f: closure [] [1/Jan/0000]
	1/Jan/0000 = f
]
[
	f: closure [] [0.0]
	0.0 == f
]
[
	f: closure [] [1.0]
	1.0 == f
]
[
	a-value: me@here.com
	f: closure [] [a-value]
	same? a-value f
]
#r3only
[
	f: closure [] [try [1 / 0]]
	error? f
]
[
	a-value: %""
	f: closure [] [a-value]
	same? a-value f
]
[
	a-value: does []
	f: closure [] [:a-value]
	same? :a-value f
]
[
	a-value: first [:a]
	f: closure [] [:a-value]
	(same? :a-value f) and (:a-value == f)
]
[
	f: closure [] [#"^@"]
	#"^@" == f
]
[
	a-value: make image! 0x0
	f: closure [] [a-value]
	same? a-value f
]
[
	f: closure [] [0]
	0 == f
]
[
	f: closure [] [1]
	1 == f
]
[
	f: closure [] [#a]
	#a == f
]
[
	a-value: first ['a/b]
	f: closure [] [:a-value]
	:a-value == f
]
[
	a-value: first ['a]
	f: closure [] [:a-value]
	:a-value == f
]
[
	f: closure [] [true]
	true = f
]
[
	f: closure [] [false]
	false = f
]
[
	f: closure [] [$1]
	$1 == f
]
[
	f: closure [] [:type?]
	same? :type? f
]
[
	f: closure [] [#[none]]
	none? f
]
[
	a-value: make object! []
	f: closure [] [:a-value]
	same? :a-value f
]
[
	a-value: first [()]
	f: closure [] [:a-value]
	same? :a-value f
]
[
	f: closure [] [get '+]
	same? get '+ f
]
[
	f: closure [] [0x0]
	0x0 == f
]
[
	a-value: 'a/b
	f: closure [] [:a-value]
	:a-value == f
]
[
	a-value: make port! http://
	f: closure [] [:a-value]
	port? f
]
[
	f: closure [] [/a]
	/a == f
]
[
	a-value: first [a/b:]
	f: closure [] [:a-value]
	:a-value == f
]
[
	a-value: first [a:]
	f: closure [] [:a-value]
	:a-value == all [:a-value]
]
[
	a-value: ""
	f: closure [] [:a-value]
	same? :a-value f
]
[
	a-value: make tag! ""
	f: closure [] [:a-value]
	same? :a-value f
]
[
	f: closure [] [0:00]
	0:00 == f
]
[
	f: closure [] [0.0.0]
	0.0.0 == f
]
[
	f: closure [] [()]
	unset? f
]
[
	f: closure [] ['a]
	'a == f
]
; basic test for recursive closure! invocation
[
	i: 0
	countdown: closure [n] [if n > 0 [++ i countdown n - 1]]
	countdown 10
	i = 10
]
; bug#21
[
	c: closure [a] [return a]
	1 == c 1
]
; two-function return test
[
	g: closure [f [any-function!]] [f [return 1] 2]
	1 = g :do
]
; BREAK out of a closure
[
	1 = loop 1 [
		f: closure [] [break/return 1]
		f
		2
	]
]
; THROW out of a closure
[
	1 = catch [
		f: closure [] [throw 1]
		f
		2
	]
]
; "error out" of a closure
[
	error? try [
		f: closure [] [1 / 0 2]
		f
		2
	]
]
; BREAK out leaves a "running" closure in a "clean" state
[
	1 = loop 1 [
		f: closure [x] [
			either x = 1 [
				loop 1 [f 2]
				x
			] [break/return 1]
		]
		f 1
	]
]
; THROW out leaves a "running" closure in a "clean" state
[
	1 = catch [
		f: closure [x] [
			either x = 1 [
				catch [f 2]
				x
			] [throw 1]
		]
		f 1
	]
]
; "error out" leaves a "running" closure in a "clean" state
[
	f: closure [x] [
		either x = 1 [
			error? try [f 2]
			x = 1
		] [1 / 0]
	]
	f 1
]
; bug#1659
; inline closure test
[
	f: closure [] reduce [closure [] [true]]
	f
]
; rebind test
[
	a: closure [b] [does [b]]
	b: a 1
	c: a 2
	found? all [
		1 == b
		2 == c
	]
]
; recursive closure test
[
	blk: copy []
	c: closure [a] [
		append blk 'a
		if a <> 2 [
			c 2
		]
	]
	c 1
	found? all [
		[a a] == blk
		[1 2] == reduce blk
	]
]
; bug#447
[slf: 'self do closure [x] [same? slf 'self] 1]
; bug#1528
[closure? closure [self] []]
; bug#2048
#r3only
[
	f: make closure! reduce [[x] f-body: [x + x]]
	change f-body 'x
	x: 1
	3 == f 2
]
; datatypes/datatype.r
[not datatype? 1]
[datatype! = type? action!]
[datatype? action!]
[datatype? binary!]
[datatype? bitset!]
[datatype? block!]
[datatype? char!]
#r3
[datatype? closure!]  ; closure! =? function! in R2/Forward, R2 2.7.7+
#r3only
[datatype? command!]
[datatype? datatype!]
[datatype? date!]
[datatype? decimal!]
[datatype? email!]
[datatype? error!]
[datatype? event!]
[datatype? file!]
[datatype? function!]
#r3
[datatype? get-path!]  ; get-path! =? path! in R2/Forward, R2 2.7.7+
[datatype? get-word!]
#r3only
[datatype? gob!]
#r3only
[datatype? handle!]
#r2only
[datatype? hash!]
[datatype? image!]
[datatype? integer!]
[datatype? issue!]
[datatype? library!]
#r2only
[datatype? list!]
[datatype? lit-path!]
[datatype? lit-word!]
[datatype? logic!]
#r3
[datatype? map!]  ; map! =? hash! in R2/Forward, R2 2.7.7+
#r3only
[datatype? module!]
[datatype? money!]
[datatype? native!]
[datatype? none!]
[datatype? object!]
[datatype? op!]
[datatype? pair!]
[datatype? paren!]
[datatype? path!]
#r3only
[datatype? percent!]
[datatype? port!]
[datatype? refinement!]
#r2only
[datatype? routine!]
[datatype? set-path!]
[datatype? set-word!]
[datatype? string!]
[datatype? struct!]
#r2only
[datatype? symbol!]
[datatype? tag!]
[datatype? time!]
[datatype? tuple!]
#r3
[datatype? typeset!]  ; typeset! =? block! in R2/Forward, R2 2.7.7+
[datatype? unset!]
[datatype? url!]
#r3only
[datatype? vector!]
[datatype? word!]
; alternative literal representation
[datatype? #[datatype! action!]]
; datatypes/date.r
[date? 25/Sep/2006]
[not date? 1]
[date! = type? 25/Sep/2006]
; alternative formats
[25/Sep/2006 = 25/9/2006]
[25/Sep/2006 = 25-Sep-2006]
[25/Sep/2006 = 25-9-2006]
[25/Sep/2006 = make date! "25/Sep/2006"]
[25/Sep/2006 = to date! "25-Sep-2006"]
["25-Sep-2006" = mold 25/Sep/2006]
; minimum
[date? 1/Jan/0000]
; another minimum
[date? 1/Jan/0000/0:00]
; extreme behaviour
[
	found? any [
		error? try [date-d: 1/Jan/0000 - 1]
		date-d = load mold date-d
	]
]
[
	found? any [
		error? try [date-d: 31-Dec-16383 + 1]
		date-d = load mold date-d
	]
]
; datatypes/decimal.r
[decimal? 0.0]
[not decimal? 0]
[decimal! = type? 0.0]
[decimal? 1.0]
[decimal? -1.0]
[decimal? 1.5]
; LOAD decimal and to binary! tests
; 64-bit IEEE 754 maximum
[equal? #{7FEFFFFFFFFFFFFF} to binary! 1.7976931348623157e308]
; Minimal positive normalized
[equal? #{0010000000000000} to binary! 2.2250738585072014E-308]
; Maximal positive denormalized
[equal? #{000FFFFFFFFFFFFF} to binary! 2.225073858507201E-308]
; Minimal positive denormalized
[equal? #{0000000000000001} to binary! 4.9406564584124654E-324]
; zero
[equal? #{0000000000000000} to binary! 0.0]
; negative zero
[equal? #{8000000000000000} to binary! -0.0]
; Maximal negative denormalized
[equal? #{8000000000000001} to binary! -4.9406564584124654E-324]
; Minimal negative denormalized
[equal? #{800FFFFFFFFFFFFF} to binary! -2.225073858507201E-308]
; Maximal negative normalized
[equal? #{8010000000000000} to binary! -2.2250738585072014E-308]
; 64-bit IEEE 754 minimum
[equal? #{FFEFFFFFFFFFFFFF} to binary! -1.7976931348623157e308]
; bug#729
; MOLD decimal accuracy tests
#r3only
[
	system/options/decimal-digits: 17
	system/options/decimal-digits = 17
]
; 64-bit IEEE 754 maximum
[zero? 1.7976931348623157e308 - load mold 1.7976931348623157e308]
[same? 1.7976931348623157e308 load mold 1.7976931348623157e308]
; Minimal positive normalized
[zero? 2.2250738585072014E-308 - load mold 2.2250738585072014E-308]
[same? 2.2250738585072014E-308 load mold 2.2250738585072014E-308]
; Maximal positive denormalized
[zero? 2.225073858507201E-308 - load mold 2.225073858507201E-308]
[same? 2.225073858507201E-308 load mold 2.225073858507201E-308]
; Minimal positive denormalized
[zero? 4.9406564584124654E-324 - load mold 4.9406564584124654E-324]
[same? 4.9406564584124654E-324 load mold 4.9406564584124654E-324]
; Positive zero
[zero? 0.0 - load mold 0.0]
[same? 0.0 load mold 0.0]
; Negative zero
[zero? -0.0 - load mold -0.0]
[same? -0.0 load mold -0.0]
; Maximal negative denormalized
[zero? -4.9406564584124654E-324 - load mold -4.9406564584124654E-324]
[same? -4.9406564584124654E-324 load mold -4.9406564584124654E-324]
; Minimal negative denormalized
[zero? -2.225073858507201E-308 - load mold -2.225073858507201E-308]
[same? -2.225073858507201E-308 load mold -2.225073858507201E-308]
; Maximal negative normalized
[zero? -2.2250738585072014E-308 - load mold -2.2250738585072014E-308]
[same? -2.2250738585072014E-308 load mold -2.2250738585072014E-308]
; 64-bit IEEE 754 minimum
[zero? -1.7976931348623157E308 - load mold -1.7976931348623157e308]
[same? -1.7976931348623157E308 load mold -1.7976931348623157e308]
[zero? 0.10000000000000001 - load mold 0.10000000000000001]
[same? 0.10000000000000001 load mold 0.10000000000000001]
[zero? 0.29999999999999999 - load mold 0.29999999999999999]
[same? 0.29999999999999999 load mold 0.29999999999999999]
[zero? 0.30000000000000004 - load mold 0.30000000000000004]
[same? 0.30000000000000004 load mold 0.30000000000000004]
[zero? 9.9999999999999926e152 - load mold 9.9999999999999926e152]
[same? 9.9999999999999926e152 load mold 9.9999999999999926e152]
; bug#718
[
	a: 9.9999999999999926e152 * 1e-138
	zero? a - load mold a
]
; bug#897
; MOLD/ALL decimal accuracy tests
; 64-bit IEEE 754 maximum
[zero? 1.7976931348623157e308 - load mold/all 1.7976931348623157e308]
[same? 1.7976931348623157e308 load mold/all 1.7976931348623157e308]
; Minimal positive normalized
[zero? 2.2250738585072014E-308 - load mold/all 2.2250738585072014E-308]
[same? 2.2250738585072014E-308 load mold/all 2.2250738585072014E-308]
; Maximal positive denormalized
[zero? 2.225073858507201E-308 - load mold/all 2.225073858507201E-308]
[same? 2.225073858507201E-308 load mold/all 2.225073858507201E-308]
; Minimal positive denormalized
[zero? 4.9406564584124654E-324 - load mold/all 4.9406564584124654E-324]
[same? 4.9406564584124654E-324 load mold/all 4.9406564584124654E-324]
; Positive zero
[zero? 0.0 - load mold/all 0.0]
[same? 0.0 load mold/all 0.0]
; Negative zero
[zero? -0.0 - load mold/all -0.0]
[same? -0.0 load mold/all -0.0]
; Maximal negative denormalized
[zero? -4.9406564584124654E-324 - load mold/all -4.9406564584124654E-324]
[same? -4.9406564584124654E-324 load mold/all -4.9406564584124654E-324]
; Minimal negative denormalized
[zero? -2.225073858507201E-308 - load mold/all -2.225073858507201E-308]
[same? -2.225073858507201E-308 load mold/all -2.225073858507201E-308]
; Maximal negative normalized
[zero? -2.2250738585072014E-308 - load mold/all -2.2250738585072014E-308]
[same? -2.2250738585072014E-308 load mold/all -2.2250738585072014E-308]
; 64-bit IEEE 754 minimum
[zero? -1.7976931348623157E308 - load mold/all -1.7976931348623157e308]
[same? -1.7976931348623157E308 load mold/all -1.7976931348623157e308]
[zero? 0.10000000000000001 - load mold/all 0.10000000000000001]
[same? 0.10000000000000001 load mold/all 0.10000000000000001]
[zero? 0.29999999999999999 - load mold/all 0.29999999999999999]
[same? 0.29999999999999999 load mold/all 0.29999999999999999]
[zero? 0.30000000000000004 - load mold/all 0.30000000000000004]
[same? 0.30000000000000004 load mold/all 0.30000000000000004]
[zero? 9.9999999999999926e152 - load mold/all 9.9999999999999926e152]
[same? 9.9999999999999926e152 load mold/all 9.9999999999999926e152]
; LOAD decimal accuracy tests
[equal? to binary! 2.2250738585072004e-308 #{000FFFFFFFFFFFFE}]
[equal? to binary! 2.2250738585072005e-308 #{000FFFFFFFFFFFFE}]
[equal? to binary! 2.2250738585072006e-308 #{000FFFFFFFFFFFFE}]
[equal? to binary! 2.2250738585072007e-308 #{000FFFFFFFFFFFFF}]
[equal? to binary! 2.2250738585072008e-308 #{000FFFFFFFFFFFFF}]
[equal? to binary! 2.2250738585072009e-308 #{000FFFFFFFFFFFFF}]
[equal? to binary! 2.225073858507201e-308 #{000FFFFFFFFFFFFF}]
[equal? to binary! 2.2250738585072011e-308 #{000FFFFFFFFFFFFF}]
[equal? to binary! 2.2250738585072012e-308 #{0010000000000000}]
[equal? to binary! 2.2250738585072013e-308 #{0010000000000000}]
[equal? to binary! 2.2250738585072014e-308 #{0010000000000000}]
; bug#1753
[c: last mold/all 1e16 (#"0" <= c) and (#"9" >= c)]
; alternative form
[1.1 == 1,1]
[1.1 = make decimal! 1.1]
[1.1 = make decimal! "1.1"]
[1.1 = to decimal! 1.1]
[1.1 = to decimal! "1.1"]
[error? try [to decimal! "t"]]
; decimal! to binary! and binary! to decimal!
[equal? #{3ff0000000000000} to binary! 1.0]
[same? to decimal! #{3ff0000000000000} 1.0]
; bug#747
[equal? #{3FF0000000000009} to binary! to decimal! #{3FF0000000000009}]
; bug#2256
[
	a: 0.1 + 0.1 + 0.1
	b: 0.3
	equal? (lesser? a b) or (equal? a b) lesser-or-equal? a b
]
; datatypes/email.r
[email? me@here.com]
[not email? 1]
[email! = type? me@here.com]
; "minimum"
[email? #[email! ""]]
[strict-equal? #[email! ""] make email! 0]
[strict-equal? #[email! ""] to email! ""]
[equal? mold/all #[email! ""] {#[email! ""]}]
[equal? mold/all #[email! "a"] {#[email! "a"]}]
; datatypes/error.r
[error? try [1 / 0]]
[not error? 1]
[error! = type? try [1 / 0]]
; error types
#r2only
[error? make error! [throw no-loop]]
#r2only
[error? make error! [throw no-function]]
#r2only
[error? make error! [throw no-catch]]
#r2only
[error? make error! [note no-load]]
#r2only
[error? make error! [note exited]]
#r2only
[error? make error! [syntax invalid]]
#r2only
[error? make error! [syntax missing]]
#r2only
[error? make error! [syntax header]]
#r2only
[error? make error! [script no-value]]
#r2only
[error? make error! [script need-value]]
#r2only
[error? make error! [script no-arg]]
#r2only
[error? make error! [script expect-arg]]
#r2only
[error? make error! [script expect-set]]
#r2only
[error? make error! [script invalid-arg]]
#r2only
[error? make error! [script invalid-op]]
#r2only
[error? make error! [script no-op-arg]]
#r2only
[error? make error! [script no-return]]
#r2only
[error? make error! [script not-defined]]
#r2only
[error? make error! [script no-refine]]
#r2only
[error? make error! [script invalid-path]]
#r2only
[error? make error! [script cannot-use]]
#r2only
[error? make error! [script already-used]]
#r2only
[error? make error! [script out-of-range]]
#r2only
[error? make error! [script past-end]]
#r2only
[error? make error! [script no-memory]]
#r2only
[error? make error! [script block-lines]]
#r2only
[error? make error! [script invalid-part]]
#r2only
[error? make error! [script wrong-denom]]
#r2only
[error? make error! [script else-gone]]
#r2only
[error? make error! [script bad-press]]
#r2only
[error? make error! [script bad-prompt]]
#r2only
[error? make error! [script bad-port-action]]
#r2only
[error? make error! [script needs]]
#r2only
[error? make error! [script locked-word]]
#r2only
[error? make error! [script too-many-refines]]
#r2only
[error? make error! [script dup-vars]]
#r2only
[error? make error! [script feature-na]]
#r2only
[error? make error! [script bad-bad]]
#r2only
[error? make error! [script limit-hit]]
#r2only
[error? make error! [script call-fail]]
#r2only
[error? make error! [script face-error]]
#r2only
[error? make error! [script face-reused]]
#r2only
[error? make error! [script bad-refine]]
#r2only
[error? make error! [math zero-divide]]
#r2only
[error? make error! [math overflow]]
#r2only
[error? make error! [math positive]]
#r2only
[error? make error! [access cannot-open]]
#r2only
[error? make error! [access not-open]]
#r2only
[error? make error! [access already-open]]
#r2only
[error? make error! [access already-closed]]
#r2only
[error? make error! [access read-error]]
#r2only
[error? make error! [access invalid-spec]]
#r2only
[error? make error! [access socket-open]]
#r2only
[error? make error! [access no-connect]]
#r2only
[error? make error! [access no-delete]]
#r2only
[error? make error! [access no-rename]]
#r2only
[error? make error! [access no-make-dir]]
#r2only
[error? make error! [access protocol]]
#r2only
[error? make error! [access timeout]]
#r2only
[error? make error! [access new-level]]
#r2only
[error? make error! [access security]]
#r2only
[error? make error! [access invalid-path]]
#r2only
[error? make error! [access bad-image]]
#r2only
[error? make error! [access would-block]]
#r2only
[error? make error! [access serial-timeout]]
#r2only
[error? make error! [access write-error]]
#r2only
[error? make error! [command fmt-too-short]]
#r2only
[error? make error! [command fmt-no-struct-size]]
#r2only
[error? make error! [command fmt-no-struct-align]]
#r2only
[error? make error! [command fmt-bad-word]]
#r2only
[error? make error! [command fmt-type-mismatch]]
#r2only
[error? make error! [command fmt-size-mismatch]]
#r2only
[error? make error! [command dll-arg-count]]
#r2only
[error? make error! [command empty-command]]
#r2only
[error? make error! [command db-not-open]]
#r2only
[error? make error! [command db-too-many]]
#r2only
[error? make error! [command cant-free]]
#r2only
[error? make error! [command nothing-to-free]]
#r2only
[error? make error! [command ssl-error]]
#r2only
[error? make error! [user message]]
#r2only
[error? make error! [internal bad-path]]
#r2only
[error? make error! [internal not-here]]
#r2only
[error? make error! [internal stack-overflow]]
#r2only
[error? make error! [internal globals-full]]
#r2only
[error? make error! [internal bad-internal]]
; error evaluation
#r3only
[error? do head insert copy [] try [1 / 0]]
; error that does not exist
#r3only
[try/except [make error! [type: 'script id: 'set-self]] [true]]
; throw errors cannot be made
#r3only
[try/except [make error! [type: 'throw id: 'break]] [true]]
#r3only
[try/except [make error! [type: 'throw id: 'return]] [true]]
#r3only
[try/except [make error! [type: 'throw id: 'throw]] [true]]
#r3only
[try/except [make error! [type: 'throw id: 'continue]] [true]]
#r3only
[try/except [make error! [type: 'throw id: 'halt]] [true]]
#r3only
[try/except [make error! [type: 'throw id: 'quit]] [true]]
; error types that should be predefined
#r3only
[error? make error! [type: 'note id: 'no-load]]
#r3only
[error? make error! [type: 'note id: 'exited]]
#r3only
[error? make error! [type: 'note id: 'deprecated]]
#r3only
[error? make error! [type: 'syntax id: 'invalid]]
#r3only
[error? make error! [type: 'syntax id: 'missing]]
#r3only
[error? make error! [type: 'syntax id: 'no-header]]
#r3only
[error? make error! [type: 'syntax id: 'bad-header]]
#r3only
[error? make error! [type: 'syntax id: 'bad-checksum]]
#r3only
[error? make error! [type: 'syntax id: 'malconstruct]]
#r3only
[error? make error! [type: 'syntax id: 'bad-char]]
#r3only
[error? make error! [type: 'syntax id: 'needs]]
#r3only
[error? make error! [type: 'script id: 'no-value]]
#r3only
[error? make error! [type: 'script id: 'need-value]]
#r3only
[error? make error! [type: 'script id: 'not-defined]]
#r3only
[error? make error! [type: 'script id: 'not-in-context]]
#r3only
[error? make error! [type: 'script id: 'no-arg]]
#r3only
[error? make error! [type: 'script id: 'expect-arg]]
#r3only
[error? make error! [type: 'script id: 'expect-val]]
#r3only
[error? make error! [type: 'script id: 'expect-type]]
#r3only
[error? make error! [type: 'script id: 'cannot-use]]
#r3only
[error? make error! [type: 'script id: 'invalid-arg]]
#r3only
[error? make error! [type: 'script id: 'invalid-type]]
#r3only
[error? make error! [type: 'script id: 'invalid-op]]
#r3only
[error? make error! [type: 'script id: 'no-op-arg]]
#r3only
[error? make error! [type: 'script id: 'invalid-data]]
#r3only
[error? make error! [type: 'script id: 'not-same-type]]
#r3only
[error? make error! [type: 'script id: 'not-related]]
#r3only
[error? make error! [type: 'script id: 'bad-func-def]]
#r3only
[error? make error! [type: 'script id: 'bad-func-arg]]
#r3only
[error? make error! [type: 'script id: 'no-refine]]
#r3only
[error? make error! [type: 'script id: 'bad-refines]]
#r3only
[error? make error! [type: 'script id: 'bad-refine]]
#r3only
[error? make error! [type: 'script id: 'invalid-path]]
#r3only
[error? make error! [type: 'script id: 'bad-path-type]]
#r3only
[error? make error! [type: 'script id: 'bad-path-set]]
#r3only
[error? make error! [type: 'script id: 'bad-field-set]]
#r3only
[error? make error! [type: 'script id: 'dup-vars]]
#r3only
[error? make error! [type: 'script id: 'past-end]]
#r3only
[error? make error! [type: 'script id: 'missing-arg]]
#r3only
[error? make error! [type: 'script id: 'out-of-range]]
#r3only
[error? make error! [type: 'script id: 'too-short]]
#r3only
[error? make error! [type: 'script id: 'too-long]]
#r3only
[error? make error! [type: 'script id: 'invalid-chars]]
#r3only
[error? make error! [type: 'script id: 'invalid-compare]]
#r3only
[error? make error! [type: 'script id: 'assert-failed]]
#r3only
[error? make error! [type: 'script id: 'wrong-type]]
#r3only
[error? make error! [type: 'script id: 'invalid-part]]
#r3only
[error? make error! [type: 'script id: 'type-limit]]
#r3only
[error? make error! [type: 'script id: 'size-limit]]
#r3only
[error? make error! [type: 'script id: 'no-return]]
#r3only
[error? make error! [type: 'script id: 'block-lines]]
#r3only
[error? make error! [type: 'script id: 'throw-usage]]
#r3only
[error? make error! [type: 'script id: 'locked-word]]
#r3only
[error? make error! [type: 'script id: 'protected]]
#r3only
[error? make error! [type: 'script id: 'hidden]]
#r3only
[error? make error! [type: 'script id: 'self-protected]]
#r3only
[error? make error! [type: 'script id: 'bad-bad]]
#r3only
[error? make error! [type: 'script id: 'bad-make-arg]]
#r3only
[error? make error! [type: 'script id: 'bad-decode]]
#r3only
[error? make error! [type: 'script id: 'already-used]]
#r3only
[error? make error! [type: 'script id: 'wrong-denom]]
#r3only
[error? make error! [type: 'script id: 'bad-press]]
#r3only
[error? make error! [type: 'script id: 'dialect]]
#r3only
[error? make error! [type: 'script id: 'bad-command]]
#r3only
[error? make error! [type: 'script id: 'parse-rule]]
#r3only
[error? make error! [type: 'script id: 'parse-end]]
#r3only
[error? make error! [type: 'script id: 'parse-variable]]
#r3only
[error? make error! [type: 'script id: 'parse-command]]
#r3only
[error? make error! [type: 'script id: 'parse-series]]
#r3only
[error? make error! [type: 'math id: 'zero-divide]]
#r3only
[error? make error! [type: 'math id: 'overflow]]
#r3only
[error? make error! [type: 'math id: 'positive]]
#r3only
[error? make error! [type: 'access id: 'cannot-open]]
#r3only
[error? make error! [type: 'access id: 'not-open]]
#r3only
[error? make error! [type: 'access id: 'already-open]]
#r3only
[error? make error! [type: 'access id: 'no-connect]]
#r3only
[error? make error! [type: 'access id: 'not-connected]]
#r3only
[error? make error! [type: 'access id: 'no-script]]
#r3only
[error? make error! [type: 'access id: 'no-scheme-name]]
#r3only
[error? make error! [type: 'access id: 'no-scheme]]
#r3only
[error? make error! [type: 'access id: 'invalid-spec]]
#r3only
[error? make error! [type: 'access id: 'invalid-port]]
#r3only
[error? make error! [type: 'access id: 'invalid-actor]]
#r3only
[error? make error! [type: 'access id: 'invalid-port-arg]]
#r3only
[error? make error! [type: 'access id: 'no-port-action]]
#r3only
[error? make error! [type: 'access id: 'protocol]]
#r3only
[error? make error! [type: 'access id: 'invalid-check]]
#r3only
[error? make error! [type: 'access id: 'write-error]]
#r3only
[error? make error! [type: 'access id: 'read-error]]
#r3only
[error? make error! [type: 'access id: 'read-only]]
#r3only
[error? make error! [type: 'access id: 'no-buffer]]
#r3only
[error? make error! [type: 'access id: 'timeout]]
#r3only
[error? make error! [type: 'access id: 'no-create]]
#r3only
[error? make error! [type: 'access id: 'no-delete]]
#r3only
[error? make error! [type: 'access id: 'no-rename]]
#r3only
[error? make error! [type: 'access id: 'bad-file-path]]
#r3only
[error? make error! [type: 'access id: 'bad-file-mode]]
#r3only
[error? make error! [type: 'access id: 'security]]
#r3only
[error? make error! [type: 'access id: 'security-level]]
#r3only
[error? make error! [type: 'access id: 'security-error]]
#r3only
[error? make error! [type: 'access id: 'no-codec]]
#r3only
[error? make error! [type: 'access id: 'bad-media]]
#r3only
[error? make error! [type: 'access id: 'no-extension]]
#r3only
[error? make error! [type: 'access id: 'bad-extension]]
#r3only
[error? make error! [type: 'access id: 'extension-init]]
#r3only
[error? make error! [type: 'access id: 'call-fail]]
#r3only
[error? make error! [type: 'user id: 'message]]
#r3only
[error? make error! [type: 'internal id: 'bad-path]]
#r3only
[error? make error! [type: 'internal id: 'not-here]]
#r3only
[error? make error! [type: 'internal id: 'no-memory]]
#r3only
[error? make error! [type: 'internal id: 'stack-overflow]]
#r3only
[error? make error! [type: 'internal id: 'globals-full]]
#r3only
[error? make error! [type: 'internal id: 'max-natives]]
#r3only
[error? make error! [type: 'internal id: 'bad-series]]
#r3only
[error? make error! [type: 'internal id: 'limit-hit]]
#r3only
[error? make error! [type: 'internal id: 'bad-sys-func]]
#r3only
[error? make error! [type: 'internal id: 'feature-na]]
#r3only
[error? make error! [type: 'internal id: 'not-done]]
; triggered errors should not be assignable
[a: 1 error? try [a: 1 / 0] :a =? 1]
[a: 1 error? try [set 'a 1 / 0] :a =? 1]
[a: 1 error? try [set/any 'a 1 / 0] :a =? 1]
; bug#2190
[catch/quit [attempt [catch/quit [1 / 0]] quit/return true]]
; bug#2190
[error? try [catch/quit [attempt [quit]] print x]]
; datatypes/event.r
[not event? 1]
; datatypes/file.r
[file? %myscript.r]
[not file? 1]
[file! = type? %myscript.r]
; minimum
[file? %""]
[%"" == #[file! ""]]
[%"" == make file! 0]
[%"" == to file! ""]
["%%2520" = mold to file! "%20"]
; bug#1241
[file? %"/c/Program Files (x86)"]
; datatypes/function.r
[function? does ["OK"]]
[not function? 1]
[function! = type? does ["OK"]]
; minimum
[function? does []]
; literal form
#r2only
[function? first [#[function! [] []]]]
#r3only
[function? first [#[function! [[] []]]]]
; return-less return value tests
[
	f: does []
	unset? f
]
[
	f: does [:abs]
	:abs = f
]
[
	a-value: #{}
	f: does [a-value]
	same? a-value f
]
[
	a-value: charset ""
	f: does [a-value]
	same? a-value f
]
[
	a-value: []
	f: does [a-value]
	same? a-value f
]
[
	a-value: none!
	f: does [a-value]
	same? a-value f
]
[
	f: does [1/Jan/0000]
	1/Jan/0000 = f
]
[
	f: does [0.0]
	0.0 == f
]
[
	f: does [1.0]
	1.0 == f
]
[
	a-value: me@here.com
	f: does [a-value]
	same? a-value f
]
#r3only
[
	f: does [try [1 / 0]]
	error? f
]
[
	a-value: %""
	f: does [a-value]
	same? a-value f
]
[
	a-value: does []
	f: does [:a-value]
	same? :a-value f
]
[
	a-value: first [:a]
	f: does [:a-value]
	(same? :a-value f) and (:a-value == f)
]
[
	f: does [#"^@"]
	#"^@" == f
]
[
	a-value: make image! 0x0
	f: does [a-value]
	same? a-value f
]
[
	f: does [0]
	0 == f
]
[
	f: does [1]
	1 == f
]
[
	f: does [#a]
	#a == f
]
[
	a-value: first ['a/b]
	f: does [:a-value]
	:a-value == f
]
[
	a-value: first ['a]
	f: does [:a-value]
	:a-value == f
]
[
	f: does [true]
	true = f
]
[
	f: does [false]
	false = f
]
[
	f: does [$1]
	$1 == f
]
[
	f: does [:type?]
	same? :type? f
]
[
	f: does [#[none]]
	none? f
]
[
	a-value: make object! []
	f: does [:a-value]
	same? :a-value f
]
[
	a-value: first [()]
	f: does [:a-value]
	same? :a-value f
]
[
	f: does [get '+]
	same? get '+ f
]
[
	f: does [0x0]
	0x0 == f
]
[
	a-value: 'a/b
	f: does [:a-value]
	:a-value == f
]
[
	a-value: make port! http://
	f: does [:a-value]
	port? f
]
[
	f: does [/a]
	/a == f
]
[
	a-value: first [a/b:]
	f: does [:a-value]
	:a-value == f
]
[
	a-value: first [a:]
	f: does [:a-value]
	:a-value == all [:a-value]
]
[
	a-value: ""
	f: does [:a-value]
	same? :a-value f
]
[
	a-value: make tag! ""
	f: does [:a-value]
	same? :a-value f
]
[
	f: does [0:00]
	0:00 == f
]
[
	f: does [0.0.0]
	0.0.0 == f
]
[
	f: does [()]
	unset? f
]
[
	f: does ['a]
	'a == f
]
; two-function return tests
[
	g: func [f [any-function!]] [f [return 1] 2]
	1 = g :do
]
; BREAK out of a function
[
	1 = loop 1 [
		f: does [break/return 1]
		f
		2
	]
]
; THROW out of a function
[
	1 = catch [
		f: does [throw 1]
		f
		2
	]
]
; "error out" of a function
[
	error? try [
		f: does [1 / 0 2]
		f
		2
	]
]
; BREAK out leaves a "running" function in a "clean" state
[
	1 = loop 1 [
		f: func [x] [
			either x = 1 [
				loop 1 [f 2]
				x
			] [break/return 1]
		]
		f 1
	]
]
; THROW out leaves a "running" function in a "clean" state
[
	1 = catch [
		f: func [x] [
			either x = 1 [
				catch [f 2]
				x
			] [throw 1]
		]
		f 1
	]
]
; "error out" leaves a "running" function in a "clean" state
[
	f: func [x] [
		either x = 1 [
			error? try [f 2]
			x = 1
		] [1 / 0]
	]
	f 1
]
; Argument passing of "get arguments" ("get-args")
[gf: func [:x] [:x] 10 == gf 10]
#r3only
[gf: func [:x] [:x] 'a == gf a]
[gf: func [:x] [:x] (quote 'a) == gf 'a]
[gf: func [:x] [:x] (quote :a) == gf :a]
[gf: func [:x] [:x] (quote a:) == gf a:]
[gf: func [:x] [:x] (quote (10 + 20)) == gf (10 + 20)]
[gf: func [:x] [:x] o: context [f: 10] (quote :o/f) == gf :o/f]
#r2only
[gf: func [:x] [:x] a: 10 10 == gf a]
; Argument passing of "literal arguments" ("lit-args")
[lf: func ['x] [:x] 10 == lf 10]
[lf: func ['x] [:x] 'a == lf a]
[lf: func ['x] [:x] (quote 'a) == lf 'a]
[lf: func ['x] [:x] a: 10 10 == lf :a]
[lf: func ['x] [:x] (quote a:) == lf a:]
#r3only
[lf: func ['x] [:x] 30 == lf (10 + 20)]
#r3only
[lf: func ['x] [:x] o: context [f: 10] 10 == lf :o/f]
#r2only
[lf: func ['x] [:x] (quote (10 + 20)) == lf (10 + 20)]
#r2only
[lf: func ['x] [:x] (quote :o/f) == lf :o/f]
; basic test for recursive function! invocation
[i: 0 countdown: func [n] [if n > 0 [++ i countdown n - 1]] countdown 10 i = 10]
; a function-local word that escapes the function's dynamic extent still works
; when re-entering the dynamic extent of the same function later.
[
	f: func [code value] [either none? code ['value] [do code]]
	f-value: f none none
	42 == f compose [2 * (f-value)] 21  ; re-entering same function
]
[
	f: func [code value] [either none? code ['value] [do code]]
	g: func [code value] [either none? code ['value] [do code]]
	f-value: f none none
	error? try [g compose [2 * (f-value)] 21]  ; re-entering different function
]
; bug#19
[
	f: func [/r x] [x]
	2 == f/r/r 1 2
]
; bug#27
#r3only
[error? try [(type?) 1]]
; bug#1659
; inline function test
[
	f: does reduce [does [true]]
	f
]
; no-rebind test
[
	a: func [b] [a: none c: b]
	f: func [d] [a [d] do c]
	found? all [
		1 = f 1
		2 = f 2
	]
]
; bug#1528
[function? func [self] []]
; bug#1756
#r3only
[do does [reduce reduce [:self] true]]
; bug#2025
#r3only
[
	body: [x + y]
	f: make function! reduce [[x] body]
	g: make function! reduce [[y] body]
	error? try [f 1]
]
; bug#2044
[
	o: make object! [f: func [x] ['x]]
	p: make o []
	not same? o/f 1 p/f 1
]
; datatypes/get-path.r
; minimum
; bug#1947
; empty get-path test
#r3only
[get-path? load "#[get-path! []]"]
#r3only
[get-path? load "#[get-path! [a]]"]
#r3only
[equal? mold/all load "#[get-path! []]" "#[get-path! []]"]
#r3only
[equal? mold/all load "#[get-path! [a]]" "#[get-path! [a]]"]
#r3only
[
	all [
		get-path? a: load "#[get-path! [a b c] 2]"
		2 == index? a
	]
]
; datatypes/get-word.r
[get-word? first [:a]]
[not get-word? 1]
[get-word! = type? first [:a]]
#r2only
[
	; context-less get-word
	e: disarm try [do to block! ":a"]
	e/id = 'not-defined
]
#r3only
[
	; context-less get-word
	e: try [do to block! ":a"]
	e/id = 'not-defined
]
; behaviour for REBOL datatypes; unset
#r2only
[
	unset 'a
	e: disarm try [:a]
	e/id = 'no-value
]
#r3only
[
	unset 'a
	unset? :a
]
; bug#1477
[get-word? first [:/]]
[get-word? first [://]]
[get-word? first [:///]]
; datatypes/gob.r
; minimum
#r3only
[gob? make gob! []]
#r3only
[gob! = type? make gob! []]
; bug#62
#r3only
[
	g: make gob! []
	1x1 == g/offset: 1x1
]
; bug#1969
#r3only
[
	g1: make gob! []
	g2: make gob! []
	insert g1 g2
	same? g1 g2/parent
	do "g1: none"
	do "recycle"
	g3: make gob! []
	insert g2/parent g3
	true
]
; bug#1989
#r3only
[
	loop 30000000 [make gob! []]
	true
]
#r3only
[
	main: make gob! []
	foreach i [31 325 1] [
		clear main
		recycle
		loop i [
			append main make gob! []
		]
	]
	true
]
; datatypes/hash.r
#r2only
; minimum
[hash? make hash! []]
#r2only
[not hash? 1]
#r2only
[hash! = type? make hash! []]
; datatypes/image.r
[image? make image! 100x100]
[not image? 1]
[image! = type? make image! 0x0]
; minimum
[image? #[image! 0x0 #{}]]
[equal? load mold/all #[image! 0x0 #{}] #[image! 0x0 #{}]]
; default colours
#r2only
[
	a-value: #[image! 1x1 #{}]
	equal? pick a-value 0x0 0.0.0.0
]
#r3only
[
	a-value: #[image! 1x1 #{}]
	equal? pick a-value 0x0 0.0.0.255
]
; datatypes/integer.r
[integer? 0]
; bug#33
[integer? -0]
[not integer? 1.1]
[integer! = type? 0]
[integer? 1]
[integer? -1]
[integer? 2]
; 32-bit minimum for two's complement representation
[integer? -2147483648]
; 32-bit maximum
[integer? 2147483647]
; 64-bit minimum for two's complement representation
#64bit
[integer? -9223372036854775808]
; 64-bit maximum
#64bit
[integer? 9223372036854775807]
[0 == make integer! 0]
[0 == make integer! "0"]
[0 == to integer! 0]
[
	; decimal! to 32-bit integer minimum
	-2147483648 == to integer! -2147483648.0
]
[
	; decimal! to 32-bit integer minimum
	-2147483648 == to integer! -2147483648.9
]
[
	; decimal! to 32-bit integer maximum
	2147483647 == to integer! 2147483647.9
]
#32bit
[error? try [to integer! -2147483649.0]]
#32bit
[error? try [to integer! 2147483648.0]]
#64-bit
[to integer! -9223372036854775808.0]
#64-bit
[to integer! 9223372036854775807.0]
; bug#921
[error? try [to integer! -9.223372036854778e+18]]
[error? try [to integer! 9.223372036854778e+18]]
[0 == to integer! "0"]
[error? try [to integer! false]]
[error? try [to integer! true]]
[0 == to integer! #"^@"]
[1 == to integer! #"^a"]
[0 == to integer! #0]
[1 == to integer! #1]
[0 == to integer! #{00}]
[1 == to integer! #{01}]
; -1 for 32-bit two's complement representation
#32bit
[-1 == to integer! #{ffffffff}]
; -1 for 64-bit two's complement representation
#64bit
[-1 == to integer! #{ffffffffffffffff}]
#64bit
[302961000000 == to integer! "3.02961E+11"]
[error? try [to integer! "t"]]
["0" = mold 0]
["1" = mold 1]
["-1" = mold -1]
; datatypes/issue.r
[issue? #aa]
[not issue? 1]
[issue! = type? #aa]
; minimum
#r2only
[issue? #]
#r2only
[# == #[issue! ""]]
#r2only
[# == make issue! 0]
#r2only
[# == to issue! ""]
[issue? #a]
; datatypes/library.r
[
	success: library? a-library: load/library case [
		; this needs to be system-specific
		system/version/4 = 2 [%libc.dylib]					; OSX
		system/version/4 = 3 [%kernel32.dll]					; Windows
		all [system/version/4 = 4 system/version/5 = 2] [%/lib/libc.so.6]	; Linux libc6
		system/version/4 = 4 [%libc.so]						; Linux
		system/version/4 = 7 [%libc.so]						; FreeBSD
		system/version/4 = 8 [%libc.so]						; NetBSD
		system/version/4 = 9 [%libc.so]						; OpenBSD
		system/version/4 = 10 [%libc.so]					; Solaris
	]
	free a-library
	success
]
; datatypes/list.r
#r2only
[list? make list! []]
#r2only
[not list? 1]
#r2only
[list! = type? make list! []]
; datatypes/lit-path.r
[lit-path? first ['a/b]]
[not lit-path? 1]
[lit-path! = type? first ['a/b]]
; minimum
; bug#1947
[lit-path? load "#[lit-path! []]"]
[lit-path? load "#[lit-path! [a]]"]
[equal? mold/all load "#[lit-path! []]" "#[lit-path! []]"]
[equal? mold/all load "#[lit-path! [a]]" "#[lit-path! [a]]"]
[
	all [
		lit-path? a: load "#[lit-path! [a b c] 2]"
		2 == index? a
	]
]
; lit-paths are active
[
	a-value: first ['a/b]
	strict-equal? to path! :a-value do reduce [:a-value]
]
; datatypes/lit-word.r
[lit-word? first ['a]]
[not lit-word? 1]
[lit-word! = type? first ['a]]
; lit-words are active
[
	a-value: first ['a]
	strict-equal? to word! :a-value do reduce [:a-value]
]
; bug#1477
[word? '/]
[word? '//]
[word? '///]
; bug#1342
[word? '<]
[word? '>]
[word? '<=]
[word? '>=]
[word? '<>]
; datatypes/logic.r
[logic? true]
[logic? false]
[not logic? 1]
[logic! = type? true]
[logic! = type? false]
[true = #[true]]
[false = #[false]]
[on = true]
[off = false]
[yes = true]
[no = false]
[false = make logic! 0]
[true = make logic! 1]
[true = to logic! 0]
[true = to logic! 1]
[false = to logic! none]
[true = to logic! "f"]
["true" = mold true]
["false" = mold false]
; datatypes/map.r
; map! =? hash! in R2/Forward, R2 2.7.7+
#r3
[empty? make map! []]
#r3
[empty? make map! 4]
#r3only
; The length of a map is the number of key/value pairs it holds.
[2 == length? make map! [a 1 b 2]]  ; 4 in R2, R2/Forward
#r3
[m: make map! [a 1 b 2] 1 == m/a]
#r3
[m: make map! [a 1 b 2] 2 == m/b]
#r3only
[m: make map! [a 1 b 2] none? m/c]
#r3only
[m: make map! [a 1 b 2] m/c: 3 3 == m/c]
; Maps contain key/value pairs and must be created from blocks of even length.
#r3only
[error? try [make map! [1]]]
#r3
[empty? clear make map! [a 1 b 2]]
; bug#1930: Lookup crashes on empty hashed map.
#r3only
[m: make map! 8 clear m none? m/a]
; append to a map string key
#r3only
[
	res: true
	b: copy []
	k: copy "key"
	append b k
	append b copy "value"
	m: make map! b
	if "value" <> select m "key" [res: false]
	append k "chain"
	if none <> select m "keychain" [res: false]
	if "value" <> select m "key" [res: false]
	res
]
; datatypes/module.r
#r3only
[module? make module! [[] []]]
#r3only
[not module? 1]
#r3only
[module! = type? make module! [[] []]]
#r3only
[
	a-module: make module! [
		[]
		[
			; 'var will be in the module
			var: 1
		]
	]
	var: 2
	1 == a-module/var
]
; import test
#r3only
[
	a-module: make module! [
		[
			exports: [var]
		]

		[
			var: 2
		]
	]
	import a-module
	2 == var
]
; import test
#r3only
[
	var: 1
	a-module: make module! [
		[
			exports: [var]
		]

		[
			var: 2
		]
	]
	import a-module
	1 == var
]
; datatypes/money.r
[money? $0.0]
[not money? 0]
[money! = type? $0.0]
[money? $1.0]
[money? -$1.0]
[money? $1.5]
[money? USD$1]
[money? CZK$1]
; moldable maximum for R2
[money? $999999999999999.87]
; moldable minimum for R2
[money? -$999999999999999.87]
; check, whether these are moldable
[
	x: $999999999999999
	found? any [
		error? try [x: x + $1]
		not error? try [mold x]
	]
]
[
	x: -$999999999999999
	found? any [
		error? try [x: x - $1]
		not error? try [mold x]
	]
]
; alternative form
[$1.1 == $1,1]
[
	found? any [
		error? try [x: $1234567890123456]
		not error? try [mold x]
	]
]
[$11 = make money! 11]
[$1.1 = make money! "1.1"]
; bug#4
[$11 = to money! 11]
[$1.1 = to money! "1.1"]
["$1.10" = mold $1.10]
["-$1.10" = mold -$1.10]
#r3only
["$0" = mold $0]
; equality
[$1 = $1.0000000000000000000000000]
[not $1 = $2]
#r3only
; maximum for R3
[equal? $99999999999999999999999999e127 $99999999999999999999999999e127]
#r3only
; minimum for R3
[equal? -$99999999999999999999999999e127 -$99999999999999999999999999e127]
#r3only
[not $0 = $1e-128]
#r3only
[not $0 = -$1e-128]
; inequality
[not $1 <> $1]
[$1 <= $2]
[not $2 <= $1]
#r3only
[not zero? $1e-128]
#r3only
[not zero? -$1e-128]
; positive? tests
[not positive? negate $0]
#r3only
[positive? $1e-128]
#r3only
[not positive? -$1e-128]
[not negative? negate $0]
#r3only
[not negative? $1e-128]
#r3only
[negative? -$1e-128]
; same? tests
[same? $0 $0]
[same? $0 negate $0]
[same? $1 $1]
#r3only
[not same? $1 $1.0]
#r3only
["$1.0000000000000000000000000" = mold $2.0000000000000000000000000 - $1]
#r3only
["$1" = mold $2 - $1]
#r3only
["$1" = mold $1 * $1]
#r3only
["$4" = mold $2 * $2]
#r3only
["$1.0000000000000000000000000" = mold $1 * $1.0000000000000000000000000]
#r3only
["$1.0000000000000000000000000" = mold $1.0000000000000000000000000 * $1.0000000000000000000000000]
; division uses "full precision"
#r3only
["$1.0000000000000000000000000" = mold $1 / $1]
#r3only
["$1.0000000000000000000000000" = mold $1 / $1.0]
#r3only
["$1.0000000000000000000000000" = mold $1 / $1.000]
#r3only
["$1.0000000000000000000000000" = mold $1 / $1.000000]
#r3only
["$1.0000000000000000000000000" = mold $1 / $1.000000000]
#r3only
["$1.0000000000000000000000000" = mold $1 / $1.000000000000]
#r3only
["$1.0000000000000000000000000" = mold $1 / $1.0000000000000000000000000]
#r3only
["$0.10000000000000000000000000" = mold $1 / $10]
#r3only
["$0.33333333333333333333333333" = mold $1 / $3]
#r3only
["$0.66666666666666666666666667" = mold $2 / $3]
; conversion to integer
#r3only
[1 = to integer! $1]
#r3only
#64bit
[-9223372036854775808 == to integer! -$9223372036854775808.99]
#r3only
#64bit
[9223372036854775807 == to integer! $9223372036854775807.99]
; conversion to decimal
#r3only
[1.0 = to decimal! $1]
#r3only
[zero? 0.3 - to decimal! $0.3]
#r3only
[zero? 0.1 - to decimal! $0.1]
#r3only
[
	x: 9.9999999999999981e152
	zero? x - to decimal! to money! x
]
#r3only
[
	x: -9.9999999999999981e152
	zero? x - to decimal! to money! x
]
#r3only
[
	x: 9.9999999999999926E152
	zero? x - to decimal! to money! x
]
#r3only
[
	x: -9.9999999999999926E152
	zero? x - to decimal! to money! x
]
#r3only
[
	x: 9.9999999999999293E152
	zero? x - to decimal! to money! x
]
#r3only
[
	x: -9.9999999999999293E152
	zero? x - to decimal! to money! x
]
#r3only
[
	x: to decimal! $1e-128
	zero? x - to decimal! to money! x
]
#r3only
[
	x: to decimal! -$1e-128
	zero? x - to decimal! to money! x
]
#r3only
[
	x: 9.2233720368547758E18
	zero? x - to decimal! to money! x
]
#r3only
[
	x: -9.2233720368547758E18
	zero? x - to decimal! to money! x
]
#r3only
[
	x: 9.2233720368547748E18
	zero? x - to decimal! to money! x
]
#r3only
[
	x: -9.2233720368547748E18
	zero? x - to decimal! to money! x
]
#r3only
[
	x: 9.2233720368547779E18
	zero? x - to decimal! to money! x
]
#r3only
[
	x: -9.2233720368547779E18
	zero? x - to decimal! to money! x
]
; datatypes/native.r
[native? :type?]
[not native? 1]
[native! = type? :type?]
; bug#1659
; natives are active
[same? none! do reduce [:type? make none! none]]
; datatypes/none.r
[none? none]
[not none? 1]
[none! = type? none]
; literal form
[none = #[none]]
; bug#845
[none = #[none!]]
#r3only
[none = #]
[none = make none! none]
[none = to none! none]
[none = to none! 1]
["none" = mold none]
; bug#1666
; bug#1650
[
	f: does [#]
	# == f
]
; datatypes/object.r
[object? make object! [x: 1]]
[not object? 1]
[object! = type? make object! [x: 1]]
; minimum
[object? make object! []]
; literal form
[object? #[object! []]]
; local words
[
	x: 1
	make object! [x: 2]
	x = 1
]
; BREAK out of make object!
; bug#846
[
	1 = loop 1 [
		make object! [break/return 1]
		2
	]
]
; THROW out of make object!
; bug#847
[
	1 = catch [
		make object! [throw 1]
		2
	]
]
; "error out" of make object!
[
	error? try [
		make object! [1 / 0]
		2
	]
]
; RETURN out of make object!
; bug#848
[
	f: func [] [
		make object! [return 1]
		2
	]
	1 = f
]
; object cloning
; bug#2045
[
	a: 1
	f: func [] [a]
	g: :f
	o: make object! [a: 2 g: :f]
	p: make o [a: 3]
	1 == p/g
]
; object cloning
; bug#2045
[
	a: 1
	b: [a]
	c: b
	o: make object! [a: 2 c: b]
	p: make o [a: 3]
	1 == do p/c
]
; object cloning
; bug#2050
[
    o: make object! [n: 'o b: reduce [func [] [n]]]
	p: make o [n: 'p]
	o/b/1 = 'o
]
; multiple inheritance
; bug#1863
[
	o1: make object! [a: 1 f: does [a]]
	o2: make object! [a: 2]
	o3: make o1 o2
	2 == o3/f
]
; object cloning
; bug#2049
[
	o: make object! [n: 'o f: closure [] [n]]
	p: make o [n: 'p]
	'p = p/f
]
; appending to objects
; bug#1979
#r3only
[
	o: make object! []
	append o [b: 1 b: 2]
	1 == length? words-of o
]
#r3only
[
	o: make object! [b: 0]
	append o [b: 1 b: 2]
	1 == length? words-of o
]
#r3only
[
	o: make object! []
	c: "c"
	append o compose [b: "b" b: (c)]
	same? c o/b
]
#r3only
[
	o: make object! [b: "a"]
	c: "c"
	append o compose [b: "b" b: (c)]
	same? c o/b
]
#r3only
[
	o: make object! []
	error? try [append o 'self]
]
#r3only
[
	o: make object! []
	error? try [append o [self: 1]]
]
; bug#2076
#r3only
[
	o: bound? use [x] ['x]
	2 == length? words-of append o 'self
]
; bug#2076
#r3only
[
	o: bound? use [x] ['x]
	2 == length? words-of append o [self: 1]
]
; datatypes/op.r
[op? get '+]
[not op? 1]
[op! = type? get '+]
#r2only
[3 == do reduce [get '+ 1 2]]
#r3only
[error? try [do reduce [get '+ 1 2]]]
; bug#1934
#r3only
[3 = do reduce [1 :+ 2]]
; datatypes/pair.r
[pair? 1x2]
[not pair? 1]
[pair! = type? 1x2]
[1x1 = make pair! 1]
[1x2 = make pair! [1 2]]
[1x1 = to pair! 1]
; bug#17
[error? try [to pair! [0.4]]]
[1x2 = to pair! [1 2]]
["1x1" = mold 1x1]
; minimum
[pair? -2147483648x-2147483648]
; maximum
[pair? 2147483647x2147483647]
; datatypes/paren.r
[paren? first [(1 + 1)]]
[not paren? 1]
; minimum
[paren! = type? first [()]]
; alternative literal form
[strict-equal? first [()] first [#[paren! []]]]
[strict-equal? first [()] make paren! 0]
[strict-equal? first [()] to paren! []]
["()" == mold first [()]]
; parens are active
[
	a-value: first [(1)]
	1 == do reduce [:a-value]
]
; finite recursion
[
	num1: 4
	num2: 1
	fact: to paren! [either num1 = 1 [num2] [num2: num1 * num2 num1: num1 - 1]]
	insert/only tail last fact fact
	24 = do fact
]
; bug#1665
; infinite recursion
[
	fact: to paren! []
	insert/only fact fact
	error? try [do fact]
]
; datatypes/path.r
[path? 'a/b]
['a/b == first [a/b]]
[not path? 1]
[path! = type? 'a/b]
; the minimum
; bug#1947
[path? load "#[path! []]"]
[path? load "#[path! [a]]"]
[equal? mold/all load "#[path! []]" "#[path! []]"]
[equal? mold/all load "#[path! [a]]" "#[path! [a]]"]
[
	all [
		path? a: load "#[path! [a b c] 2]"
		2 == index? a
	]
]
["a/b" = mold 'a/b]
[
	a-word: 1
	data: #{0201}
	2 = data/:a-word
]
[
	blk: reduce [:abs 2]
	2 == blk/:abs
]
[
	blk: [#{} 2]
	2 == blk/#{}
]
[
	blk: reduce [charset "a" 3]
	3 == do reduce [to path! reduce ['blk charset "a"]]
]
[
	blk: [[] 3]
	3 == blk/#[block! []]
]
[
	blk: [#[none] 3]
	3 == do [blk/#[none]]
]
[
	blk: [none 3]
	3 == do [blk/none]
]
[
	a-value: 1/Jan/0000
	0 == a-value/1
]
[
	a-value: me@here.com
	#"m" == a-value/1
]
#r3only
[
	a-value: make error! ""
	a-value/type = 'user
]
[
	a-value: func [/local a] [a]
	1 == a-value/local 1
]
#r2only
[
	a-value: make image! 1x1
	0.0.0.0 == a-value/1
]
#r3only
[
	a-value: make image! 1x1
	0.0.0.255 == a-value/1
]
#r2only
[
	a-value: #2
	#"2" == a-value/1
]
[
	a-value: first ['a/b]
	'a == a-value/1
]
[
	a-value: USD$1
	"USD" = a-value/1
]
[
	a-value: make object! [a: 1]
	1 == a-value/a
]
[
	a-value: 2x3
	2 = a-value/1
]
[
	a-value: first [(2)]
	2 == a-value/1
]
[
	a-value: 'a/b
	'a == a-value/1
]
#r2only
[
	a-value: make port! http://
	none? a-value/user-data
]
#r3only
[
	a-value: make port! http://
	none? a-value/data
]
[
	a-value: first [a/b:]
	'a == a-value/1
]
[
	a-value: "12"
	#"1" == a-value/1
]
[
	a-value: <tag>
	#"t" == a-value/1
]
[
	a-value: 2:03
	2 == a-value/1
]
[
	a-value: 1.2.3
	1 == a-value/1
]
[
	a-value: file://a
	file://a/1 = a-value/1
]
; calling functions through paths: function in object
[
	obj: make object! [fun: func [] [1]]
	1 == obj/fun
]
[
	obj: make object! [fun: func [/ref val] [val]]
	1 == obj/fun/ref 1
]
; calling functions through paths: function in block, positional
[
	blk: reduce [func [] [10]  func [] [20]]
	10 == blk/1
]
; calling functions through paths: function in block, "named"
[
	blk: reduce ['foo func [] [10]  'bar func [] [20]]
	20 == blk/bar
]
; bug#26
[
	b: [b 1]
	1 = b/b
]
; path evaluation order
[
	a: 1x2
	found? any [
		error? try [b: a/(a: [3 4] 1)]
		b = 1
		b = 3
	]
]
; recursive path
[
	a: make object! []
	path: 'a/a
	change/only back tail path path
	error? try [do path]
	true
]
; bug#71
[
	a: "abcd"
	error? try [a/x]
]
; bug#1820: Word USER can't be selected with path syntax
[
	b: [user 1 _user 2]
	1 = b/user
]
; bug#1977
#r3only
[f: func [/r] [1] error? try [f/r/%]]
; datatypes/percent.r
#r3only
[percent? 0%]
#r3only
[not percent? 1]
#r3only
[percent! = type? 0%]
#r3only
[percent? 0.0%]
#r3only
[percent? 1%]
#r3only
[percent? -1.0%]
#r3only
[percent? 2.2%]
#r3only
[0% = make percent! 0]
#r3only
[0% = make percent! "0"]
#r3only
[0% = to percent! 0]
#r3only
[0% = to percent! "0"]
#r3only
[100% = to percent! 1]
#r3only
[10% = to percent! 0.1]
#r3only
[error? try [to percent! "t"]]
#r3only
[0 = to decimal! 0%]
#r3only
[0.1 = to decimal! 10%]
#r3only
[1.0 = to decimal! 100%]
#r3only
[0% = load mold 0.0%]
#r3only
[1% = load mold 1.0%]
#r3only
[1.1% = load mold 1.1%]
#r3only
[-1% = load mold -1.0%]
; bug#57
#r3only
[-5% = negate 5%]
; bug#57
#r3only
[10% = (5% + 5%)]
; bug#57
#r3only
[6% = round 5.55%]
; bug#97
#r3only
[$59.0 = (10% * $590)]
; bug#97
#r3only
[$100.6 = ($100 + 60%)]
; 64-bit IEEE 754 maximum
; bug#1475
#r3only
[same? 1.7976931348623157e310% load mold/all 1.7976931348623157e310%]
; bug#1475
; 64-bit IEEE 754 minimum
#r3only
[same? -1.7976931348623157E310% load mold/all -1.7976931348623157e310%]
; Minimal positive normalized
#r3only
[same? 2.2250738585072014E-310% load mold/all 2.2250738585072014E-310%]
; Maximal positive denormalized
#r3only
[same? 2.2250738585072009E-310% load mold/all 2.2250738585072009E-310%]
; Minimal positive denormalized
#r3only
[same? 4.9406564584124654E-322% load mold/all 4.9406564584124654E-322%]
; Maximal negative normalized
#r3only
[same? -2.2250738585072014E-306% load mold/all -2.2250738585072014E-306%]
; Minimal negative denormalized
#r3only
[same? -2.2250738585072009E-306% load mold/all -2.2250738585072009E-306%]
; Maximal negative denormalized
#r3only
[same? -4.9406564584124654E-322% load mold/all -4.9406564584124654E-322%]
#r3only
[same? 10.000000000000001% load mold/all 10.000000000000001%]
#r3only
[same? 29.999999999999999% load mold/all 29.999999999999999%]
#r3only
[same? 30.000000000000004% load mold/all 30.000000000000004%]
#r3only
[same? 9.9999999999999926e154% load mold/all 9.9999999999999926e154%]
; alternative form
#r3only
[1.1% == 1,1%]
#r3only
[110% = make percent! 110%]
#r3only
[110% = make percent! "110%"]
#r3only
[1.1% = to percent! 1.1%]
#r3only
[1.1% = to percent! "1.1%"]
; datatypes/port.r
[port? make port! http://]
[not port? 1]
[port! = type? make port! http://]
; datatypes/refinement.r
[refinement? /a]
[not refinement? 1]
[refinement! = type? /a]
; datatypes/routine.r
#r2only
[
	success: routine? case [
		; this needs to be system-specific
		system/version/4 = 2 [							; OSX
			a-library: load/library %libc.dylib
			make routine! [
				tv [struct! []]
				tz [struct! []]
				return: [integer!]
			] a-library "settimeofday"
		]
		system/version/4 = 3 [							; Windows
			a-library: load/library %kernel32.dll
			make routine! [
				systemtime [struct! []]
				return: [int]
			] a-library "SetSystemTime"
		]
		all [system/version/4 = 4 system/version/5 = 2] [			; Linux libc6
			a-library: %/lib/libc.so.6
			make routine! [
				tv [struct! []]
				tz [struct! []]
				return: [integer!]
			] a-library "settimeofday"
		]
		system/version/4 = 4 [							; Linux
			a-library: load/library %libc.so
			make routine! [
				tv [struct! []]
				tz [struct! []]
				return: [integer!]
			] a-library "settimeofday"
		]
		system/version/4 = 7 [							; FreeBSD
			a-library: load/library %libc.so
			make routine! [
				tv [struct! []]
				tz [struct! []]
				return: [integer!]
			] a-library "settimeofday"
		]
		system/version/4 = 8 [							; NetBSD
			a-library: load/library %libc.so
			make routine! [
				tv [struct! []]
				tz [struct! []]
				return: [integer!]
			] a-library "settimeofday"
		]
		system/version/4 = 9 [							; OpenBSD
			a-library: load/library %libc.so
			make routine! [
				tv [struct! []]
				tz [struct! []]
				return: [integer!]
			] a-library "settimeofday"
		]
		system/version/4 = 10 [							; Solaris
			a-library: load/library %libc.so
			make routine! [
				tv [struct! []]
				tz [struct! []]
				return: [integer!]
			] a-library "settimeofday"
		]
	]
	free a-library
	success
]
; datatypes/set-path.r
[set-path? first [a/b:]]
[not set-path? 1]
[set-path! = type? first [a/b:]]
; the minimum
; bug#1947
[set-path? load "#[set-path! []]"]
[set-path? load "#[set-path! [a]]"]
[equal? mold/all load "#[set-path! []]" "#[set-path! []]"]
[equal? mold/all load "#[set-path! [a]]" "#[set-path! [a]]"]
[
	all [
		set-path? a: load "#[set-path! [a b c] 2]"
		2 == index? a
	]
]
["a/b:" = mold first [a/b:]]
; set-paths are active
[
	a: make object! [b: none]
	a/b: 5
	5 == a/b
]
; bug#1
[
	o: make object! [a: 0x0]
    o/a/x: 71830
	o/a/x = 71830
]
; set-path evaluation order
[
	a: 1x2
	a/x: (a: [x 4] 3)
	found? any [
		a == 3x2
		a == [x 3]
	]
]
; bug#64
[
	blk: [1]
	i: 1
	blk/:i: 2
	blk = [2]
]
; datatypes/set-word.r
[set-word? first [a:]]
[not set-word? 1]
[set-word! = type? first [a:]]
; set-word is active
[
	a: :abs
	equal? :a :abs
]
[
	a: #{}
	equal? :a #{}
]
[
	a: charset ""
	equal? :a charset ""
]
[
	a: []
	equal? a []
]
[
	a: action!
	equal? :a action!
]
; bug#1477
[set-word? first [/:]]
[set-word? first [//:]]
[set-word? first [///:]]
; bug#1817
#r3only
[
	a: make map! []
	a/b: make object! [
		c: make map! []
	]
	integer? a/b/c/d: 1
]
; datatypes/string.r
[string? "ahoj"]
[not string? 1]
[string! = type? "ahoj"]
; minimum
[string? ""]
; alternative literal form
["" == #[string! ""]]
["" == make string! 0]
["^@" = "^(00)"]
["^A" = "^(01)"]
["^B" = "^(02)"]
["^C" = "^(03)"]
["^D" = "^(04)"]
["^E" = "^(05)"]
["^F" = "^(06)"]
["^G" = "^(07)"]
["^H" = "^(08)"]
["^I" = "^(09)"]
["^J" = "^(0A)"]
["^K" = "^(0B)"]
["^L" = "^(0C)"]
["^M" = "^(0D)"]
["^N" = "^(0E)"]
["^O" = "^(0F)"]
["^P" = "^(10)"]
["^Q" = "^(11)"]
["^R" = "^(12)"]
["^S" = "^(13)"]
["^T" = "^(14)"]
["^U" = "^(15)"]
["^V" = "^(16)"]
["^W" = "^(17)"]
["^X" = "^(18)"]
["^Y" = "^(19)"]
["^Z" = "^(1A)"]
["^[" = "^(1B)"]
["^\" = "^(1C)"]
["^]" = "^(1D)"]
["^!" = "^(1E)"]
["^_" = "^(1F)"]
[" " = "^(20)"]
["!" = "^(21)"]
["^"" = "^(22)"]
["#" = "^(23)"]
["$" = "^(24)"]
["%" = "^(25)"]
["&" = "^(26)"]
["'" = "^(27)"]
["(" = "^(28)"]
[")" = "^(29)"]
["*" = "^(2A)"]
["+" = "^(2B)"]
["," = "^(2C)"]
["-" = "^(2D)"]
["." = "^(2E)"]
["/" = "^(2F)"]
["0" = "^(30)"]
["1" = "^(31)"]
["2" = "^(32)"]
["3" = "^(33)"]
["4" = "^(34)"]
["5" = "^(35)"]
["6" = "^(36)"]
["7" = "^(37)"]
["8" = "^(38)"]
["9" = "^(39)"]
[":" = "^(3A)"]
[";" = "^(3B)"]
["<" = "^(3C)"]
["=" = "^(3D)"]
[">" = "^(3E)"]
["?" = "^(3F)"]
["@" = "^(40)"]
["A" = "^(41)"]
["B" = "^(42)"]
["C" = "^(43)"]
["D" = "^(44)"]
["E" = "^(45)"]
["F" = "^(46)"]
["G" = "^(47)"]
["H" = "^(48)"]
["I" = "^(49)"]
["J" = "^(4A)"]
["K" = "^(4B)"]
["L" = "^(4C)"]
["M" = "^(4D)"]
["N" = "^(4E)"]
["O" = "^(4F)"]
["P" = "^(50)"]
["Q" = "^(51)"]
["R" = "^(52)"]
["S" = "^(53)"]
["T" = "^(54)"]
["U" = "^(55)"]
["V" = "^(56)"]
["W" = "^(57)"]
["X" = "^(58)"]
["Y" = "^(59)"]
["Z" = "^(5A)"]
["[" = "^(5B)"]
["\" = "^(5C)"]
["]" = "^(5D)"]
["^^" = "^(5E)"]
["_" = "^(5F)"]
["`" = "^(60)"]
["a" = "^(61)"]
["b" = "^(62)"]
["c" = "^(63)"]
["d" = "^(64)"]
["e" = "^(65)"]
["f" = "^(66)"]
["g" = "^(67)"]
["h" = "^(68)"]
["i" = "^(69)"]
["j" = "^(6A)"]
["k" = "^(6B)"]
["l" = "^(6C)"]
["m" = "^(6D)"]
["n" = "^(6E)"]
["o" = "^(6F)"]
["p" = "^(70)"]
["q" = "^(71)"]
["r" = "^(72)"]
["s" = "^(73)"]
["t" = "^(74)"]
["u" = "^(75)"]
["v" = "^(76)"]
["w" = "^(77)"]
["x" = "^(78)"]
["y" = "^(79)"]
["z" = "^(7A)"]
["{" = "^(7B)"]
["|" = "^(7C)"]
["}" = "^(7D)"]
["~" = "^(7E)"]
["^~" = "^(7F)"]
["^(null)" = "^(00)"]
["^(line)" = "^(0A)"]
["^/" = "^(0A)"]
["^(tab)" = "^(09)"]
["^-" = "^(09)"]
["^(page)" = "^(0C)"]
["^(esc)" = "^(1B)"]
["^(back)" = "^(08)"]
["^(del)" = "^(7f)"]
["ahoj" = #[string! "ahoj"]]
["1" = to string! 1]
[{""} = mold ""]
; datatypes/struct.r
[struct? make struct! [i [integer!]] none]
[not struct? 1]
[struct! = type? make struct! [] none]
; minimum
[struct? make struct! [] none]
; literal form
[struct? #[struct! [] []]]
[
	s: make string! 15
	addr: func [s] [copy third make struct! [s [string!]] reduce [s]]
	(addr s) = (addr insert/dup s #"0" 15)
]
[false = not make struct! [] none]
[
	a-value: make struct! [] none
	f: does [:a-value]
	same? third :a-value third f
]
[
	a-value: make struct! [i [integer!]] [1]
	1 == a-value/i
]
[
	a-value: make struct! [] none
	same? third :a-value third all [:a-value]
]
[
	a-value: make struct! [] none
	same? third :a-value third all [true :a-value]
]
[
	a-value: make struct! [] none
	true = all [:a-value true]
]
[
	a-value: make struct! [] none
	same? third :a-value third do reduce [:a-value]
]
[
	a-value: make struct! [] none
	same? third :a-value third do :a-value
]
[if make struct! [] none [true]]
[
	a-value: make struct! [] none
	same? third :a-value third any [:a-value]
]
[
	a-value: make struct! [] none
	same? third :a-value third any [false :a-value]
]
[
	a-value: make struct! [] none
	same? third :a-value third any [:a-value false]
]
; datatypes/symbol.r
#r2only
[symbol! = type? make symbol! "xx"]
; datatypes/tag.r
[tag? <tag>]
[not tag? 1]
[tag! = type? <tag>]
; minimum
[tag? #[tag! ""]]
[strict-equal? #[tag! ""] make tag! 0]
[strict-equal? #[tag! ""] to tag! ""]
["<tag>" == mold <tag>]
; bug#2169
["<ēee>" == mold <ēee>]
[equal? mold/all #[tag! ""] {#[tag! ""]}]
; datatypes/time.r
[time? 0:00]
[not time? 1]
[time! = type? 0:00]
[0:0:10 = make time! 10]
[0:0:10 = to time! 10]
[error? try [to time! "a"]]
["0:00" = mold 0:00]
; small value
[
	found? any [
		error? try [t: -596522:0:0 - 1:00]
		t = load mold t
	]
]
; big value
[
	found? any [
		error? try [t: 596522:0:0 + 1:00]
		t = load mold t
	]
]
; strange value
[error? try [load "--596523:-14:-07.772224"]]
; minimal time
[time? load "-596523:14:07.999999999"]
; maximal negative time
[negative? -0:0:0.000000001]
; minimal positive time
[positive? 0:0:0.000000001]
; maximal time
[time? 596523:14:07.999999999]
; bug#96
[
    time: 1:23:45.6
    1:23:45.7 = (time + 0.1)
]
; bug#96
[
    time: 1:23:45.6
    0:41:52.8 = (time * .5)
]
[
	; time overflow?
	found? any [
		error? try [596522:14:07.999999999 + 1:00:0.000000001]
		greater? 596522:14:07.999999999 + 1:00:0.000000001 596522:14:07.999999999 + 1:00:00
	]
]
[
	; time maximum?
	found? any [
		error? try [596522:14:07.999999998 + 1:00:0.000000001]
		greater? 596522:14:07.999999998 + 1:00:0.000000001 596522:14:07.999999999 + 1:00:00
	]
]
; datatypes/tuple.r
[tuple? 1.2.3]
[not tuple? 1]
[tuple! = type? 1.2.3]
[1.2.3 = to tuple! [1 2 3]]
["1.2.3" = mold 1.2.3]
; minimum
[tuple? make tuple! []]
; maximum
[tuple? 255.255.255.255.255.255.255.255.255.255]
[error? try [load "255.255.255.255.255.255.255.255.255.255.255"]]
; datatypes/typeset.r
#r2only
[datatype? any-block!]
#r3only
[typeset? any-block!]
#r3
[typeset? to-typeset any-block!]
#r2only
[datatype? any-function!]
#r3only
[typeset? any-function!]
#r3
[typeset? to-typeset any-function!]
#r3
[typeset? any-path!]
#r3
[typeset? to-typeset any-path!]
#r3
[typeset? any-object!]
#r3
[typeset? to-typeset any-object!]
#r2only
[datatype? any-string!]
#r3only
[typeset? any-string!]
#r3
[typeset? to-typeset any-string!]
#r2only
[datatype? any-word!]
#r3only
[typeset? any-word!]
#r3
[typeset? to-typeset any-word!]
#r3
[typeset? immediate!]
#r3
[typeset? to-typeset immediate!]
#r3
[typeset? internal!]
#r3
[typeset? to-typeset internal!]
#r2only
[datatype? number!]
#r3only
[typeset? number!]
#r3
[typeset? to-typeset number!]
#r3
[typeset? scalar!]
#r3
[typeset? to-typeset scalar!]
#r2only
[datatype? series!]
#r3only
[typeset? series!]
#r3
[typeset? to-typeset series!]
#r3only
[typeset? make typeset! [integer! none!]]
#r3
[typeset? make typeset! reduce [integer! none!]]
#r3
[typeset? to-typeset [integer! none!]]
#r3only
[typeset! = type? series!]
; bug#92
[
    x: to typeset! []
    not x = now
]
; datatypes/unset.r
[unset? ()]
[unset! == type? ()]
[not unset? 1]
; bug#836
[unset? #[unset!]]
#r3only
[unset? make unset! none]
; bug#68
#r3only
[unset? to unset! none]
#r3only
[unset? to unset! 1]
[error? try [a: ()]]
[not error? try [set/any 'a ()]]
; datatypes/url.r
[url? http://www.fm.tul.cz/~ladislav/rebol]
[not url? 1]
[url! = type? http://www.fm.tul.cz/~ladislav/rebol]
; minimum; alternative literal form
[url? #[url! ""]]
[strict-equal? #[url! ""] make url! 0]
[strict-equal? #[url! ""] to url! ""]
["http://" = mold http://]
["http://a%2520b" = mold http://a%2520b]
[equal? mold/all #[url! ""] {#[url! ""]}]
[equal? mold/all #[url! "a"] {#[url! "a"]}]
; bug#2011
[url? http://a.b.c/d?e=f%26]
[url? http://a.b.c/d?e=f&]
[not equal? http://a.b.c/d?e=f%26 http://a.b.c/d?e=f&]
; bug#2013
[url? http://a.b.c/d?e=č]
[url? http://a.b.c/d?e=%c4%8d]
[equal? http://a.b.c/d?e=%c4%8d http://a.b.c/d?e=č]
; datatypes/vector.r
#r3only
[vector? make vector! 0]
#r3only
[vector? make vector! [integer! 8]]
#r3only
[vector? make vector! [integer! 16]]
#r3only
[vector? make vector! [integer! 32]]
#r3only
[vector? make vector! [integer! 64]]
#r3only
[0 = length? make vector! 0]
#r3only
[1 = length? make vector! 1]
#r3only
[1 = length? make vector! [integer! 32]]
#r3only
[2 = length? make vector! 2]
#r3only
[2 = length? make vector! [integer! 32 2]]
; bug#1538
#r3only
[10 = length? make vector! 10.5]
; bug#1213
#r3only
[error? try [make vector! -1]]
#r3only
[0 = first make vector! [integer! 32]]
#r3only
[all map-each x make vector! [integer! 32 16] [zero? x]]
#r3only
[
	v: make vector! [integer! 32 3]
	v/1: 10
	v/2: 20
	v/3: 30
	v = make vector! [integer! 32 [10 20 30]]
]
; datatypes/word.r
[word? 'a]
[not word? 1]
[word! = type? 'a]
; literal form
[word? first [a]]
; transitivity, bug#2251
[
	not all [
		lesser-or-equal? 'C 'a
		lesser-or-equal? 'c 'C
		not lesser-or-equal? 'c 'a
	]
]
; words are active
[
	a-value: #{}
	same? :a-value a-value
]
[
	a-value: charset ""
	same? :a-value a-value
]
[
	a-value: []
	same? :a-value a-value
]
[
	a-value: none!
	same? :a-value a-value
]
[
	a-value: 1/Jan/0000
	same? :a-value a-value
]
[
	a-value: 0.0
	:a-value == a-value
]
[
	a-value: 1.0
	:a-value == a-value
]
[
	a-value: me@here.com
	same? :a-value a-value
]
#r2only
[
	error? a-value: try [1 / 0]
	same? disarm :a-value disarm a-value
]
#r3only
[
	error? a-value: try [1 / 0]
	same? :a-value a-value
]
[
	a-value: %""
	same? :a-value a-value
]
; functions are word-active
[
	a-value: does [1]
	1 == a-value
]
[
	a-value: first [:a]
	:a-value == a-value
]
[
	a-value: #"^@"
	:a-value == a-value
]
[
	a-value: make image! 0x0
	same? :a-value a-value
]
[
	a-value: 0
	:a-value == a-value
]
[
	a-value: 1
	:a-value == a-value
]
[
	a-value: #
	same? :a-value a-value
]
; lit-paths are word-active
#r2only
[
	a-value: first ['a/b]
	a-value == to path! :a-value
]
; lit-paths aren't word-active
#r3only
[
	a-value: first ['a/b]
	a-value == :a-value
]
; lit-words are word-active
[
	a-value: first ['a]
	a-value == to word! :a-value
]
[:true == true]
[:false == false]
[
	a-value: $1
	:a-value == a-value
]
; natives are word-active
[native! == type? :type?]
[:none == none]
; library test?
[
	a-value: make object! []
	same? :a-value a-value
]
[
	a-value: first [()]
	same? :a-value a-value
]
; ops are word-active
#r2only
[
	a-value: get '+
	3 == a-value 1 2
]
#r3only
[
	a-value: get '+
	1 a-value 2 == 3
]
[
	a-value: 0x0
	:a-value == a-value
]
[
	a-value: 'a/b
	:a-value == a-value
]
[
	a-value: make port! http://
	port? a-value
]
[
	a-value: /a
	:a-value == a-value
]
; set-paths are not word-active
[
	a-value: first [a/b:]
	:a-value == a-value
]
[
	a-value: first [a:]
	:a-value == a-value
]
[
	a-value: ""
	same? :a-value a-value
]
#r2only
[
	a-value: make struct! [] none
	same? third :a-value third a-value
]
[
	a-value: make tag! ""
	same? :a-value a-value
]
[
	a-value: 0:00
	same? :a-value a-value
]
[
	a-value: 0.0.0
	same? :a-value a-value
]
#r2only
[
	unset 'a-value
	e: disarm try [a-value]
	e/id = 'no-value
]
#r3only
[
	unset 'a-value
	e: try [a-value]
	e/id = 'no-value
]
[
	a-value: 'a
	:a-value == a-value
]
; functions/comparison/lesserq.r
; integer -9223372036854775808 < x tests
#64bit
[not -9223372036854775808 < -9223372036854775808]
#64bit
[-9223372036854775808 < -9223372036854775807]
#64bit
[-9223372036854775808 < -2147483648]
#64bit
[-9223372036854775808 < -1]
#64bit
[-9223372036854775808 < 0]
; bug#2054
#64bit
[-9223372036854775808 < 1]
#64bit
[-9223372036854775808 < 9223372036854775806]
#64bit
[-9223372036854775808 < 9223372036854775807]
; integer -9223372036854775807 < x tests
#64bit
[not -9223372036854775807 < -9223372036854775808]
#64bit
[not -9223372036854775807 < -9223372036854775807]
#64bit
[-9223372036854775807 < -1]
#64bit
[-9223372036854775807 < 0]
#64bit
[-9223372036854775807 < 1]
#64bit
[-9223372036854775807 < 9223372036854775806]
#64bit
[-9223372036854775807 < 9223372036854775807]
; integer -2147483648 < x tests
[not -2147483648 < -2147483648]
[-2147483648 < -1]
[-2147483648 < 0]
[-2147483648 < 1]
[-2147483648 < 2147483647]
; integer -1 < x tests
#64bit
[not -1 < -9223372036854775808]
#64bit
[not -1 < -9223372036854775807]
[not -1 < -1]
[-1 < 0]
[-1 < 1]
#64bit
[-1 < 9223372036854775806]
#64bit
[-1 < 9223372036854775807]
; integer 0 < x tests
#64bit
[not 0 < -9223372036854775808]
#64bit
[not 0 < -9223372036854775807]
[not 0 < -1]
[not 0 < 0]
[0 < 1]
#64bit
[0 < 9223372036854775806]
#64bit
[0 < 9223372036854775807]
; integer 1 < x tests
#64bit
[not 1 < -9223372036854775808]
#64bit
[not 1 < -9223372036854775807]
[not 1 < -1]
[not 1 < 0]
[not 1 < 1]
#64bit
[1 < 9223372036854775806]
#64bit
[1 < 9223372036854775807]
; integer 2147483647 < x tests
[not 2147483647 < -2147483648]
[not 2147483647 < -1]
[not 2147483647 < 0]
[not 2147483647 < 1]
[not 2147483647 < 2147483647]
; integer 9223372036854775806 < x tests
#64bit
[not 9223372036854775806 < -9223372036854775808]
#64bit
[not 9223372036854775806 < -9223372036854775807]
#64bit
[not 9223372036854775806 < -1]
#64bit
[not 9223372036854775806 < 0]
#64bit
[not 9223372036854775806 < 1]
#64bit
[not 9223372036854775806 < 9223372036854775806]
#64bit
[9223372036854775806 < 9223372036854775807]
; integer 9223372036854775807 < x tests
#64bit
[not 9223372036854775807 < -9223372036854775808]
#64bit
[not 9223372036854775807 < -9223372036854775807]
#64bit
[not 9223372036854775807 < -1]
#64bit
[not 9223372036854775807 < 0]
#64bit
[not 9223372036854775807 < 1]
#64bit
[not 9223372036854775807 < 9223372036854775806]
#64bit
[not 9223372036854775807 < 9223372036854775807]
; decimal < integer
[not 1.1 < 1]
[1.0 < 2147483647]
[not -1.0 < -2147483648]
; integer < decimal
[1 < 1.1]
[not 2147483647 < 1.0]
[-2147483648 < -1.0]
; -1.7976931348623157e308 < decimal
[not -1.7976931348623157e308 < -1.7976931348623157e308]
[-1.7976931348623157e308 < -1.0]
[-1.7976931348623157e308 < -4.94065645841247E-324]
[-1.7976931348623157e308 < 0.0]
[-1.7976931348623157e308 < 4.94065645841247E-324]
[-1.7976931348623157e308 < 1.0]
[-1.7976931348623157e308 < 1.7976931348623157e308]
; -1.0 < decimal
[not -1.0 < -1.7976931348623157e308]
[not -1.0 < -1.0]
[-1.0 < -4.94065645841247E-324]
[-1.0 < 0.0]
[-1.0 < 4.94065645841247E-324]
[-1.0 < 1.0]
[-1.0 < 1.7976931348623157e308]
; -4.94065645841247E-324 < decimal
[not -4.94065645841247E-324 < -1.7976931348623157e308]
[not -4.94065645841247E-324 < -1.0]
[not -4.94065645841247E-324 < -4.94065645841247E-324]
[-4.94065645841247E-324 < 0.0]
[-4.94065645841247E-324 < 4.94065645841247E-324]
[-4.94065645841247E-324 < 1.0]
[-4.94065645841247E-324 < 1.7976931348623157e308]
; 0.0 < decimal
[not 0.0 < -1.7976931348623157e308]
[not 0.0 < -1.0]
[not 0.0 < -4.94065645841247E-324]
[not 0.0 < 0.0]
[0.0 < 4.94065645841247E-324]
[0.0 < 1.0]
[0.0 < 1.7976931348623157e308]
; 4.94065645841247E-324 < decimal
[not 4.94065645841247E-324 < -1.7976931348623157e308]
[not 4.94065645841247E-324 < -1.0]
[not 4.94065645841247E-324 < -4.94065645841247E-324]
[not 4.94065645841247E-324 < 0.0]
[not 4.94065645841247E-324 < 4.94065645841247E-324]
[4.94065645841247E-324 < 1.0]
[4.94065645841247E-324 < 1.7976931348623157e308]
; 1.0 < decimal
[not 1.0 < -1.7976931348623157e308]
[not 1.0 < -1.0]
[not 1.0 < -4.94065645841247E-324]
[not 1.0 < 0.0]
[not 1.0 < 4.94065645841247E-324]
[not 1.0 < 1.0]
[1.0 < 1.7976931348623157e308]
; 1.7976931348623157e308 < decimal
[not 1.7976931348623157e308 < -1.7976931348623157e308]
[not 1.7976931348623157e308 < -1.0]
[not 1.7976931348623157e308 < -4.94065645841247E-324]
[not 1.7976931348623157e308 < 0.0]
[not 1.7976931348623157e308 < 4.94065645841247E-324]
[not 1.7976931348623157e308 < 1.0]
[not 1.7976931348623157e308 < 1.7976931348623157e308]
; char
[not #"^(00)" < #"^(00)"]
[#"^(00)" < #"^(01)"]
[#"^(00)" < #"^(ff)"]
[not #"^(01)" < #"^(00)"]
[not #"^(01)" < #"^(01)"]
[#"^(01)" < #"^(ff)"]
[not #"^(ff)" < #"^(00)"]
[not #"^(ff)" < #"^(01)"]
[not #"^(ff)" < #"^(ff)"]
; tuple
[not 0.0.0 < 0.0.0]
[0.0.0 < 0.0.1]
[0.0.0 < 0.0.255]
[not 0.0.1 < 0.0.0]
[not 0.0.1 < 0.0.1]
[0.0.1 < 0.0.255]
[not 0.0.255 < 0.0.0]
[not 0.0.255 < 0.0.1]
[not 0.0.255 < 0.0.255]
; functions/comparison/maximum-of.r
; bug#8
[3 = first maximum-of [1 2 3]]
; functions/comparison/equalq.r
; reflexivity test for native!
[equal? :abs :abs]
[not equal? :abs :add]
[equal? :all :all]
[not equal? :all :any]
; reflexivity test for op!
[equal? :+ :+]
[not equal? :+ :-]
; reflexivity test for function!
; Uses func instead of make function! so the test is compatible.
[equal? a-value: func [] [] :a-value]
; No structural equivalence for function!
; Uses FUNC instead of make function! so the test is compatible.
[not equal? func [] [] func [] []]
; reflexivity test for closure!
; Uses CLOSURE to make the test compatible.
[equal? a-value: closure [] [] :a-value]
; No structural equivalence for closure!
; Uses CLOSURE to make the test compatible.
[not equal? closure [] [] closure [] []]
[equal? a-value: #{00} a-value]
; binary!
; Same contents
[equal? #{00} #{00}]
; Different contents
[not equal? #{00} #{01}]
; Offset + similar contents at reference
[equal? #{00} #[binary! #{0000} 2]]
; Offset + similar contents at reference
[equal? #{00} #[binary! #{0100} 2]]
[equal? equal? #{00} #[binary! #{0100} 2] equal? #[binary! #{0100} 2] #{00}]
; No binary! padding
[not equal? #{00} #{0000}]
[equal? equal? #{00} #{0000} equal? #{0000} #{00}]
; Empty binary! not none
[not equal? #{} none]
[equal? equal? #{} none equal? none #{}]
; case sensitivity
; bug#1459
[not-equal? #{0141} #{0161}]
; email! vs. string!
; RAMBO #3518
#r3only
[
	a-value: to email! ""
	equal? a-value to string! a-value
]
; email! vs. string! symmetry
[
	a-value: to email! ""
	equal? equal? to string! a-value a-value equal? a-value to string! a-value
]
; file! vs. string!
; RAMBO #3518
#r3only
[
	a-value: %""
	equal? a-value to string! a-value
]
; file! vs. string! symmetry
[
	a-value: %""
	equal? equal? a-value to string! a-value equal? to string! a-value a-value
]
; image! same contents
[equal? a-value: #[image! 1x1 #{000000}] a-value]
[equal? #[image! 1x1 #{000000}] #[image! 1x1 #{000000}]]
[equal? #[image! 1x1 #{}] #[image! 1x1 #{000000}]]
; image! different size
[not equal? #[image! 1x2 #{000000}] #[image! 1x1 #{000000}]]
; image! different size
[not equal? #[image! 2x1 #{000000}] #[image! 1x1 #{000000}]]
; image! different rgb
[not equal? #[image! 1x1 #{000001}] #[image! 1x1 #{000000}]]
; image! alpha not specified = 0
#r2only
[equal? #[image! 1x1 #{000000} #{00}] #[image! 1x1 #{000000}]]
; image! alpha not specified = ff
#r3only
[equal? #[image! 1x1 #{000000} #{ff}] #[image! 1x1 #{000000}]]
; image! alpha different
[not equal? #[image! 1x1 #{000000} #{01}] #[image! 1x1 #{000000} #{00}]]
; Literal offset not supported in R2.
#r3only
[equal? #[image! 1x1 #{000000} 2] #[image! 1x1 #{000000} 2]]
; Literal offset not supported in R2.
#r3only
[not equal? #[image! 1x1 #{000000} 2] #[image! 1x1 #{000000}]]
[
	a-value: #[image! 1x1 #{000000}]
	not equal? a-value next a-value
]
; image! offset + structural equivalence
#r3only
[equal? #[image! 0x0 #{}] next #[image! 1x1 #{000000}]]
; image! offset + structural equivalence
#r3only
[equal? #[image! 1x0 #{}] next #[image! 1x1 #{000000}]]
; image! offset + structural equivalence
#r3only
[equal? #[image! 0x1 #{}] next #[image! 1x1 #{000000}]]
; image! offset + structural equivalence
#r2
[not equal? #[image! 0x0 #{}] next #[image! 1x1 #{000000}]]
; image! offset + structural equivalence
#r2
[not equal? #[image! 1x0 #{}] next #[image! 1x1 #{000000}]]
; image! offset + structural equivalence
#r2
[not equal? #[image! 0x1 #{}] next #[image! 1x1 #{000000}]]
; No implicit to binary! from image!
[not equal? #{00} #[image! 1x1 #{000000}]]
; No implicit to binary! from image!
[not equal? #{00000000} #[image! 1x1 #{000000}]]
; No implicit to binary! from image!
[not equal? #{0000000000} #[image! 1x1 #{000000}]]
[equal? equal? #{00} #[image! 1x1 #{00}] equal? #[image! 1x1 #{00}] #{00}]
; No implicit to binary! from integer!
[not equal? #{00} to integer! #{00}]
[equal? equal? #{00} to integer! #{00} equal? to integer! #{00} #{00}]
; issue! vs. string!
; RAMBO #3518
#r3only
[not-equal? a-value: #a to string! a-value]
[
	a-value: #a
	equal? equal? a-value to string! a-value equal? to string! a-value a-value
]
; No implicit to binary! from string!
[not equal? a-value: "" to binary! a-value]
[
	a-value: ""
	equal? equal? a-value to binary! a-value equal? to binary! a-value a-value
]
; tag! vs. string!
; RAMBO #3518
#r3only
[equal? a-value: to tag! "" to string! a-value]
[
	a-value: to tag! ""
	equal? equal? a-value to string! a-value equal? to string! a-value a-value
]
[equal? 0.0.0 0.0.0]
[not equal? 0.0.1 0.0.0]
; tuple! right-pads with 0
[equal? 1.0.0 1.0.0.0.0.0.0.0.0.0]
; tuple! right-pads with 0
[equal? 1.0.0.0.0.0.0.0.0.0 1.0.0]
; tuple! right-pads with 0
[not equal? 1.0.0 0.0.0.0.0.0.0.1.0.0]
; No implicit to binary! from tuple!
[
	a-value: 0.0.0.0
	not equal? to binary! a-value a-value
]
[
	a-value: 0.0.0.0
	equal? equal? to binary! a-value a-value equal? a-value to binary! a-value
]
[equal? #[bitset! #{00}] #[bitset! #{00}]]
; bitset! with no bits set does not equal empty bitset
; This is because of the COMPLEMENT problem: bug#1085.
[not equal? #[bitset! #{}] #[bitset! #{00}]]
; No implicit to binary! from bitset!
[not equal? #{00} #[bitset! #{00}]]
[equal? equal? #[bitset! #{00}] #{00} equal? #{00} #[bitset! #{00}]]
[equal? [] []]
[equal? a-value: [] a-value]
; Reflexivity for past-tail blocks
; Error in R2.
#r3only
[
	a-value: tail [1]
	clear head a-value
	equal? a-value a-value
]
; Reflexivity for cyclic blocks
[
	a-value: copy []
	insert/only a-value a-value
	equal? a-value a-value
]
; bug#1049
; Comparison of cyclic blocks
[
	a-value: copy []
	insert/only a-value a-value
	b-value: copy []
	insert/only b-value b-value
	error? try [equal? a-value b-value]
	true
]
[not equal? [] none]
[equal? equal? [] none equal? none []]
; block! vs. paren!
[not equal? [] first [()]]
; block! vs. paren! symmetry
[equal? equal? [] first [()] equal? first [()] []]
; block! vs. path!
[not equal? [a b] 'a/b]
; block! vs. path! symmetry
[
	a-value: 'a/b
	b-value: [a b]
	equal? equal? :a-value :b-value equal? :b-value :a-value
]
; block! vs. lit-path!
[not equal? [a b] first ['a/b]]
; block! vs. lit-path! symmetry
[
	a-value: first ['a/b]
	b-value: [a b]
	equal? equal? :a-value :b-value equal? :b-value :a-value
]
; block! vs. set-path!
[not equal? [a b] first [a/b:]]
; block! vs. set-path! symmetry
[
	a-value: first [a/b:]
	b-value: [a b]
	equal? equal? :a-value :b-value equal? :b-value :a-value
]
; block! vs. get-path!
[not equal? [a b] first [:a/b]]
; block! vs. get-path! symmetry
[
	a-value: first [:a/b]
	b-value: [a b]
	equal? equal? :a-value :b-value equal? :b-value :a-value
]
[equal? decimal! decimal!]
[not equal? decimal! integer!]
[equal? equal? decimal! integer! equal? integer! decimal!]
; datatype! vs. typeset!
[not equal? number! integer!]
; datatype! vs. typeset! symmetry
[equal? equal? number! integer! equal? integer! number!]
; datatype! vs. typeset!
#r3only
[not equal? integer! make typeset! [integer!]]
; datatype! vs. typeset!
#r3only
[not equal? integer! to typeset! [integer!]]
; datatype! vs. typeset!
; Supported by R2/Forward.
#r3
[not equal? integer! to-typeset [integer!]]
; typeset! (or pseudo-type in R2)
[equal? number! number!]
; typeset! (or pseudo-type in R2)
[not equal? number! series!]
#r3only
[equal? make typeset! [integer!] make typeset! [integer!]]
#r3only
[equal? to typeset! [integer!] to typeset! [integer!]]
; Supported by R2/Forward.
#r3
[equal? to-typeset [integer!] to-typeset [integer!]]
[equal? -1 -1]
[equal? 0 0]
[equal? 1 1]
[equal? 0.0 0.0]
[equal? 0.0 -0.0]
[equal? 1.0 1.0]
[equal? -1.0 -1.0]
#64bit
[equal? -9223372036854775808 -9223372036854775808]
#64bit
[equal? -9223372036854775807 -9223372036854775807]
#64bit
[equal? 9223372036854775807 9223372036854775807]
#64bit
[not equal? -9223372036854775808 -9223372036854775807]
#64bit
[not equal? -9223372036854775808 -1]
#64bit
[not equal? -9223372036854775808 0]
#64bit
[not equal? -9223372036854775808 1]
#64bit
[not equal? -9223372036854775808 9223372036854775806]
#64bit
[not equal? -9223372036854775807 -9223372036854775808]
#64bit
[not equal? -9223372036854775807 -1]
#64bit
[not equal? -9223372036854775807 0]
#64bit
[not equal? -9223372036854775807 1]
#64bit
[not equal? -9223372036854775807 9223372036854775806]
#64bit
[not equal? -9223372036854775807 9223372036854775807]
#64bit
[not equal? -1 -9223372036854775808]
#64bit
[not equal? -1 -9223372036854775807]
[not equal? -1 0]
[not equal? -1 1]
#64bit
[not equal? -1 9223372036854775806]
#64bit
[not equal? -1 9223372036854775807]
#64bit
[not equal? 0 -9223372036854775808]
#64bit
[not equal? 0 -9223372036854775807]
[not equal? 0 -1]
[not equal? 0 1]
#64bit
[not equal? 0 9223372036854775806]
#64bit
[not equal? 0 9223372036854775807]
#64bit
[not equal? 1 -9223372036854775808]
#64bit
[not equal? 1 -9223372036854775807]
[not equal? 1 -1]
[not equal? 1 0]
#64bit
[not equal? 1 9223372036854775806]
#64bit
[not equal? 1 9223372036854775807]
#64bit
[not equal? 9223372036854775806 -9223372036854775808]
#64bit
[not equal? 9223372036854775806 -9223372036854775807]
#64bit
[not equal? 9223372036854775806 -1]
#64bit
[not equal? 9223372036854775806 0]
#64bit
[not equal? 9223372036854775806 1]
#64bit
[not equal? 9223372036854775806 9223372036854775807]
#64bit
[not equal? 9223372036854775807 -9223372036854775808]
#64bit
[not equal? 9223372036854775807 -9223372036854775807]
#64bit
[not equal? 9223372036854775807 -1]
#64bit
[not equal? 9223372036854775807 0]
#64bit
[not equal? 9223372036854775807 1]
#64bit
[not equal? 9223372036854775807 9223372036854775806]
; decimal! approximate equality
[equal? 0.3 0.1 + 0.1 + 0.1]
; decimal! approximate equality symmetry
[equal? equal? 0.3 0.1 + 0.1 + 0.1 equal? 0.1 + 0.1 + 0.1 0.3]
[equal? 0.15 - 0.05 0.1]
[equal? equal? 0.15 - 0.05 0.1 equal? 0.1 0.15 - 0.05]
[equal? -0.5 cosine 120]
[equal? equal? -0.5 cosine 120 equal? cosine 120 -0.5]
[equal? 0.5 * square-root 2.0 sine 45]
[equal? equal? 0.5 * square-root 2.0 sine 45 equal? sine 45 0.5 * square-root 2.0]
[equal? 0.5 sine 30]
[equal? equal? 0.5 sine 30 equal? sine 30 0.5]
[equal? 0.5 cosine 60]
[equal? equal? 0.5 cosine 60 equal? cosine 60 0.5]
[equal? 0.5 * square-root 3.0 sine 60]
[equal? equal? 0.5 * square-root 3.0 sine 60 equal? sine 60 0.5 * square-root 3.0]
[equal? 0.5 * square-root 3.0 cosine 30]
[equal? equal? 0.5 * square-root 3.0 cosine 30 equal? cosine 30 0.5 * square-root 3.0]
[equal? square-root 3.0 tangent 60]
[equal? equal? square-root 3.0 tangent 60 equal? tangent 60 square-root 3.0]
[equal? (square-root 3.0) / 3.0 tangent 30]
[equal? equal? (square-root 3.0) / 3.0 tangent 30 equal? tangent 30 (square-root 3.0) / 3.0]
[equal? 1.0 tangent 45]
[equal? equal? 1.0 tangent 45 equal? tangent 45 1.0]
[
	num: square-root 2.0
	equal? 2.0 num * num
]
[
	num: square-root 2.0
	equal? equal? 2.0 num * num equal? num * num 2.0
]
[
	num: square-root 3.0
	equal? 3.0 num * num
]
[
	num: square-root 3.0
	equal? equal? 3.0 num * num equal? num * num 3.0
]
; integer! vs. decimal!
[equal? 0 0.0]
; integer! vs. money!
[equal? 0 $0]
; integer! vs. percent!
#r3only
[equal? 0 0%]
; decimal! vs. money!
[equal? 0.0 $0]
; decimal! vs. percent!
#r3only
[equal? 0.0 0%]
; money! vs. percent!
#r3only
[equal? $0 0%]
; integer! vs. decimal! symmetry
[equal? equal? 1 1.0 equal? 1.0 1]
; integer! vs. money! symmetry
[equal? equal? 1 $1 equal? $1 1]
; integer! vs. percent! symmetry
#r3only
[equal? equal? 1 100% equal? 100% 1]
; decimal! vs. money! symmetry
[equal? equal? 1.0 $1 equal? $1 1.0]
; decimal! vs. percent! symmetry
#r3only
[equal? equal? 1.0 100% equal? 100% 1.0]
; money! vs. percent! symmetry
#r3only
[equal? equal? $1 100% equal? 100% $1]
; percent! approximate equality
#r3only
[equal? 10% + 10% + 10% 30%]
; percent! approximate equality symmetry
#r3only
[equal? equal? 10% + 10% + 10% 30% equal? 30% 10% + 10% + 10%]
[equal? 2-Jul-2009 2-Jul-2009]
; date! ignores time portion
#r2only
[equal? 2-Jul-2009 2-Jul-2009/22:20]
; date! doesn't ignore time portion
#r3only
[not equal? 2-Jul-2009 2-Jul-2009/22:20]
[equal? equal? 2-Jul-2009 2-Jul-2009/22:20 equal? 2-Jul-2009/22:20 2-Jul-2009]
; date! missing time and zone = 00:00:00+00:00
[equal? 2-Jul-2009 2-Jul-2009/00:00:00+00:00]
[equal? equal? 2-Jul-2009 2-Jul-2009/00:00 equal? 2-Jul-2009/00:00 2-Jul-2009]
; Timezone math in date!
[equal? 2-Jul-2009/22:20 2-Jul-2009/20:20-2:00]
[equal? 00:00 00:00]
; time! missing components are 0
[equal? 0:0 00:00:00.0000000000]
[equal? equal? 0:0 00:00:00.0000000000 equal? 00:00:00.0000000000 0:0]
; time! vs. integer!
; bug#1103
[not equal? 0:00 0]
; integer! vs. time!
; bug#1103
[not equal? 0 00:00]
[equal? #"a" #"a"]
; char! vs. integer!
; No implicit to char! from integer! in R3.
#r3only
[not equal? #"a" 97]
; char! vs. integer! symmetry
[equal? equal? #"a" 97 equal? 97 #"a"]
; char! vs. decimal!
; No implicit to char! from decimal! in R3.
#r3only
[not equal? #"a" 97.0]
; char! vs. decimal! symmetry
[equal? equal? #"a" 97.0 equal? 97.0 #"a"]
; char! case
#r3only
[equal? #"a" #"A"]
; string! case
[equal? "a" "A"]
; issue! case
[equal? #a #A]
; tag! case
[equal? <a a="a"> <A A="A">]
; url! case
[equal? http://a.com httP://A.coM]
; email! case
[equal? a@a.com A@A.Com]
[equal? 'a 'a]
[equal? 'a 'A]
[equal? equal? 'a 'A equal? 'A 'a]
; word binding
[equal? 'a use [a] ['a]]
; word binding symmetry
[equal? equal? 'a use [a] ['a] equal? use [a] ['a] 'a]
; word! vs. get-word!
[equal? 'a first [:a]]
; word! vs. get-word! symmetry
[equal? equal? 'a first [:a] equal? first [:a] 'a]
; {word! vs. lit-word!
[equal? 'a first ['a]]
; word! vs. lit-word! symmetry
[equal? equal? 'a first ['a] equal? first ['a] 'a]
; word! vs. refinement!
[equal? 'a /a]
; word! vs. refinement! symmetry
[equal? equal? 'a /a equal? /a 'a]
; word! vs. set-word!
[equal? 'a first [a:]]
; word! vs. set-word! symmetry
[equal? equal? 'a first [a:] equal? first [a:] 'a]
; get-word! reflexivity
[equal? first [:a] first [:a]]
; get-word! vs. lit-word!
[equal? first [:a] first ['a]]
; get-word! vs. lit-word! symmetry
[equal? equal? first [:a] first ['a] equal? first ['a] first [:a]]
; get-word! vs. refinement!
[equal? first [:a] /a]
; get-word! vs. refinement! symmetry
[equal? equal? first [:a] /a equal? /a first [:a]]
; get-word! vs. set-word!
[equal? first [:a] first [a:]]
; get-word! vs. set-word! symmetry
[equal? equal? first [:a] first [a:] equal? first [a:] first [:a]]
; lit-word! reflexivity
[equal? first ['a] first ['a]]
; lit-word! vs. refinement!
[equal? first ['a] /a]
; lit-word! vs. refinement! symmetry
[equal? equal? first ['a] /a equal? /a first ['a]]
; lit-word! vs. set-word!
[equal? first ['a] first [a:]]
; lit-word! vs. set-word! symmetry
[equal? equal? first ['a] first [a:] equal? first [a:] first ['a]]
; refinement! reflexivity
[equal? /a /a]
; refinement! vs. set-word!
[equal? /a first [a:]]
; refinement! vs. set-word! symmetry
[equal? equal? /a first [a:] equal? first [a:] /a]
; set-word! reflexivity
[equal? first [a:] first [a:]]
[equal? true true]
[equal? false false]
[not equal? true false]
[not equal? false true]
; object! reflexivity
[equal? a-value: make object! [a: 1] a-value]
; object! simple structural equivalence
#r3only
[equal? make object! [a: 1] make object! [a: 1]]
; object! different values
[not equal? make object! [a: 1] make object! [a: 2]]
; object! different words
[not equal? make object! [a: 1] make object! [b: 1]]
[not equal? make object! [a: 1] make object! []]
; object! complex structural equivalence
#r3only
[
	a-value: construct/only [
		a: 1 b: 1.0 c: $1 d: 1%
		e: [a 'a :a a: /a #"a" #{00}]
		f: ["a" #a http://a a@a.com <a>]
		g: :a/b/(c: 'd/e/f)/(b/d: [:f/g h/i])
	]
	b-value: construct/only [
		a: 1 b: 1.0 c: $1 d: 1%
		e: [a 'a :a a: /a #"a" #{00}]
		f: ["a" #a http://a a@a.com <a>]
		g: :a/b/(c: 'd/e/f)/(b/d: [:f/g h/i])
	]
	equal? a-value b-value
]
; object! complex structural equivalence
; Slight differences.
; bug#1133
#r3only
[
	a-value: construct/only [c: $1]
	b-value: construct/only [c: 100%]
	equal? a-value b-value
]
#r3only
[
	a-value: construct/only [
		a: 1 b: 1.0 c: $1 d: 1%
		e: [a 'a :a a: /a #"a" #{00}]
		f: ["a" #a http://a a@a.com <a>]
		g: :a/b/(c: 'd/e/f)/(b/d: [:f/g h/i])
	]
	b-value: construct/only [
		a: 1.0 b: $1 c: 100% d: 0.01
		e: [/a a 'a :a a: #"A" #[binary! #{0000} 2]]
		f: [#a <A> http://A a@A.com "A"]
		g: :a/b/(c: 'd/e/f)/(b/d: [:f/g h/i])
	]
	equal? a-value b-value
]
; object! structural equivalence verified
; Structural equality requires equality of the object's fields.
#r3only
[
	a-value: construct/only [
		a: 1 b: 1.0 c: $1 d: 1%
		e: [a 'a :a a: /a #"a" #{00}]
		f: ["a" #a http://a a@a.com <a>]
		g: :a/b/(c: 'd/e/f)/(b/d: [:f/g h/i])
	]
	b-value: construct/only [
		a: 1 b: 1.0 c: $1 d: 1%
		e: [a 'a :a a: /a #"a" #{00}]
		f: ["a" #a http://a a@a.com <a>]
		g: :a/b/(c: 'd/e/f)/(b/d: [:f/g h/i])
	]
	test: :equal?
	equal?
		test a-value b-value
		foreach [w v] a-value [
			unless test :v select b-value w [break/return false]
			true
		]
]
; object! structural equivalence verified
; Structural equality requires equality of the object's fields.
#r3only
[
	a-value: construct/only [
		a: 1 b: 1.0 c: $1 d: 1%
		e: [a 'a :a a: /a #"a" #{00}]
		f: ["a" #a http://a a@a.com <a>]
		g: :a/b/(c: 'd/e/f)/(b/d: [:f/g h/i])
	]
	b-value: construct/only [
		a: 1.0 b: $1 c: 100% d: 0.01
		e: [/a a 'a :a a: #"A" #[binary! #{0000} 2]]
		f: [#a <A> http://A a@A.com "A"]
		g: :a/b/(c: 'd/e/f)/(b/d: [:f/g h/i])
	]
	test: :equal?
	equal?
		test a-value b-value
		foreach [w v] a-value [
			unless test :v select b-value w [break/return false]
			true
		]
]
; unset! comparison fails
; Evaluates () to get unset! value, in case #[unset!] constructor fails.
#r2only
[error? try [equal? () ()]]
#r3only
[equal? () ()]
; basic comparison with unset first argument fails
#r2only
[error? try [equal? () none]]
#r3only
[not-equal? () none]
; basic comparison with unset second argument fails
#r2only
[error? try [equal? none ()]]
#r3only
[not-equal? none ()]
; unset! symmetry
#r3only
[equal? equal? none () equal? () none]
; unset! symmetry
; Fails on R2 because there is no structural comparison of objects.
#r2only
[not equal? disarm try [equal? none ()] disarm try [equal? () none]]
; basic comparison with unset first argument succeeds with = op
; Code in R3 mezzanines depends on this.
#r3only
[not (() = none)]
; basic comparison with unset first argument succeeds with != op
; Code in R3 mezzanines depends on this.
#r3only
[() != none]
; basic comparison with unset second argument fails with = op
#r2only
[error? try [none = ()]]
#r3only
[not none = ()]
; basic comparison with unset second argument fails with != op
#r2only
[error? try [none != ()]]
#r3only
[none != ()]
#r2only
[error? try [() = ()]]
#r3only
[() = ()]
#r2only
[error? try [() != ()]]
#r3only
[not () != ()]
; unset! symmetry with =
#r3only
[equal? none = () () = none]
; error! reflexivity
; Evaluates (try [1 / 0]) to get error! value.
#r3only
[
	a-value: none
	set/any 'a-value (try [1 / 0])
	equal? a-value a-value
]
; error! structural equivalence
; Evaluates (try [1 / 0]) to get error! value.
#r3only
[equal? (try [1 / 0]) (try [1 / 0])]
; error! structural equivalence
#r3only
[equal? (make error! "hello") (make error! "hello")]
; error! difference in code
#r3only
[not equal? (try [1 / 0]) (make error! "hello")]
; error! difference in data
#r3only
[not equal? (make error! "hello") (make error! "there")]
; error! difference in op! code
; bug#60: operators generate errors with offset NEAR field
#r3only
[not equal? (try [1 / 0]) (try [2 / 0])]
; error! basic comparison
#r3only
[not equal? (try [1 / 0]) none]
; error! basic comparison
#r3only
[not equal? none (try [1 / 0])]
; error! basic comparison symmetry
#r3only
[equal? equal? (try [1 / 0]) none equal? none (try [1 / 0])]
; error! basic comparison with = op
#r3only
[not ((try [1 / 0]) = none)]
; error! basic comparison with != op
#r3only
[(try [1 / 0]) != none]
; error! basic comparison with = op
#r3only
[not (none = (try [1 / 0]))]
; error! basic comparison with != op
#r3only
[none != (try [1 / 0])]
; error! symmetry with = op
#r3only
[equal? not ((try [1 / 0]) = none) not (none = (try [1 / 0]))]
; error! symmetry with != op
#r3only
[equal? (try [1 / 0]) != none none != (try [1 / 0])]
; port! reflexivity
; Error in R2 (could be fixed).
#r3only
[equal? p: make port! http:// p]
; No structural equivalence for port!
; Error in R2 (could be fixed).
#r3only
[not equal? make port! http:// make port! http://]
; bug#859
[
	a: copy quote ()
	insert/only a a
	error? try [do a]
]
; functions/comparison/equivq.r
; reflexivity test for native!
#r3
[equiv? :abs :abs]
#r3
[equiv? :all :all]
#r3
[not equiv? :all :any]
; reflexivity test for op!
#r3
[equiv? :+ :+]
#r3
[not equiv? :+ :-]
; reflexivity test for function!
; Uses func instead of make function! so the test is compatible.
#r3
[equiv? a-value: func [] [] :a-value]
; no structural equivalence for function!
#r3
[not equiv? func [] [] func [] []]
; reflexivity test for closure!
; Uses CLOSURE to make the test compatible.
#r3
[equiv? a-value: closure [] [] :a-value]
; No structural equivalence for closure!
; Uses CLOSURE to make the test compatible.
#r3
[not equiv? closure [] [] closure [] []]
; binary!
; Same contents
#r3
[equiv? #{00} #{00}]
; Different contents
#r3
[not equiv? #{00} #{01}]
; Offset + similar contents at reference
#r3
[equiv? #{00} #[binary! #{0000} 2]]
; Offset + similar contents at reference
#r3
[equiv? #{00} #[binary! #{0100} 2]]
#r3
[equal? equiv? #{00} #[binary! #{0100} 2] equiv? #[binary! #{0100} 2] #{00}]
; No binary! padding
#r3
[not equiv? #{00} #{0000}]
#r3
[equal? equiv? #{00} #{0000} equiv? #{0000} #{00}]
; Empty binary! not none
#r3
[not equiv? #{} none]
; case sensitivity
; bug#1459
#r3
[not-equiv? #{0141} #{0161}]
; email versus string; RAMBO #3518
#r3
[
	a-value: to email! ""
	equiv? a-value to string! a-value
]
; symmetry
#r3
[
	a-value: to email! ""
	equal? equiv? to string! a-value a-value equiv? a-value to string! a-value
]
; file! vs. string!
; RAMBO #3518
#r3
[
	a-value: %""
	equiv? a-value to string! a-value
]
; symmetry
#r3
[
	a-value: %""
	equal? equiv? a-value to string! a-value equiv? to string! a-value a-value
]
; image! same contents
#r3
[equiv? a-value: #[image! 1x1 #{000000}] a-value]
#r3
[equiv? #[image! 1x1 #{000000}] #[image! 1x1 #{000000}]]
#r3
[equiv? #[image! 1x1 #{}] #[image! 1x1 #{000000}]]
#r3
[not equiv? #{00} #[image! 1x1 #{00}]]
; symmetry
#r3
[equal? equiv? #{00} #[image! 1x1 #{00}] equiv? #[image! 1x1 #{00}] #{00}]
#r3
[not equiv? #{00} to integer! #{00}]
; symmetry
#r3
[equal? equiv? #{00} to integer! #{00} equiv? to integer! #{00} #{00}]
; RAMBO #3518
#r3
[
	a-value: #a
	not-equiv? a-value to string! a-value
]
; symmetry
#r3
[
	a-value: #a
	equal? equiv? a-value to string! a-value equiv? to string! a-value a-value
]
; symmetry
#r3
[equal? equiv? #{} none equiv? none #{}]
#r3
[
	a-value: ""
	not equiv? a-value to binary! a-value
]
; symmetry
#r3
[
	a-value: ""
	equal? equiv? a-value to binary! a-value equiv? to binary! a-value a-value
]
; RAMBO #3518
#r3
[
	a-value: to tag! ""
	equiv? a-value to string! a-value
]
; symmetry
#r3
[
	a-value: to tag! ""
	equal? equiv? a-value to string! a-value equiv? to string! a-value a-value
]
#r3
[
	a-value: 0.0.0.0
	not equiv? to binary! a-value a-value
]
; symmetry
#r3
[
	a-value: 0.0.0.0
	equal? equiv? to binary! a-value a-value equiv? a-value to binary! a-value
]
#r3
[equiv? #[bitset! #{00}] #[bitset! #{00}]]
#r3
[not equiv? #[bitset! #{}] #[bitset! #{00}]]
; block!
#r3
[equiv? [] []]
; reflexivity
#r3
[
	a-value: []
	equiv? a-value a-value
]
; reflexivity for past-tail blocks
#r3
[
	a-value: tail [1]
	clear head a-value
	equiv? a-value a-value
]
; reflexivity for cyclic blocks
#r3
[
	a-value: copy []
	insert/only a-value a-value
	equiv? a-value a-value
]
; comparison of cyclic blocks
; bug#1049
#r3
[
	a-value: copy []
	insert/only a-value a-value
	b-value: copy []
	insert/only b-value b-value
	error? try [equiv? a-value b-value]
	true
]
#r3
[not equiv? [] none]
#r3
[equal? equiv? [] none equiv? none []]
; block! vs. paren!
#r3
[not equiv? [] first [()]]
; block! vs. paren! symmetry
#r3
[equal? equiv? [] first [()] equiv? first [()] []]
; block! vs. path!
#r3
[not equiv? [a b] 'a/b]
; block! vs. path! symmetry
#r3
[
	a-value: 'a/b
	b-value: [a b]
	equal? equiv? :a-value :b-value equiv? :b-value :a-value
]
; block! vs. lit-path!
#r3
[not equiv? [a b] first ['a/b]]
; block! vs. lit-path! symmetry
#r3
[
	a-value: first ['a/b]
	b-value: [a b]
	equal? equiv? :a-value :b-value equiv? :b-value :a-value
]
; block! vs. set-path!
#r3
[not equiv? [a b] first [a/b:]]
; block! vs. set-path! symmetry
#r3
[
	a-value: first [a/b:]
	b-value: [a b]
	equal? equiv? :a-value :b-value equiv? :b-value :a-value
]
; block! vs. get-path!
#r3
[not equiv? [a b] first [:a/b]]
; block! vs. get-path! symmetry
#r3
[
	a-value: first [:a/b]
	b-value: [a b]
	equal? equiv? :a-value :b-value equiv? :b-value :a-value
]
#r3
[equiv? decimal! decimal!]
#r3
[not equiv? decimal! integer!]
#r3
[equal? equiv? decimal! integer! equiv? integer! decimal!]
#r3
[not equiv? number! integer!]
; symmetry
#r3
[equal? equiv? number! integer! equiv? integer! number!]
#r3only
[not equiv? integer! make typeset! [integer!]]
#r3only
[equal? equiv? integer! make typeset! [integer!] equiv? make typeset! [integer!] integer!]
; reflexivity
#r3
[equiv? -1 -1]
; reflexivity
#r3
[equiv? 0 0]
; reflexivity
#r3
[equiv? 1 1]
; reflexivity
#r3
[equiv? 0.0 0.0]
#r3
[equiv? 0.0 -0.0]
; reflexivity
#r3
[equiv? 1.0 1.0]
; reflexivity
#r3
[equiv? -1.0 -1.0]
; reflexivity
#64bit
#r3
[equiv? -9223372036854775808 -9223372036854775808]
; reflexivity
#64bit
#r3
[equiv? -9223372036854775807 -9223372036854775807]
; reflexivity
#64bit
#r3
[equiv? 9223372036854775807 9223372036854775807]
; -9223372036854775808 not equiv?
#64bit
#r3
[not equiv? -9223372036854775808 -9223372036854775807]
#64bit
#r3
[not equiv? -9223372036854775808 -1]
#64bit
#r3
[not equiv? -9223372036854775808 0]
#64bit
#r3
[not equiv? -9223372036854775808 1]
#64bit
#r3
[not equiv? -9223372036854775808 9223372036854775806]
#64bit
#r3
[not equiv? -9223372036854775808 9223372036854775807]
; -9223372036854775807 not equiv?
#64bit
#r3
[not equiv? -9223372036854775807 -9223372036854775808]
#64bit
#r3
[not equiv? -9223372036854775807 -1]
#64bit
#r3
[not equiv? -9223372036854775807 0]
#64bit
#r3
[not equiv? -9223372036854775807 1]
#64bit
#r3
[not equiv? -9223372036854775807 9223372036854775806]
#64bit
#r3
[not equiv? -9223372036854775807 9223372036854775807]
; -1 not equiv?
#64bit
#r3
[not equiv? -1 -9223372036854775808]
#64bit
#r3
[not equiv? -1 -9223372036854775807]
#r3
[not equiv? -1 0]
#r3
[not equiv? -1 1]
#64bit
#r3
[not equiv? -1 9223372036854775806]
#64bit
#r3
[not equiv? -1 9223372036854775807]
; 0 not equiv?
#64bit
#r3
[not equiv? 0 -9223372036854775808]
#64bit
#r3
[not equiv? 0 -9223372036854775807]
#r3
[not equiv? 0 -1]
#r3
[not equiv? 0 1]
#64bit
#r3
[not equiv? 0 9223372036854775806]
#64bit
#r3
[not equiv? 0 9223372036854775807]
; 1 not equiv?
#64bit
#r3
[not equiv? 1 -9223372036854775808]
#64bit
#r3
[not equiv? 1 -9223372036854775807]
#r3
[not equiv? 1 -1]
#r3
[not equiv? 1 0]
#64bit
#r3
[not equiv? 1 9223372036854775806]
#64bit
#r3
[not equiv? 1 9223372036854775807]
; 9223372036854775806 not equiv?
#64bit
#r3
[not equiv? 9223372036854775806 -9223372036854775808]
#64bit
#r3
[not equiv? 9223372036854775806 -9223372036854775807]
#64bit
#r3
[not equiv? 9223372036854775806 -1]
#64bit
#r3
[not equiv? 9223372036854775806 0]
#64bit
#r3
[not equiv? 9223372036854775806 1]
#64bit
#r3
[not equiv? 9223372036854775806 9223372036854775807]
; 9223372036854775807 not equiv?
#64bit
#r3
[not equiv? 9223372036854775807 -9223372036854775808]
#64bit
#r3
[not equiv? 9223372036854775807 -9223372036854775807]
#64bit
#r3
[not equiv? 9223372036854775807 -1]
#64bit
#r3
[not equiv? 9223372036854775807 0]
#64bit
#r3
[not equiv? 9223372036854775807 1]
#64bit
#r3
[not equiv? 9223372036854775807 9223372036854775806]
; "decimal tolerance"
#r3
; bug#1134
[not equiv? to decimal! #{3FD3333333333333} to decimal! #{3FD3333333333334}]
; symmetry
#r3
[
	equal? equiv? to decimal! #{3FD3333333333333} to decimal! #{3FD3333333333334}
		equiv? to decimal! #{3FD3333333333334} to decimal! #{3FD3333333333333}
]
#r3
[not equiv? to decimal! #{3FB9999999999999} to decimal! #{3FB999999999999A}]
; symmetry
#r3
[
	equal? equiv? to decimal! #{3FB9999999999999} to decimal! #{3FB999999999999A}
		equiv? to decimal! #{3FB999999999999A} to decimal! #{3FB9999999999999}
]
; ignores datatype differences
#r3
[equiv? 0 0.0]
; ignores datatype differences
#r3
[equiv? 0 $0]
; ignores datatype differences
#r3only
[equiv? 0 0%]
; ignores datatype differences
#r3
[equiv? 0.0 $0]
; ignores datatype differences
#r3only
[equiv? 0.0 0%]
; ignores datatype differences
#r3only
[equiv? $0 0%]
; symmetry
#r3
[equal? equiv? 1 1.0 equiv? 1.0 1]
; symmetry
#r3
[equal? equiv? 1 $1 equiv? $1 1]
; symmetry
#r3only
[equal? equiv? 1 100% equiv? 100% 1]
; symmetry
#r3
[equal? equiv? 1.0 $1 equiv? $1 1.0]
; symmetry
#r3only
[equal? equiv? 1.0 100% equiv? 100% 1.0]
; symmetry
#r3only
[equal? equiv? $1 100% equiv? 100% $1]
; approximate equality
#r3only
[equiv? 10% + 10% + 10% 30%]
; symmetry
#r3only
[equal? equiv? 10% + 10% + 10% 30% equiv? 30% 10% + 10% + 10%]
; date!; approximate equality
#r3
[not equiv? 2-Jul-2009 2-Jul-2009/22:20]
; symmetry
#r3
[equal? equiv? 2-Jul-2009 2-Jul-2009/22:20 equiv? 2-Jul-2009/22:20 2-Jul-2009]
; missing time = 00:00:00+00:00, by time compatibility standards
#r3
[equiv? 2-Jul-2009 2-Jul-2009/00:00:00+00:00]
; symmetry
#r3
[equal? equiv? 2-Jul-2009 2-Jul-2009/00:00 equiv? 2-Jul-2009/00:00 2-Jul-2009]
; timezone in date!
#r3
[equiv? 2-Jul-2009/22:20 2-Jul-2009/20:20-2:00]
; time!; reflexivity
#r3
[equiv? 00:00 00:00]
; char!; symmetry
#r3
[equal? equiv? #"a" 97 equiv? 97 #"a"]
; symmetry
#r3
[equal? equiv? #"a" 97.0 equiv? 97.0 #"a"]
; case
#r3
[equiv? #"a" #"A"]
; case
#r3
[equiv? "a" "A"]
; words; reflexivity
#r3
[equiv? 'a 'a]
; aliases
#r3
[equiv? 'a 'A]
; symmetry
#r3
[equal? equiv? 'a 'A equiv? 'A 'a]
; binding
#r3
[not equiv? 'a use [a] ['a]]
; symmetry
#r3
[equal? equiv? 'a use [a] ['a] equiv? use [a] ['a] 'a]
; different word types
#r3
[equiv? 'a first [:a]]
; symmetry
#r3
[equal? equiv? 'a first [:a] equiv? first [:a] 'a]
; different word types
#r3
[equiv? 'a first ['a]]
; symmetry
#r3
[equal? equiv? 'a first ['a] equiv? first ['a] 'a]
; different word types
#r3
[equiv? 'a /a]
; symmetry
#r3
[equal? equiv? 'a /a equiv? /a 'a]
; different word types
#r3
[equiv? 'a first [a:]]
; symmetry
#r3
[equal? equiv? 'a first [a:] equiv? first [a:] 'a]
; reflexivity
#r3
[equiv? first [:a] first [:a]]
; different word types
#r3
[equiv? first [:a] first ['a]]
; symmetry
#r3
[equal? equiv? first [:a] first ['a] equiv? first ['a] first [:a]]
; different word types
#r3
[equiv? first [:a] /a]
; symmetry
#r3
[equal? equiv? first [:a] /a equiv? /a first [:a]]
; different word types
#r3
[equiv? first [:a] first [a:]]
; symmetry
#r3
[equal? equiv? first [:a] first [a:] equiv? first [a:] first [:a]]
; reflexivity
#r3
[equiv? first ['a] first ['a]]
; different word types
#r3
[equiv? first ['a] /a]
; symmetry
#r3
[equal? equiv? first ['a] /a equiv? /a first ['a]]
; different word types
#r3
[equiv? first ['a] first [a:]]
; symmetry
#r3
[equal? equiv? first ['a] first [a:] equiv? first [a:] first ['a]]
; reflexivity
#r3
[equiv? /a /a]
; different word types
#r3
[equiv? /a first [a:]]
; symmetry
#r3
[equal? equiv? /a first [a:] equiv? first [a:] /a]
; reflexivity
#r3
[equiv? first [a:] first [a:]]
; logic! values
#r3
[equiv? true true]
#r3
[equiv? false false]
#r3
[not equiv? true false]
#r3
[not equiv? false true]
; port! values; reflexivity; in this case the error should not be generated, I think
#r3
[
	p: make port! http://
	found? any [
		error? try [equiv? p p]
		equiv? p p
	]
]
; functions/comparison/sameq.r
; reflexivity test for action!
[same? :abs :abs]
; reflexivity test for native!
[same? :all :all]
; reflexivity test for op!
[same? :+ :+]
; reflexivity test for function!
[
	a-value: func [] []
	same? :a-value :a-value
]
; no structural equality for function!
[not same? func [] [] func [] []]
; reflexivity test for closure!
[
	a-value: closure [] []
	same? :a-value :a-value
]
; no structural equality for closure!
[not same? closure [] [] closure [] []]
; binary!
[not same? #{00} #{00}]
; binary versus bitset
[not same? #{00} #[bitset! #{00}]]
; symmetry
[equal? same? #[bitset! #{00}] #{00} same? #{00} #[bitset! #{00}]]
; email versus string
[
	a-value: to email! ""
	not same? a-value to string! a-value
]
; symmetry
[
	a-value: to email! ""
	equal? same? to string! a-value a-value same? a-value to string! a-value
]
[
	a-value: %""
	not same? a-value to string! a-value
]
; symmetry
[
	a-value: %""
	equal? same? a-value to string! a-value same? to string! a-value a-value
]
[not same? #{00} #[image! 1x1 #{00}]]
; symmetry
[equal? same? #{00} #[image! 1x1 #{00}] same? #[image! 1x1 #{00}] #{00}]
[not same? #{00} to integer! #{00}]
; symmetry
[equal? same? #{00} to integer! #{00} same? to integer! #{00} #{00}]
[
	a-value: #a
	not same? a-value to string! a-value
]
; symmetry
[
	a-value: #a
	equal? same? a-value to string! a-value same? to string! a-value a-value
]
[not same? #{} none]
; symmetry
[equal? same? #{} none same? none #{}]
[
	a-value: ""
	not same? a-value to binary! a-value
]
; symmetry
[
	a-value: ""
	equal? same? a-value to binary! a-value same? to binary! a-value a-value
]
[
	a-value: to tag! ""
	not same? a-value to string! a-value
]
; symmetry
[
	a-value: to tag! ""
	equal? same? a-value to string! a-value same? to string! a-value a-value
]
[
	a-value: 0.0.0.0
	not same? to binary! a-value a-value
]
; symmetry
[
	a-value: 0.0.0.0
	equal? same? to binary! a-value a-value same? a-value to binary! a-value
]
[not same? #[bitset! #{00}] #[bitset! #{00}]]
[not same? #[bitset! #{}] #[bitset! #{00}]]
; block!
[not same? [] []]
; reflexivity
[
	a-value: []
	same? a-value a-value
]
; reflexivity for past-tail blocks
[
	a-value: tail [1]
	clear head a-value
	same? a-value a-value
]
; reflexivity for cyclic blocks
[
	a-value: copy []
	insert/only a-value a-value
	same? a-value a-value
]
; comparison of cyclic blocks
[
	a-value: copy []
	insert/only a-value a-value
	b-value: copy []
	insert/only b-value b-value
	not same? a-value b-value
]
#r2only
[
	a-value: first ['a/b]
	parse :a-value [b-value:]
	not same? :a-value :b-value
]
; bug#1068
; bug#1066
#r3only
[
	a-value: first ['a/b]
	parse :a-value [b-value:]
	same? :a-value :b-value
]
; symmetry
[
	a-value: first ['a/b]
	parse :a-value [b-value:]
	equal? same? :a-value :b-value same? :b-value :a-value
]
[not same? [] none]
; symmetry
[equal? same? [] none same? none []]
#r2only
[
	a-value: first [()]
	parse a-value [b-value:]
	not same? a-value b-value
]
; bug#1068
; bug#1066
#r3only
[
	a-value: first [()]
	parse a-value [b-value:]
	same? a-value b-value
]
; symmetry
[
	a-value: first [()]
	parse a-value [b-value:]
	equal? same? a-value b-value same? b-value a-value
]
#r2only
[
	a-value: 'a/b
	parse a-value [b-value:]
	not same? :a-value :b-value
]
; bug#1068
; bug#1066
#r3only
[
	a-value: 'a/b
	parse a-value [b-value:]
	same? :a-value :b-value
]
; symmetry
[
	a-value: 'a/b
	parse a-value [b-value:]
	equal? same? :a-value :b-value same? :b-value :a-value
]
#r2only
[
	a-value: first [a/b:]
	parse :a-value [b-value:]
	not same? :a-value :b-value
]
; bug#1068
; bug#1066
#r3only
[
	a-value: first [a/b:]
	parse :a-value [b-value:]
	same? :a-value :b-value
]
; symmetry
[
	a-value: first [a/b:]
	parse :a-value [b-value:]
	equal? same? :a-value :b-value same? :b-value :a-value
]
[not same? number! integer!]
; symmetry
[equal? same? number! integer! same? integer! number!]
; reflexivity
[same? -1 -1]
; reflexivity
[same? 0 0]
; reflexivity
[same? 1 1]
; reflexivity
[same? 0.0 0.0]
[not same? 0.0 -0.0]
; reflexivity
[same? 1.0 1.0]
; reflexivity
[same? -1.0 -1.0]
; reflexivity
#64bit
[same? -9223372036854775808 -9223372036854775808]
; reflexivity
#64bit
[same? -9223372036854775807 -9223372036854775807]
; reflexivity
#64bit
[same? 9223372036854775807 9223372036854775807]
; -9223372036854775808 not same?
#64bit
[not same? -9223372036854775808 -9223372036854775807]
#64bit
[not same? -9223372036854775808 -1]
#64bit
[not same? -9223372036854775808 0]
#64bit
[not same? -9223372036854775808 1]
#64bit
[not same? -9223372036854775808 9223372036854775806]
#64bit
[not same? -9223372036854775808 9223372036854775807]
; -9223372036854775807 not same?
#64bit
[not same? -9223372036854775807 -9223372036854775808]
#64bit
[not same? -9223372036854775807 -1]
#64bit
[not same? -9223372036854775807 0]
#64bit
[not same? -9223372036854775807 1]
#64bit
[not same? -9223372036854775807 9223372036854775806]
#64bit
[not same? -9223372036854775807 9223372036854775807]
; -1 not same?
#64bit
[not same? -1 -9223372036854775808]
#64bit
[not same? -1 -9223372036854775807]
[not same? -1 0]
[not same? -1 1]
#64bit
[not same? -1 9223372036854775806]
#64bit
[not same? -1 9223372036854775807]
; 0 not same?
#64bit
[not same? 0 -9223372036854775808]
#64bit
[not same? 0 -9223372036854775807]
[not same? 0 -1]
[not same? 0 1]
#64bit
[not same? 0 9223372036854775806]
#64bit
[not same? 0 9223372036854775807]
; 1 not same?
#64bit
[not same? 1 -9223372036854775808]
#64bit
[not same? 1 -9223372036854775807]
[not same? 1 -1]
[not same? 1 0]
#64bit
[not same? 1 9223372036854775806]
#64bit
[not same? 1 9223372036854775807]
; 9223372036854775806 not same?
#64bit
[not same? 9223372036854775806 -9223372036854775808]
#64bit
[not same? 9223372036854775806 -9223372036854775807]
#64bit
[not same? 9223372036854775806 -1]
#64bit
[not same? 9223372036854775806 0]
#64bit
[not same? 9223372036854775806 1]
#64bit
[not same? 9223372036854775806 9223372036854775807]
; 9223372036854775807 not same?
#64bit
[not same? 9223372036854775807 -9223372036854775808]
#64bit
[not same? 9223372036854775807 -9223372036854775807]
#64bit
[not same? 9223372036854775807 -1]
#64bit
[not same? 9223372036854775807 0]
#64bit
[not same? 9223372036854775807 1]
#64bit
[not same? 9223372036854775807 9223372036854775806]
; "decimal tolerance"
[not same? to decimal! #{3FD3333333333333} to decimal! #{3FD3333333333334}]
; symmetry
[
	equal? same? to decimal! #{3FD3333333333333} to decimal! #{3FD3333333333334}
		same? to decimal! #{3FD3333333333334} to decimal! #{3FD3333333333333}
]
[not same? to decimal! #{3FB9999999999999} to decimal! #{3FB999999999999A}]
; symmetry
[
	equal? same? to decimal! #{3FB9999999999999} to decimal! #{3FB999999999999A}
		same? to decimal! #{3FB999999999999A} to decimal! #{3FB9999999999999}
]
; datatype differences
[not same? 0 0.0]
; datatype differences
[not same? 0 $0]
; datatype differences
#r3only
[not same? 0 0%]
; datatype differences
[not same? 0.0 $0]
; datatype differences
#r3only
[not same? 0.0 0%]
; datatype differences
#r3only
[not same? $0 0%]
; symmetry
[equal? same? 1 1.0 same? 1.0 1]
; symmetry
[equal? same? 1 $1 same? $1 1]
#r3only
; symmetry
[equal? same? 1 100% same? 100% 1]
; symmetry
[equal? same? 1.0 $1 same? $1 1.0]
; symmetry
#r3only
[equal? same? 1.0 100% same? 100% 1.0]
; symmetry
#r3only
[equal? same? $1 100% same? 100% $1]
; approximate equality
#r3only
[not same? 10% + 10% + 10% 30%]
; symmetry
#r3only
[equal? same? 10% + 10% + 10% 30% same? 30% 10% + 10% + 10%]
; date!; approximate equality
[not same? 2-Jul-2009 2-Jul-2009/22:20]
; symmetry
[equal? same? 2-Jul-2009 2-Jul-2009/22:20 same? 2-Jul-2009/22:20 2-Jul-2009]
; missing time is considered a difference
[not same? 2-Jul-2009 2-Jul-2009/00:00:00+00:00]
; symmetry
[equal? not same? 2-Jul-2009 2-Jul-2009/00:00 not same? 2-Jul-2009/00:00 2-Jul-2009]
; no timezone math
[not same? 2-Jul-2009/22:20 2-Jul-2009/20:20-2:00]
; time!
[same? 00:00 00:00]
; missing components are 0
[same? 00:00 00:00:00]
; no timezone math
[not same? 22:20 20:20]
; char!; symmetry
[equal? same? #"a" 97 same? 97 #"a"]
; symmetry
[equal? same? #"a" 97.0 same? 97.0 #"a"]
; case
[not same? #"a" #"A"]
; case
[not same? "a" "A"]
; words; reflexivity
[same? 'a 'a]
; aliases
[not same? 'a 'A]
; symmetry
[equal? same? 'a 'A same? 'A 'a]
; binding
[not same? 'a use [a] ['a]]
; symmetry
[equal? same? 'a use [a] ['a] same? use [a] ['a] 'a]
; different word types
#r2only
[same? 'a first [:a]]
#r3only
[not same? 'a first [:a]]
; symmetry
[equal? same? 'a first [:a] same? first [:a] 'a]
; different word types
#r2only
[same? 'a first ['a]]
#r3only
[not same? 'a first ['a]]
; symmetry
[equal? same? 'a first ['a] same? first ['a] 'a]
; different word types
[not same? 'a /a]
; symmetry
[equal? same? 'a /a same? /a 'a]
; different word types
#r2only
[same? 'a first [a:]]
#r3only
[not same? 'a first [a:]]
; symmetry
[equal? same? 'a first [a:] same? first [a:] 'a]
; reflexivity
[same? first [:a] first [:a]]
; different word types
#r2only
[same? first [:a] first ['a]]
#r3only
[not same? first [:a] first ['a]]
; symmetry
[equal? same? first [:a] first ['a] same? first ['a] first [:a]]
; different word types
[not same? first [:a] /a]
; symmetry
[equal? same? first [:a] /a same? /a first [:a]]
; different word types
#r2only
[same? first [:a] first [a:]]
#r3only
[not same? first [:a] first [a:]]
; symmetry
[equal? same? first [:a] first [a:] same? first [a:] first [:a]]
; reflexivity
[same? first ['a] first ['a]]
; different word types
[not same? first ['a] /a]
; symmetry
[equal? same? first ['a] /a same? /a first ['a]]
; different word types
#r2only
[same? first ['a] first [a:]]
#r3only
[not same? first ['a] first [a:]]
; symmetry
[equal? same? first ['a] first [a:] same? first [a:] first ['a]]
; reflexivity
[same? /a /a]
; different word types
[not same? /a first [a:]]
; symmetry
[equal? same? /a first [a:] same? first [a:] /a]
; reflexivity
[same? first [a:] first [a:]]
; logic! values
[same? true true]
[same? false false]
[not same? true false]
[not same? false true]
; port! values; reflexivity; in this case the error should not be generated, I think
[
	p: make port! http://
	found? any [
		error? try [same? p p]
		same? p p
	]
]
; functions/comparison/strict-equalq.r
[strict-equal? :abs :abs]
; reflexivity test for native!
[strict-equal? :all :all]
; reflexivity test for op!
[strict-equal? :+ :+]
; reflexivity test for function!
[
	a-value: func [] []
	strict-equal? :a-value :a-value
]
; no structural equality for function!
[not strict-equal? func [] [] func [] []]
; reflexivity test for closure!
[
	a-value: closure [] []
	strict-equal? :a-value :a-value
]
; no structural equality for closure!
[not strict-equal? closure [] [] closure [] []]
; binary!
[strict-equal? #{00} #{00}]
; binary versus bitset
[not strict-equal? #{00} #[bitset! #{00}]]
; symmetry
[equal? strict-equal? #[bitset! #{00}] #{00} strict-equal? #{00} #[bitset! #{00}]]
; email versus string
[
	a-value: to email! ""
	not strict-equal? a-value to string! a-value
]
; symmetry
[
	a-value: to email! ""
	equal? strict-equal? to string! a-value a-value strict-equal? a-value to string! a-value
]
[
	a-value: %""
	not strict-equal? a-value to string! a-value
]
; symmetry
[
	a-value: %""
	equal? strict-equal? a-value to string! a-value strict-equal? to string! a-value a-value
]
[not strict-equal? #{00} #[image! 1x1 #{00}]]
; symmetry
[equal? strict-equal? #{00} #[image! 1x1 #{00}] strict-equal? #[image! 1x1 #{00}] #{00}]
[not strict-equal? #{00} to integer! #{00}]
; symmetry
[equal? strict-equal? #{00} to integer! #{00} strict-equal? to integer! #{00} #{00}]
[
	a-value: #a
	not strict-equal? a-value to string! a-value
]
; symmetry
[
	a-value: #a
	equal? strict-equal? a-value to string! a-value strict-equal? to string! a-value a-value
]
[not strict-equal? #{} none]
; symmetry
[equal? strict-equal? #{} none strict-equal? none #{}]
[
	a-value: ""
	not strict-equal? a-value to binary! a-value
]
; symmetry
[
	a-value: ""
	equal? strict-equal? a-value to binary! a-value strict-equal? to binary! a-value a-value
]
[
	a-value: to tag! ""
	not strict-equal? a-value to string! a-value
]
; symmetry
[
	a-value: to tag! ""
	equal? strict-equal? a-value to string! a-value strict-equal? to string! a-value a-value
]
[
	a-value: 0.0.0.0
	not strict-equal? to binary! a-value a-value
]
; symmetry
[
	a-value: 0.0.0.0
	equal? strict-equal? to binary! a-value a-value strict-equal? a-value to binary! a-value
]
[strict-equal? #[bitset! #{00}] #[bitset! #{00}]]
[not strict-equal? #[bitset! #{}] #[bitset! #{00}]]
; block!
[strict-equal? [] []]
; reflexivity
[
	a-value: []
	strict-equal? a-value a-value
]
; reflexivity for past-tail blocks
[
	a-value: tail [1]
	clear head a-value
	strict-equal? a-value a-value
]
; reflexivity for cyclic blocks
[
	a-value: copy []
	insert/only a-value a-value
	strict-equal? a-value a-value
]
; bug#1049
; comparison of cyclic blocks
[
	a-value: copy []
	insert/only a-value a-value
	b-value: copy []
	insert/only b-value b-value
	error? try [strict-equal? a-value b-value]
	true
]
#r2only
[
	a-value: first ['a/b]
	parse :a-value [b-value:]
	not strict-equal? :a-value :b-value
]
; bug#1068
; bug#1066
#r3only
[
	a-value: first ['a/b]
	parse :a-value [b-value:]
	strict-equal? :a-value :b-value
]
; symmetry
[
	a-value: first ['a/b]
	parse :a-value [b-value:]
	equal? strict-equal? :a-value :b-value strict-equal? :b-value :a-value
]
[not strict-equal? [] none]
; symmetry
[equal? strict-equal? [] none strict-equal? none []]
#r2only
[
	a-value: first [()]
	parse a-value [b-value:]
	not strict-equal? a-value b-value
]
; bug#1068
; bug#1066
#r3only
[
	a-value: first [()]
	parse a-value [b-value:]
	strict-equal? a-value b-value
]
; symmetry
[
	a-value: first [()]
	parse a-value [b-value:]
	equal? strict-equal? a-value b-value strict-equal? b-value a-value
]
#r2only
[
	a-value: 'a/b
	parse a-value [b-value:]
	not strict-equal? :a-value :b-value
]
; bug#1068
; bug#1066
#r3only
[
	a-value: 'a/b
	parse a-value [b-value:]
	strict-equal? :a-value :b-value
]
; symmetry
[
	a-value: 'a/b
	parse a-value [b-value:]
	equal? strict-equal? :a-value :b-value strict-equal? :b-value :a-value
]
#r2only
[
	a-value: first [a/b:]
	parse :a-value [b-value:]
	not strict-equal? :a-value :b-value
]
; bug#1068
; bug#1066
#r3only
[
	a-value: first [a/b:]
	parse :a-value [b-value:]
	strict-equal? :a-value :b-value
]
; symmetry
[
	a-value: first [a/b:]
	parse :a-value [b-value:]
	equal? strict-equal? :a-value :b-value strict-equal? :b-value :a-value
]
[not strict-equal? number! integer!]
; symmetry
[equal? strict-equal? number! integer! strict-equal? integer! number!]
; reflexivity
[strict-equal? -1 -1]
; reflexivity
[strict-equal? 0 0]
; reflexivity
[strict-equal? 1 1]
; reflexivity
[strict-equal? 0.0 0.0]
[strict-equal? 0.0 -0.0]
; reflexivity
[strict-equal? 1.0 1.0]
; reflexivity
[strict-equal? -1.0 -1.0]
; reflexivity
#64bit
[strict-equal? -9223372036854775808 -9223372036854775808]
; reflexivity
#64bit
[strict-equal? -9223372036854775807 -9223372036854775807]
; reflexivity
#64bit
[strict-equal? 9223372036854775807 9223372036854775807]
; -9223372036854775808 not strict-equal?
#64bit
[not strict-equal? -9223372036854775808 -9223372036854775807]
#64bit
[not strict-equal? -9223372036854775808 -1]
#64bit
[not strict-equal? -9223372036854775808 0]
#64bit
[not strict-equal? -9223372036854775808 1]
#64bit
[not strict-equal? -9223372036854775808 9223372036854775806]
#64bit
[not strict-equal? -9223372036854775808 9223372036854775807]
; -9223372036854775807 not strict-equal?
#64bit
[not strict-equal? -9223372036854775807 -9223372036854775808]
#64bit
[not strict-equal? -9223372036854775807 -1]
#64bit
[not strict-equal? -9223372036854775807 0]
#64bit
[not strict-equal? -9223372036854775807 1]
#64bit
[not strict-equal? -9223372036854775807 9223372036854775806]
#64bit
[not strict-equal? -9223372036854775807 9223372036854775807]
; -1 not strict-equal?
#64bit
[not strict-equal? -1 -9223372036854775808]
#64bit
[not strict-equal? -1 -9223372036854775807]
[not strict-equal? -1 0]
[not strict-equal? -1 1]
#64bit
[not strict-equal? -1 9223372036854775806]
#64bit
[not strict-equal? -1 9223372036854775807]
; 0 not strict-equal?
#64bit
[not strict-equal? 0 -9223372036854775808]
#64bit
[not strict-equal? 0 -9223372036854775807]
[not strict-equal? 0 -1]
[not strict-equal? 0 1]
#64bit
[not strict-equal? 0 9223372036854775806]
#64bit
[not strict-equal? 0 9223372036854775807]
; 1 not strict-equal?
#64bit
[not strict-equal? 1 -9223372036854775808]
#64bit
[not strict-equal? 1 -9223372036854775807]
[not strict-equal? 1 -1]
[not strict-equal? 1 0]
#64bit
[not strict-equal? 1 9223372036854775806]
#64bit
[not strict-equal? 1 9223372036854775807]
; 9223372036854775806 not strict-equal?
#64bit
[not strict-equal? 9223372036854775806 -9223372036854775808]
#64bit
[not strict-equal? 9223372036854775806 -9223372036854775807]
#64bit
[not strict-equal? 9223372036854775806 -1]
#64bit
[not strict-equal? 9223372036854775806 0]
#64bit
[not strict-equal? 9223372036854775806 1]
#64bit
[not strict-equal? 9223372036854775806 9223372036854775807]
; 9223372036854775807 not strict-equal?
#64bit
[not strict-equal? 9223372036854775807 -9223372036854775808]
#64bit
[not strict-equal? 9223372036854775807 -9223372036854775807]
#64bit
[not strict-equal? 9223372036854775807 -1]
#64bit
[not strict-equal? 9223372036854775807 0]
#64bit
[not strict-equal? 9223372036854775807 1]
#64bit
[not strict-equal? 9223372036854775807 9223372036854775806]
; "decimal tolerance"
[not strict-equal? to decimal! #{3FD3333333333333} to decimal! #{3FD3333333333334}]
; symmetry
[
	equal? strict-equal? to decimal! #{3FD3333333333333} to decimal! #{3FD3333333333334}
		strict-equal? to decimal! #{3FD3333333333334} to decimal! #{3FD3333333333333}
]
[not strict-equal? to decimal! #{3FB9999999999999} to decimal! #{3FB999999999999A}]
; symmetry
[
	equal? strict-equal? to decimal! #{3FB9999999999999} to decimal! #{3FB999999999999A}
		strict-equal? to decimal! #{3FB999999999999A} to decimal! #{3FB9999999999999}
]
; datatype differences
[not strict-equal? 0 0.0]
; datatype differences
[not strict-equal? 0 $0]
; datatype differences
#r3only
[not strict-equal? 0 0%]
; datatype differences
[not strict-equal? 0.0 $0]
; datatype differences
#r3only
[not strict-equal? 0.0 0%]
; datatype differences
#r3only
[not strict-equal? $0 0%]
; symmetry
[equal? strict-equal? 1 1.0 strict-equal? 1.0 1]
; symmetry
[equal? strict-equal? 1 $1 strict-equal? $1 1]
; symmetry
#r3only
[equal? strict-equal? 1 100% strict-equal? 100% 1]
; symmetry
[equal? strict-equal? 1.0 $1 strict-equal? $1 1.0]
; symmetry
#r3only
[equal? strict-equal? 1.0 100% strict-equal? 100% 1.0]
; symmetry
#r3only
[equal? strict-equal? $1 100% strict-equal? 100% $1]
; approximate equality
#r3only
[not strict-equal? 10% + 10% + 10% 30%]
; symmetry
#r3only
[equal? strict-equal? 10% + 10% + 10% 30% strict-equal? 30% 10% + 10% + 10%]
; date!; approximate equality
#r2only
[strict-equal? 2-Jul-2009 2-Jul-2009/22:20]
#r3only
[not strict-equal? 2-Jul-2009 2-Jul-2009/22:20]
; symmetry
[equal? strict-equal? 2-Jul-2009 2-Jul-2009/22:20 strict-equal? 2-Jul-2009/22:20 2-Jul-2009]
; missing time = 00:00:00+00:00, by time compatibility standards
#r2only
[strict-equal? 2-Jul-2009 2-Jul-2009/00:00:00+00:00]
#r3only
[not strict-equal? 2-Jul-2009 2-Jul-2009/00:00:00+00:00]
; symmetry
[equal? strict-equal? 2-Jul-2009 2-Jul-2009/00:00 strict-equal? 2-Jul-2009/00:00 2-Jul-2009]
; no timezone math in date!
[not strict-equal? 2-Jul-2009/22:20 2-Jul-2009/20:20-2:00]
; time!
[strict-equal? 00:00 00:00]
; char!; symmetry
[equal? strict-equal? #"a" 97 strict-equal? 97 #"a"]
; symmetry
[equal? strict-equal? #"a" 97.0 strict-equal? 97.0 #"a"]
; case
[not strict-equal? #"a" #"A"]
; case
[not strict-equal? "a" "A"]
; words; reflexivity
[strict-equal? 'a 'a]
; aliases
[not strict-equal? 'a 'A]
; symmetry
[equal? strict-equal? 'a 'A strict-equal? 'A 'a]
; binding
[not strict-equal? 'a use [a] ['a]]
; symmetry
[equal? strict-equal? 'a use [a] ['a] strict-equal? use [a] ['a] 'a]
; different word types
[not strict-equal? 'a first [:a]]
; symmetry
[equal? strict-equal? 'a first [:a] strict-equal? first [:a] 'a]
; different word types
[not strict-equal? 'a first ['a]]
; symmetry
[equal? strict-equal? 'a first ['a] strict-equal? first ['a] 'a]
; different word types
[not strict-equal? 'a /a]
; symmetry
[equal? strict-equal? 'a /a strict-equal? /a 'a]
; different word types
[not strict-equal? 'a first [a:]]
; symmetry
[equal? strict-equal? 'a first [a:] strict-equal? first [a:] 'a]
; reflexivity
[strict-equal? first [:a] first [:a]]
; different word types
[not strict-equal? first [:a] first ['a]]
; symmetry
[equal? strict-equal? first [:a] first ['a] strict-equal? first ['a] first [:a]]
; different word types
[not strict-equal? first [:a] /a]
; symmetry
[equal? strict-equal? first [:a] /a strict-equal? /a first [:a]]
; different word types
[not strict-equal? first [:a] first [a:]]
; symmetry
[equal? strict-equal? first [:a] first [a:] strict-equal? first [a:] first [:a]]
; reflexivity
[strict-equal? first ['a] first ['a]]
; different word types
[not strict-equal? first ['a] /a]
; symmetry
[equal? strict-equal? first ['a] /a strict-equal? /a first ['a]]
; different word types
[not strict-equal? first ['a] first [a:]]
; symmetry
[equal? strict-equal? first ['a] first [a:] strict-equal? first [a:] first ['a]]
; reflexivity
[strict-equal? /a /a]
; different word types
[not strict-equal? /a first [a:]]
; symmetry
[equal? strict-equal? /a first [a:] strict-equal? first [a:] /a]
; reflexivity
[strict-equal? first [a:] first [a:]]
; logic! values
[strict-equal? true true]
[strict-equal? false false]
[not strict-equal? true false]
[not strict-equal? false true]
; port! values; reflexivity; in this case the error should not be generated, I think
[
	p: make port! http://
	found? any [
		error? try [strict-equal? p p]
		strict-equal? p p
	]
]
; functions/comparison/strict-not-equalq.r
; bug#32
[strict-not-equal? 0 1]
; functions/context/bind.r
; bug#50
#r3only
[none? bind? to word! "zzz"]
; BIND works 'as expected' in object spec
; bug#1549
[
	b1: [self]
	ob: make object! [
	    b2: [self]
	    set 'a same? first b2 first bind/copy b1 'b2
	]
	a
]
; bug#1549
; BIND works 'as expected' in function body
[
	b1: [self]
	f: func [/local b2] [
	    b2: [self]
	    same? first b2 first bind/copy b1 'b2
	]
	f
]
; bug#1549
; BIND works 'as expected' in closure body
[
	b1: [self]
	f: closure [/local b2] [
	    b2: [self]
	    same? first b2 first bind/copy b1 'b2
	]
	f
]
; bug#1549
; BIND works 'as expected' in REPEAT body
[
	b1: [self]
	repeat i 1 [
	    b2: [self]
	    same? first b2 first bind/copy b1 'i
	]
]
; bug#1655
[not head? bind next [1] 'rebol]
; bug#892, bug#216
[y: 'x do has [x] [x: true get bind y 'x]]
; bug#1893
[
	word: do func [x] ['x] 1
	same? word bind 'x word
]
; bug#2086
[
	bind next block: [a a] use [a] ['a]
	same? 'a first block
]
; functions/context/boundq.r
; functions/context/bindq.r
[
	o: make object! [a: none]
	same? o bound? in o 'a
]
[
	o: make object! [a: none]
	same? bound? in o 'self bound? in o 'a
]
; functions/context/resolve.r
; bug#2017: crash in RESOLVE/extend/only
#r3only
[get in resolve/extend/only context [] context [a: true] [a] 'a]
; functions/context/set.r
; bug#1745
[equal? error? try [set /a 1] error? try [set [/a] 1]]
; bug#1745
[equal? error? try [set #a 1] error? try [set [#a] 1]]
; bug#1763
[a: 1 all [error? try [set [a] reduce [()]] a = 1]]
[a: 1 set [a] reduce [2 ()] a = 2]
[a: 1 attempt [set [a b] reduce [2 ()]] a = 1]
[x: construct [a: 1] all [error? try [set x reduce [()]] x/a = 1]]
[x: construct [a: 1] set x reduce [2 ()] x/a = 2]
[x: construct [a: 1 b: 2] all [error? try [set x reduce [3 ()]] x/a = 1]]
[a: 1 set/any [a] reduce [()] unset? get/any 'a]
[a: 1 b: 2 set/any [a b] reduce [3 ()] all [a = 3 unset? get/any 'b]]
[x: construct [a: 1] set/any x reduce [()] unset? get/any in x 'a]
[x: construct [a: 1 b: 2] set/any x reduce [3 ()] all [a = 3 unset? get/any in x 'b]]
; set [:get-word] [word]
[a: 1 b: none set [:b] [a] b =? 1]
[unset 'a b: none all [error? try [set [:b] [a]] none? b]]
[unset 'a b: none set/any [:b] [a] unset? get/any 'b]
; functions/context/unset.r
[
	a: none
	unset 'a
	not value? 'a
]
[
	a: none
	unset 'a
	unset 'a
	not value? 'a
]
; functions/context/use.r
; local word test
[
	a: 1
	use [a] [a: 2]
	a = 1
]
[
	a: 1
	error? try [use 'a [a: 2]]
	a = 1
]
[
	[x] = words-of bound? use [x] ['x]
]
[
	[x y] = words-of bound? use [x y] ['x]
]
; use does not bind special words
[
	same? 'self use [x] ['self]
]
[
	same? 'local use [x] ['local]
]
[
	same? 'return use [x] ['return]
]
[
	same? 'exit use [x] ['exit]
]
; initialization
#r2only
[use [a] [unset? get/any 'a]]
#r3only
[use [a] [none? :a]]
; BREAK out of USE
[
	1 = loop 1 [
		use [a] [break/return 1]
		2
	]
]
; THROW out of USE
[
	1 = catch [
		use [a] [throw 1]
		2
	]
]
; "error out" of USE
[
	error? try [
		use [a] [1 / 0]
		2
	]
]
; bug#539
; RETURN out of USE
[
	f: func [] [
		use [a] [return 1]
		2
	]
	1 = f
]
; bug#539
; EXIT out of USE
[
	f: func [] [
		use [] [exit]
		42
	]
	unset? f
]
; functions/context/valueq.r
[false == value? 'nonsense]
[true == value? 'value?]
; bug#1914
#r3only
[false == value? do func [x] ['x] none]
; functions/control/all.r
; zero values
[true == all []]
; one value
[:abs = all [:abs]]
[
	a-value: #{}
	same? a-value all [a-value]
]
[
	a-value: charset ""
	same? a-value all [a-value]
]
[
	a-value: []
	same? a-value all [a-value]
]
[
	a-value: none!
	same? a-value all [a-value]
]
[1/Jan/0000 = all [1/Jan/0000]]
[0.0 == all [0.0]]
[1.0 == all [1.0]]
[
	a-value: me@here.com
	same? a-value all [a-value]
]
[error? all [try [1 / 0]]]
[
	a-value: %""
	same? a-value all [a-value]
]
[
	a-value: does []
	same? :a-value all [:a-value]
]
[
	a-value: first [:a]
	:a-value == all [:a-value]
]
[#"^@" == all [#"^@"]]
[
	a-value: make image! 0x0
	same? a-value all [a-value]
]
[0 == all [0]]
[1 == all [1]]
[#a == all [#a]]
[
	a-value: first ['a/b]
	:a-value == all [:a-value]
]
[
	a-value: first ['a]
	:a-value == all [:a-value]
]
[true = all [true]]
[none? all [false]]
[$1 == all [$1]]
[same? :type? all [:type?]]
[none? all [#[none]]]
[
	a-value: make object! []
	same? :a-value all [:a-value]
]
[
	a-value: first [()]
	same? :a-value all [:a-value]
]
[same? get '+ all [get '+]]
[0x0 == all [0x0]]
[
	a-value: 'a/b
	:a-value == all [:a-value]
]
[
	a-value: make port! http://
	port? all [:a-value]
]
[/a == all [/a]]
[
	a-value: first [a/b:]
	:a-value == all [:a-value]
]
[
	a-value: first [a:]
	:a-value == all [:a-value]
]
[
	a-value: ""
	same? :a-value all [:a-value]
]
[
	a-value: make tag! ""
	same? :a-value all [:a-value]
]
[0:00 == all [0:00]]
[0.0.0 == all [0.0.0]]
[unset? all [()]]
['a == all ['a]]
; two values
[:abs = all [true :abs]]
[
	a-value: #{}
	same? a-value all [true a-value]
]
[
	a-value: charset ""
	same? a-value all [true a-value]
]
[
	a-value: []
	same? a-value all [true a-value]
]
[
	a-value: none!
	same? a-value all [true a-value]
]
[1/Jan/0000 = all [true 1/Jan/0000]]
[0.0 == all [true 0.0]]
[1.0 == all [true 1.0]]
[
	a-value: me@here.com
	same? a-value all [true a-value]
]
[error? all [true try [1 / 0]]]
[
	a-value: %""
	same? a-value all [true a-value]
]
[
	a-value: does []
	same? :a-value all [true :a-value]
]
[
	a-value: first [:a]
	same? :a-value all [true :a-value]
]
[#"^@" == all [true #"^@"]]
[
	a-value: make image! 0x0
	same? a-value all [true a-value]
]
[0 == all [true 0]]
[1 == all [true 1]]
[#a == all [true #a]]
[
	a-value: first ['a/b]
	:a-value == all [true :a-value]
]
[
	a-value: first ['a]
	:a-value == all [true :a-value]
]
[$1 == all [true $1]]
[same? :type? all [true :type?]]
[none? all [true #[none]]]
[
	a-value: make object! []
	same? :a-value all [true :a-value]
]
[
	a-value: first [()]
	same? :a-value all [true :a-value]
]
[same? get '+ all [true get '+]]
[0x0 == all [true 0x0]]
[
	a-value: 'a/b
	:a-value == all [true :a-value]
]
[
	a-value: make port! http://
	port? all [true :a-value]
]
[/a == all [true /a]]
[
	a-value: first [a/b:]
	:a-value == all [true :a-value]
]
[
	a-value: first [a:]
	:a-value == all [true :a-value]
]
[
	a-value: ""
	same? :a-value all [true :a-value]
]
[
	a-value: make tag! ""
	same? :a-value all [true :a-value]
]
[0:00 == all [true 0:00]]
[0.0.0 == all [true 0.0.0]]
[unset? all [true ()]]
['a == all [true 'a]]
[true = all [:abs true]]
[
	a-value: #{}
	true = all [a-value true]
]
[
	a-value: charset ""
	true = all [a-value true]
]
[
	a-value: []
	true = all [a-value true]
]
[
	a-value: none!
	true = all [a-value true]
]
[true = all [1/Jan/0000 true]]
[true = all [0.0 true]]
[true = all [1.0 true]]
[
	a-value: me@here.com
	true = all [a-value true]
]
[true = all [try [1 / 0] true]]
[
	a-value: %""
	true = all [a-value true]
]
[
	a-value: does []
	true = all [:a-value true]
]
[
	a-value: first [:a]
	true = all [:a-value true]
]
[true = all [#"^@" true]]
[
	a-value: make image! 0x0
	true = all [a-value true]
]
[true = all [0 true]]
[true = all [1 true]]
[true = all [#a true]]
[
	a-value: first ['a/b]
	true = all [:a-value true]
]
[
	a-value: first ['a]
	true = all [:a-value true]
]
[true = all [true true]]
[none? all [false true]]
[none? all [true false]]
[true = all [$1 true]]
[true = all [:type? true]]
[none? all [#[none] true]]
[
	a-value: make object! []
	true = all [:a-value true]
]
[
	a-value: first [()]
	true = all [:a-value true]
]
[true = all [get '+ true]]
[true = all [0x0 true]]
[
	a-value: 'a/b
	true = all [:a-value true]
]
[
	a-value: make port! http://
	true = all [:a-value true]
]
[true = all [/a true]]
[
	a-value: first [a/b:]
	true = all [:a-value true]
]
[
	a-value: first [a:]
	true = all [:a-value true]
]
[
	a-value: ""
	true = all [:a-value true]
]
[
	a-value: make tag! ""
	true = all [:a-value true]
]
[true = all [0:00 true]]
[true = all [0.0.0 true]]
[true = all [() true]]
[true = all ['a true]]
; evaluation stops after encountering FALSE or NONE
[
	success: true
	all [false success: false]
	success
]
[
	success: true
	all [none success: false]
	success
]
; evaluation continues otherwise
[
	success: false
	all [true success: true]
	success
]
[
	success: false
	all [1 success: true]
	success
]
; RETURN stops evaluation
[
	f1: does [all [return 1 2] 2]
	1 = f1
]
; THROW stops evaluation
[
	1 = catch [
		all [
			throw 1
			2
		]
	]
]
; BREAK stops evaluation
[
	1 = loop 1 [
		all [
			break/return 1
			2
		]
	]
]
; recursivity
[all [true all [true]]]
[not all [true all [false]]]
; infinite recursion
[
	blk: [all blk]
	error? try blk
]
; functions/control/any.r
; zero values
[none? any []]
; one value
[:abs = any [:abs]]
[
	a-value: #{}
	same? a-value any [a-value]
]
[
	a-value: charset ""
	same? a-value any [a-value]
]
[
	a-value: []
	same? a-value any [a-value]
]
[
	a-value: none!
	same? a-value any [a-value]
]
[1/Jan/0000 = any [1/Jan/0000]]
[0.0 == any [0.0]]
[1.0 == any [1.0]]
[
	a-value: me@here.com
	same? a-value any [a-value]
]
[error? any [try [1 / 0]]]
[
	a-value: %""
	same? a-value any [a-value]
]
[
	a-value: does []
	same? :a-value any [:a-value]
]
[
	a-value: first [:a]
	:a-value == any [:a-value]
]
[#"^@" == any [#"^@"]]
[
	a-value: make image! 0x0
	same? a-value any [a-value]
]
[0 == any [0]]
[1 == any [1]]
[#a == any [#a]]
[
	a-value: first ['a/b]
	:a-value == any [:a-value]
]
[
	a-value: first ['a]
	:a-value == any [:a-value]
]
[true = any [true]]
[none? any [false]]
[$1 == any [$1]]
[same? :type? any [:type?]]
[none? any [#[none]]]
[
	a-value: make object! []
	same? :a-value any [:a-value]
]
[
	a-value: first [()]
	same? :a-value any [:a-value]
]
[same? get '+ any [get '+]]
[0x0 == any [0x0]]
[
	a-value: 'a/b
	:a-value == any [:a-value]
]
[
	a-value: make port! http://
	port? any [:a-value]
]
[/a == any [/a]]
; set-path test
[
	a-value: first [a/b:]
	:a-value == any [:a-value]
]
[
	a-value: first [a:]
	:a-value == any [:a-value]
]
[
	a-value: ""
	same? :a-value any [:a-value]
]
[
	a-value: make tag! ""
	same? :a-value any [:a-value]
]
[0:00 == any [0:00]]
[0.0.0 == any [0.0.0]]
#r2only
[unset? any [()]]
#r3only
[none? any [()]]
['a == any ['a]]
; two values
[:abs = any [false :abs]]
[
	a-value: #{}
	same? a-value any [false a-value]
]
[
	a-value: charset ""
	same? a-value any [false a-value]
]
[
	a-value: []
	same? a-value any [false a-value]
]
[
	a-value: none!
	same? a-value any [false a-value]
]
[1/Jan/0000 = any [false 1/Jan/0000]]
[0.0 == any [false 0.0]]
[1.0 == any [false 1.0]]
[
	a-value: me@here.com
	same? a-value any [false a-value]
]
[error? any [false try [1 / 0]]]
[
	a-value: %""
	same? a-value any [false a-value]
]
[
	a-value: does []
	same? :a-value any [false :a-value]
]
[
	a-value: first [:a]
	:a-value == any [false :a-value]
]
[#"^@" == any [false #"^@"]]
[
	a-value: make image! 0x0
	same? a-value any [false a-value]
]
[0 == any [false 0]]
[1 == any [false 1]]
[#a == any [false #a]]
[
	a-value: first ['a/b]
	:a-value == any [false :a-value]
]
[
	a-value: first ['a]
	:a-value == any [false :a-value]
]
[true = any [false true]]
[none? any [false false]]
[$1 == any [false $1]]
[same? :type? any [false :type?]]
[none? any [false #[none]]]
[
	a-value: make object! []
	same? :a-value any [false :a-value]
]
[
	a-value: first [()]
	same? :a-value any [false :a-value]
]
[same? get '+ any [false get '+]]
[0x0 == any [false 0x0]]
[
	a-value: 'a/b
	:a-value == any [false :a-value]
]
[
	a-value: make port! http://
	port? any [false :a-value]
]
[/a == any [false /a]]
[
	a-value: first [a/b:]
	:a-value == any [false :a-value]
]
[
	a-value: first [a:]
	:a-value == any [false :a-value]
]
[
	a-value: ""
	same? :a-value any [false :a-value]
]
[
	a-value: make tag! ""
	same? :a-value any [false :a-value]
]
[0:00 == any [false 0:00]]
[0.0.0 == any [false 0.0.0]]
#r2only
[unset? any [false ()]]
#r3only
[none? any [false ()]]
['a == any [false 'a]]
[:abs = any [:abs false]]
[
	a-value: #{}
	same? a-value any [a-value false]
]
[
	a-value: charset ""
	same? a-value any [a-value false]
]
[
	a-value: []
	same? a-value any [a-value false]
]
[
	a-value: none!
	same? a-value any [a-value false]
]
[1/Jan/0000 = any [1/Jan/0000 false]]
[0.0 == any [0.0 false]]
[1.0 == any [1.0 false]]
[
	a-value: me@here.com
	same? a-value any [a-value false]
]
[error? any [try [1 / 0] false]]
[
	a-value: %""
	same? a-value any [a-value false]
]
[
	a-value: does []
	same? :a-value any [:a-value false]
]
[
	a-value: first [:a]
	:a-value == any [:a-value false]
]
[#"^@" == any [#"^@" false]]
[
	a-value: make image! 0x0
	same? a-value any [a-value false]
]
[0 == any [0 false]]
[1 == any [1 false]]
[#a == any [#a false]]
[
	a-value: first ['a/b]
	:a-value == any [:a-value false]
]
[
	a-value: first ['a]
	:a-value == any [:a-value false]
]
[true = any [true false]]
[$1 == any [$1 false]]
[same? :type? any [:type? false]]
[none? any [#[none] false]]
[
	a-value: make object! []
	same? :a-value any [:a-value false]
]
[
	a-value: first [()]
	same? :a-value any [:a-value false]
]
[same? get '+ any [get '+ false]]
[0x0 == any [0x0 false]]
[
	a-value: 'a/b
	:a-value == any [:a-value false]
]
[
	a-value: make port! http://
	port? any [:a-value false]
]
[/a == any [/a false]]
[
	a-value: first [a/b:]
	:a-value == any [:a-value false]
]
[
	a-value: first [a:]
	:a-value == any [:a-value false]
]
[
	a-value: ""
	same? :a-value any [:a-value false]
]
[
	a-value: make tag! ""
	same? :a-value any [:a-value false]
]
[0:00 == any [0:00 false]]
[0.0.0 == any [0.0.0 false]]
#r2only
[unset? any [() false]]
#r3only
[none? any [() false]]
['a == any ['a false]]
; evaluation stops after encountering something else than FALSE or NONE
[
	success: true
	any [true success: false]
	success
]
[
	success: true
	any [1 success: false]
	success
]
; evaluation continues otherwise
[
	success: false
	any [false success: true]
	success
]
[
	success: false
	any [none success: true]
	success
]
; RETURN stops evaluation
[
	f1: does [any [return 1 2] 2]
	1 = f1
]
; THROW stops evaluation
[
	1 = catch [
		any [
			throw 1
			2
		]
	]
]
; BREAK stops evaluation
[
	1 = loop 1 [
		any [
			break/return 1
			2
		]
	]
]
; recursivity
[any [false any [true]]]
[none? any [false any [false]]]
; infinite recursion
[
	blk: [any blk]
	error? try blk
]
; functions/control/apply.r
; bug#44
[error? try [apply 'type?/word []]]
; bug#1949: RETURN/redo can break APPLY security
[same? :add attempt [apply does [return/redo :add] []]]
; DO is special
[2 == do does [return apply :do [:add 1 1] 4 4]]
[1 == apply :subtract [2 1]]
#r3only
[1 == apply :- [2 1]]
#r2only
[-2 == apply :- [2]]
[none == apply func [a] [a] []]
[none == apply/only func [a] [a] []]
[1 == apply func [a] [a] [1 2]]
[1 == apply/only func [a] [a] [1 2]]
[true == apply func [/a] [a] [true]]
[none == apply func [/a] [a] [false]]
[none == apply func [/a] [a] []]
[true == apply/only func [/a] [a] [true]]
; the word 'false
[true == apply/only func [/a] [a] [false]]
[false == apply/only func [/a] [a] [#[false]]]
[none == apply/only func [/a] [a] []]
[use [a] [a: true true == apply func [/a] [a] [a]]]
[use [a] [a: false none == apply func [/a] [a] [a]]]
[use [a] [a: false true == apply func [/a] [a] ['a]]]
[use [a] [a: false true == apply func [/a] [a] [/a]]]
[use [a] [a: false true == apply/only func [/a] [a] [a]]]
[paren! == apply/only :type? [()]]
['paren! == apply/only :type? [() true]]
[[1] == head apply :insert [copy [] [1] none none none]]
[[1] == head apply :insert [copy [] [1] none none false]]
[[[1]] == head apply :insert [copy [] [1] none none true]]
[native! == apply :type? [:print]]
[get-word! == apply/only :type? [:print]]
[1 == do does [apply :return [1] 2]]
; bug#1760
[1 == do does [apply does [] [return 1] 2]]
; bug#1760
[1 == do does [apply func [a] [a] [return 1] 2]]
; bug#1760
[1 == do does [apply does [] [return 1]]]
[1 == do does [apply func [a] [a] [return 1]]]
[1 == do does [apply :also [return 1 2]]]
; bug#1760
[1 == do does [apply :also [2 return 1]]]
[unset? apply func [x [any-type!]] [get/any 'x] [()]]
[unset? apply func ['x [any-type!]] [get/any 'x] [()]]
[unset? apply func [:x [any-type!]] [get/any 'x] [()]]
[unset? apply func [x [any-type!]] [return get/any 'x] [()]]
[unset? apply func ['x [any-type!]] [return get/any 'x] [()]]
[unset? apply func [:x [any-type!]] [return get/any 'x] [()]]
[error? apply :make [error! ""]]
#r3only
[error? apply func [:x [any-type!]] [return get/any 'x] [make error! ""]]
[
	error? apply/only func [x [any-type!]] [
		return get/any 'x
	] head insert copy [] make error! ""
]
[
	error? apply/only func ['x [any-type!]] [
		return get/any 'x
	] head insert copy [] make error! ""
]
[
	error? apply/only func [:x [any-type!]] [
		return get/any 'x
	] head insert copy [] make error! ""
]
[use [x] [x: 1 strict-equal? 1 apply func ['x] [:x] [:x]]]
[use [x] [x: 1 strict-equal? first [:x] apply/only func ['x] [:x] [:x]]]
[
	use [x] [
		unset 'x
		strict-equal? first [:x] apply/only func ['x [any-type!]] [
			return get/any 'x
		] [:x]
	]
]
[use [x] [x: 1 strict-equal? 1 apply func [:x] [:x] [x]]]
[use [x] [x: 1 strict-equal? 'x apply func [:x] [:x] ['x]]]
[use [x] [x: 1 strict-equal? 'x apply/only func [:x] [:x] [x]]]
[use [x] [x: 1 strict-equal? 'x apply/only func [:x] [return :x] [x]]]
[
	use [x] [
		unset 'x
		strict-equal? 'x apply/only func [:x [any-type!]] [
			return get/any 'x
		] [x]
	]
]
; functions/control/attempt.r
; bug#41
[none? attempt [1 / 0]]
[1 = attempt [1]]
[unset? attempt []]
; RETURN stops attempt evaluation
[
	f1: does [attempt [return 1 2] 2]
	1 == f1
]
; THROW stops attempt evaluation
[1 == catch [attempt [throw 1 2] 2]]
; BREAK stops attempt evaluation
[unset? loop 1 [attempt [break 2] 2]]
[1 == loop 1 [attempt [break/return 1 2] 2]]
; recursion
[1 = attempt [attempt [1]]]
[none? attempt [attempt [1 / 0]]]
; infinite recursion
[
	blk: [attempt blk]
	none? attempt blk
]
; functions/control/break.r
; see loop functions for basic breaking functionality
; just testing return values, but written as if break could fail altogether
; in case that becomes an issue. break failure tests are with the functions
; that they are failing to break from.
; break should return #[unset!]
[unset? loop 1 [break 2]]
; break/return should return argument
[none? loop 1 [break/return none 2]]
[false =? loop 1 [break/return false 2]]
[true =? loop 1 [break/return true 2]]
[unset? loop 1 [break/return () 2]]
[error? loop 1 [break/return try [1 / 0] 2]]
; the "result" of break should not be assignable, bug#1515
[a: 1 loop 1 [a: break] :a =? 1]
[a: 1 loop 1 [set 'a break] :a =? 1]
[a: 1 loop 1 [set/any 'a break] :a =? 1]
[a: 1 loop 1 [a: break/return 2] :a =? 1]
[a: 1 loop 1 [set 'a break/return 2] :a =? 1]
[a: 1 loop 1 [set/any 'a break/return 2] :a =? 1]
; the "result" of break should not be passable to functions, bug#1509
[a: 1 loop 1 [a: error? break] :a =? 1] ; error? function takes 1 arg
[a: 1 loop 1 [a: error? break/return 2] :a =? 1]
[a: 1 loop 1 [a: type? break] :a =? 1] ; type? function takes 1-2 args
[foo: func [x y] [9] a: 1 loop 1 [a: foo break 5] :a =? 1] ; foo takes 2 args
[foo: func [x y] [9] a: 1 loop 1 [a: foo 5 break] :a =? 1]
[foo: func [x y] [9] a: 1 loop 1 [a: foo break break] :a =? 1]
; check that BREAK is evaluated (and not CONTINUE):
[foo: func [x y] [] a: 1 loop 2 [a: a + 1 foo break continue a: a + 10] :a =? 2]
#r3
; check that BREAK is not evaluated (but CONTINUE is):
[foo: func [x y] [] a: 1 loop 2 [a: a + 1 foo continue break a: a + 10] :a =? 3]
; bug#1535
[loop 1 [words-of break] true]
[loop 1 [values-of break] true]
; bug#1945
[loop 1 [spec-of break] true]
; the "result" of break should not be caught by try
[a: 1 loop 1 [a: error? try [break]] :a =? 1]
; functions/control/case.r
[
	success: false
	case [true [success: true]]
	success
]
[
	success: true
	case [false [success: false]]
	success
]
; not sure these are consistent with other control functions
[not case []]
[logic! = type? case [true []]]
; case results
[case [true [true]]]
[not case [true [false]]]
; RETURN stops evaluation
[
	f1: does [case [return 1 2]]
	1 = f1
]
; THROW stops evaluation
[
	1 = catch [
		case [throw 1 2]
		2
	]
]
; BREAK stops evaluation
[
	1 = loop 1 [
		case [break/return 1 2]
		2
	]
]
; /all refinement
; bug#86
[
	s1: false
	s2: false
	case/all [
		true [s1: true]
		true [s2: true]
	]
	s1 and s2
]
; recursivity
[1 = case [true [case [true [1]]]]]
; infinite recursion
[
	blk: [case blk]
	error? try blk
]
; functions/control/catch.r
; see also functions/control/throw.r
[
	catch [
		throw success: true
		sucess: false
	]
	success
]
; catch results
[unset? catch []]
[unset? catch [()]]
#r3only
[error? catch [try [1 / 0]]]
[1 = catch [1]]
[unset? catch [throw ()]]
[error? catch [throw try [1 / 0]]]
[1 = catch [throw 1]]
; catch/name results
[unset? catch/name [] 'catch]
[unset? catch/name [()] 'catch]
#r3only
[error? catch/name [try [1 / 0]] 'catch]
[1 = catch/name [1] 'catch]
[unset? catch/name [throw/name () 'catch] 'catch]
[error? catch/name [throw/name try [1 / 0] 'catch] 'catch]
[1 = catch/name [throw/name 1 'catch] 'catch]
; recursive cases
[
	num: 1
	catch [
		catch [throw 1]
		num: 2
	]
	2 = num
]
[
	num: 1
	catch [
		catch/name [
			throw 1
		] 'catch
		num: 2
	]
	1 = num
]
[
	num: 1
	catch/name [
		catch [throw 1]
		num: 2
	] 'catch
	2 = num
]
[
	num: 1
	catch/name [
		catch/name [
			throw/name 1 'name
		] 'name
		num: 2
	] 'name
	2 = num
]
; CATCH and RETURN
[
	f: does [catch [return 1] 2]
	1 = f
]
; CATCH and BREAK
[
	1 = loop 1 [
		catch [break/return 1 2]
		2
	]
]
; CATCH/QUIT
#r3only
[
	catch/quit [quit]
	true
]
; bug#851
#r3only
[error? try [catch/quit [] do make error! ""]]
; bug#851
[none? attempt [catch/quit [] do make error! ""]]
; functions/control/compose.r
[
	num: 1
	[1 num] = compose [(num) num]
]
[[] = compose []]
[
	blk: []
	append blk [try [1 / 0]]
	blk = compose blk
]
[
	blk: reduce [()]
	blk = compose blk
]
; RETURN stops the evaluation
[
	f1: does [compose [(return 1)] 2]
	1 = f1
]
; THROW stops the evaluation
[1 = catch [compose [(throw 1 2)] 2]]
; BREAK stops the evaluation
[1 = loop 1 [compose [(break/return 1 2)] 2]]
; Test that errors do not stop the evaluation:
#r3only
[block? compose [(try [1 / 0])]]
[
	blk: []
	not same? blk compose blk
]
[
	blk: [[]]
	same? first blk first compose blk
]
[
	blk: []
	same? blk first compose [(reduce [blk])]
]
[
	blk: []
	same? blk first compose/only [(blk)]
]
; recursion
[
	num: 1
	[num 1] = compose [num (compose [(num)])]
]
; infinite recursion
[
	blk: [(compose blk)]
	error? try blk
]
; #1906
[
	b: copy [] insert/dup b 1 32768 compose b
]
; functions/control/continue.r
; see loop functions for basic continuing functionality
; the "result" of continue should not be assignable, bug#1515
#r3only
[a: 1 loop 1 [a: continue] :a =? 1]
#r3only
[a: 1 loop 1 [set 'a continue] :a =? 1]
#r3only
[a: 1 loop 1 [set/any 'a continue] :a =? 1]
; the "result" of continue should not be passable to functions, bug#1509
#r3only
[a: 1 loop 1 [a: error? continue] :a =? 1]
; bug#1535
#r3only
[loop 1 [words-of continue] true]
#r3only
[loop 1 [values-of continue] true]
; bug#1945
#r3only
[loop 1 [spec-of continue] true]
; continue should not be caught by try
#r3only
[a: 1 loop 1 [a: error? try [continue]] :a =? 1]
; functions/control/disarm.r
#r2only
[object? disarm try [1 / 0]]
; functions/control/do.r
[
	success: false
	do [success: true]
	success
]
#r2only
[
	a-value: #{}
	same? a-value do a-value
]
#r3only
[
	a-value: to binary! "1 + 1"
	2 == do a-value
]
[
	a-value: charset ""
	same? a-value do a-value
]
; do block start
[unset? do []]
[:abs = do [:abs]]
[
	a-value: #{}
	same? a-value do reduce [a-value]
]
[
	a-value: charset ""
	same? a-value do reduce [a-value]
]
[
	a-value: []
	same? a-value do reduce [a-value]
]
[same? none! do reduce [none!]]
[1/Jan/0000 = do [1/Jan/0000]]
[0.0 == do [0.0]]
[1.0 == do [1.0]]
[
	a-value: me@here.com
	same? a-value do reduce [a-value]
]
#r3only
[error? do [try [1 / 0]]]
[
	a-value: %""
	same? a-value do reduce [a-value]
]
[
	a-value: does []
	same? :a-value do [:a-value]
]
[
	a-value: first [:a-value]
	:a-value == do reduce [:a-value]
]
[#"^@" == do [#"^@"]]
[
	a-value: make image! 0x0
	same? a-value do reduce [a-value]
]
[0 == do [0]]
[1 == do [1]]
[#a == do [#a]]
[
	a-value: first ['a/b]
	:a-value == do [:a-value]
]
[
	a-value: first ['a]
	:a-value == do [:a-value]
]
[#[true] == do [#[true]]]
[#[false] == do [#[false]]]
[$1 == do [$1]]
[same? :type? do [:type?]]
[none? do [#[none]]]
[
	a-value: make object! []
	same? :a-value do reduce [:a-value]
]
[
	a-value: first [()]
	same? :a-value do [:a-value]
]
[same? get '+ do [get '+]]
[0x0 == do [0x0]]
[
	a-value: 'a/b
	:a-value == do [:a-value]
]
[
	a-value: make port! http://
	port? do reduce [:a-value]
]
[/a == do [/a]]
[
	a-value: first [a/b:]
	:a-value == do [:a-value]
]
[
	a-value: first [a:]
	:a-value == do [:a-value]
]
[
	a-value: ""
	same? :a-value do reduce [:a-value]
]
[
	a-value: make tag! ""
	same? :a-value do reduce [:a-value]
]
[0:00 == do [0:00]]
[0.0.0 == do [0.0.0]]
[unset? do [()]]
['a == do ['a]]
; do block end
[
	a-value: none!
	same? a-value do a-value
]
[1/Jan/0000 == do 1/Jan/0000]
[0.0 == do 0.0]
[1.0 == do 1.0]
[
	a-value: me@here.com
	same? a-value do a-value
]
#r3only
[error? try [do try [1 / 0] 1]]
[
	a-value: does [5]
	5 == do :a-value
]
#r2only
[
	a: 12
	a-value: first [:a]
	:a-value == do :a-value
]
#r3only
[
	a: 12
	a-value: first [:a]
	:a == do :a-value
]
[#"^@" == do #"^@"]
[
	a-value: make image! 0x0
	same? a-value do a-value
]
[0 == do 0]
[1 == do 1]
[#a == do #a]
[
	a-value: first ['a/b]
	:a-value == do :a-value
]
#r2only
[
	a-value: first ['a]
	:a-value == do :a-value
]
#r3only
[
	a-value: first ['a]
	a-value == do :a-value
]
[true = do true]
[false = do false]
[$1 == do $1]
[unset! = do :type? ()]
[none? do #[none]]
[
	a-value: make object! []
	same? :a-value do :a-value
]
[
	a-value: first [(2)]
	2 == do :a-value
]
#r2only
[
	a-value: 'a/b
	a: make object! [b: 1]
	1 == do :a-value
]
#r3only
[
	a-value: 'a/b
	a: make object! [b: 1]
	a-value == do :a-value
]
[
	a-value: make port! http://
	port? do :a-value
]
[
	a-value: first [a/b:]
	:a-value == do :a-value
]
#r2only
[
	a-value: first [a:]
	:a-value == do :a-value
]
[
	a-value: "1"
	1 == do :a-value
]
[unset? do ""]
[1 = do "1"]
[3 = do "1 2 3"]
[
	a-value: make tag! ""
	same? :a-value do :a-value
]
[0:00 == do 0:00]
[0.0.0 == do 0.0.0]
[
	a-value: 'b-value
	b-value: 1
	1 == do :a-value
]
; RETURN stops the evaluation
[
	f1: does [do [return 1 2] 2]
	1 = f1
]
; bug#539
[
	f1: does [do "return 1 2" 2]
	1 = f1
]
; THROW stops evaluation
[
	1 = catch [
		do [
			throw 1
			2
		]
		2
	]
]
; BREAK stops evaluation
[
	1 = loop 1 [
		do [
			break/return 1
			2
		]
		2
	]
]
; do/next block tests
#r2only
[
	success: false
	do/next [success: true success: false]
	success
]
#r3only
[
	success: false
	do/next [success: true success: false] 'b
	success
]
#r2only
[[1 [2]] = do/next [1 2]]
#r3only
[
	all [
		1 = do/next [1 2] 'b
		[2] = b
	]
]
#r2only
[unset? first do/next []]
#r3only
[unset? do/next [] 'b]
#r3only
[error? do/next [try [1 / 0]] 'b]
; RETURN stops the evaluation
#r2only
[
	f1: does [do/next [return 1 2] 2]
	1 = f1
]
#r3only
[
	f1: does [do/next [return 1 2] 'b 2]
	1 = f1
]
; recursive behaviour
[1 = do [do [1]]]
[1 = do "do [1]"]
[1 == 1]
[3 = do :do :add 1 2]
; infinite recursion for block
[
	blk: [do blk]
	error? try blk
]
; infinite recursion for string
; bug#1896
[
	str: "do str"
	error? try [do str]
]
; infinite recursion for do/next
#r2only
[
	blk: [do/next blk]
	error? try blk
]
#r3only
[
	blk: [do/next blk 'b]
	error? try blk
]
; are error reports for do and do/next consistent?
#r2only
[
	val1: disarm try [do [1 / 0]]
	val2: disarm try [do/next [1 / 0]]
	val1/near = val2/near
]
#r3only
[
	val1: try [do [1 / 0]]
	val2: try [do/next [1 / 0] 'b]
	val1/near = val2/near
]
; functions/control/either.r
[
	either true [success: true] [success: false]
	success
]
[
	either false [success: false] [success: true]
	success
]
[1 = either true [1] [2]]
[2 = either false [1] [2]]
[unset? either true [] [1]]
[unset? either false [1] []]
#r3only
[error? either true [try [1 / 0]] []]
#r3only
[error? either false [] [try [1 / 0]]]
; RETURN stops the evaluation
[
	f1: does [
		either true [return 1 2] [2]
		2
	]
	1 = f1
]
[
	f1: does [
		either false [2] [return 1 2]
		2
	]
	1 = f1
]
; THROW stops the evaluation
[
	1 == catch [
		either true [throw 1 2] [2]
		2
	]
]
[
	1 == catch [
		either false [2] [throw 1 2]
		2
	]
]
; BREAK stops the evaluation
[
	1 == loop 1 [
		either true [break/return 1 2] [2]
		2
	]
]
[
	1 == loop 1 [
		either false [2] [break/return 1 2]
		2
	]
]
; recursive behaviour
[2 = either true [either false [1] [2]] []]
[1 = either false [] [either true [1] [2]]]
; infinite recursion
[
	blk: [either true blk []]
	error? try blk
]
[
	blk: [either false [] blk]
	error? try blk
]
; functions/control/else.r
#r2only
[error? err: try [else] c: disarm err c/id = 'else-gone]
#r3only
[error? err: try [else] c: err c/id = 'no-value]
; functions/control/exit.r
[
	success: true
	f1: does [exit success: false]
	f1
	success
]
[
	f1: does [exit]
	unset? f1
]
; the "result" of exit should not be assignable, bug#1515
[a: 1 do does [a: exit] :a =? 1]
[a: 1 do does [set 'a exit] :a =? 1]
[a: 1 do does [set/any 'a exit] :a =? 1]
; the "result" of exit should not be passable to functions, bug#1509
[a: 1 do does [a: error? exit] :a =? 1]
; bug#1535
[do does [words-of exit] true]
[do does [values-of exit] true]
; bug#1945
[do does [spec-of exit] true]
; exit should not be caught by try
[a: 1 do does [a: error? try [exit]] :a =? 1]
; functions/control/for.r
[
	; traverse all values
	success: true
	num: 0
	for i 1 10 1 [
		num: num + 1
		success: i == num and success
	]
	10 == num and success
]
[
	; cycle value
	false == for i 1 1 1 [false]
]
[
	; #[unset!] cycle value
	unset? for i 1 1 1 []
]
[
	; break stops the cycle
	num: 0
	for i 1 10 1 [
		num: num + 1
		break
	]
	num == 1
]
[
	; break cycle value
	unset? for i 1 10 1 [break]
]
[
	; break/return stops the cycle
	num: 0
	for i 1 10 1 [
		num: num + 1
		break/return -1
	]
	num == 1
]
[
	; break/return cycle value
	-1 == for i 1 10 1 [break/return -1 i]
]
#r3only
[
	; continue cycle
	; bug#58
	success: true
	for i 1 1 1 [continue success: false]
	success
]
#r3only
[
	; string!, continue cycle
	success: true
	x: "a"
	for i x tail x 1 [continue success: false]
	success
]
[
	; string! all values
	out: copy ""
	for i s: "abc" back tail s 1 [append out i]
	out = "abcbcc"
]
[
	; block! all values
	out: copy []
	for i b: [1 2 3] back tail b 1 [append out i]
	out = [1 2 3 2 3 3]
]
[
	; block! cycle end for positive BUMP
	num: 0
	1 == for i b: [1 2 3] tail b 4 [
		num: num + 1
		if num > 2 [break/return -1]
		index? i
	]
]
[
	; block! cycle end for negative BUMP
	num: 0
	3 == for i back tail b: [1 2 3] b -3 [
		num: num + 1
		if num > 2 [break/return -1]
		index? i
	]
]
[
	; zero repetition
	success: true
	for i 1 0 1 [success: false]
	success
]
[
	; block! zero repetition
	success: true
	for i b: [1] tail :b -1 [success: false]
	success
]
[
	; return stops the loop
	f1: does [for i 1 1 1 [return 1 2] 2]
	1 == f1
]
#r3only
[
	; errors do not stop the loop and can become cycle value
	num: 0
	e: for i 1 2 1 [num: i try [1 / 0]]
	all [error? e num == 2]
]
; infinite loop tests
[
	; block! with zero bump
	num: 0
	for i s: [1] tail s 0 [
		num: num + 1
		if num > 1 [break]
	]
	num > 1
]
[
	; block! with zero bump
	num: 0
	for i tail s: [1] s 0 [
		num: num + 1
		if num > 1 [break]
	]
	num > 1
]
[
	; block! with zero bump, equal bounds and skip
	num: 0
	for i s: next [1 2] s 0 [
		num: num + 1
		if num > 1 [break]
		i: next i
	]
	num == 1
]
[
	; block! with zero bump, equal bounds and backward skip
	num: 0
	for i s: next [1 2] s 0 [
		num: num + 1
		if num > 1 [break]
		i: back i
	]
	num == 1
]
[
	; block! with zero bump, different bounds and skip
	num: 0
	for i s: next [1 2 3] next s 0 [
		num: num + 1
		if num > 2 [break]
		i: next i
	]
	num == 2
]
[
	; block! with zero bump, different bounds and skip
	num: 0
	for i next s: next [1 2 3] s 0 [
		num: num + 1
		if num > 2 [break]
		i: next i
	]
	num == 3
]
[
	; block! with zero bump, different bounds and backward skip
	num: 0
	for i s: next [1 2 3] next s 0 [
		num: num + 1
		if num > 2 [break]
		i: back i
	]
	num == 3
]
[
	; block! with zero bump, different bounds and backward skip
	num: 0
	for i next s: next [1 2 3] s 0 [
		num: num + 1
		if num > 2 [break]
		i: back i
	]
	num == 2
]
[
	; block with invalid word reference
	num: 0
	error? try [
		for i next s: next [1 2 3] s 0 [
			num: num + 1
			if num > 1 [break]
			i: 0
		]
	]
]
[
	; block with invalid word reference
	num: 0
	error? try [
		for i next s: next [1 2 3] s 0 [
			num: num + 1
			if num > 1 [break]
			i: []
		]
	]
]
[
	num: 0
	for i b: [1] tail b 1 [
		num: num + 1
		if num > 2 [break]
	]
	num <= 2
]
[
	num: 0
	for i 2147483647 2147483647 1 [
		num: num + 1
		either num > 1 [break/return false] [true]
	]
]
[
	num: 0
	for i -2147483648 -2147483648 -1 [
		num: num + 1
		either num > 1 [break/return false] [true]
	]
]
; bug#1136
#64bit
[
	num: 0
	for i 9223372036854775807 9223372036854775807 1 [
		num: num + 1
		either num > 1 [break/return false] [true]
	]
]
#64bit
[
	num: 0
	for i -9223372036854775808 -9223372036854775808 -1 [
		num: num + 1
		either num > 1 [break/return false] [true]
	]
]
; bug#1994
#64bit
[
	num: 0
	for i 9223372036854775807 9223372036854775807 9223372036854775807 [
		num: num + 1
		if num <> 1 [break/return false]
		true
	]
]
#64bit
[
	num: 0
	for i 9223372036854775807 9223372036854775807 -9223372036854775808 [
		num: num + 1
		if num <> 1 [break/return false]
		true
	]
]
#64bit
[
	num: 0
	for i -9223372036854775808 -9223372036854775808 9223372036854775807 [
		num: num + 1
		if num <> 1 [break/return false]
		true
	]
]
#64bit
[
	num: 0
	for i -9223372036854775808 -9223372036854775808 -9223372036854775808 [
		num: num + 1
		if num <> 1 [break/return false]
		true
	]
]
[
	num: 0
	for i 2147483647 2147483647 2147483647 [
		num: num + 1
		if num <> 1 [break/return false]
		true
	]
]
[
	num: 0
	for i 2147483647 2147483647 -2147483648 [
		num: num + 1
		if num <> 1 [break/return false]
		true
	]
]
[
	num: 0
	for i -2147483648 -2147483648 2147483647 [
		num: num + 1
		if num <> 1 [break/return false]
		true
	]
]
[
	num: 0
	for i -2147483648 -2147483648 -2147483648 [
		num: num + 1
		if num <> 1 [break/return false]
		true
	]
]
; bug#1993
[equal? type? for i 1 2 0 [break] type? for i 2 1 0 [break]]
[equal? type? for i -1 -2 0 [break] type? for i 2 1 0 [break]]
[equal? type? for i -1 -2 0 [break] type? for i -2 -1 0 [break]]
; char tests
#r2only
[
	num: 0
	char: #"^(ff)"
	not for i char char 1 [
		num: num + 1
		if num > 1 [break/return true]
	]
]
#r2only
[
	num: 0
	char: #"^(0)"
	not for i char char -1 [
		num: num + 1
		if num > 1 [break/return true]
	]
]
; skip before head test
[[] = for i b: tail [1] head b -2 [i]]
[
	; the cycle variable must be local
	not same? 'i for i 1 1 1 ['i]
]
; recursivity
[
	num: 0
	for i 1 5 1 [
		for i 1 2 1 [num: num + 1]
	]
	num = 10
]
; infinite recursion
[
	blk: [for i 1 1 1 blk]
	error? try blk
]
; local variable changeability - this is how it works in R3
[
	test: false
	for i 1 3 1 [
		if i = 2 [
			if test [break/return true]
			test: true
			i: 1
		]
	]
]
; THROW error test
#r2only
[
	b: head insert copy [] try [1 / 0]
	pokus1: func [[catch] block [block!] /local elem] [
		for i 1 length? block 1 [
			if error? set/any 'elem first block [
				throw make error! {Dangerous element}
			]
			block: next block
		]
	]
	b: disarm try [pokus1 b]
	b/near = [pokus1 b]
]
; local variable type safety
#r3only
[
	test: false
	error? try [
		for i 1 2 [
			either test [i == 2] [
				test: true
				i: false
			]
		]
	]
]
; FOR should not bind 'self
; bug#1529
[same? 'self for i 1 1 1 ['self]]
; functions/control/forall.r
[
	str: "abcdef"
	out: copy ""
	forall str [append out first str]
	all [
		head? str
		out = head str
	]
]
[
	blk: [1 2 3 4]
	sum: 0
	forall blk [sum: sum + first blk]
	sum = 10
]
; cycle return value
[
	blk: [1 2 3 4]
	true = forall blk [true]
]
[
	blk: [1 2 3 4]
	false = forall blk [false]
]
; break cycle
[
	str: "abcdef"
	forall str [if #"c" = char: str/1 [break]]
	char = #"c"
]
; break return value
[
	blk: [1 2 3 4]
	unset? forall blk [break]
]
; break/return return value
[
	blk: [1 2 3 4]
	1 = forall blk [break/return 1]
]
; continue cycle
#r3only
[
	success: true
	x: "a"
	forall x [continue success: false]
	success
]
; zero repetition
[
	success: true
	blk: []
	forall blk [success: false]
	success
]
; Test that return stops the loop
[
	blk: [1]
	f1: does [forall blk [return 1 2]]
	1 = f1
]
; Test that errors do not stop the loop and errors can be returned
#r3only
[
	num: 0
	blk: [1 2]
	e: forall blk [num: first blk try [1 / 0]]
	all [error? e num = 2]
]
; recursivity
[
	num: 0
	blk1: [1 2 3 4 5]
	blk2: [6 7]
	forall blk1 [
		num: num + first blk1
		forall blk2 [num: num + first blk2]
	]
	num = 80
]
; in Rebol2 the FORALL function is unable to pass a THROW error test
#r2only
[
	f: func [[catch] /local x] [
		x: [1]
		forall x [throw make error! ""]
	]
	e: disarm try [f]
	e/near = [f]
]
; bug#81
[
	blk: [1]
	1 == forall blk [blk/1]
]
; functions/control/foreach.r
[
	out: copy ""
	str: "abcdef"
	foreach i str [append out i]
	out = str
]
[
	blk: [1 2 3 4]
	sum: 0
	foreach i blk [sum: sum + i]
	sum = 10
]
; cycle return value
[
	blk: [1 2 3 4]
	true = foreach i blk [true]
]
[
	blk: [1 2 3 4]
	false = foreach i blk [false]
]
; break cycle
[
	str: "abcdef"
	foreach i str [
		num: i
		if i = #"c" [break]
	]
	num = #"c"
]
; break return value
[
	blk: [1 2 3 4]
	unset? foreach i blk [break]
]
; break/return return value
[
	blk: [1 2 3 4]
	1 = foreach i blk [break/return 1]
]
; continue cycle
#r3only
[
	success: true
	foreach i [1] [continue success: false]
	success
]
; zero repetition
[
	success: true
	blk: []
	foreach i blk [success: false]
	success
]
; Test that return stops the loop
[
	blk: [1]
	f1: does [foreach i blk [return 1 2]]
	1 = f1
]
; Test that errors do not stop the loop and errors can be returned
#r3only
[
	num: 0
	blk: [1 2]
	e: foreach i blk [num: i try [1 / 0]]
	all [error? e num = 2]
]
; "recursive safety", "locality" and "body constantness" test in one
[foreach i [1] b: [not same? 'i b/3]]
; recursivity
[
	num: 0
	foreach i [1 2 3 4 5] [
		foreach i [1 2] [num: num + 1]
	]
	num = 10
]
; functions/control/forever.r
[
	num: 0
	forever [
		num: num + 1
		if num = 10 [break]
	]
	num = 10
]
; Test break, break/return and continue
[unset? forever [break]]
[1 = forever [break/return 1]]
#r3only
[
	success: true
	cycle?: true
	forever [if cycle? [cycle?: false continue success: false] break]
	success
]
; Test that return stops the loop
[
	f1: does [forever [return 1]]
	1 = f1
]
; Test that exit stops the loop
[unset? do does [forever [exit]]]
; Test that errors do not stop the loop and errors can be returned
#r3only
[
	num: 0
	e: forever [
		num: num + 1
		if num = 10 [break/return try [1 / 0]]
		try [1 / 0]
	]
	all [error? e num = 10]
]
; Recursion check
[
	num1: 0
	num3: 0
	forever [
		if num1 = 5 [break]
		num2: 0
		forever [
			if num2 = 2 [break]
			num3: num3 + 1
			num2: num2 + 1
		]
		num1: num1 + 1
	]
	10 = num3
]
; functions/control/forskip.r
#r2only
[
	blk: copy out: copy []
	for i #"A" #"Z" 1 [append blk i]
	forskip blk 2 [append out blk/1]
	out = [#"A" #"C" #"E" #"G" #"I" #"K" #"M" #"O" #"Q" #"S" #"U" #"W" #"Y"]
]
[
	blk: copy out: copy []
	for i 1 25 1 [append blk i]
	forskip blk 3 [append out blk/1]
	out = [1 4 7 10 13 16 19 22 25]
]
; cycle return value
[
	blk: [1 2 3 4]
	true = forskip blk 1 [true]
]
[
	blk: [1 2 3 4]
	false = forskip blk 1 [false]
]
; break cycle
[
	str: "abcdef"
	forskip str 2 [if #"c" = char: str/1 [break]
	]
	char = #"c"
]
; break return value
[
	blk: [1 2 3 4]
	unset? forskip blk 2 [break]
]
; break/return return value
[
	blk: [1 2 3 4]
	1 = forskip blk 2 [break/return 1]
]
; continue cycle
#r3only
[
	success: true
	x: "a"
	forskip x 1 [continue success: false]
	success
]
; zero repetition
[
	success: true
	blk: []
	forskip blk 1 [success: false]
	success
]
; Test that return stops the loop
[
	blk: [1]
	f1: does [forskip blk 2 [return 1 2]]
	1 = f1
]
; Test that errors do not stop the loop and errors can be returned
#r3only
[
	num: 0
	blk: [1 2]
	e: forskip blk 1 [num: first blk try [1 / 0]]
	all [error? e num = 2]
]
; recursivity
[
	num: 0
	blk1: [1 2 3 4 5]
	blk2: [6 7]
	forskip blk1 1 [
		num: num + first blk1
		forskip blk2 1 [num: num + first blk2]
	]
	num = 80
]
; in Rebol2 the FORSKIP function is unable to pass a THROW error test
#r2only
[
	f: func [[catch] /local x] [
		x: [1]
		forskip x 1 [throw make error! ""]
	]
	e: disarm try [f]
	e/near = [f]
]
; functions/control/halt.r
[any-function? :halt]
; functions/control/if.r
[
	success: false
	if true [success: true]
	success
]
[
	success: true
	if false [success: false]
	success
]
[1 = if true [1]]
[unset? if true []]
#r3only
[error? if true [try [1 / 0]]]
; RETURN stops the evaluation
[
	f1: does [
		if true [return 1 2]
		2
	]
	1 = f1
]
; condition datatype tests; action
[if get 'abs [true]]
; binary
[if #{00} [true]]
; bitset
[if make bitset! "" [true]]
; block
[if [] [true]]
; datatype
[if none! [true]]
; typeset
[if number! [true]]
; date
[if 1/1/0000 [true]]
; decimal
[if 0.0 [true]]
[if 1.0 [true]]
[if -1.0 [true]]
; email
[if me@rt.com [true]]
[if %"" [true]]
[if does [] [true]]
[if first [:first] [true]]
[if #"^@" [true]]
[if make image! 0x0 [true]]
; integer
[if 0 [true]]
[if 1 [true]]
[if -1 [true]]
[if #a [true]]
[if first ['a/b] [true]]
[if first ['a] [true]]
[if true [true]]
[none? if false [true]]
[if $1 [true]]
[if :type? [true]]
[none? if none [true]]
[if make object! [] [true]]
[if get '+ [true]]
[if 0x0 [true]]
[if first [()] [true]]
[if 'a/b [true]]
[if make port! http:// [true]]
[if /a [true]]
[if first [a/b:] [true]]
[if first [a:] [true]]
[if "" [true]]
[if to tag! "" [true]]
[if 0:00 [true]]
[if 0.0.0 [true]]
[if  http:// [true]]
[if 'a [true]]
; recursive behaviour
[none? if true [if false [1]]]
[1 = if true [if true [1]]]
; infinite recursion
[
	blk: [if true blk]
	error? try blk
]
; functions/control/loop.r
[
	num: 0
	loop 10 [num: num + 1]
	10 = num
]
; cycle return value
[false = loop 1 [false]]
; break cycle
[
	num: 0
	loop 10 [num: num + 1 break]
	num = 1
]
; break return value
[unset? loop 10 [break]]
; break/return return value
[2 = loop 10 [break/return 2]]
; continue cycle
#r3only
[
	success: true
	loop 1 [continue success: false]
	success
]
; zero repetition
[
	success: true
	loop 0 [success: false]
	success
]
[
	success: true
	loop -1 [success: false]
	success
]
; Test that return stops the loop
[
	f1: does [loop 1 [return 1 2]]
	1 = f1
]
; Test that errors do not stop the loop and errors can be returned
#r3only
[
	num: 0
	e: loop 2 [num: num + 1 try [1 / 0]]
	all [error? e num = 2]
]
; loop recursivity
[
	num: 0
	loop 5 [
		loop 2 [num: num + 1]
	]
	num = 10
]
; recursive use of 'break
[
	f: func [x] [
		loop 1 [
			if x = 1 [
				use [break] [
					break: 1
					f 2
					1 = get/any 'break
				]
			]
		]
	]
	f 1
]
; functions/control/map-each.r
; "return bug"
[
	integer? do does [map-each v [] [] 1]
]
; functions/control/reduce.r
[[1 2] = reduce [1 1 + 1]]
[
	success: false
	reduce [success: true]
	success
]
[[] = reduce []]
[unset? first reduce [()]]
["1 + 1" = reduce "1 + 1"]
#r3only
[error? first reduce [try [1 / 0]]]
; unwind functions should stop evaluation, bug#1760
[unset? loop 1 [reduce [break]]]
[unset? loop 1 [reduce/no-set [a: break]]]
[1 = loop 1 [reduce [break/return 1]]]
#r3only
[unset? loop 1 [reduce [continue]]]
[1 = catch [reduce [throw 1]]]
[1 = catch/name [reduce [throw/name 1 'a]] 'a]
[1 = do does [reduce [return 1 2] 2]]
[unset? do does [reduce [exit 1] 2]]
; recursive behaviour
[1 = first reduce [first reduce [1]]]
; infinite recursion
[
	blk: [reduce blk]
	error? try blk
]
; functions/control/remove-each.r
[
	remove-each i s: [1 2] [true]
	empty? s
]
[
	remove-each i s: [1 2] [false]
	[1 2] = s
]
; functions/control/repeat.r
[
	success: true
	num: 0
	repeat i 10 [
		num: num + 1
		success: i = num and success
	]
	10 = num and success
]
; cycle return value
[false = repeat i 1 [false]]
; break cycle
[
	num: 0
	repeat i 10 [num: i break]
	num = 1
]
; break return value
[unset? repeat i 10 [break]]
; break/return return value
[2 = repeat i 10 [break/return 2]]
; continue cycle
#r3only
[
	success: true
	repeat i 1 [continue success: false]
	success
]
#r3only
[
	success: true
	repeat i "a" [continue success: false]
	success
]
#r3only
[
	success: true
	repeat i [a] [continue success: false]
	success
]
; decimal! test
#r3
[[1 2 3] == collect [repeat i 3.0 [keep i]]]
[[1 2 3] == collect [repeat i 3.1 [keep i]]]
[[1 2 3] == collect [repeat i 3.5 [keep i]]]
[[1 2 3] == collect [repeat i 3.9 [keep i]]]
; pair! test (bug#1995)
#r3
[[1x1 2x1 1x2 2x2] == collect [repeat i 2x2 [keep i]]]
; string! test
#r2only
[
	out: copy ""
	repeat i "abc" [append out i]
	out = "abc"
]
; string! test
#r3only
[
	out: copy ""
	repeat i "abc" [append out i]
	out = "abcbcc"
]
; block! test
#r2only
[
	out: copy []
	repeat i [1 2 3] [append out i]
	out = [1 2 3]
]
; block! test
#r3only
[
	out: copy []
	repeat i [1 2 3] [append out i]
	out = [1 2 3 2 3 3]
]
; TODO: is hash! test and list! test needed too?
; zero repetition
[
	success: true
	repeat i 0 [success: false]
	success
]
[
	success: true
	repeat i -1 [success: false]
	success
]
; Test that return stops the loop
[
	f1: does [repeat i 1 [return 1 2]]
	1 = f1
]
; Test that errors do not stop the loop and errors can be returned
#r3only
[
	num: 0
	e: repeat i 2 [num: i try [1 / 0]]
	all [error? e num = 2]
]
; "recursive safety", "locality" and "body constantness" test in one
[repeat i 1 b: [not same? 'i b/3]]
; recursivity
[
	num: 0
	repeat i 5 [
		repeat i 2 [num: num + 1]
	]
	num = 10
]
; local variable type safety
#r2only
[
	test: false
	repeat i 2 [
		either test [i == 2] [
			test: true
			i: false
			true
		]
	]
]
; local variable type safety
#r3only
[
	test: false
	error? try [
		repeat i 2 [
			either test [i == 2] [
				test: true
				i: false
			]
		]
	]
]
; functions/control/return.r
[
	f1: does [return 1 2]
	1 = f1
]
[
	success: true
	f1: does [return 1 success: false]
	f1
	success
]
; return value tests
[
	f1: does [return ()]
	unset? f1
]
[
	f1: does [return try [1 / 0]]
	error? f1
]
; the "result" of return should not be assignable, bug#1515
[a: 1 do does [a: return 2] :a =? 1]
[a: 1 do does [set 'a return 2] :a =? 1]
[a: 1 do does [set/any 'a return 2] :a =? 1]
; the "result" of return should not be passable to functions, bug#1509
[a: 1 do does [a: error? return 2] :a =? 1]
; bug#1535
[do does [words-of return none] true]
[do does [values-of return none] true]
; bug#1945
[do does [spec-of return none] true]
; return should not be caught by try
[a: 1 do does [a: error? try [return 2]] :a =? 1]
; functions/control/switch.r
[
	11 = switch 1 [
		1 [11]
		2 [12]
	]
]
[
	12 = switch 2 [
		1 [11]
		2 [12]
	]
]
[unset? switch 1 [1 []]]
#r3only
[
	cases: reduce [1 head insert copy [] try [1 / 0]]
	error? switch 1 cases
]
; bug#2242
[11 = do does [switch/all 1 [1 [return 11 88]] 99]]
; functions/control/throw.r
; see functions/control/catch.r for basic functionality
; the "result" of throw should not be assignable, bug#1515
[a: 1 catch [a: throw 2] :a =? 1]
[a: 1 catch [set 'a throw 2] :a =? 1]
[a: 1 catch [set/any 'a throw 2] :a =? 1]
[a: 1 catch/name [a: throw/name 2 'b] 'b :a =? 1]
[a: 1 catch/name [set 'a throw/name 2 'b] 'b :a =? 1]
[a: 1 catch/name [set/any 'a throw/name 2 'b] 'b :a =? 1]
; the "result" of throw should not be passable to functions, bug#1509
[a: 1 catch [a: error? throw 2] :a =? 1]
; bug#1535
[catch [words-of throw none] true]
[catch [values-of throw none] true]
; bug#1945
[catch [spec-of throw none] true]
[a: 1 catch/name [a: error? throw/name 2 'b] 'b :a =? 1]
; throw should not be caught by try
[a: 1 catch [a: error? try [throw 2]] :a =? 1]
[a: 1 catch/name [a: error? try [throw/name 2 'b]] 'b :a =? 1]
; functions/control/try.r
#r2only
[
	e: disarm try [1 / 0]
	e/id = 'zero-divide
]
#r3only
[
	e: try [1 / 0]
	e/id = 'zero-divide
]
[
	success: true
	error? try [
		1 / 0
		success: false
	]
	success
]
[
	success: true
	f1: does [
		1 / 0
		success: false
	]
	error? try [f1]
	success
]
; testing TRY/EXCEPT
; bug#822
#r3only
[error? try/except [make error! ""] [0]]
#r3only
[try/except [do make error! ""] [true]]
#r3only
[try/except [1 / 0] :error?]
#r3only
[try/except [1 / 0] func [e] [error? e]]
#r3only
[try/except [true] func [e] [false]]
; bug#1514
#r3only
[error? try [try/except [1 / 0] :add]]
; functions/control/unless.r
[
	success: false
	unless false [success: true]
	success
]
[
	success: true
	unless true [success: false]
	success
]
[1 = unless false [1]]
[none? unless true [1]]
[unset? unless false []]
#r3only
[error? unless false [try [1 / 0]]]
; RETURN stops the evaluation
[
	f1: does [
		unless false [return 1 2]
		2
	]
	1 = f1
]
; functions/control/until.r
[
	num: 0
	until [num: num + 1 num > 9]
	num = 10
]
; Test body-block return values
[1 = until [1]]
; Test break and break/return
[unset? until [break true]]
[1 = until [break/return 1 true]]
; Test continue
#r3only
[
	success: true
	cycle?: true
	until [if cycle? [cycle?: false continue success: false] true]
	success
]
; Test that return stops the loop
[
	f1: does [until [return 1]]
	1 = f1
]
; Test that errors do not stop the loop
#r3only
[1 = until [try [1 / 0] 1]]
; Recursion check
[
	num1: 0
	num3: 0
	until [
		num2: 0
		until [
			num3: num3 + 1
			1 < num2: num2 + 1
		]
		4 < num1: num1 + 1
	]
	10 = num3
]
; functions/control/wait.r
; bug#5
[wait 0:0:0.3 true]
; functions/control/while.r
[
	num: 0
	while [num < 10] [num: num + 1]
	num = 10
]
; bug#37
; Test body-block return values
[
	num: 0
	1 = while [num < 1] [num: num + 1]
]
[none? while [false] []]
; zero repetition
[
	success: true
	while [false] [success: false]
	success
]
; Test break, break/return and continue
[cycle?: true unset? while [cycle?] [break cycle?: false]]
[cycle?: true unset? while [if cycle? [break] cycle?] [cycle?: false]]  ; bug#1519
[cycle?: true 1 = while [cycle?] [break/return 1 cycle?: false]]
[cycle?: true 1 = while [if cycle? [break/return 1] cycle?] [cycle?: false]]  ; bug#1519
#r3only
[
	success: true
	cycle?: true
	while [cycle?] [cycle?: false continue success: false]
	success
]
#r3only
[  ; bug#1519
	success: true
	cycle?: true
	while [if cycle? [cycle?: false continue success: false] cycle?] []
	success
]
[
	num: 0
	while [true] [num: 1 break num: 2]
	num = 1
]
; RETURN should stop the loop
[
	cycle?: true
	f1: does [while [cycle?] [cycle?: false return 1] 2]
	1 = f1
]
[  ; bug#1519
	cycle?: true
	f1: does [while [if cycle? [return 1] cycle?] [cycle?: false 2]]
	1 = f1
]
; EXIT should stop the loop
[
	cycle?: true
	f1: does [while [cycle?] [cycle?: false exit] 2]
	unset? f1
]
[  ; bug#1519
	cycle?: true
	f1: does [while [if cycle? [exit] cycle?] [cycle?: false 2]]
	unset? f1
]
; THROW should stop the loop
[1 = catch [cycle?: true while [cycle?] [throw 1 cycle?: false]]]
[  ; bug#1519
	cycle?: true
	1 = catch [while [if cycle? [throw 1] false] [cycle?: false]]
]
[1 = catch/name [cycle?: true while [cycle?] [throw/name 1 'a cycle?: false]] 'a]
[  ; bug#1519
	cycle?: true
	1 = catch/name [while [if cycle? [throw/name 1 'a] false] [cycle?: false]] 'a
]
; Test that disarmed errors do not stop the loop and errors can be returned
#r3only
[
	num: 0
	e: while [num < 10] [num: num + 1 try [1 / 0]]
	all [error? e num = 10]
]
; Recursion check
[
	num1: 0
	num3: 0
	while [num1 < 5] [
		num2: 0
		while [num2 < 2] [
			num3: num3 + 1
			num2: num2 + 1
		]
		num1: num1 + 1
	]
	10 = num3
]
; functions/control/quit.r
; In R3, DO of a script provided as a string! code catches QUIT, just as it
; would do for scripts in files.
#r3only
[42 = do "quit/return 42"]
#r3only
[99 = do {do {quit/return 42} 99}]
; Returning of Rebol values from called to calling script via QUIT/return.
[
	do-script-returning: func [value /local script] [
		save/header script: %tmp-inner.reb compose ['quit/return (value)] []
		do script
	]
	result: all map-each value reduce [
		42
		{foo}
		#{CAFE}
		none
		http://somewhere
		1900-01-30
		context [x: 42]
	] [
		value = do-script-returning value
	]
	delete %tmp-inner.reb
	result
]
; bug#2190
[error? try [catch/quit [attempt [quit]] 1 / 0]]
; functions/convert/as-binary.r
#r2only
[
	a: "a"
	b: as-binary a
	b == to binary! a
	change a "b"
	b == to binary! a
]
; functions/convert/as-string.r
#r2only
[
	a: #{00}
	b: as-string a
	b == to string! a
	change a #{01}
	b == to string! a
]
; functions/convert/encode.r
#r3only
[binary? encode 'bmp make image! 10x20]
; bug#2040
#r3only
[binary? encode 'png make image! 10x20]
; functions/convert/load.r
; bug#20
[block? load/all "1"]
; bug#22a
[error? try [load "':a"]]
; bug#22b
[error? try [load "':a:"]]
; bug#858
[
	a: [ < ]
	a = load mold a
]
[error? try [load "1xyz#"]]
; load/next
#r2only
[block? load/next "1"]
; bug#1703  bug#1711
#r3only
[error? try [load/next "1"]]
; bug#1122
[
	found? any [
		error? try [load "9999999999999999999"]
		greater? load "9999999999999999999" load "9223372036854775807"
	]
]
; R2 bug
[
	 x: 1
	 error? try [x: load/header ""]
	 not error? x
]
; functions/convert/mold.r
; bug#860
; bug#6
; cyclic block
[
	a: copy []
	insert/only a a
	string? mold a
]
; cyclic paren
[
	a: first [()]
	insert/only a a
	string? mold a
]
; cyclic object
; bug#69
[
	a: make object! [a: self]
	string? mold a
]
; closure mold
; bug#23
#r3only
[
	c: closure [a] [print a]
	equal? "make closure! [[a] [print a]]" mold :c
]
; deep nested block mold
; bug#876
[
	n: 1
	forever [
		a: copy []
		if error? try [
			loop n [a: append/only copy [] a]
			mold a
		] [break/return true]
		n: n * 2
	]
]
; bug#719
["()" = mold quote ()]
; bug#77
["#[block! [1 2] 2]" == mold/all next [1 2]]
; bug#77
[none? find mold/flat make object! [a: 1] "    "]
; bug#84
[equal? mold make bitset! "^(00)" "make bitset! #{80}"]
[equal? mold/all make bitset! "^(00)" "#[bitset! #{80}]"]
; functions/convert/to.r
; bug#12
[image? to image! make gob! []]
; bug#38
['logic! = to word! logic!]
#r3only
['percent! = to word! percent!]
['money! = to word! money!]
; bug#1967
[not same? to binary! [1] to binary! [2]]
; functions/datatype/as-pair.r
; bug#1624
#r3only
[native? :as-pair]
; functions/define/func.r
; recursive safety
[
	f: func [] [
		func [x] [
			if x = 1 [
				do f 2
				x = 1
			]
		]
	]
	do f 1
]
; functions/onvert/to-hex.r
; bug#43
#r3only
[#FFFFFFFE = to-hex/size -2 8]
; functions/file/clean-path.r
; bug#35
[any-function? :clean-path]
; functions/file/existsq.r
; bug#1613
[exists? http://www.rebol.com/index.html]
; functions/file/make-dir.r
; bug#1674
#r2only
[
	found? any [
		not error? e: try [make-dir %/folder-to-save-test-files]
		(e: disarm e e/type = 'access)
	]
]
#r3only
[
	found? any [
		not error? e: try [make-dir %/folder-to-save-test-files]
		e/type = 'access
	]
]
; functions/file/open.r
; bug#1422: "Rebol crashes when opening the 128th port"
[error? try [repeat n 200 [try [close open open join tcp://localhost: n]]] true]
; functions/file/file-typeq.r
; bug#1651: "FILE-TYPE? should return NONE for unknown types"
#r3only
[none? file-type? %foo.0123456789bar0123456789]
; functions/math/absolute.r
[:abs = :absolute]
[0 = abs 0]
[1 = abs 1]
[1 = abs -1]
[2147483647 = abs 2147483647]
[2147483647 = abs -2147483647]
#32bit
[error? try [abs -2147483648]]
#64bit
[2147483648 = abs 2147483648]
#64bit
[2147483648 = abs -2147483648]
[0.0 = abs 0.0]
[zero? 1.0 - abs 1.0]
[zero? 1.0 - abs -1.0]
#64bit
[9223372036854775807 = abs 9223372036854775807]
#64bit
[9223372036854775807 = abs -9223372036854775807]
#64bit
; bug#833
[error? try [abs -9223372036854775808]]
; pair! tests
[0x0 = abs 0x0]
[0x1 = abs 0x1]
[1x0 = abs 1x0]
[1x1 = abs 1x1]
[0x1 = abs 0x-1]
[1x0 = abs -1x0]
[1x1 = abs -1x-1]
[2147483647x2147483647 = abs 2147483647x2147483647]
[2147483647x2147483647 = abs 2147483647x-2147483647]
[2147483647x2147483647 = abs -2147483647x2147483647]
[2147483647x2147483647 = abs -2147483647x-2147483647]
; functions/math/add.r
[3 = add 1 2]
; integer -9223372036854775808 + x tests
#64bit
[error? try [add -9223372036854775808 -9223372036854775808]]
#64bit
[error? try [add -9223372036854775808 -9223372036854775807]]
#64bit
[error? try [add -9223372036854775808 -2147483648]]
#64bit
[error? try [add -9223372036854775808 -1]]
#64bit
[-9223372036854775808 = add -9223372036854775808 0]
#64bit
[-9223372036854775807 = add -9223372036854775808 1]
#64bit
[-2 = add -9223372036854775808 9223372036854775806]
#64bit
[-1 = add -9223372036854775808 9223372036854775807]
; integer -9223372036854775807 + x tests
#64bit
[error? try [add -9223372036854775807 -9223372036854775808]]
#64bit
[error? try [add -9223372036854775807 -9223372036854775807]]
#64bit
[-9223372036854775808 = add -9223372036854775807 -1]
#64bit
[-9223372036854775807 = add -9223372036854775807 0]
#64bit
[-9223372036854775806 = add -9223372036854775807 1]
#64bit
[-1 = add -9223372036854775807 9223372036854775806]
#64bit
[0 = add -9223372036854775807 9223372036854775807]
; integer -2147483648 + x tests
#32bit
[error? try [add -2147483648 -2147483648]]
#64bit
[-4294967296 = add -2147483648 -2147483648]
#32bit
[error? try [add -2147483648 -1]]
#64bit
[-2147483649 = add -2147483648 -1]
[-2147483648 = add -2147483648 0]
[-2147483647 = add -2147483648 1]
[-1 = add -2147483648 2147483647]
; integer -1 + x tests
#64bit
[error? try [add -1 -9223372036854775808]]
#64bit
[-9223372036854775808 = add -1 -9223372036854775807]
[-2 = add -1 -1]
[-1 = add -1 0]
[0 = add -1 1]
#64bit
[9223372036854775805 = add -1 9223372036854775806]
#64bit
[9223372036854775806 = add -1 9223372036854775807]
; integer 0 + x tests
#64bit
[-9223372036854775808 = add 0 -9223372036854775808]
#64bit
[-9223372036854775807 = add 0 -9223372036854775807]
[-1 = add 0 -1]
; bug#28
[0 = add 0 0]
[1 = add 0 1]
#64bit
[9223372036854775806 = add 0 9223372036854775806]
#64bit
[9223372036854775807 = add 0 9223372036854775807]
; integer 1 + x tests
#64bit
[-9223372036854775807 = add 1 -9223372036854775808]
#64bit
[-9223372036854775806 = add 1 -9223372036854775807]
[0 = add 1 -1]
[1 = add 1 0]
[2 = add 1 1]
#64bit
[9223372036854775807 = add 1 9223372036854775806]
#64bit
[error? try [add 1 9223372036854775807]]
; integer 2147483647 + x
[-1 = add 2147483647 -2147483648]
[2147483646 = add 2147483647 -1]
[2147483647 = add 2147483647 0]
#32bit
[error? try [add 2147483647 1]]
#64bit
[2147483648 = add 2147483647 1]
#32bit
[error? try [add 2147483647 2147483647]]
#64bit
[4294967294 = add 2147483647 2147483647]
; integer 9223372036854775806 + x tests
#64bit
[-2 = add 9223372036854775806 -9223372036854775808]
#64bit
[-1 = add 9223372036854775806 -9223372036854775807]
#64bit
[9223372036854775805 = add 9223372036854775806 -1]
#64bit
[9223372036854775806 = add 9223372036854775806 0]
#64bit
[9223372036854775807 = add 9223372036854775806 1]
#64bit
[error? try [add 9223372036854775806 9223372036854775806]]
#64bit
[error? try [add 9223372036854775806 9223372036854775807]]
; integer 9223372036854775807 + x tests
#64bit
[-1 = add 9223372036854775807 -9223372036854775808]
#64bit
[0 = add 9223372036854775807 -9223372036854775807]
#64bit
[9223372036854775806 = add 9223372036854775807 -1]
#64bit
[9223372036854775807 = add 9223372036854775807 0]
#64bit
[error? try [add 9223372036854775807 1]]
#64bit
[error? try [add 9223372036854775807 9223372036854775806]]
#64bit
[error? try [add 9223372036854775807 9223372036854775807]]
; decimal + integer
[2.1 = add 1.1 1]
[2147483648.0 = add 1.0 2147483647]
[-2147483649.0 = add -1.0 -2147483648]
; integer + decimal
[2.1 = add 1 1.1]
[2147483648.0 = add 2147483647 1.0]
[-2147483649.0 = add -2147483648 -1.0]
; -1.7976931348623157e308 + decimal
[error? try [add -1.7976931348623157e308 -1.7976931348623157e308]]
[-1.7976931348623157e308 = add -1.7976931348623157e308 -1.0]
[-1.7976931348623157e308 = add -1.7976931348623157e308 -4.94065645841247E-324]
[-1.7976931348623157e308 = add -1.7976931348623157e308 0.0]
[-1.7976931348623157e308 = add -1.7976931348623157e308 4.94065645841247E-324]
[-1.7976931348623157e308 = add -1.7976931348623157e308 1.0]
[0.0 = add -1.7976931348623157e308 1.7976931348623157e308]
; -1.0 + decimal
[-1.7976931348623157e308 = add -1.0 -1.7976931348623157e308]
[-2.0 = add -1.0 -1.0]
[-1.0 = add -1.0 -4.94065645841247E-324]
[-1.0 = add -1.0 0.0]
[-1.0 = add -1.0 4.94065645841247E-324]
[0.0 = add -1.0 1.0]
[1.7976931348623157e308 = add -1.0 1.7976931348623157e308]
; -4.94065645841247E-324 + decimal
[-1.7976931348623157e308 = add -4.94065645841247E-324 -1.7976931348623157e308]
[-1.0 = add -4.94065645841247E-324 -1.0]
[-9.88131291682493e-324 = add -4.94065645841247E-324 -4.94065645841247E-324]
[-4.94065645841247E-324 = add -4.94065645841247E-324 0.0]
[0.0 = add -4.94065645841247E-324 4.94065645841247E-324]
[1.0 = add -4.94065645841247E-324 1.0]
[1.7976931348623157e308 = add -4.94065645841247E-324 1.7976931348623157e308]
; 0.0 + decimal
[-1.7976931348623157e308 = add 0.0 -1.7976931348623157e308]
[-1.0 = add 0.0 -1.0]
[-4.94065645841247E-324 = add 0.0 -4.94065645841247E-324]
[0.0 = add 0.0 0.0]
[4.94065645841247E-324 = add 0.0 4.94065645841247E-324]
[1.0 = add 0.0 1.0]
[1.7976931348623157e308 = add 0.0 1.7976931348623157e308]
; 4.94065645841247E-324 + decimal
[-1.7976931348623157e308 = add 4.94065645841247E-324 -1.7976931348623157e308]
[-1.0 = add 4.94065645841247E-324 -1.0]
[0.0 = add 4.94065645841247E-324 -4.94065645841247E-324]
[4.94065645841247E-324 = add 4.94065645841247E-324 0.0]
[9.88131291682493e-324 = add 4.94065645841247E-324 4.94065645841247E-324]
[1.0 = add 4.94065645841247E-324 1.0]
[1.7976931348623157e308 = add 4.94065645841247E-324 1.7976931348623157e308]
; 1.0 + decimal
[-1.7976931348623157e308 = add 1.0 -1.7976931348623157e308]
[0.0 = add 1.0 -1.0]
[1.0 = add 1.0 4.94065645841247E-324]
[1.0 = add 1.0 0.0]
[1.0 = add 1.0 -4.94065645841247E-324]
[2.0 = add 1.0 1.0]
[1.7976931348623157e308 = add 1.0 1.7976931348623157e308]
; 1.7976931348623157e308 + decimal
[0.0 = add 1.7976931348623157e308 -1.7976931348623157e308]
[1.7976931348623157e308 = add 1.7976931348623157e308 -1.0]
[1.7976931348623157e308 = add 1.7976931348623157e308 -4.94065645841247E-324]
[1.7976931348623157e308 = add 1.7976931348623157e308 0.0]
[1.7976931348623157e308 = add 1.7976931348623157e308 4.94065645841247E-324]
[1.7976931348623157e308 = add 1.7976931348623157e308 1.0]
[error? try [add 1.7976931348623157e308 1.7976931348623157e308]]
; pair
#r2only
[0x0 = add -2147483648x-2147483648 -2147483648x-2147483648]
#r2only
[2147483647x2147483647 = add -2147483648x-2147483648 -1x-1]
[-2147483648x-2147483648 = add -2147483648x-2147483648 0x0]
#r2only
[-2147483647x-2147483647 = add -2147483648x-2147483648 1x1]
#r2only
[-1x-1 = add -2147483648x-2147483648 2147483647x2147483647]
#r2only
[2147483647x2147483647 = add -1x-1 -2147483648x-2147483648]
[-2x-2 = add -1x-1 -1x-1]
[-1x-1 = add -1x-1 0x0]
[0x0 = add -1x-1 1x1]
#r2only
[2147483646x2147483646 = add -1x-1 2147483647x2147483647]
[-2147483648x-2147483648 = add 0x0 -2147483648x-2147483648]
[-1x-1 = add 0x0 -1x-1]
[0x0 = add 0x0 0x0]
[1x1 = add 0x0 1x1]
[2147483647x2147483647 = add 0x0 2147483647x2147483647]
#r2only
[-2147483647x-2147483647 = add 1x1 -2147483648x-2147483648]
[0x0 = add 1x1 -1x-1]
[1x1 = add 1x1 0x0]
[2x2 = add 1x1 1x1]
#r2only
[-2147483648x-2147483648 = add 1x1 2147483647x2147483647]
#r2only
[-1x-1 = add 2147483647x2147483647 -2147483648x-2147483648]
#r2only
[2147483646x2147483646 = add 2147483647x2147483647 -1x-1]
[2147483647x2147483647 = add 2147483647x2147483647 0x0]
#r2only
[-2147483648x-2147483648 = add 2147483647x2147483647 1x1]
#r2only
[-2x-2 = add 2147483647x2147483647 2147483647x2147483647]
; pair + ...
[error? try [0x0 + none]]
[error? try [0x0 + ""]]
; char
[#"^(00)" = add #"^(00)" #"^(00)"]
[#"^(01)" = add #"^(00)" #"^(01)"]
[#"^(ff)" = add #"^(00)" #"^(ff)"]
[#"^(01)" = add #"^(01)" #"^(00)"]
[#"^(02)" = add #"^(01)" #"^(01)"]
#r2only
[#"^(00)" = add #"^(01)" #"^(ff)"]
[#"^(ff)" = add #"^(ff)" #"^(00)"]
#r2only
[#"^(00)" = add #"^(ff)" #"^(01)"]
#r2only
[#"^(fe)" = add #"^(ff)" #"^(ff)"]
; tuple
[0.0.0 = add 0.0.0 0.0.0]
[0.0.1 = add 0.0.0 0.0.1]
[0.0.255 = add 0.0.0 0.0.255]
[0.0.1 = add 0.0.1 0.0.0]
[0.0.2 = add 0.0.1 0.0.1]
[0.0.255 = add 0.0.1 0.0.255]
[0.0.255 = add 0.0.255 0.0.0]
[0.0.255 = add 0.0.255 0.0.1]
[0.0.255 = add 0.0.255 0.0.255]
; functions/math/and.r
[true and true = true]
[true and false = false]
[false and true = false]
[false and false = false]
; integer
[1 and 1 = 1]
[1 and 0 = 0]
[0 and 1 = 0]
[0 and 0 = 0]
[1 and 2 = 0]
[2 and 1 = 0]
[2 and 2 = 2]
; char
[#"^(00)" and #"^(00)" = #"^(00)"]
[#"^(01)" and #"^(00)" = #"^(00)"]
[#"^(00)" and #"^(01)" = #"^(00)"]
[#"^(01)" and #"^(01)" = #"^(01)"]
[#"^(01)" and #"^(02)" = #"^(00)"]
[#"^(02)" and #"^(02)" = #"^(02)"]
; tuple
[0.0.0 and 0.0.0 = 0.0.0]
[1.0.0 and 1.0.0 = 1.0.0]
[2.0.0 and 2.0.0 = 2.0.0]
[255.255.255 and 255.255.255 = 255.255.255]
; binary
[#{030000} and #{020000} = #{020000}]
; string
#r2only
["^(03)^(00)" and "^(02)^(00)" = "^(02)^(00)"]
; functions/math/arccosine.r
[0 = arccosine 1]
[0 = arccosine/radians 1]
[30 = arccosine (square-root 3) / 2]
[pi / 6 = arccosine/radians (square-root 3) / 2]
[45 = arccosine (square-root 2) / 2]
[pi / 4 = arccosine/radians (square-root 2) / 2]
[60 = arccosine 0.5]
[pi / 3 = arccosine/radians 0.5]
[90 = arccosine 0]
[pi / 2 = arccosine/radians 0]
[180 = arccosine -1]
[pi = arccosine/radians -1]
[150 = arccosine (square-root 3) / -2]
[pi * 5 / 6 = arccosine/radians (square-root 3) / -2]
[135 = arccosine (square-root 2) / -2]
[pi * 3 / 4 = arccosine/radians (square-root 2) / -2]
[120 = arccosine -0.5]
[pi * 2 / 3 = arccosine/radians -0.5]
[error? try [arccosine 1.1]]
[error? try [arccosine -1.1]]
; functions/math/arcsine.r
[0 = arcsine 0]
[0 = arcsine/radians 0]
[30 = arcsine 0.5]
[pi / 6 = arcsine/radians 0.5]
[45 = arcsine (square-root 2) / 2]
[pi / 4 = arcsine/radians (square-root 2) / 2]
[60 = arcsine (square-root 3) / 2]
[pi / 3 = arcsine/radians (square-root 3) / 2]
[90 = arcsine 1]
[pi / 2 = arcsine/radians 1]
[-30 = arcsine -0.5]
[pi / -6 = arcsine/radians -0.5]
[-45 = arcsine (square-root 2) / -2]
[pi / -4 = arcsine/radians (square-root 2) / -2]
[-60 = arcsine (square-root 3) / -2]
[pi / -3 = arcsine/radians (square-root 3) / -2]
[-90 = arcsine -1]
[pi / -2 = arcsine/radians -1]
[1e-12 / (arcsine 1e-12) = (pi / 180)]
[1e-9 / (arcsine/radians 1e-9) = 1.0]
[error? try [arcsine 1.1]]
[error? try [arcsine -1.1]]
; functions/math/arctangent.r
[-90 = arctangent -1e16]
[pi / -2 = arctangent/radians -1e16]
[-60 = arctangent negate square-root 3]
[pi / -3 = arctangent/radians negate square-root 3]
[-45 = arctangent -1]
[pi / -4 = arctangent/radians -1]
[-30 = arctangent (square-root 3) / -3]
[pi / -6 = arctangent/radians (square-root 3) / -3]
[0 = arctangent 0]
[0 = arctangent/radians 0]
[30 = arctangent (square-root 3) / 3]
[pi / 6 = arctangent/radians (square-root 3) / 3]
[45 = arctangent 1]
[pi / 4 = arctangent/radians 1]
[60 = arctangent square-root 3]
[pi / 3 = arctangent/radians square-root 3]
[90 = arctangent 1e16]
[pi / 2 = arctangent/radians 1e16]
; functions/math/complement.r
; bug#849
[false = complement true]
[true = complement false]
; integer
; two's complement representation
[-1 = complement 0]
; two's complement representation
[0 = complement -1]
; two's complement representation
[2147483647 = complement -2147483648]
; two's complement representation
[-2147483648 = complement 2147483647]
; char
#r2only
[#"^(ff)" = complement #"^@"]
#r2only
[#"^@" = complement #"^(ff)"]
#r2only
[#"^(fe)" = complement #"^(01)"]
#r2only
[#"^(01)" = complement #"^(fe)"]
; tuple
[255.255.255 = complement 0.0.0]
[0.0.0 = complement 255.255.255]
; binary
[#{ffffffffff} = complement #{0000000000}]
[#{0000000000} = complement #{ffffffffff}]
; string
#r2only
["^(ff)" = complement "^@"]
#r2only
["^@" = complement "^(ff)"]
#r2only
["^(fe)" = complement "^(01)"]
#r2only
["^(01)" = complement "^(fe)"]
; bitset
#r2only
[
	(make bitset! #{FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF})
		= complement make bitset! #{0000000000000000000000000000000000000000000000000000000000000000}
]
#r2only
[
	(make bitset! #{0000000000000000000000000000000000000000000000000000000000000000})
		= complement make bitset! #{FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
]
[not find complement charset "b" #"b"]
[find complement charset "a" #"b"]
[
	a: make bitset! #{0000000000000000000000000000000000000000000000000000000000000000}
	a == complement complement a
]
[
	a: make bitset! #{FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
	a == complement complement a
]
; image
; bug#1706
[(make image! [1x1 #{000000} #{00}]) = complement make image! [1x1 #{ffffff} #{ff}]]
[(make image! [1x1 #{ffffff} #{ff}]) = complement make image! [1x1 #{000000} #{00}]]
; typeset
; bug#799
#r3only
[typeset? complement make typeset! [unset!]]
; functions/math/cosine.r
[1 = cosine 0]
[1 = cosine/radians 0]
[(square-root 3) / 2 = cosine 30]
[(square-root 3) / 2 = cosine/radians pi / 6]
[(square-root 2) / 2 = cosine 45]
[(square-root 2) / 2 = cosine/radians pi / 4]
[0.5 = cosine 60]
[0.5 = cosine/radians pi / 3]
[0 = cosine 90]
[0 = cosine/radians pi / 2]
[-1 = cosine 180]
[-1 = cosine/radians pi]
[(square-root 3) / -2 = cosine 150]
[(square-root 3) / -2 = cosine/radians pi * 5 / 6]
[(square-root 2) / -2 = cosine 135]
[(square-root 2) / -2 = cosine/radians pi * 3 / 4]
[-0.5 = cosine 120]
[-0.5 = cosine/radians pi * 2 / 3]
; functions/math/difference.r
[24:00 = difference 1/Jan/2007 31/Dec/2006]
[0:00 = difference 1/Jan/2007 1/Jan/2007]
; block
[[1 2] = difference [1 3] [2 3]]
[[] = difference [1 2] [1 2]]
; bitset
[(charset "a") = difference charset "a" charset ""]
; bug#1822: DIFFERENCE on date!s problem
[12:00 = difference 13/1/2011/12:00 13/1/2011]
; functions/math/divide.r
[1 == divide -2147483648 -2147483648]
[2 == divide -2147483648 -1073741824]
[1073741824 == divide -2147483648 -2]
#32bit
[error? try [divide -2147483648 -1]]
[error? try [divide -2147483648 0]]
[-2147483648 == divide -2147483648 1]
[-1073741824 == divide -2147483648 2]
[-2 == divide -2147483648 1073741824]
[0.5 == divide -1073741824 -2147483648]
[1 == divide -1073741824 -1073741824]
[536870912 == divide -1073741824 -2]
[1073741824 == divide -1073741824 -1]
[error? try [divide -1073741824 0]]
[-1073741824 == divide -1073741824 1]
[-536870912 == divide -1073741824 2]
[-1 == divide -1073741824 1073741824]
[1 == divide -2 -2]
[2 == divide -2 -1]
[error? try [divide -2 0]]
[-2 == divide -2 1]
[-1 == divide -2 2]
[0.5 == divide -1 -2]
[1 == divide -1 -1]
[error? try [divide -1 0]]
[-1 == divide -1 1]
[-0.5 == divide -1 2]
[0 == divide 0 -2147483648]
[0 == divide 0 -1073741824]
[0 == divide 0 -2]
[0 == divide 0 -1]
[error? try [divide 0 0]]
[0 == divide 0 1]
[0 == divide 0 2]
[0 == divide 0 1073741824]
[0 == divide 0 2147483647]
[-0.5 == divide 1 -2]
[-1 == divide 1 -1]
[error? try [divide 1 0]]
[1 == divide 1 1]
[0.5 == divide 1 2]
[-1 == divide 2 -2]
[-2 == divide 2 -1]
[error? try [divide 2 0]]
[2 == divide 2 1]
[1 == divide 2 2]
[-0.5 == divide 1073741824 -2147483648]
[-1 == divide 1073741824 -1073741824]
[-536870912 == divide 1073741824 -2]
[-1073741824 == divide 1073741824 -1]
[error? try [divide 1073741824 0]]
[1073741824 == divide 1073741824 1]
[536870912 == divide 1073741824 2]
[1 == divide 1073741824 1073741824]
[-1 == divide 2147483647 -2147483647]
[-1073741823.5 == divide 2147483647 -2]
[-2147483647 == divide 2147483647 -1]
[error? try [divide 2147483647 0]]
[2147483647 == divide 2147483647 1]
[1073741823.5 == divide 2147483647 2]
[1 == divide 2147483647 2147483647]
[10.0 == divide 1 .1]
[10.0 == divide 1.0 .1]
[10x10 == divide 1x1 .1]
; bug#1974
[10.10.10 == divide 1.1.1 .1]
; functions/math/evenq.r
[even? 0]
[not even? 1]
[not even? -1]
[not even? 2147483647]
[even? -2147483648]
#64bit
[not even? 9223372036854775807]
#64bit
[even? -9223372036854775808]
; decimal
[even? 0.0]
[not even? 1.0]
[even? 2.0]
[not even? -1.0]
[even? -2.0]
[not even? 999999999999999.0]
[not even? -999999999999999.0]
; bug#1775
[even? 1.7976931348623157e308]
[even? -1.7976931348623157e308]
; char
[even? #"^@"]
[not even? #"^a"]
[even? #"^b"]
[not even? #"^(ff)"]
; money
[even? $0]
[not even? $1]
[even? $2]
[not even? -$1]
[even? -$2]
[not even? $999999999999999]
[not even? -$999999999999999]
; time
[even? 0:00]
[even? 0:1:00]
[even? -0:1:00]
[not even? 0:0:01]
[even? 0:0:02]
[not even? -0:0:01]
[even? -0:0:02]
; functions/math/exp.r
[1 = exp 0]
[2.718281828459045 = exp 1]
[2.718281828459045 * 2.718281828459045 = exp 2]
[(square-root 2.718281828459045) = exp 0.5]
[1 / 2.718281828459045 = exp -1]
; functions/math/log-10.r
[0 = log-10 1]
[0.5 = log-10 square-root 10]
[1 = log-10 10]
[-1 = log-10 0.1]
[2 = log-10 100]
[-2 = log-10 0.01]
[3 = log-10 1000]
[-3 = log-10 0.001]
[error? try [log-10 0]]
[error? try [log-10 -1]]
; functions/math/log-2.r
[0 = log-2 1]
[1 = log-2 2]
[-1 = log-2 0.5]
[2 = log-2 4]
[-2 = log-2 0.25]
[3 = log-2 8]
[-3 = log-2 0.125]
[error? try [log-2 0]]
[error? try [log-2 -1]]
; functions/math/log-e.r
[0 = log-e 1]
[0.5 = log-e square-root 2.718281828459045]
[1 = log-e 2.718281828459045]
[-1 = log-e 1 / 2.718281828459045]
[2 = log-e 2.718281828459045 * 2.718281828459045]
[error? try [log-e 0]]
[error? try [log-e -1]]
; functions/math/mod.r
[0.0 == mod 1E15 1]
[0.0 == mod -1E15 1]
[0.0 == mod 1E14 1]
[0.0 == mod -1E14 1]
[0 == mod -1 1]
[0.75 == mod -1.25 1]
[0.5 == mod -1.5 1]
[0.25 == mod -1.75 1]
; these have small error; due to binary approximation of decimal numbers
[not negative? 1e-8 - abs 0.9 - mod 99'999'999.9 1]
[not negative? 1e-8 - abs 0.99 - mod 99'999'999.99 1]
[not negative? 1e-8 - abs 0.999 - mod 99'999'999.999 1]
[not negative? 1e-8 - abs 0.9999 - mod 99'999'999.9999 1]
[not negative? 1e-8 - abs 0.99999 - mod 99'999'999.99999 1]
[not negative? 1e-8 - abs 0.999999 - mod 99'999'999.999999 1]
[$0 == mod $999'999'999'999'999 1]
[$0 == mod $999'999'999'999'999 $1]
[0.0 == mod 9'999'999'999'999'999 1.0]
[0.0 == mod 999'999'999'999'999 1.0]
[0.0 == mod 562'949'953'421'311.0 1]
[0.0 == mod -562'949'953'421'311.0 1]
[0.25 == mod 562'949'953'421'311.25 1]
[0.5 == mod 562'949'953'421'311.5 1]
[0.5 == mod -562'949'953'421'311.5 1]
[0.25 == mod -562'949'953'421'311.75 1]
[0.0 == mod 562'949'953'421'312.0 1]
[0.0 == mod -562'949'953'421'312.0 1]
[0.25 == mod 562'949'953'421'312.25 1]
[0.5 == mod -562'949'953'421'312.5 1]
[0.5 == mod 562'949'953'421'312.5 1]
[0.25 == mod -562'949'953'421'312.75 1]
[0.0 == mod 562'949'953'421'313.0 1.0]
[0.0 == mod -562'949'953'421'313.0 1.0]
[0.5 == mod -562'949'953'421'313.5 1]
[0.5 == mod 562'949'953'421'313.5 1]
[0.0 == mod -562'949'953'421'314.0 1]
[0.5 == mod -562'949'953'421'314.5 1]
[0.5 == mod 562'949'953'421'314.5 1]
[not negative? 1e-16 - abs mod 0.15 - 0.05 - 0.1 0.1]
[not negative? 1e-16 - abs mod 0.1 + 0.1 + 0.1 0.3]
[not negative? 1e-16 - abs mod 0.3 0.1 + 0.1 + 0.1]
[not negative? 1e-16 - abs mod to money! 0.1 + 0.1 + 0.1 0.3]
; functions/math/modulo.r
[0.0 == modulo 0.1 + 0.1 + 0.1 0.3]
[0.0 == modulo 0.3 0.1 + 0.1 + 0.1]
[$0.0 == modulo $0.1 + $0.1 + $0.1 $0.3]
[$0.0 == modulo $0.3 $0.1 + $0.1 + $0.1]
[0.0 == modulo 1 0.1]
[0.0 == modulo 0.15 - 0.05 - 0.1 0.1]
; bug#56
[0 = modulo 1 1]
; functions/math/multiply.r
#32bit
[error? try [multiply -2147483648 -2147483648]]
#32bit
[error? try [multiply -2147483648 -1073741824]]
#32bit
[error? try [multiply -2147483648 -2]]
#32bit
[error? try [multiply -2147483648 -1]]
[0 = multiply -2147483648 0]
[-2147483648 = multiply -2147483648 1]
#32bit
[error? try [multiply -2147483648 2]]
#32bit
[error? try [multiply -2147483648 1073741824]]
#32bit
[error? try [multiply -2147483648 2147483647]]
#32bit
[error? try [multiply -1073741824 -2147483648]]
#32bit
[error? try [multiply -1073741824 -1073741824]]
#32bit
[error? try [multiply -1073741824 -2]]
[1073741824 = multiply -1073741824 -1]
[0 = multiply -1073741824 0]
[-1073741824 = multiply -1073741824 1]
[-2147483648 = multiply -1073741824 2]
#32bit
[error? try [multiply -1073741824 1073741824]]
#32bit
[error? try [multiply -1073741824 2147483647]]
#32bit
[error? try [multiply -2 -2147483648]]
#32bit
[error? try [multiply -2 -1073741824]]
[4 = multiply -2 -2]
[2 = multiply -2 -1]
[0 = multiply -2 0]
[-2 = multiply -2 1]
[-4 = multiply -2 2]
[-2147483648 = multiply -2 1073741824]
#32bit
[error? try [multiply -2 2147483647]]
#32bit
[error? try [multiply -1 -2147483648]]
[1073741824 = multiply -1 -1073741824]
[2 = multiply -1 -2]
[1 = multiply -1 -1]
[0 = multiply -1 0]
[-1 = multiply -1 1]
[-2 = multiply -1 2]
[-1073741824 = multiply -1 1073741824]
[-2147483647 = multiply -1 2147483647]
[0 = multiply 0 -2147483648]
[0 = multiply 0 -1073741824]
[0 = multiply 0 -2]
[0 = multiply 0 -1]
[0 = multiply 0 0]
[0 = multiply 0 1]
[0 = multiply 0 2]
[0 = multiply 0 1073741824]
[0 = multiply 0 2147483647]
[-2147483648 = multiply 1 -2147483648]
[-1073741824 = multiply 1 -1073741824]
[-2 = multiply 1 -2]
[-1 = multiply 1 -1]
[0 = multiply 1 0]
[1 = multiply 1 1]
[2 = multiply 1 2]
[1073741824 = multiply 1 1073741824]
[2147483647 = multiply 1 2147483647]
#32bit
[error? try [multiply 2 -2147483648]]
[-2147483648 = multiply 2 -1073741824]
[-4 = multiply 2 -2]
[-2 = multiply 2 -1]
[0 = multiply 2 0]
[2 = multiply 2 1]
#32bit
[error? try [multiply 2 1073741824]]
#32bit
[error? try [multiply 2 2147483647]]
#32bit
[error? try [multiply 1073741824 -2147483648]]
#32bit
[error? try [multiply 1073741824 -1073741824]]
[-2147483648 = multiply 1073741824 -2]
[-1073741824 = multiply 1073741824 -1]
[0 = multiply 1073741824 0]
[1073741824 = multiply 1073741824 1]
#32bit
[error? try [multiply 1073741824 2]]
#32bit
[error? try [multiply 1073741824 1073741824]]
#32bit
[error? try [multiply 1073741824 2147483647]]
#32bit
[error? try [multiply 2147483647 -2147483648]]
#32bit
[error? try [multiply 2147483647 -1073741824]]
#32bit
[error? try [multiply 2147483647 -2]]
[-2147483647 = multiply 2147483647 -1]
[0 = multiply 2147483647 0]
[2147483647 = multiply 2147483647 1]
#32bit
[error? try [multiply 2147483647 2]]
#32bit
[error? try [multiply 2147483647 1073741824]]
#32bit
[error? try [multiply 2147483647 2147483647]]
#64bit
[error? try [multiply -1 -9223372036854775808]]
#64bit
[error? try [multiply -9223372036854775808 -1]]
[0:0:1 == multiply 0:0:2 0.5]
; functions/math/negate.r
[0 = negate 0]
[-1 = negate 1]
[1 = negate -1]
#32bit
[error? try [negate -2147483648]]
; decimal
[0.0 == negate 0.0]
[-1.0 == negate 1.0]
[1.0 == negate -1.0]
[1.7976931348623157e308 = negate -1.7976931348623157e308]
[-1.7976931348623157e308 = negate 1.7976931348623157e308]
[4.94065645841247E-324 = negate -4.94065645841247E-324]
[-4.94065645841247E-324 = negate 4.94065645841247E-324]
; pair
[0x0 = negate 0x0]
[-1x-1 = negate 1x1]
[1x1 = negate -1x-1]
[-1x1 = negate 1x-1]
#r2only
[-2147483648x-2147483648 = negate -2147483648x-2147483648]
; money
[$0 = negate $0]
[-$1 = negate $1]
[$1 = negate -$1]
; time
[0:00 = negate 0:00]
[-1:01 = negate 1:01]
[1:01 = negate -1:01]
; bitset
#r2only
[
	(make bitset! #{FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF})
		= negate make bitset! #{0000000000000000000000000000000000000000000000000000000000000000}
]
#r2only
[
	(make bitset! #{0000000000000000000000000000000000000000000000000000000000000000})
		= negate make bitset! #{FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
]
[
	a: make bitset! #{FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
	a == negate negate a
]
[
	a: make bitset! #{0000000000000000000000000000000000000000000000000000000000000000}
	a == negate negate a
]
; functions/math/negativeq.r
[not negative? 0]
[not negative? 1]
[negative? -1]
[not negative? 2147483647]
[negative? -2147483648]
#64bit
[not negative? 9223372036854775807]
#64bit
[negative? -9223372036854775808]
; decimal
[not negative? 0.0]
[not negative? 4.94065645841247E-324]
[negative? -4.94065645841247E-324]
[not negative? 1.7976931348623157e308]
[negative? -1.7976931348623157e308]
; char
#r2only
[not negative? #"^@"]
#r2only
[not negative? #"^a"]
#r2only
[not negative? #"^(ff)"]
; money
[not negative? $0]
[not negative? $0.01]
[negative? -$0.01]
[not negative? $999999999999999.87]
[negative? -$999999999999999.87]
; time
[not negative? 0:00]
[not negative? 0:00:0.000000001]
[negative? -0:00:0.000000001]
; functions/math/not.r
[false = not :abs]
[false = not #{}]
[false = not charset ""]
[false = not []]
[false = not #"a"]
[false = not datatype!]
[false = not 1/1/2007]
[false = not 0.0]
[false = not me@mydomain.com]
[false = not %myfile]
[false = not func [] []]
[false = not first [:a]]
#r2only
[false = not make hash! []]
[false = not make image! 0x0]
[false = not 0]
[false = not #1444]
#r2only
[false = not make list! []]
[false = not first ['a/b]]
[false = not first ['a]]
[false = not true]
[true = not false]
#r3only
[false = not make map! []]
[false = not $0.00]
[false = not :type?]
[true = not none]
[false = not make object! []]
[false = not type? get '+]
[false = not 0x0]
[false = not first [()]]
[false = not first [a/b]]
[false = not make port! http://]
[false = not /refinement]
[false = not first [a/b:]]
[false = not first [a:]]
[false = not ""]
[false = not <tag>]
[false = not 1:00]
[false = not 1.2.3]
#r3only
[false = not http://]
[false = not 'a]
; functions/math/oddq.r
[not odd? 0]
[odd? 1]
[odd? -1]
[odd? 2147483647]
[not odd? -2147483648]
#64bit
[odd? 9223372036854775807]
#64bit
[not odd? -9223372036854775808]
; decimal
[not odd? 0.0]
[odd? 1.0]
[not odd? 2.0]
[odd? -1.0]
[not odd? -2.0]
[not odd? 1.7976931348623157e308]
[not odd? -1.7976931348623157e308]
[odd? 999999999999999.0]
[odd? -999999999999999.0]
; char
[not odd? #"^@"]
[odd? #"^a"]
[not odd? #"^b"]
[odd? #"^(ff)"]
; money
[not odd? $0]
[odd? $1]
[not odd? $2]
[odd? -$1]
[not odd? -$2]
[odd? $999999999999999]
[odd? -$999999999999999]
; time
[not odd? 0:00]
[not odd? 0:1:00]
[not odd? -0:1:00]
[odd? 0:0:01]
[not odd? 0:0:02]
[odd? -0:0:01]
[not odd? -0:0:02]
; functions/math/positiveq.r
[not positive? 0]
[positive? 1]
[not positive? -1]
[positive? 2147483647]
[not positive? -2147483648]
#64bit
[positive? 9223372036854775807]
#64bit
[not positive? -9223372036854775808]
; decimal
[not positive? 0.0]
[positive? 4.94065645841247E-324]
[not positive? -4.94065645841247E-324]
[positive? 1.7976931348623157e308]
[not positive? -1.7976931348623157e308]
; char
#r2only
[not positive? #"^@"]
#r2only
[positive? #"^a"]
#r2only
[positive? #"^(ff)"]
; money
[not positive? $0]
[positive? $0.01]
[not positive? -$0.01]
[positive? $999999999999999.87]
[not positive? -$999999999999999.87]
; time
[not positive? 0:00]
[positive? 0:00:0.000000001]
[not positive? -0:00:0.000000001]
; functions/math/power.r
[1 = power 1 1000]
[1 = power 1000 0]
[4 = power 2 2]
[0.5 = power 2 -1]
[0.1 = power 10 -1]
; functions/math/random.r
; bug#1084
#r3only
[
	random/seed 0
	not any [
		negative? random 1.0
		negative? random 1.0
	]
]
; bug#1875
[
	random/seed 0
	2 = random/only next [1 2]
]
; bug#932
[
	s: "aa"
	random/seed s
	a: random 10000
	random/seed s
	a = random 10000
]
; functions/math/remainder.r
#64bit
; integer! tests
[0 = remainder -9223372036854775808 -1]
; integer! tests
[0 == remainder -2147483648 -1]
; time! tests
[-1:00 == remainder -1:00 -3:00]
[1:00 == remainder 1:00 -3:00]
; functions/math/round.r
[0 == round 0]
[1 == round 1]
[-1 == round -1]
[zero? 2 - round 1.5]
[zero? 3 - round 2.5]
[zero? -2 - round -1.5]
[zero? -3 - round -2.5]
; REBOL rounds to 2.0 beyond this
[zero? 1 - round 1.499999999999995]
[zero? 2 - round 1.500000000000001]
[zero? -1 - round -1.499999999999995]
[zero? -2 - round -1.500000000000001]
[1:03:01 == round 1:03:01.1]
[1:03:02 == round 1:03:01.5]
[1:03:02 == round 1:03:01.9]
[zero? round 0.00001]
[zero? round 0.49999999]
[zero? 1 - round 0.5]
[zero? 1 - round 1.49999999]
[2 == round 2]
[zero? 2 - round 2.49999999]
[zero? round -0.00001]
[zero? round -0.49999999]
[zero? -1 - round -0.5]
[zero? -1 - round -1.49999999]
[-2 == round -2]
#r3only
[1E20 == round 1E20]
#r3only
[2147483648.0 == round 2147483648.0]
#r3only
[9223372036854775808.0 == round 9223372036854775808.0]
[$101 == round $100.5]
[-$101 = round -$100.5]
; REBOL2 rounds to $100.5 beyond this
[$100 == round $100.4999999999998]
; REBOL2 rounds to $100.5 beyond this
[-$100 == round -$100.4999999999998]
; REBOL2 rounds to $1000.5 beyond this
[$1000 == round $1000.499999999999]
; REBOL2 rounds to $1000.5 beyond this
[-$1000 == round -$1000.499999999999]
[0:0:1 == round 0:0:1.4999]
[0:1:0 == round 0:1:0.4999]
[1:0:0 == round 1:0:0.4999]
[-0:0:1 == round -0:0:1.4999]
[-0:1:0 == round -0:1:0.4999]
[-1:0:0 == round -1:0:0.4999]
[0:0:2 == round 0:0:1.5]
[0:1:1 == round 0:1:0.5]
[1:0:1 == round 1:0:0.5]
[-0:0:2 == round -0:0:1.5]
[-0:1:1 == round -0:1:0.5]
[-1:0:1 == round -1:0:0.5]
; round/to tests
[100 == round/to 108 25]
[zero? 100 - round/to 100.000001 25]
[zero? 100 - round/to 112.499999 25]
[zero? 125 - round/to 112.5 25]
[zero? -100 - round/to -100.000001 25]
[zero? -100 - round/to -112.499999 25]
[zero? -125 - round/to -112.5 25]
[zero? -125 - round/to -112.500001 25]
[125 == round/to 133 25]
[1.00 == round/to 1.08 0.25]
[1.25 == round/to 1.33 0.25]
[1:00 == round/to 1:03 0:15]
[1:15 == round/to 1:08 0:15]
[1:15 == round/to 1:18 0:15]
[1:30 == round/to 1:22:31 0:15]
[1:02 == round/to 1:02:03 0:01]
[562'949'953'421'312.0 == round/to 562'949'953'421'312.0 1.0]
[-562'949'953'421'312.0 == round/to -562'949'953'421'312.0 1.0]
[562'949'953'421'313.0 == round/to 562'949'953'421'313.0 1.0]
[-562'949'953'421'313.0 == round/to -562'949'953'421'313.0 1.0]
[562'949'953'421'314.0 == round/to 562'949'953'421'314.0 1.0]
[-562'949'953'421'314.0 == round/to -562'949'953'421'314.0 1.0]
[zero? $100.2 - round/to 100.15 $0.1]
[$100.2 == round/to $100.15 $0.1]
[1:1:1.2 == round/to 1:1:1.15 0:0:0.1]
[$100 == round/to $100.15 $2]
[1:1:2 == round/to 1:1:1.15 0:0:2]
[0 == round/even 0]
[1 == round/even 1]
[-1 == round/even -1]
[zero? 2 - round/even 1.5]
[zero? 2 - round/even 2.5]
[zero? -2 - round/even -1.5]
[zero? -2 - round/even -2.5]
; REBOL2 rounds to 2.0 beyond this
[zero? 1 - round/even 1.49999999999995]
[zero? 1 - round/even 1.499999999999995]
[zero? 2 - round/even 1.500000000000001]
[zero? -1 - round/even -1.499999999999995]
[zero? -2 - round/even -1.500000000000001]
[2147483647 == round/even 2147483647]
[-2147483648 == round/even -2147483648]
#r2only
[error? try [round/even 2147483648.0]]
#r2only
[error? try [round/even 9.2233720368547799e18]]
#r3only
[9223372036854780000.0 == round/even 9223372036854780000.0]
[1:03:01 == round/even 1:03:01.1]
[1:03:02 == round/even 1:03:01.5]
[1:03:02 == round/even 1:03:01.9]
[$100 == round/even $100.25]
[-$100 == round/even -$100.25]
; round/even/to; divide by 0
[error? try [round/even/to 0.1 0]]
[zero? round/even/to 0.1 -1.0]
[zero? round/even/to 0.1 -1]
[zero? round/even/to 0.5 -1.0]
[zero? round/even/to 0.5 -1]
[zero? 2 - round/even/to 1.5 -1.0]
[zero? 2 - round/even/to 1.5 -1]
[zero? round/even/to -0.1 -1.0]
[zero? round/even/to -0.1 -1]
[0.0 == round/even/to -0.5 -1.0]
[zero? round/even/to -0.5 -1]
[-2.0 == round/even/to -1.5 -1.0]
[zero? -2 - round/even/to -1.5 -1]
[0.0 == round/even/to 0.1 1.0]
[0.0 == round/even/to 0.1 1E-0]
[0.0 == round/even/to -0.1 1E-0]
[0.1 == round/even/to 0.12 1E-1]
[-0.1 == round/even/to -0.12 1E-1]
[0.12 == round/even/to 0.123 1E-2]
[-0.12 == round/even/to -0.123 1e-2]
[0.123 == round/even/to 0.1234 1E-3]
[-0.123 == round/even/to -0.1234 1E-3]
[0.1234 = round/even/to 0.12345 1E-4]
[-0.1234 = round/even/to -0.12345 1E-4]
; bug#1470
[2.6 == round/even/to $2.55 0.1]
; bug#1470
[$2.6 == round/even/to 2.55 $0.1]
; round-up breakpoint
[0.12346 = round/even/to 0.123456 1E-5]
[-0.12346 = round/even/to -0.123456 1E-5]
[1.0 == round/even/to 0.9 1E-0]
[-1.0 == round/even/to -0.9 1E-0]
[0.6 = round/even/to 0.55 1E-1]
[-0.6 = round/even/to -0.55 1E-1]
[0.56 == round/even/to 0.555 1E-2]
[-0.56 == round/even/to -0.555 1E-2]
[2.0 == round/even/to 1.5 1E-0]
[1.6 == round/even/to 1.55 1E-1]
[1.56 == round/even/to 1.555 1E-2]
[1.556 == round/even/to 1.5555  1E-3]
[1.5556 == round/even/to 1.55555 1E-4]
[1.55556 = round/even/to 1.555555 1E-5]
[1.555556 == round/even/to 1.5555555 1E-6]
[1.5555556 == round/even/to 1.55555555 1E-7]
[1.55555556 == round/even/to 1.555555555 1E-8]
[1.555555556 = round/even/to 1.5555555555 1E-9]
[0.2 == round/even/to 0.15 1E-1]
[-0.2 == round/even/to -0.15 1E-1]
[0.4 == round/even/to 0.35 1E-1]
[1.0 == round/even/to 0.95 1E-1]
[1.2 = round/even/to 1.15 1E-1]
[2.2 == round/even/to 2.15 1E-1]
[2.6 == round/even/to 2.55 1E-1]
[10.0 == round/even/to 10 1E-1]
[zero? 110 - round/even/to 107.5 5]
[zero? 110 - round/even/to 112.5 5]
[zero? 120 - round/even/to 115 10]
[zero? 100 - round/even/to 100.000001 25]
[zero? 100 - round/even/to 112.499999 25]
[zero? 100 - round/even/to 112.5 25]
[zero? 150 - round/even/to 137.5 25]
[zero? -100 - round/even/to -100.000001 25]
[zero? -100 - round/even/to -112.499999 25]
[zero? -100 - round/even/to -112.5 25]
[zero? -125 - round/even/to -112.500001 25]
[zero? -150 - round/even/to -137.5 25]
[1:02:3.1 == round/even/to 1:02:3.14999 0:0:0.1]
[1:02:3.2 == round/even/to 1:02:3.15 0:0:0.1]
[1:02:3.2 == round/even/to 1:02:3.25 0:0:0.1]
[1:02:3.3 == round/even/to 1:02:3.25001 0:0:0.1]
[1:15 == round/even/to 1:22:29.9999 0:15]
[1:30 == round/even/to 1:22:30 0:15]
[0.0 == (562'949'953'421'312.0 - round/even/to 562'949'953'421'312.0 1.0)]
[0.0 == (-562'949'953'421'312.0 - round/even/to -562'949'953'421'312.0 1.0)]
[0.0 == (562'949'953'421'313.0 - round/even/to 562'949'953'421'313.0 1.0)]
[0.0 == (-562'949'953'421'313.0 - round/even/to -562'949'953'421'313.0 1.0)]
[562'949'953'421'314.0 == round/even/to 562'949'953'421'314.0 1.0]
[-562'949'953'421'314.0 == round/even/to -562'949'953'421'314.0 1.0]
; bug#1116
[$1.15 == round/even/to 1.15 $0.01]
; this fails, by design
[0:0:1.15 == round/even/to 0:0:1.15 0:0:0.01]
[1.15 == round/even/to $1.15 0.01]
[-0:0:2.6 == round/even/to -0:0:2.55 0:0:0.1]
[-$2.6 == round/even/to -$2.55 $0.1]
[0.0 == (1e-15 - round/even/to 1.1e-15 1e-15)]
#r2only
[$0.0 == ($0.000'000'000'000'001 - round/even/to $0.000'000'000'000'001'1 1e-15)]
#r3only
[$0.0 == ($0.000'000'000'000'001 - round/even/to $0.000'000'000'000'001'1 $1e-15)]
[not negative? 1e-31 - abs 26e-17 - round/even/to 25.5e-17 1e-17]
#r2only
[not negative? 1e-31 - abs (to money! 26e-17) - round/even/to $0.000'000'000'000'000'255 to money! 1e-17]
#r3only
[not negative? ($1e-31) - abs $26e-17 - round/even/to $0.000'000'000'000'000'255 $1e-17]
[0:0:2.6 == round/even/to 0:0:2.55 0:0:0.1]
#r2only
[$2.6 == round/even/to $2.55 1E-1]
#r3only
[$2.6 == round/even/to $2.55 $0.1]
[not negative? 1e-31 - abs -26e-17 - round/even/to -25.5e-17 1e-17]
#r2only
[not negative? (to money! 1e-31) - abs (to money! -26e-17) - round/even/to -$0.000'000'000'000'000'255 to money! 1e-17]
#r3only
[not negative? $1e-31 - abs -$26e-17 - round/even/to -$0.000'000'000'000'000'255 $1e-17]
[$1 == round/even/to $1.23456789 $1]
[$1.2 == round/even/to $1.23456789 $0.1]
[$1.23 == round/even/to $1.23456789 $0.01]
[$1.235 == round/even/to $1.23456789 $0.001]
[$1.2346 == round/even/to $1.23456789 $0.0001]
[$1.23457 == round/even/to $1.23456789 $0.00001]
[$1.234568 == round/even/to $1.23456789 $0.000001]
[$1.2345679 == round/even/to $1.23456789 $0.0000001]
[$1.23456789 == round/even/to $1.23456789 $0.00000001]
; round/ceiling
[0 == round/ceiling 0]
[1 == round/ceiling 1]
[-1 == round/ceiling -1]
[zero? 2 - round/ceiling 1.1]
[zero? 1 - round/ceiling 0.00000000000001]
[zero? round/ceiling -0.00000000000001]
[zero? 1 - round/ceiling 0.99999999999995]
[zero? -1 - round/ceiling -1.00000000000001]
[zero? -1 - round/ceiling -1.99999999999995]
[zero? 1 - round/ceiling 0.00001]
[zero? 1 - round/ceiling 0.49999999]
[zero? 1 - round/ceiling 0.5]
[zero? 2 - round/ceiling 1.49999999]
[zero? 2 - round/ceiling 1.5]
[2 == round/ceiling 2]
[zero? 3 - round/ceiling 2.49999999]
[zero? 3 - round/ceiling 2.5]
[zero? round/ceiling -0.00001]
[zero? round/ceiling -0.49999999]
[zero? round/ceiling -0.5]
[zero? -1 - round/ceiling -1.49999999]
[zero? -1 - round/ceiling -1.5]
[-2 == round/ceiling -2]
; round/ceiling/to
[562'949'953'421'312.0 == round/ceiling/to 562'949'953'421'312.0 1.0]
[-562'949'953'421'312.0 == round/ceiling/to -562'949'953'421'312.0 1.0]
[562'949'953'421'313.0 == round/ceiling/to 562'949'953'421'313.0 1.0]
[-562'949'953'421'313.0 == round/ceiling/to -562'949'953'421'313.0 1.0]
[562'949'953'421'314.0 == round/ceiling/to 562'949'953'421'314.0 1.0]
[-562'949'953'421'314.0 == round/ceiling/to -562'949'953'421'314.0 1.0]
; round/floor
[-1 == round/floor -1]
[zero? 1 - round/floor 1.1]
[zero? round/floor 0.00000000000001]
[zero? -1 - round/floor -0.00000000000001]
[zero? round/floor 0.99999999999995]
[zero? -2 - round/floor -1.00000000000001]
[zero? -2 - round/floor -1.99999999999995]
; round/floor/to
[zero? 100 - round/floor/to 112.499999 25]
[zero? 100 - round/floor/to 112.5 25]
[zero? -125 - round/floor/to -112.000001 25]
[zero? -125 - round/floor/to -112.5 25]
[zero? -125 - round/floor/to -112.500001 25]
[562'949'953'421'312.0 == round/floor/to 562'949'953'421'312.0 1.0]
[-562'949'953'421'312.0 == round/floor/to -562'949'953'421'312.0 1.0]
[562'949'953'421'313.0 == round/floor/to 562'949'953'421'313.0 1.0]
[-562'949'953'421'313.0 == round/floor/to -562'949'953'421'313.0 1.0]
[562'949'953'421'314.0 == round/floor/to 562'949'953'421'314.0 1.0]
[-562'949'953'421'314.0 == round/floor/to -562'949'953'421'314.0 1.0]
; round/down
[0 == round/down 0]
[1 == round/down 1]
[-1 == round/down -1]
[zero? 1 - round/down 1.1]
[zero? round/down 0.00000000000001]
[zero? round/down -0.00000000000001]
[zero? round/down 0.99999999999995]
[zero? -1 - round/down -1.00000000000001]
[zero? -1 - round/down -1.99999999999995]
[1:02:03 == round/down 1:02:03]
[1:02:03 == round/down 1:02:03.00000000001]
[1:02:03 == round/down 1:02:03.999999999]
; round/down/to
[9.6 == round/down/to 10.0 0.96]
[9.6 == round/down/to 10.55 0.96]
[562'949'953'421'312.0 == round/down/to 562'949'953'421'312.0 1.0]
[-562'949'953'421'312.0 == round/down/to -562'949'953'421'312.0 1.0]
[562'949'953'421'313.0 == round/down/to 562'949'953'421'313.0 1.0]
[-562'949'953'421'313.0 == round/down/to -562'949'953'421'313.0 1.0]
[562'949'953'421'314.0 == round/down/to 562'949'953'421'314.0 1.0]
[-562'949'953'421'314.0 == round/down/to -562'949'953'421'314.0 1.0]
[1.1 == round/down/to 1.123456789 1E-1]
[1.12 == round/down/to 1.123456789 1E-2]
[1.123 == round/down/to 1.123456789 1E-3]
[1.1234 == round/down/to 1.123456789 1E-4]
[1.12345 == round/down/to 1.123456789 1E-5]
[1.123456 == round/down/to 1.123456789 1E-6]
[1.1234567 == round/down/to 1.123456789 1E-7]
[1.12345678 == round/down/to 1.123456789 1E-8]
[1:0:0 == round/down/to 1:02:3.456789 0:5:0]
[1:0:0 == round/down/to 1:02:3.456789 0:3:0]
[1:2:0 == round/down/to 1:02:3.456789 0:2:0]
[1:2:0 == round/down/to 1:02:3.456789 0:1:0]
[1:2:0 == round/down/to 1:02:3.456789 0:0:5]
[1:2:0 == round/down/to 1:02:3.456789 0:0:4]
[1:02:3 == round/down/to 1:02:3.456789 0:0:3]
[1:2:2 == round/down/to 1:02:3.456789 0:0:2]
[1:2:3 == round/down/to 1:02:3.456789 0:0:1]
[1:2:3.4 == round/down/to 1:02:3.456789 0:0:0.1]
[1:2:3.45 == round/down/to 1:02:3.456789 0:0:0.01]
[1:2:3.456 == round/down/to 1:02:3.456789 0:0:0.001]
[1:2:3.4567 == round/down/to 1:02:3.456789 0:0:0.0001]
[1:2:3.45678 == round/down/to 1:02:3.456789 0:0:0.00001]
; round/half-ceiling
[0 == round/half-ceiling 0]
[1 == round/half-ceiling 1]
[-1 == round/half-ceiling -1]
[zero? 2 - round/half-ceiling 1.5]
[zero? 3 - round/half-ceiling 2.5]
[zero? -1 - round/half-ceiling -1.5]
[zero? -2 - round/half-ceiling -2.5]
; REBOL2 rounds to 1.5 beyond this
[zero? 1 - round/half-ceiling 1.499999999999995]
[zero? 2 - round/half-ceiling 1.50000000000001]
[zero? -1 - round/half-ceiling -1.49999999999995]
[zero? -2 - round/half-ceiling -1.50000000000001]
[1:03:01 == round/half-ceiling 1:03:01.1]
[1:03:02 == round/half-ceiling 1:03:01.5]
[1:03:02 == round/half-ceiling 1:03:01.9]
[-1:03:01 == round/half-ceiling -1:03:01]
[-1:03:01 == round/half-ceiling -1:03:01.5]
[-1:03:02 == round/half-ceiling -1:03:01.50001]
[$100 == round/half-ceiling $100]
[$101 == round/half-ceiling $100.5]
[$101 == round/half-ceiling $100.5000000001]
[-$100 == round/half-ceiling -$100]
[-$100 == round/half-ceiling -$100.5]
; bug#1471
[-$101 == round/half-ceiling -$100.5000000001]
; round/half-ceiling/to
[0.0 == round/half-ceiling/to 0.1 -1.0]
[zero? round/half-ceiling/to 0.1 -1]
[1.0 == round/half-ceiling/to 0.5 -1.0]
[zero? 1 - round/half-ceiling/to 0.5 -1]
[2.0 == round/half-ceiling/to 1.5 -1.0]
[zero? 2 - round/half-ceiling/to 1.5 -1]
[0.0 == round/half-ceiling/to -0.1 -1.0]
[zero? round/half-ceiling/to -0.1 -1]
[0.0 == round/half-ceiling/to -0.5 -1.0]
[zero? round/half-ceiling/to -0.5 -1]
[-1.0 == round/half-ceiling/to -1.5 -1.0]
[zero? -1 - round/half-ceiling/to -1.5 -1]
; round/half-down
[0 == round/half-down 0]
[1 == round/half-down 1]
[-1 == round/half-down -1]
[zero? 1 - round/half-down 1.5]
[zero? 2 - round/half-down 1.50000000001]
[zero? 2 - round/half-down 2.5]
[zero? 3 - round/half-down 2.50000000001]
[zero? -1 - round/half-down -1.5]
[zero? -2 - round/half-down -1.50000000001]
[zero? -2 - round/half-down -2.5]
[zero? -3 - round/half-down -2.50000000001]
[1:03:01 == round/half-down 1:03:01.1]
[1:03:01 == round/half-down 1:03:01.5]
[1:03:02 == round/half-down 1:03:01.9]
[-1:03:01 == round/half-down -1:03:01]
[-1:03:01 == round/half-down -1:03:01.5]
[-1:03:02 == round/half-down -1:03:01.50001]
[$100 == round/half-down $100]
[$100 == round/half-down $100.5]
[$101 == round/half-down $100.5000000001]
[-$100 == round/half-down -$100]
[-$100 == round/half-down -$100.5]
[-$101 == round/half-down -$100.5000000001]
; round/half-down/to
[0.1 == round/half-down/to 0.15 0.1]
[0.2 == round/half-down/to 0.15001 0.1]
[0.5 == round/half-down/to 0.55 0.1]
[0.6 == round/half-down/to 0.55001 0.1]
[0.5 == round/half-down/to 0.75 0.5]
[1.0 == round/half-down/to 0.75001 0.5]
[-0.1 == round/half-down/to -0.15 0.1]
[-0.2 == round/half-down/to -0.15001 0.1]
[-0.5 == round/half-down/to -0.55 0.1]
[-0.6 == round/half-down/to -0.55001 0.1]
[-0.5 == round/half-down/to -0.75 0.5]
[-1.0 == round/half-down/to -0.75001 0.5]
; functions/math/shift.r
; bug#2067
; logical shift of to integer! #{8000000000000000}
#64bit
[strict-equal? 0 shift/logical to integer! #{8000000000000000} to integer! #{8000000000000000}]
#64bit
[strict-equal? 0 shift/logical to integer! #{8000000000000000} to integer! #{8000000000000001}]
#64bit
[strict-equal? 0 shift/logical to integer! #{8000000000000000} -65]
#64bit
[strict-equal? 0 shift/logical to integer! #{8000000000000000} -64]
#64bit
[strict-equal? 1 shift/logical to integer! #{8000000000000000} -63]
#64bit
[strict-equal? 2 shift/logical to integer! #{8000000000000000} -62]
#64bit
[strict-equal? to integer! #{4000000000000000} shift/logical to integer! #{8000000000000000} -1]
#64bit
[strict-equal? to integer! #{8000000000000000} shift/logical to integer! #{8000000000000000} 0]
#64bit
[strict-equal? 0 shift/logical to integer! #{8000000000000000} 1]
#64bit
[strict-equal? 0 shift/logical to integer! #{8000000000000000} 62]
#64bit
[strict-equal? 0 shift/logical to integer! #{8000000000000000} 63]
#64bit
[strict-equal? 0 shift/logical to integer! #{8000000000000000} 64]
#64bit
[strict-equal? 0 shift/logical to integer! #{8000000000000000} 65]
#64bit
[strict-equal? 0 shift/logical to integer! #{8000000000000000} to integer! #{7ffffffffffffffe}]
#64bit
[strict-equal? 0 shift/logical to integer! #{8000000000000000} to integer! #{7fffffffffffffff}]
; logical shift of to integer! #{8000000000000001}
#64bit
[strict-equal? 0 shift/logical to integer! #{8000000000000001} to integer! #{8000000000000000}]
#64bit
[strict-equal? 0 shift/logical to integer! #{8000000000000001} to integer! #{8000000000000001}]
#64bit
[strict-equal? 0 shift/logical to integer! #{8000000000000001} -65]
#64bit
[strict-equal? 0 shift/logical to integer! #{8000000000000001} -64]
#64bit
[strict-equal? 1 shift/logical to integer! #{8000000000000001} -63]
#64bit
[strict-equal? 2 shift/logical to integer! #{8000000000000001} -62]
#64bit
[strict-equal? to integer! #{4000000000000000} shift/logical to integer! #{8000000000000001} -1]
#64bit
[strict-equal? to integer! #{8000000000000001} shift/logical to integer! #{8000000000000001} 0]
#64bit
[strict-equal? 2 shift/logical to integer! #{8000000000000001} 1]
#64bit
[strict-equal? to integer! #{4000000000000000} shift/logical to integer! #{8000000000000001} 62]
#64bit
[strict-equal? to integer! #{8000000000000000} shift/logical to integer! #{8000000000000001} 63]
#64bit
[strict-equal? 0 shift/logical to integer! #{8000000000000001} 64]
#64bit
[strict-equal? 0 shift/logical to integer! #{8000000000000001} 65]
#64bit
[strict-equal? 0 shift/logical to integer! #{8000000000000001} to integer! #{7ffffffffffffffe}]
#64bit
[strict-equal? 0 shift/logical to integer! #{8000000000000001} to integer! #{7fffffffffffffff}]
; logical shift of -1
#64bit
[strict-equal? 0 shift/logical -1 to integer! #{8000000000000000}]
#64bit
[strict-equal? 0 shift/logical -1 to integer! #{8000000000000001}]
#r3only
[strict-equal? 0 shift/logical -1 -65]
#r3only
[strict-equal? 0 shift/logical -1 -64]
#64bit
[strict-equal? 1 shift/logical -1 -63]
#r3only
[strict-equal? 3 shift/logical -1 -62]
#64bit
[strict-equal? to integer! #{7fffffffffffffff} shift/logical -1 -1]
[strict-equal? -1 shift/logical -1 0]
[strict-equal? -2 shift/logical -1 1]
#64bit
[strict-equal? to integer! #{c000000000000000} shift/logical -1 62]
#64bit
[strict-equal? to integer! #{8000000000000000} shift/logical -1 63]
[strict-equal? 0 shift/logical -1 64]
[strict-equal? 0 shift/logical -1 65]
#64bit
[strict-equal? 0 shift/logical -1 to integer! #{7ffffffffffffffe}]
#64bit
[strict-equal? 0 shift/logical -1 to integer! #{7fffffffffffffff}]
; logical shift of 0
#64bit
[strict-equal? 0 shift/logical 0 to integer! #{8000000000000000}]
#64bit
[strict-equal? 0 shift/logical 0 to integer! #{8000000000000001}]
[strict-equal? 0 shift/logical 0 -65]
[strict-equal? 0 shift/logical 0 -64]
[strict-equal? 0 shift/logical 0 -63]
[strict-equal? 0 shift/logical 0 -62]
[strict-equal? 0 shift/logical 0 -1]
[strict-equal? 0 shift/logical 0 0]
[strict-equal? 0 shift/logical 0 1]
[strict-equal? 0 shift/logical 0 62]
[strict-equal? 0 shift/logical 0 63]
[strict-equal? 0 shift/logical 0 64]
[strict-equal? 0 shift/logical 0 65]
#64bit
[strict-equal? 0 shift/logical 0 to integer! #{7ffffffffffffffe}]
#64bit
[strict-equal? 0 shift/logical 0 to integer! #{7fffffffffffffff}]
; logical shift of 1
#64bit
[strict-equal? 0 shift/logical 1 to integer! #{8000000000000000}]
#64bit
[strict-equal? 0 shift/logical 1 to integer! #{8000000000000001}]
#r3only
[strict-equal? 0 shift/logical 1 -65]
#r3only
[strict-equal? 0 shift/logical 1 -64]
#r3only
[strict-equal? 0 shift/logical 1 -63]
#r3only
[strict-equal? 0 shift/logical 1 -62]
#r3only
[strict-equal? 0 shift/logical 1 -1]
[strict-equal? 1 shift/logical 1 0]
[strict-equal? 2 shift/logical 1 1]
#64bit
[strict-equal? to integer! #{4000000000000000} shift/logical 1 62]
#64bit
[strict-equal? to integer! #{8000000000000000} shift/logical 1 63]
[strict-equal? 0 shift/logical 1 64]
[strict-equal? 0 shift/logical 1 65]
#64bit
[strict-equal? 0 shift/logical 1 to integer! #{7ffffffffffffffe}]
#64bit
[strict-equal? 0 shift/logical 1 to integer! #{7fffffffffffffff}]
; logical shift of to integer! #{7ffffffffffffffe}
#64bit
[strict-equal? 0 shift/logical to integer! #{7ffffffffffffffe} to integer! #{8000000000000000}]
#64bit
[strict-equal? 0 shift/logical to integer! #{7ffffffffffffffe} to integer! #{8000000000000001}]
#64bit
[strict-equal? 0 shift/logical to integer! #{7ffffffffffffffe} -65]
#64bit
[strict-equal? 0 shift/logical to integer! #{7ffffffffffffffe} -64]
#64bit
[strict-equal? 0 shift/logical to integer! #{7ffffffffffffffe} -63]
#64bit
[strict-equal? 1 shift/logical to integer! #{7ffffffffffffffe} -62]
#64bit
[strict-equal? to integer! #{3fffffffffffffff} shift/logical to integer! #{7ffffffffffffffe} -1]
#64bit
[strict-equal? to integer! #{7ffffffffffffffe} shift/logical to integer! #{7ffffffffffffffe} 0]
#64bit
[strict-equal? -4 shift/logical to integer! #{7ffffffffffffffe} 1]
#64bit
[strict-equal? to integer! #{8000000000000000} shift/logical to integer! #{7ffffffffffffffe} 62]
#64bit
[strict-equal? 0 shift/logical to integer! #{7ffffffffffffffe} 63]
#64bit
[strict-equal? 0 shift/logical to integer! #{7ffffffffffffffe} 64]
#64bit
[strict-equal? 0 shift/logical to integer! #{7ffffffffffffffe} 65]
#64bit
[strict-equal? 0 shift/logical to integer! #{7ffffffffffffffe} to integer! #{7ffffffffffffffe}]
#64bit
[strict-equal? 0 shift/logical to integer! #{7ffffffffffffffe} to integer! #{7fffffffffffffff}]
; logical shift of to integer! #{7fffffffffffffff}
#64bit
[strict-equal? 0 shift/logical to integer! #{7fffffffffffffff} to integer! #{8000000000000000}]
#64bit
[strict-equal? 0 shift/logical to integer! #{7fffffffffffffff} to integer! #{8000000000000001}]
#64bit
[strict-equal? 0 shift/logical to integer! #{7fffffffffffffff} -65]
#64bit
[strict-equal? 0 shift/logical to integer! #{7fffffffffffffff} -64]
#64bit
[strict-equal? 0 shift/logical to integer! #{7fffffffffffffff} -63]
#64bit
[strict-equal? 1 shift/logical to integer! #{7fffffffffffffff} -62]
#64bit
[strict-equal? to integer! #{3fffffffffffffff} shift/logical to integer! #{7fffffffffffffff} -1]
#64bit
[strict-equal? to integer! #{7fffffffffffffff} shift/logical to integer! #{7fffffffffffffff} 0]
#64bit
[strict-equal? -2 shift/logical to integer! #{7fffffffffffffff} 1]
#64bit
[strict-equal? to integer! #{c000000000000000} shift/logical to integer! #{7fffffffffffffff} 62]
#64bit
[strict-equal? to integer! #{8000000000000000} shift/logical to integer! #{7fffffffffffffff} 63]
#64bit
[strict-equal? 0 shift/logical to integer! #{7fffffffffffffff} 64]
#64bit
[strict-equal? 0 shift/logical to integer! #{7fffffffffffffff} 65]
#64bit
[strict-equal? 0 shift/logical to integer! #{7fffffffffffffff} to integer! #{7ffffffffffffffe}]
#64bit
[strict-equal? 0 shift/logical to integer! #{7fffffffffffffff} to integer! #{7fffffffffffffff}]
; arithmetic shift of to integer! #{8000000000000000}
#64bit
[strict-equal? -1 shift to integer! #{8000000000000000} to integer! #{8000000000000000}]
#64bit
[strict-equal? -1 shift to integer! #{8000000000000000} to integer! #{8000000000000001}]
#64bit
[strict-equal? -1 shift to integer! #{8000000000000000} -65]
#64bit
[strict-equal? -1 shift to integer! #{8000000000000000} -64]
#64bit
[strict-equal? -1 shift to integer! #{8000000000000000} -63]
#64bit
[strict-equal? -2 shift to integer! #{8000000000000000} -62]
#64bit
[strict-equal? to integer! #{c000000000000000} shift to integer! #{8000000000000000} -1]
#64bit
[strict-equal? to integer! #{8000000000000000} shift to integer! #{8000000000000000} 0]
#64bit
[error? try [shift to integer! #{8000000000000000} 1]]
#64bit
[error? try [shift to integer! #{8000000000000000} 62]]
#64bit
[error? try [shift to integer! #{8000000000000000} 63]]
#64bit
[error? try [shift to integer! #{8000000000000000} 64]]
#64bit
[error? try [shift to integer! #{8000000000000000} 65]]
#64bit
[error? try [shift to integer! #{8000000000000000} to integer! #{7ffffffffffffffe}]]
#64bit
[error? try [shift to integer! #{8000000000000000} to integer! #{7fffffffffffffff}]]
#64bit
; arithmetic shift of to integer! #{8000000000000001}
#64bit
[strict-equal? -1 shift to integer! #{8000000000000001} to integer! #{8000000000000000}]
#64bit
[strict-equal? -1 shift to integer! #{8000000000000001} to integer! #{8000000000000001}]
#64bit
[strict-equal? -1 shift to integer! #{8000000000000001} -65]
#64bit
[strict-equal? -1 shift to integer! #{8000000000000001} -64]
#64bit
[strict-equal? -1 shift to integer! #{8000000000000001} -63]
#64bit
[strict-equal? -2 shift to integer! #{8000000000000001} -62]
#64bit
[strict-equal? to integer! #{c000000000000000} shift to integer! #{8000000000000001} -1]
#64bit
[strict-equal? to integer! #{8000000000000001} shift to integer! #{8000000000000001} 0]
#64bit
[error? try [shift to integer! #{8000000000000001} 1]]
#64bit
[error? try [shift to integer! #{8000000000000001} 62]]
#64bit
[error? try [shift to integer! #{8000000000000001} 63]]
#64bit
[error? try [shift to integer! #{8000000000000001} 64]]
#64bit
[error? try [shift to integer! #{8000000000000001} 65]]
#64bit
[error? try [shift to integer! #{8000000000000001} to integer! #{7ffffffffffffffe}]]
#64bit
[error? try [shift to integer! #{8000000000000001} to integer! #{7fffffffffffffff}]]
; arithmetic shift of -1
#64bit
[strict-equal? -1 shift -1 to integer! #{8000000000000000}]
#64bit
[strict-equal? -1 shift -1 to integer! #{8000000000000001}]
#r3only
[strict-equal? -1 shift -1 -65]
#r3only
[strict-equal? -1 shift -1 -64]
#r3only
[strict-equal? -1 shift -1 -63]
#r3only
[strict-equal? -1 shift -1 -62]
#r3only
[strict-equal? -1 shift -1 -1]
[strict-equal? -1 shift -1 0]
[strict-equal? -2 shift -1 1]
#64bit
[strict-equal? to integer! #{c000000000000000} shift -1 62]
#64bit
[strict-equal? to integer! #{8000000000000000} shift -1 63]
[error? try [shift -1 64]]
[error? try [shift -1 65]]
#64bit
[error? try [shift -1 to integer! #{7ffffffffffffffe}]]
#64bit
[error? try [shift -1 to integer! #{7fffffffffffffff}]]
; arithmetic shift of 0
#64bit
[strict-equal? 0 shift 0 to integer! #{8000000000000000}]
#64bit
[strict-equal? 0 shift 0 to integer! #{8000000000000001}]
[strict-equal? 0 shift 0 -65]
[strict-equal? 0 shift 0 -64]
[strict-equal? 0 shift 0 -63]
[strict-equal? 0 shift 0 -62]
[strict-equal? 0 shift 0 -1]
[strict-equal? 0 shift 0 0]
[strict-equal? 0 shift 0 1]
[strict-equal? 0 shift 0 62]
[strict-equal? 0 shift 0 63]
[strict-equal? 0 shift 0 64]
[strict-equal? 0 shift 0 65]
#64bit
[strict-equal? 0 shift 0 to integer! #{7ffffffffffffffe}]
#64bit
[strict-equal? 0 shift 0 to integer! #{7fffffffffffffff}]
; arithmetic shift of 1
#64bit
[strict-equal? 0 shift 1 to integer! #{8000000000000000}]
#64bit
[strict-equal? 0 shift 1 to integer! #{8000000000000001}]
#r3only
[strict-equal? 0 shift 1 -65]
#r3only
[strict-equal? 0 shift 1 -64]
#r3only
[strict-equal? 0 shift 1 -63]
#r3only
[strict-equal? 0 shift 1 -62]
#r3only
[strict-equal? 0 shift 1 -1]
[strict-equal? 1 shift 1 0]
[strict-equal? 2 shift 1 1]
#64bit
[strict-equal? to integer! #{4000000000000000} shift 1 62]
[error? try [shift 1 63]]
[error? try [shift 1 64]]
[error? try [shift 1 65]]
#64bit
[error? try [shift 1 to integer! #{7ffffffffffffffe}]]
#64bit
[error? try [shift 1 to integer! #{7fffffffffffffff}]]
; arithmetic shift of to integer! #{7ffffffffffffffe}
#64bit
[strict-equal? 0 shift to integer! #{7ffffffffffffffe} to integer! #{8000000000000000}]
#64bit
[strict-equal? 0 shift to integer! #{7ffffffffffffffe} to integer! #{8000000000000001}]
#64bit
[strict-equal? 0 shift to integer! #{7ffffffffffffffe} -65]
#64bit
[strict-equal? 0 shift to integer! #{7ffffffffffffffe} -64]
#64bit
[strict-equal? 0 shift to integer! #{7ffffffffffffffe} -63]
#64bit
[strict-equal? 1 shift to integer! #{7ffffffffffffffe} -62]
#64bit
[strict-equal? to integer! #{3fffffffffffffff} shift to integer! #{7ffffffffffffffe} -1]
#64bit
[strict-equal? to integer! #{7ffffffffffffffe} shift to integer! #{7ffffffffffffffe} 0]
#64bit
[error? try [shift to integer! #{7ffffffffffffffe} 1]]
#64bit
[error? try [shift to integer! #{7ffffffffffffffe} 62]]
#64bit
[error? try [shift to integer! #{7ffffffffffffffe} 63]]
#64bit
[error? try [shift to integer! #{7ffffffffffffffe} 64]]
#64bit
[error? try [shift to integer! #{7ffffffffffffffe} 65]]
#64bit
[error? try [shift to integer! #{7ffffffffffffffe} to integer! #{7ffffffffffffffe}]]
#64bit
[error? try [shift to integer! #{7ffffffffffffffe} to integer! #{7fffffffffffffff}]]
; arithmetic shift of to integer! #{7fffffffffffffff}
#64bit
[strict-equal? 0 shift to integer! #{7fffffffffffffff} to integer! #{8000000000000000}]
#64bit
[strict-equal? 0 shift to integer! #{7fffffffffffffff} to integer! #{8000000000000001}]
#64bit
[strict-equal? 0 shift to integer! #{7fffffffffffffff} -65]
#64bit
[strict-equal? 0 shift to integer! #{7fffffffffffffff} -64]
#64bit
[strict-equal? 0 shift to integer! #{7fffffffffffffff} -63]
#64bit
[strict-equal? 1 shift to integer! #{7fffffffffffffff} -62]
#64bit
[strict-equal? to integer! #{3fffffffffffffff} shift to integer! #{7fffffffffffffff} -1]
#64bit
[strict-equal? to integer! #{7fffffffffffffff} shift to integer! #{7fffffffffffffff} 0]
#64bit
[error? try [shift to integer! #{7fffffffffffffff} 1]]
#64bit
[error? try [shift to integer! #{7fffffffffffffff} 62]]
#64bit
[error? try [shift to integer! #{7fffffffffffffff} 63]]
#64bit
[error? try [shift to integer! #{7fffffffffffffff} 64]]
#64bit
[error? try [shift to integer! #{7fffffffffffffff} 65]]
#64bit
[error? try [shift to integer! #{7fffffffffffffff} to integer! #{7ffffffffffffffe}]]
#64bit
[error? try [shift to integer! #{7fffffffffffffff} to integer! #{7fffffffffffffff}]]
; functions/math/signq.r
[0 = sign? 0]
[1 = sign? 1]
[-1 = sign? -1]
[1 = sign? 2147483647]
[-1 = sign? -2147483648]
; decimal
[0 = sign? 0.0]
[1 = sign? 4.94065645841247E-324]
[-1 = sign? -4.94065645841247E-324]
[1 = sign? 1.7976931348623157e308]
[-1 = sign? -1.7976931348623157e308]
; money
[0 = sign? $0]
[0 = sign? USD$0]
[1 = sign? $0.000000000000001]
[-1 = sign? -$0.000000000000001]
; time
[0 = sign? 0:00]
[1 = sign? 0:00:0.000000001]
[-1 = sign? -0:00:0.000000001]
; functions/math/sine.r
[0 = sine 0]
[0 = sine/radians 0]
[0.5 = sine 30]
[0.5 = sine/radians pi / 6]
[(square-root 2) / 2 = sine 45]
[(square-root 2) / 2 = sine/radians pi / 4]
[(square-root 3) / 2 = sine 60]
[(square-root 3) / 2 = sine/radians pi / 3]
[1 = sine 90]
[1 = sine/radians pi / 2]
[0 = sine 180]
[0 = sine/radians pi]
[-0.5 = sine -30]
[-0.5 = sine/radians pi / -6]
[(square-root 2) / -2 = sine -45]
[(square-root 2) / -2 = sine/radians pi / -4]
[(square-root 3) / -2 = sine -60]
[(square-root 3) / -2 = sine/radians pi / -3]
[-1 = sine -90]
[-1 = sine/radians pi / -2]
[0 = sine -180]
[0 = sine/radians negate pi]
[(sine 1e-12) / 1e-12 = (pi / 180)]
[(sine/radians 1e-9) / 1e-9 = 1.0]
; #bug#852
; Flint Hills test
[
	n: 25000
	s4: 0.0
	repeat l n [
		k: to decimal! l
		ks: sine/radians k
		s4: 1.0 / (k * k * k * ks * ks) + s4
	]
	30.314520404 = round/to s4 1e-9
]
; functions/math/square-root.r
[0 = square-root 0]
[error? try [square-root -1]]
[1 = square-root 1]
[0.5 = square-root 0.25]
[2 = square-root 4]
[3 = square-root 9]
[1.1 = square-root 1.21]
; functions/math/subtract.r
[1 == subtract 3 2]
; integer -9223372036854775808 - x tests
#64bit
[0 == subtract -9223372036854775808 -9223372036854775808]
#64bit
[-1 == subtract -9223372036854775808 -9223372036854775807]
#64bit
[-9223372036854775807 == subtract -9223372036854775808 -1]
#64bit
[-9223372036854775808 == subtract -9223372036854775808 0]
#64bit
[error? try [subtract -9223372036854775808 1]]
#64bit
[error? try [subtract -9223372036854775808 9223372036854775806]]
#64bit
[error? try [subtract -9223372036854775808 9223372036854775807]]
; integer -9223372036854775807 - x tests
#64bit
[1 == subtract -9223372036854775807 -9223372036854775808]
#64bit
[0 == subtract -9223372036854775807 -9223372036854775807]
#64bit
[-9223372036854775806 == subtract -9223372036854775807 -1]
#64bit
[-9223372036854775807 == subtract -9223372036854775807 0]
#64bit
[-9223372036854775808 == subtract -9223372036854775807 1]
#64bit
[error? try [subtract -9223372036854775807 9223372036854775806]]
#64bit
[error? try [subtract -9223372036854775807 9223372036854775807]]
; integer -2147483648 - x tests
[0 == subtract -2147483648 -2147483648]
[-2147483647 == subtract -2147483648 -1]
[-2147483648 == subtract -2147483648 0]
#32bit
[error? try [subtract -2147483648 1]]
#64bit
[-2147483649 == subtract -2147483648 1]
#32bit
[error? try [subtract -2147483648 2147483647]]
#64bit
[-4294967295 == subtract -2147483648 2147483647]
; integer -1 - x tests
#64bit
[9223372036854775807 == subtract -1 -9223372036854775808]
#64bit
[9223372036854775806 == subtract -1 -9223372036854775807]
[2147483647 == subtract -1 -2147483648]
[0 == subtract -1 -1]
[-1 == subtract -1 0]
[-2 == subtract -1 1]
[-2147483648 == subtract -1 2147483647]
#64bit
[-9223372036854775807 == subtract -1 9223372036854775806]
#64bit
[-9223372036854775808 == subtract -1 9223372036854775807]
; integer 0 - x tests
#64bit
[error? try [subtract 0 -9223372036854775808]]
#64bit
[-9223372036854775807 == subtract 0 -9223372036854775807]
#32bit
[error? try [subtract 0 -2147483648]]
#64bit
[2147483648 == subtract 0 -2147483648]
[1 == subtract 0 -1]
[0 == subtract 0 0]
[-1 == subtract 0 1]
[-2147483647 == subtract 0 2147483647]
#64bit
[-9223372036854775806 == subtract 0 9223372036854775806]
#64bit
[-9223372036854775807 == subtract 0 9223372036854775807]
; integer 1 - x tests
#64bit
[error? try [subtract 1 -9223372036854775808]]
#64bit
[error? try [subtract 1 -9223372036854775807]]
#32bit
[error? try [subtract 1 -2147483648]]
#64bit
[2147483649 == subtract 1 -2147483648]
#32bit
[error? try [subtract 1 -2147483647]]
#64bit
[2147483648 == subtract 1 -2147483647]
[2147483647 == subtract 1 -2147483646]
[2 == subtract 1 -1]
[1 == subtract 1 0]
[0 == subtract 1 1]
[-2147483646 == subtract 1 2147483647]
#64bit
[-9223372036854775805 == subtract 1 9223372036854775806]
#64bit
[-9223372036854775806 == subtract 1 9223372036854775807]
; integer 2147483647 - x
#32bit
[error? try [subtract 2147483647 -2147483648]]
#64bit
[4294967295 == subtract 2147483647 -2147483648]
#32bit
[error? try [subtract 2147483647 -1]]
#64bit
[2147483648 == subtract 2147483647 -1]
[2147483647 == subtract 2147483647 0]
[2147483646 == subtract 2147483647 1]
[0 == subtract 2147483647 2147483647]
; integer 9223372036854775806 - x tests
#64bit
[error? try [subtract 9223372036854775806 -9223372036854775808]]
#64bit
[error? try [subtract 9223372036854775806 -9223372036854775807]]
#64bit
[9223372036854775807 == subtract 9223372036854775806 -1]
#64bit
[9223372036854775806 == subtract 9223372036854775806 0]
#64bit
[9223372036854775805 == subtract 9223372036854775806 1]
#64bit
[0 == subtract 9223372036854775806 9223372036854775806]
#64bit
[-1 == subtract 9223372036854775806 9223372036854775807]
; integer 9223372036854775807 - x tests
#64bit
[error? try [subtract 9223372036854775807 -9223372036854775808]]
#64bit
[error? try [subtract  9223372036854775807 -9223372036854775807]]
#64bit
[error? try [subtract 9223372036854775807 -1]]
#64bit
[9223372036854775807 == subtract 9223372036854775807 0]
#64bit
[9223372036854775806 == subtract 9223372036854775807 1]
#64bit
[1 == subtract 9223372036854775807 9223372036854775806]
#64bit
[0 == subtract 9223372036854775807 9223372036854775807]
; decimal - integer
[0.1 == subtract 1.1 1]
[-2147483648.0 == subtract -1.0 2147483647]
[2147483649.0 == subtract 1.0 -2147483648]
; integer - decimal
[-0.1 == subtract 1 1.1]
[2147483648.0 == subtract 2147483647 -1.0]
[-2147483649.0 == subtract -2147483648 1.0]
; -1.7976931348623157e308 - decimal
[0.0 == subtract -1.7976931348623157e308 -1.7976931348623157e308]
[-1.7976931348623157e308 == subtract -1.7976931348623157e308 -1.0]
[-1.7976931348623157e308 == subtract -1.7976931348623157e308 -4.94065645841247E-324]
[-1.7976931348623157e308 == subtract -1.7976931348623157e308 0.0]
[-1.7976931348623157e308 == subtract -1.7976931348623157e308 4.94065645841247E-324]
[-1.7976931348623157e308 == subtract -1.7976931348623157e308 1.0]
[error? try [subtract -1.7976931348623157e308 1.7976931348623157e308]]
; -1.0 - decimal
[1.7976931348623157e308 == subtract -1.0 -1.7976931348623157e308]
[0.0 == subtract -1.0 -1.0]
[-1.0 == subtract -1.0 -4.94065645841247E-324]
[-1.0 == subtract -1.0 0.0]
[-1.0 == subtract -1.0 4.94065645841247E-324]
[-2.0 == subtract -1.0 1.0]
[-1.7976931348623157e308 == subtract -1.0 1.7976931348623157e308]
; -4.94065645841247E-324 - decimal
[1.7976931348623157e308 == subtract -4.94065645841247E-324 -1.7976931348623157e308]
[1.0 == subtract -4.94065645841247E-324 -1.0]
[0.0 == subtract -4.94065645841247E-324 -4.94065645841247E-324]
[-4.94065645841247E-324 == subtract -4.94065645841247E-324 0.0]
[-9.88131291682493E-324 == subtract -4.94065645841247E-324 4.94065645841247E-324]
[-1.0 == subtract -4.94065645841247E-324 1.0]
[-1.7976931348623157e308 == subtract -4.94065645841247E-324 1.7976931348623157e308]
; 0.0 - decimal
[1.7976931348623157e308 == subtract 0.0 -1.7976931348623157e308]
[1.0 == subtract 0.0 -1.0]
[4.94065645841247E-324 == subtract 0.0 -4.94065645841247E-324]
[0.0 == subtract 0.0 0.0]
[-4.94065645841247E-324 == subtract 0.0 4.94065645841247E-324]
[-1.0 == subtract 0.0 1.0]
[-1.7976931348623157e308 == subtract 0.0 1.7976931348623157e308]
; 4.94065645841247E-324 - decimal
[1.7976931348623157e308 == subtract 4.94065645841247E-324 -1.7976931348623157e308]
[1.0 == subtract 4.94065645841247E-324 -1.0]
[9.88131291682493E-324 == subtract 4.94065645841247E-324 -4.94065645841247E-324]
[4.94065645841247E-324 == subtract 4.94065645841247E-324 0.0]
[0.0 == subtract 4.94065645841247E-324 4.94065645841247E-324]
[-1.0 == subtract 4.94065645841247E-324 1.0]
[-1.7976931348623157e308 == subtract 4.94065645841247E-324 1.7976931348623157e308]
; 1.0 - decimal
[1.7976931348623157e308 == subtract 1.0 -1.7976931348623157e308]
[2.0 == subtract 1.0 -1.0]
[1.0 == subtract 1.0 4.94065645841247E-324]
[1.0 == subtract 1.0 0.0]
[1.0 == subtract 1.0 -4.94065645841247E-324]
[0.0 == subtract 1.0 1.0]
[-1.7976931348623157e308 == subtract 1.0 1.7976931348623157e308]
; 1.7976931348623157e308 - decimal
[error? try [subtract 1.7976931348623157e308 -1.7976931348623157e308]]
[1.7976931348623157e308 == subtract 1.7976931348623157e308 -1.0]
[1.7976931348623157e308 == subtract 1.7976931348623157e308 -4.94065645841247E-324]
[1.7976931348623157e308 == subtract 1.7976931348623157e308 0.0]
[1.7976931348623157e308 == subtract 1.7976931348623157e308 4.94065645841247E-324]
[1.7976931348623157e308 == subtract 1.7976931348623157e308 1.0]
[0.0 == subtract 1.7976931348623157e308 1.7976931348623157e308]
; pair
[0x0 == subtract -2147483648x-2147483648 -2147483648x-2147483648]
[-2147483647x-2147483647 == subtract -2147483648x-2147483648 -1x-1]
[-2147483648x-2147483648 == subtract -2147483648x-2147483648 0x0]
#r2only
[2147483647x2147483647 == subtract -2147483648x-2147483648 1x1]
#r2only
[1x1 == subtract -2147483648x-2147483648 2147483647x2147483647]
#r2only
[2147483647x2147483647 == subtract -1x-1 -2147483648x-2147483648]
[0x0 == subtract -1x-1 -1x-1]
[-1x-1 == subtract -1x-1 0x0]
[-2x-2 == subtract -1x-1 1x1]
#r2only
[-2147483648x-2147483648 == subtract -1x-1 2147483647x2147483647]
#r2only
[-2147483648x-2147483648 == subtract 0x0 -2147483648x-2147483648]
#r3only
[2147483648x2147483648 == subtract 0x0 -2147483648x-2147483648]
[1x1 == subtract 0x0 -1x-1]
[0x0 == subtract 0x0 0x0]
[-1x-1 == subtract 0x0 1x1]
[-2147483647x-2147483647 == subtract 0x0 2147483647x2147483647]
#r2only
[-2147483647x-2147483647 == subtract 1x1 -2147483648x-2147483648]
[2x2 == subtract 1x1 -1x-1]
[1x1 == subtract 1x1 0x0]
[0x0 == subtract 1x1 1x1]
#r2only
[-2147483646x-2147483646 == subtract 1x1 2147483647x2147483647]
#r2only
[-1x-1 == subtract 2147483647x2147483647 -2147483648x-2147483648]
#r2only
[-2147483648x-2147483648 == subtract 2147483647x2147483647 -1x-1]
[2147483647x2147483647 == subtract 2147483647x2147483647 0x0]
#r2only
[2147483646x2147483646 == subtract 2147483647x2147483647 1x1]
[0x0 == subtract 2147483647x2147483647 2147483647x2147483647]
; char
#r2only
[#"^(00)" == subtract #"^(00)" #"^(00)"]
#r2only
[#"^(ff)" == subtract #"^(00)" #"^(01)"]
#r2only
[#"^(01)" == subtract #"^(00)" #"^(ff)"]
#r2only
[#"^(01)" == subtract #"^(01)" #"^(00)"]
#r2only
[#"^(00)" == subtract #"^(01)" #"^(01)"]
#r2only
[#"^(02)" == subtract #"^(01)" #"^(ff)"]
#r2only
[#"^(ff)" == subtract #"^(ff)" #"^(00)"]
#r2only
[#"^(fe)" == subtract #"^(ff)" #"^(01)"]
#r2only
[#"^(00)" == subtract #"^(ff)" #"^(ff)"]
; tuple
[0.0.0 == subtract 0.0.0 0.0.0]
[0.0.0 == subtract 0.0.0 0.0.1]
[0.0.0 == subtract 0.0.0 0.0.255]
[0.0.1 == subtract 0.0.1 0.0.0]
[0.0.0 == subtract 0.0.1 0.0.1]
[0.0.0 == subtract 0.0.1 0.0.255]
[0.0.255 == subtract 0.0.255 0.0.0]
[0.0.254 == subtract 0.0.255 0.0.1]
[0.0.0 == subtract 0.0.255 0.0.255]
; functions/math/tangent.r
[error? try [tangent -90]]
[error? try [tangent/radians pi / -2]]
[(negate square-root 3) = tangent -60]
[(negate square-root 3) = tangent/radians pi / -3]
[-1 = tangent -45]
[-1 = tangent/radians pi / -4]
[(square-root 3) / -3 = tangent -30]
[(square-root 3) / -3 = tangent/radians pi / -6]
[0 = tangent 0]
[0 = tangent/radians 0]
[(square-root 3) / 3 = tangent 30]
[(square-root 3) / 3 = tangent/radians pi / 6]
[1 = tangent 45]
[1 = tangent/radians pi / 4]
[(square-root 3) = tangent 60]
[(square-root 3) = tangent/radians pi / 3]
[error? try [tangent 90]]
[error? try [tangent/radians pi / 2]]
; Flint Hills test
[
	n: 25000
	s4t: 0.0
	repeat l n [
		k: to decimal! l
		kt: tangent/radians k
		s4t: 1.0 / (kt * kt) + 1.0 / (k * k * k) + s4t
	]
	30.314520404 = round/to s4t 1e-9
]
; functions/math/zeroq.r
[zero? 0]
[not zero? 1]
[not zero? -1]
[not zero? 2147483647]
[not zero? -2147483648]
#64bit
[not zero? 9223372036854775807]
#64bit
[not zero? -9223372036854775808]
; decimal
[zero? 0.0]
[not zero? 1.7976931348623157e308]
[not zero? -1.7976931348623157e308]
; pair
[zero? 0x0]
[not zero? 1x0]
[not zero? -1x0]
[not zero? 2147483647x0]
[not zero? -2147483648x0]
[not zero? 0x1]
[not zero? 0x-1]
[not zero? 0x2147483647]
[not zero? 0x-2147483648]
; char
[zero? #"^@"]
[not zero? #"^a"]
[not zero? #"^(ff)"]
; money
[zero? $0]
[not zero? $0.01]
[not zero? -$0.01]
[not zero? $999999999999999.87]
[not zero? -$999999999999999.87]
[zero? negate $0]
; time
[zero? 0:00]
[not zero? 0:00:0.000000001]
[not zero? -0:00:0.000000001]
; tuple
[zero? 0.0.0]
[not zero? 1.0.0]
[not zero? 255.0.0]
[not zero? 0.1.0]
[not zero? 0.255.0]
[not zero? 0.0.1]
[not zero? 0.0.255]
; functions/reflectors/body-of.r
; bug#49
[
	f: func [] []
	not same? body-of :f body-of :f
]
; functions/secure/protect.r
; bug#1748
; block
[
	value: copy original: [1 + 2 + 3]
	protect value
	all [
		error? try [insert value 4]
		equal? value original
	]
]
[
	value: copy original: [1 + 2 + 3]
	protect value
	all [
		error? try [append value 4]
		equal? value original
	]
]
[
	value: copy original: [1 + 2 + 3]
	protect value
	all [
		error? try [change value 4]
		equal? value original
	]
]
#r3only
[
	value: copy original: [1 + 2 + 3]
	protect value
	all [
		error? try [reduce/into [4 + 5] value]
		equal? value original
	]
]
#r3only
[
	value: copy original: [1 + 2 + 3]
	protect value
	all [
		error? try [compose/into [(4 + 5)] value]
		equal? value original
	]
]
[
	value: copy original: [1 + 2 + 3]
	protect value
	all [
		error? try [poke value 1 4]
		equal? value original
	]
]
[
	value: copy original: [1 + 2 + 3]
	protect value
	all [
		error? try [remove/part value 1]
		equal? value original
	]
]
[
	value: copy original: [1 + 2 + 3]
	protect value
	all [
		error? try [take value]
		equal? value original
	]
]
[
	value: copy original: [1 + 2 + 3]
	protect value
	all [
		error? try [reverse value]
		equal? value original
	]
]
[
	value: copy original: [1 + 2 + 3]
	protect value
	all [
		error? try [clear value]
		equal? value original
	]
]
; string
#r3only
[
	value: copy original: {1 + 2 + 3}
	protect value
	all [
		error? try [insert value 4]
		equal? value original
	]
]
#r3only
[
	value: copy original: {1 + 2 + 3}
	protect value
	all [
		error? try [append value 4]
		equal? value original
	]
]
#r3only
[
	value: copy original: {1 + 2 + 3}
	protect value
	all [
		error? try [change value 4]
		equal? value original
	]
]
#r3only
[
	value: copy original: {1 + 2 + 3}
	protect value
	all [
		error? try [poke value 1 4]
		equal? value original
	]
]
#r3only
[
	value: copy original: {1 + 2 + 3}
	protect value
	all [
		error? try [remove/part value 1]
		equal? value original
	]
]
#r3only
[
	value: copy original: {1 + 2 + 3}
	protect value
	all [
		error? try [take value]
		equal? value original
	]
]
#r3only
[
	value: copy original: {1 + 2 + 3}
	protect value
	all [
		error? try [reverse value]
		equal? value original
	]
]
#r3only
[
	value: copy original: {1 + 2 + 3}
	protect value
	all [
		error? try [clear value]
		equal? value original
	]
]
; bug#1764
#r3only
[unset 'blk protect/deep 'blk]
; functions/secure/unprotect.r
; bug#1748
; block
[
	value: copy original: [1 + 2 + 3]
	protect value
	unprotect value
	not error? try [insert value 4]
]
[
	value: copy original: [1 + 2 + 3]
	protect value
	unprotect value
	not error? try [append value 4]
]
[
	value: copy original: [1 + 2 + 3]
	protect value
	unprotect value
	not error? try [change value 4]
]
#r3only
[
	value: copy original: [1 + 2 + 3]
	protect value
	unprotect value
	not error? try [reduce/into [4 + 5] value]
]
#r3only
[
	value: copy original: [1 + 2 + 3]
	protect value
	unprotect value
	not error? try [compose/into [(4 + 5)] value]
]
[
	value: copy original: [1 + 2 + 3]
	protect value
	unprotect value
	not error? try [poke value 1 4]
]
[
	value: copy original: [1 + 2 + 3]
	protect value
	unprotect value
	not error? try [remove/part value 1]
]
[
	value: copy original: [1 + 2 + 3]
	protect value
	unprotect value
	not error? try [take value]
]
[
	value: copy original: [1 + 2 + 3]
	protect value
	unprotect value
	not error? try [reverse value]
]
[
	value: copy original: [1 + 2 + 3]
	protect value
	unprotect value
	not error? try [clear value]
]
; string
#r3only
[
	value: copy original: {1 + 2 + 3}
	protect value
	unprotect value
	not error? try [insert value 4]
]
#r3only
[
	value: copy original: {1 + 2 + 3}
	protect value
	unprotect value
	not error? try [append value 4]
]
#r3only
[
	value: copy original: {1 + 2 + 3}
	protect value
	unprotect value
	not error? try [change value 4]
]
#r3only
[
	value: copy original: {1 + 2 + 3}
	protect value
	unprotect value
	not error? try [poke value 1 4]
]
#r3only
[
	value: copy original: {1 + 2 + 3}
	protect value
	unprotect value
	not error? try [remove/part value 1]
]
#r3only
[
	value: copy original: {1 + 2 + 3}
	protect value
	unprotect value
	not error? try [take value]
]
#r3only
[
	value: copy original: {1 + 2 + 3}
	protect value
	unprotect value
	not error? try [reverse value]
]
#r3only
[
	value: copy original: {1 + 2 + 3}
	protect value
	unprotect value
	not error? try [clear value]
]
; functions/series/append.r
; bug#75
#r3only
[
	o: make object! [a: 1]
	p: make o []
	append p [b 2]
	not in o 'b
]
; bug#1894
[
	port: open/new %pokus.txt
	append port newline
	true
]
; tidy up the previous test
[
	if exists? %pokus.txt [delete %pokus.txt]
	true
]
[block? append copy [] ()]
; functions/series/at.r
[
	blk: []
	same? blk at blk 1
]
[
	blk: []
	same? blk at blk 2147483647
]
[
	blk: []
	same? blk at blk 0
]
[
	blk: []
	same? blk at blk -1
]
[
	blk: []
	same? blk at blk -2147483648
]
[
	blk: tail [1 2 3]
	same? blk at blk 1
]
[
	blk: tail [1 2 3]
	same? blk at blk 0
]
[
	blk: tail [1 2 3]
	equal? [3] at blk -1
]
[
	blk: tail [1 2]
	same? blk at blk 2147483647
]
[
	blk: [1 2]
	same? blk at blk -2147483647
]
[
	blk: [1 2]
	same? blk at blk -2147483648
]
; string
[
	str: ""
	same? str at str 1
]
[
	str: ""
	same? str at str 2147483647
]
[
	str: ""
	same? str at str 0
]
[
	str: ""
	same? str at str -1
]
[
	str: ""
	same? str at str -2147483648
]
[
	str: tail "123"
	same? str at str 1
]
[
	str: tail "123"
	same? str at str 0
]
[
	str: tail "123"
	equal? "3" at str -1
]
[
	str: tail "12"
	same? str at str 2147483647
]
[
	str: "12"
	same? str at str -2147483647
]
[
	str: "12"
	same? str at str -2147483648
]
; functions/series/back.r
[
	a: [1]
	same? a back a
]
[
	a: tail [1]
	same? head a back a
]
; path
[
	a: 'b/c
	same? a back a
]
[
	a: tail 'b/c
	same? head a back back a
]
; string
[
	a: tail "1"
	same? head a back a
]
[
	a: "1"
	same? a back a
]
; functions/series/change.r
[
	blk1: at copy [1 2 3 4 5] 3
	blk2: at copy [1 2 3 4 5] 3
	change/part blk1 6 -2147483647
	change/part blk2 6 -2147483648
	equal? head blk1 head blk2
]
; bug#9
[equal? "tr" change/part "str" "" 1]
; functions/series/clear.r
[[] = clear []]
[[] = clear copy [1]]
[
	block: at copy [1 2 3 4] 3
	clear block
	[1 2] == head clear block
]
; none
[none == clear none]
; functions/series/copy.r
[
	blk: []
	all [
		blk = copy blk
		not same? blk copy blk
	]
]
[
	blk: [1]
	all [
		blk = copy blk
		not same? blk copy blk
	]
]
[[1] = copy/part tail [1] -1]
[[1] = copy/part tail [1] -2147483647]
; bug#853
; bug#1118
[[1] = copy/part tail [1] -2147483648]
#64bit
[[1] = copy/part tail [1] -9223372036854775808]
[[] = copy/part [] 0]
[[] = copy/part [] 1]
[[] = copy/part [] 2147483647]
#64bit
[[] = copy/part [] 9223372036854775807]
[error? try [copy none]]
; bug#877
[
	a: copy []
	insert/only a a
	error? try [copy/deep a]
	true
]
; bug#2043
[
	f: func [] []
	error? try [copy :f]
	true
]
; functions/series/deline.r
[
	equal?
		"^/"
		deline case [
			system/version/4 = 3  "^M^/" ; CR LF on Windows
			true                  "^/"   ; LF elsewhere
		]
]
; bug#648
[["a"] = deline/lines "a"]
; bug#1794
[1 = length? deline/lines "Slovenščina"]
; functions/series/difference.r
; bug#799
#r3only
[equal? make typeset! [decimal!] difference make typeset! [decimal! integer!] make typeset! [integer!]]
; functions/series/emptyq.r
[empty? []]
[
	blk: tail [1]
	clear head blk
	empty? blk
]
#r3only
[empty? none]
; functions/series/enline.r
; bug#2191
[
	equal?
		enline "^/"
		case [
			system/version/4 = 3  "^M^/" ; CR LF on Windows
			true                  "^/"   ; LF elsewhere
		]
]
; bug#190
[x: copy "xx^/" loop 20 [enline x: join x x] true]
; bug#647
[string? enline ["a" "b"]]
; functions/series/exclude.r
[empty? exclude [1 2] [2 1]]
; bug#799
#r3only
[equal? make typeset! [decimal!] exclude make typeset! [decimal! integer!] make typeset! [integer!]]
; functions/series/find.r
#r2only
[error? try [find none 1]]
#r3only
[none? find none 1]
[none? find [] 1]
[
	blk: [1]
	same? blk find blk 1
]
; bug#66
[none? find/skip [1 2 3 4 5 6] 2 3]
; bug#88
["c" = find "abc" charset ["c"]]
; bug#88
[none? find/part "ab" "b" 1]
; functions/series/indexq.r
[1 == index? []]
[2 == index? next [a]]
; past-tail index
[
	a: tail copy [1]
	remove head a
	2 == index? a
]
; bug#1611: Allow INDEX? to take none as an argument, return none
#r3only
[none? index? none]
; functions/series/insert.r
[
	a: make block! 0
	insert a 0
	a == [0]
]
[
	a: [0]
	b: make block! 0
	insert b first a
	a == b
]
[
	a: [0]
	b: make block! 0
	insert b a
	a == b
]
; paren
[
	a: make paren! 0
	insert a 0
	a == first [(0)]
]
[
	a: first [(0)]
	b: make paren! 0
	insert b first a
	a == b
]
[
	a: first [(0)]
	b: make paren! 0
	insert b a
	a == b
]
; path
[
	a: make path! 0
	insert a 0
	a == to path! [0]
]
[
	a: to path! [0]
	b: make path! 0
	insert b first a
	a == b
]
[
	a: to path! [0]
	b: make path! 0
	insert :b a
	a == b
]
; lit-path
[
	a: make lit-path! 0
	insert :a 0
	:a == to lit-path! [0]
]
[
	a: to lit-path! [0]
	b: make lit-path! 0
	insert :b first :a
	:a == :b
]
[
	a: to lit-path! [0]
	b: make lit-path! 0
	insert :b :a
	:a == :b
]
; set-path
[
	a: make set-path! 0
	insert :a 0
	:a == to set-path! [0]
]
[
	a: to set-path! [0]
	b: make set-path! 0
	insert :b first :a
	:a == :b
]
[
	a: to set-path! [0]
	b: make set-path! 0
	insert :b :a
	:a == :b
]
; string
[
	a: make string! 0
	insert a #"0"
	a == "0"
]
[
	a: "0"
	b: make string! 0
	insert b first a
	a == b
]
[
	a: "0"
	b: make string! 0
	insert b a
	a == b
]
; file
[
	a: make file! 0
	insert a #"0"
	a == %"0"
]
[
	a: %"0"
	b: make file! 0
	insert b first a
	a == b
]
[
	a: %"0"
	b: make file! 0
	insert b a
	a == b
]
; email
[
	a: make email! 0
	insert a #"0"
	a == #[email! "0"]
]
[
	a: #[email! "0"]
	b: make email! 0
	insert b first a
	a == b
]
[
	a: #[email! "0"]
	b: make email! 0
	insert b a
	a == b
]
; url
[
	a: make url! 0
	insert a #"0"
	a == #[url! "0"]
]
[
	a: #[url! "0"]
	b: make url! 0
	insert b first a
	a == b
]
[
	a: #[url! "0"]
	b: make url! 0
	insert b a
	a == b
]
; tag
[
	a: make tag! 0
	insert a #"0"
	a == <0>
]
; bug#854
[
	a: <0>
	b: make tag! 0
	insert b first a
	a == b
]
[
	a: <0>
	b: make tag! 0
	insert b a
	a == b
]
; issue
#r2only
[
	a: make issue! 0
	insert a #"0"
	a == #0
]
#r2only
[
	a: #0
	b: make issue! 0
	insert b first a
	a == b
]
#r2only
[
	a: #0
	b: make issue! 0
	insert b a
	a == b
]
; binary
#r2only
[
	a: make binary! 0
	insert a #"^(00)"
	a == #{00}
]
; bug#855
[
	a: #{00}
	b: make binary! 0
	insert b first a
	a == b
]
[
	a: #{00}
	b: make binary! 0
	insert b a
	a == b
]
; insert/part
[
	a: make block! 0
	b: at [1 2 3 4 5 6 7 8 9] 5
	insert/part a b 1
	a == [5]
]
[
	a: make block! 0
	b: at [1 2 3 4 5 6 7 8 9] 5
	insert/part a b 5
	a == [5 6 7 8 9]
]
[
	a: make block! 0
	b: at [1 2 3 4 5 6 7 8 9] 5
	insert/part a b 6
	a == [5 6 7 8 9]
]
[
	a: make block! 0
	b: at [1 2 3 4 5 6 7 8 9] 5
	insert/part a b 2147483647
	a == [5 6 7 8 9]
]
[
	a: make block! 0
	b: at [1 2 3 4 5 6 7 8 9] 5
	insert/part a b 0
	empty? a
]
[
	a: make block! 0
	b: at [1 2 3 4 5 6 7 8 9] 5
	insert/part a b -1
	a == [4]
]
[
	a: make block! 0
	b: at [1 2 3 4 5 6 7 8 9] 5
	insert/part a b -4
	a == [1 2 3 4]
]
[
	a: make block! 0
	b: at [1 2 3 4 5 6 7 8 9] 5
	insert/part a b -5
	a == [1 2 3 4]
]
[
	a: make block! 0
	b: at [1 2 3 4 5 6 7 8 9] 5
	insert/part a b -2147483648
	a == [1 2 3 4]
]
; insert/only
[
	a: make block! 0
	b: []
	insert/only a b
	same? b first a
]
; insert/dup
[
	a: make block! 0
	insert/dup a 0 2
	a == [0 0]
]
[
	a: make block! 0
	insert/dup a 0 0
	a == []
]
[
	a: make block! 0
	insert/dup a 0 -1
	a == []
]
[
	a: make block! 0
	insert/dup a 0 -2147483648
	a == []
]
[
	a: make block! 0
	insert/dup a 0 -2147483648
	empty? a
]
; functions/series/intersect.r
; bug#799
#r3only
[equal? make typeset! [integer!] intersect make typeset! [decimal! integer!] make typeset! [integer!]]
; functions/series/last.r
; bug#2
[value? try [last #"c"]]
[value? try [last 7]]
; functions/series/lengthq.r
; bug#1626: "Allow LENGTH? to take none as an argument, return none"
; bug#1688: "LENGTH? NONE returns TRUE" (should return NONE)
#r3only
[none? length? none]
; functions/series/next.r
[
	blk: [1]
	same? tail blk next blk
]
[
	blk: tail [1]
	same? blk next blk
]
; functions/series/ordinals.r
#r2only
[error? try [first []]]
#r2only
[error? try [second []]]
#r2only
[error? try [third []]]
#r2only
[error? try [fourth []]]
#r2only
[error? try [fifth []]]
#r2only
[error? try [sixth []]]
#r2only
[error? try [seventh []]]
#r2only
[error? try [eighth []]]
#r2only
[error? try [ninth []]]
#r2only
[error? try [tenth []]]
#r3only
[none? first []]
#r3only
[none? second []]
#r3only
[none? third []]
#r3only
[none? fourth []]
#r3only
[none? fifth []]
#r3only
[none? sixth []]
#r3only
[none? seventh []]
#r3only
[none? eighth []]
#r3only
[none? ninth []]
#r3only
[none? tenth []]
[1 = first [1 2 3 4 5 6 7 8 9 10 11]]
[2 = second [1 2 3 4 5 6 7 8 9 10 11]]
[3 = third [1 2 3 4 5 6 7 8 9 10 11]]
[4 = fourth [1 2 3 4 5 6 7 8 9 10 11]]
[5 = fifth [1 2 3 4 5 6 7 8 9 10 11]]
[6 = sixth [1 2 3 4 5 6 7 8 9 10 11]]
[7 = seventh [1 2 3 4 5 6 7 8 9 10 11]]
[8 = eighth [1 2 3 4 5 6 7 8 9 10 11]]
[9 = ninth [1 2 3 4 5 6 7 8 9 10 11]]
[10 = tenth [1 2 3 4 5 6 7 8 9 10 11]]
; functions/series/parse.r
; SET-WORD! (store current input position)
[res: parse ser: [x y] [pos: skip skip] all [res pos = ser]]
[res: parse ser: [x y] [skip pos: skip] all [res pos = next ser]]
[res: parse ser: [x y] [skip skip pos: end] all [res pos = tail ser]]
; bug#2130
[res: parse ser: [x] [set val pos: word!] all [res val = 'x pos = ser]]
; bug#2130
#r3only
[res: parse ser: [x] [set val: pos: word!] all [res val = 'x pos = ser]]
; bug#2130
[res: parse ser: "foo" [copy val pos: skip] all [not res val = "f" pos = ser]]
; bug#2130
#r3only
[res: parse ser: "foo" [copy val: pos: skip] all [not res val = "f" pos = ser]]
; TO/THRU integer!
[parse "abcd" [to 3 "cd"]]
[parse "abcd" [to 5]]
[parse "abcd" [to 128]]
; bug#1965
[parse "abcd" [thru 3 "d"]]
[parse "abcd" [thru 4]]
[parse "abcd" [thru 128]]
[parse "abcd" ["ab" to 1 "abcd"]]
[parse "abcd" ["ab" thru 1 "bcd"]]
; THRU rule
; bug#682: parse thru tag!
[
	t: none
	parse "<tag>text</tag>" [thru <tag> copy t to </tag>]
	t == "text"
]
; THRU advances the input position correctly.
[
	i: 0
	parse "a." [any [thru "a" (i: i + 1 j: if i > 1 [[end skip]]) j]]
	i == 1
]
; bug#1959: THRU fails to to match at end
[parse "abcd" [thru "d"]]
[parse "abcd" [to "d" skip]]
; bug#1959
[parse "<abcd>" [thru <abcd>]]
[parse [a b c d] [thru 'd]]
[parse [a b c d] [to 'd skip]]
; self-invoking rule
; bug#1672
[
	a: [a]
	error? try [parse [] a]
]
; repetition
; bug#1280
[
	parse "" [(i: 0) 3 [["a" |] (i: i + 1)]]
	i == 3
]
; bug#1268
#r3only
[
	i: 0
	parse "a" [any [(i: i + 1)]]
	i == 1
]
#r2only
[
	i: 0
	parse "a" [any [(i: i + 1 j: if i = 2 [[end skip]]) j]]
	i == 2
]
#r3only
[
	i: 0
	parse "a" [while [(i: i + 1 j: if i = 2 [[fail]]) j]]
	i == 2
]
; THEN rule
; bug#1267
#r3only
[
	b: "abc"
	c: ["a" | "b"]
	a2: [any [b e: (d: [:e]) then fail | [c | (d: [fail]) fail]] d]
	a4: [any [b then e: (d: [:e]) fail | [c | (d: [fail]) fail]] d]
	equal? parse "aaaaabc" a2 parse "aaaaabc" a4
]
; NOT rule
; bug#1246
#r3only
[parse "1" [not not "1" "1"]]
#r3only
[parse "1" [not [not "1"] "1"]]
#r3only
[false == parse "" [not 0 "a"]]
#r3only
[false == parse "" [not [0 "a"]]]
; bug#1240
#r3only
[parse "" [not "a"]]
#r3only
[parse "" [not skip]]
#r3only
[parse "" [not fail]]
; empty string rule
; bug#1880
[parse "12" ["" to end]]
; bug#100
[1 == do does [parse [] [(return 1)] 2]]
; bug#1457: TO/THRU + bitset!/charset!
[parse "a" compose [thru (charset "a")]]
[not parse "a" compose [thru (charset "a") skip]]
[parse "ba" compose [to (charset "a") skip]]
[not parse "ba" compose [to (charset "a") "ba"]]
; self-modifying rule
[not parse "abcd" rule: ["ab" (remove back tail rule) "cd"]]
; bug#2214
[not parse "abcd" rule: ["ab" (clear rule) "cd"]]
; functions/series/pick.r
#64bit
[error? try [pick at [1 2 3 4 5] 3 -9223372036854775808]]
[none? pick at [1 2 3 4 5] 3 -2147483648]
[none? pick at [1 2 3 4 5] 3 -2147483647]
[none? pick at [1 2 3 4 5] 3 -3]
#r2only
[1 = pick at [1 2 3 4 5] 3 -2]
#r3only
[none? pick at [1 2 3 4 5] 3 -2]
#r2only
[2 = pick at [1 2 3 4 5] 3 -1]
#r3only
[1 = pick at [1 2 3 4 5] 3 -1]
#r2only
[none? pick at [1 2 3 4 5] 3 0]
#r3only
[2 = pick at [1 2 3 4 5] 3 0]
[3 = pick at [1 2 3 4 5] 3 1]
[4 = pick at [1 2 3 4 5] 3 2]
[5 = pick at [1 2 3 4 5] 3 3]
[none? pick at [1 2 3 4 5] 3 4]
[none? pick at [1 2 3 4 5] 3 2147483647]
#64bit
[error? try [pick at [1 2 3 4 5] 3 9223372036854775807]]
; string
#64bit
[error? try [pick at "12345" 3 -9223372036854775808]]
[none? pick at "12345" 3 -2147483648]
[none? pick at "12345" 3 -2147483647]
[none? pick at "12345" 3 -3]
#r2only
[#"1" = pick at "12345" 3 -2]
#r3only
[none? pick at "12345" 3 -2]
#r2only
[#"2" = pick at "12345" 3 -1]
#r3only
[#"1" = pick at "12345" 3 -1]
#r2only
[none? pick at "12345" 3 0]
; bug#857
#r3only
[#"2" = pick at "12345" 3 0]
[#"3" = pick at "12345" 3 1]
[#"4" = pick at "12345" 3 2]
[#"5" = pick at "12345" 3 3]
[none? pick at "12345" 3 4]
[none? pick at "12345" 3 2147483647]
#64bit
[error? try [pick at "12345" 3 9223372036854775807]]
; functions/series/poke.r
[
	poke a: #{00} 1 pick b: #{11} 1
	a == b
]
; functions/series/remove.r
[[] = remove []]
[[] = head remove [1]]
; none
[none = remove none]
; bitset
[
	a-bitset: charset "a"
	remove/part a-bitset "a"
	none? find a-bitset #"a"
]
[
	a-bitset: charset "a"
	remove/part a-bitset to integer! #"a"
	none? find a-bitset #"a"
]
; functions/series/reverse.r
; bug#1810: REVERSE/part does not work for tuple!
[3.2.1.4.5 = reverse/part 1.2.3.4.5 3]
; functions/series/select.r
; bug#1936: select returns incorrect value with block argument
[4 == select [1 2 3 4 5 6] [1 2 3]]
; functions/series/skip.r
[
	blk: []
	same? blk skip blk 0
]
[
	blk: []
	same? blk skip blk 2147483647
]
[
	blk: []
	same? blk skip blk -1
]
[
	blk: []
	same? blk skip blk -2147483648
]
[
	blk: next [1 2 3]
	same? blk skip blk 0
]
[
	blk: next [1 2 3]
	equal? [3] skip blk 1
]
[
	blk: next [1 2 3]
	same? tail blk skip blk 2
]
[
	blk: next [1 2 3]
	same? tail blk skip blk 2147483647
]
[
	blk: at [1 2 3] 3
	same? tail blk skip blk 2147483646
]
[
	blk: at [1 2 3] 4
	same? tail blk skip blk 2147483645
]
[
	blk: [1 2 3]
	same? head blk skip blk -1
]
[
	blk: [1 2 3]
	same? head blk skip blk -2147483647
]
[
	blk: next [1 2 3]
	same? head blk skip blk -2147483648
]
; functions/series/sort.r
[[1 2 3] = sort [1 3 2]]
[[3 2 1] = sort/reverse [1 3 2]]
; bug#1152: SORT not stable (order not preserved)
[strict-equal? ["A" "a"] sort ["A" "a"]]
; bug#1152: SORT not stable (order not preserved)
[strict-equal? ["A" "a"] sort/reverse ["A" "a"]]
; bug#1152: SORT not stable (order not preserved)
[strict-equal? ["a" "A"] sort ["a" "A"]]
; bug#1152: SORT not stable (order not preserved)
[strict-equal? ["A" "a"] sort/case ["a" "A"]]
; bug#1152: SORT not stable (order not preserved)
[strict-equal? ["A" "a"] sort/case ["A" "a"]]
; bug#1152: SORT not stable (order not preserved)
[
	set [c d] sort reduce [a: "a" b: "a"]
	all [
		same? c a
		same? d b
		not same? c b
		not same? d a
	]
]
; bug#1152: SORT not stable (order not preserved)
[equal? [1 9 1 5 1 7] sort/skip/compare [1 9 1 5 1 7] 2 1]
[[1 2 3] = sort/compare [1 3 2] :<]
[[3 2 1] = sort/compare [1 3 2] :>]
; bug#1516: SORT/compare ignores the typespec of its function argument
[error? try [sort/compare [1 2 #[unset!]] :>]]
; functions/series/split.r
; Tests taken from bug#1886.
#r3
[["1234" "5678" "1234" "5678"] == split "1234567812345678" 4]
#r3
[["123" "456" "781" "234" "567" "8"] == split "1234567812345678" 3]
#r3
[["12345" "67812" "34567" "8"] == split "1234567812345678" 5]
#r3
[[[1 2 3] [4 5 6]] == split/into [1 2 3 4 5 6] 2]
#r3
[["12345678" "12345678"] == split/into "1234567812345678" 2]
#r3
[["12345" "67812" "345678"] == split/into "1234567812345678" 3]
#r3
[["123" "456" "781" "234" "5678"] == split/into "1234567812345678" 5]
; Delimiter longer than series
#r3
[["1" "2" "3" "" "" ""] == split/into "123" 6]
#r3
[[[1] [2] [3] [] [] []] == split/into [1 2 3] 6]
#r3
[[[1 2] [3] [4 5 6]] == split [1 2 3 4 5 6] [2 1 3]]
#r3
[["1234" "5678" "12" "34" "5" "6" "7" "8"] == split "1234567812345678" [4 4 2 2 1 1 1 1]]
#r3
[[(1 2 3) (4 5 6) (7 8 9)] == split first [(1 2 3 4 5 6 7 8 9)] 3]
#r3
[[#{01020304} #{050607} #{08} #{090A}] == split #{0102030405060708090A} [4 3 1 2]]
#r3
[[[1 2] [3]] == split [1 2 3 4 5 6] [2 1]]
#r3
[[[1 2] [3] [4 5 6] []] == split [1 2 3 4 5 6] [2 1 3 5]]
#r3
[[[1 2] [3] [4 5 6]] == split [1 2 3 4 5 6] [2 1 6]]
#r3
[[[1 2] [5 6]] == split [1 2 3 4 5 6] [2 -2 2]]
#r3
[["abc" "de" "fghi" "jk"] == split "abc,de,fghi,jk" #","]
#r3
[["abc" "de" "fghi" "jk"] == split "abc<br>de<br>fghi<br>jk" <br>]
#r3
[["a" "b" "c"] == split "a.b.c" "."]
#r3
[["c" "c"] == split "c c" " "]
#r3
[["1,2,3"] == split "1,2,3" " "]
#r3
[["1" "2" "3"] == split "1,2,3" ","]
#r3
[["1" "2" "3" ""] == split "1,2,3," ","]
#r3
[["1" "2" "3" ""] == split "1,2,3," charset ",."]
#r3
[["1" "2" "3" ""] == split "1.2,3." charset ",."]
#r3
[["-" "-"] == split "-a-a" ["a"]]
#r3
[["-" "-" "'"] == split "-a-a'" ["a"]]
#r3
[["abc" "de" "fghi" "jk"] == split "abc|de/fghi:jk" charset "|/:"]
#r3
[["abc" "de" "fghi" "jk"] == split "abc^M^Jde^Mfghi^Jjk" [crlf | #"^M" | newline]]
#r3
[["abc" "de" "fghi" "jk"] == split "abc     de fghi  jk" [some #" "]]
; functions/series/tailq.r
[tail? []]
[
	blk: tail [1]
	clear head blk
	tail? blk
]
; functions/series/trim.r
; bug#83
; refinement order
[strict-equal? trim/all/with "a" "a" trim/with/all "a" "a"]
; bug#1948
["foo^/" = trim "  foo ^/"]
; functions/series/union.r
; bug#799
#r3only
[equal? make typeset! [decimal! integer!] union make typeset! [decimal!] make typeset! [integer!]]
; functions/string/checksum.r
[#{ACBD18DB4CC2F85CEDEF654FCCC4A4D8} = checksum/method to-binary "foo" 'md5]
[#{FC3FF98E8C6A0D3087D515C0473F8677} = checksum/method to-binary "hello world!" 'md5]
[#{0BEEC7B5EA3F0FDBC95D0DD47F3C5BC275DA8A33} = checksum/method to-binary "foo" 'sha1]
[#{430CE34D020724ED75A196DFC2AD67C77772D169} = checksum/method to-binary "hello world!" 'sha1]
; bug#1678: "Can we add CRC-32 as a checksum method?"
#r3only
[(checksum/method to-binary "foo" 'CRC32) = -1938594527]
; bug#1678
#r3only
[(checksum/method to-binary "" 'CRC32) = 0]
; functions/string/compress.r
; bug#1679
#r3only
[#{1F8B0800EF46BE4C00034BCBCF07002165738C03000000} = compress/gzip "foo"]
; functions/string/decloak.r
; bug#48
[
	a: compress "a"
	b: encloak a "a"
	equal? a decloak b "a"
]
; functions/string/decode.r
#r3
[image? decode 'bmp read %fixtures/rebol-logo.bmp]
#r3
[image? decode 'gif read %fixtures/rebol-logo.gif]
#r3
[image? decode 'jpeg read %fixtures/rebol-logo.jpg]
#r3
[image? decode 'png read %fixtures/rebol-logo.png]
#r3
[
	; The results of decoding lossless encodings should be identical.
	bmp-img: decode 'bmp read %fixtures/rebol-logo.bmp
	gif-img: decode 'gif read %fixtures/rebol-logo.gif
	png-img: decode 'gif read %fixtures/rebol-logo.png
	all [
		bmp-img == gif-img
		bmp-img == png-img
	]
]
#r3
["" == decode 'text #{}]
#r3
["bar" == decode 'text #{626172}]
#r3
[[<b> "hello" </b>] == decode 'markup "<b>hello</b>"]
; functions/string/encode.r
#r3
[out: encode 'bmp decode 'bmp src: read %fixtures/rebol-logo.bmp out == src]
; GIF encoding is not yet implemented
#r3
[out: encode 'gif decode 'gif src: read %fixtures/rebol-logo.gif out == src]
#r3
[out: encode 'png decode 'png src: read %fixtures/rebol-logo.png out == src]
; JPEG encoding is not yet implemented
#r3
[out: encode 'jpeg decode 'jpeg src: read %fixtures/rebol-logo.jpeg out == src]
; functions/string/decompress.r
; bug#1679: "Native GZIP compress/decompress suport"
#r3only
["foo" == to string! decompress/gzip compress/gzip "foo"]
; bug#1679
#r3only
["foo" == to string! decompress/gzip #{1F8B0800EF46BE4C00034BCBCF07002165738C03000000}]
; bug#3
[value? try [decompress #{AAAAAAAAAAAAAAAAAAAA}]]
; functions/string/dehex.r
["a%b" = dehex "a%b"]
["a%~b" = dehex "a%~b"]
["a^@b" = dehex "a%00b"]
["a b" = dehex "a%20b"]
["a%b" = dehex "a%25b"]
["a+b" = dehex "a%2bb"]
["a+b" = dehex "a%2Bb"]
["abc" = dehex "a%62c"]
; bug#1986
["aβc" = dehex "a%ce%b2c"]
; bug#1986
[(to-string #{61CEB262}) = dehex "a%ce%b2c"]
; bug#1986
[#{61CEB262} = to-binary dehex "a%ce%b2c"]
; system/system.r
; bug#76
[date? system/build]
; system/clipboard.r
; empty clipboard
[
	write clipboard:// ""
	c: read clipboard://
	all [string? c empty? c]
]
; ASCII string
[
	write clipboard:// c: "This is a test."
	d: read clipboard://
	strict-equal? c d
]
; Unicode string
[
	write clipboard:// c: "Příliš žluťoučký kůň úpěl ďábelské ódy."
	strict-equal? read clipboard:// c
]
; OPEN
; bug#1968
[
	p: open clipboard://
	append p c: "Clipboard port test"
	strict-equal? c copy p
]
#r3only
[
	p: open clipboard://
	write p c: "Clipboard port test"
	strict-equal? c read p
]
; WRITE shall return a port in R3
#r3only
[equal? read write clipboard:// c: "test" c]
; system/file.r
[#{C3A4C3B6C3BC} == read %fixtures/umlauts-utf8.txt]
#r3only
["äöü" == read/string %fixtures/umlauts-utf8.txt]
#r3only
[["äöü"] == read/lines %fixtures/umlauts-utf8.txt]
[#{EFBBBFC3A4C3B6C3BC} == read %fixtures/umlauts-utf8bom.txt]
#r3only
["äöü" == read/string %fixtures/umlauts-utf8bom.txt]
#r3only
[["äöü"] == read/lines %fixtures/umlauts-utf8bom.txt]
[#{FFFEE400F600FC00} == read %fixtures/umlauts-utf16le.txt]
#r3only
["äöü" == read/string %fixtures/umlauts-utf16le.txt]
#r3only
[["äöü"] == read/lines %fixtures/umlauts-utf16le.txt]
[#{FEFF00E400F600FC} == read %fixtures/umlauts-utf16be.txt]
#r3only
["äöü" == read/string %fixtures/umlauts-utf16be.txt]
#r3only
[["äöü"] == read/lines %fixtures/umlauts-utf16be.txt]
[#{FFFE0000E4000000F6000000FC000000} == read %fixtures/umlauts-utf32le.txt]
; bug#2186
#r3only
["äöü" == read/string %fixtures/umlauts-utf32le.txt]
#r3only
[["äöü"] == read/lines %fixtures/umlauts-utf32le.txt]
[#{0000FEFF000000E4000000F6000000FC} == read %fixtures/umlauts-utf32be.txt]
; bug#2186
#r3only
["äöü" == read/string %fixtures/umlauts-utf32be.txt]
#r3only
[["äöü"] == read/lines %fixtures/umlauts-utf32be.txt]
; bug#1675 (The extra MOLD is to more consistently provoke the crash.)
[files: read %. mold files block? files]
[block? read %./]
; bug#1675
[files: read %fixtures mold files block? files]
[block? read %fixtures/]
; system/gc.r
; bug#1776, bug#2072
[
	a: copy []
	loop 200'000 [a: append/only copy [] a]
	recycle
	true
]

