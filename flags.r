; the flag influences only the test immediately following it,
; if not explicitly stated otherwise

#32bit
; the test is meant to be used only when integers are 32bit

#64bit
; the test is meant to be used only when integers are 64bit

#r2only
; the test is not meant to be used with the R3 interpreter

#r3only
; the test is not meant to be used with the R2 interpreter

#r3
; the test can work with R2 if using R2/Forward, or with R3

#r2crash
; the test crashes the R2 interpreter

#r3crash
; the test crashes the R3 interpreter

#test2crash
; the test crashes the test environment when run in the R2 interpreter

#test3crash
; the test crashes the test environment when run in the R3 interpreter
