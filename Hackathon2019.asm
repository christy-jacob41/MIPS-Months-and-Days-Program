# Hackathon Challenge 2019
# Christy Jacob

.data
# creating word memory for user input month, days in the month, and user choice for number or abbreviation
userMonth:			.word	1
days:				.word 	1
outputChoice:			.word 	1
# creating memory for the month prompt
monthPrompt:			.asciiz	"Please enter the month 1 - 12, enter 0 to quit: "
# creating memory for the month message and day message
daysMessagePartOne:		.asciiz	"Number of days in month "
daysMessagePartTwo:		.asciiz	" is: "
# creating memory for a new line
newline:			.asciiz	"\n"
# creating memory for month error message
monthError:			.asciiz	"Month must be between 1 and 12"
# creating memory for the number or abbreviation prompt
numberOrAbbreviationPrompt:	.asciiz	"Press 1 for month number, 2 for month sbbreviation: "
# creating memory for welcome message
welcomeMessage: 		.asciiz	"Welcome to the months and days program."
# creating memory for month abbreviations
JanAbbreviation:		.asciiz	"Jan"
FebAbbreviation:		.asciiz	"Feb"
MarAbbreviation:		.asciiz	"Mar"
AprAbbreviation:		.asciiz	"Apr"
MayAbbreviation:		.asciiz	"May"
JunAbbreviation:		.asciiz	"Jun"
JulAbbreviation:		.asciiz	"Jul"
AugAbbreviation:		.asciiz	"Aug"
SepAbbreviation:		.asciiz	"Sep"
OctAbbreviation:		.asciiz	"Oct"
NovAbbreviation:		.asciiz	"Nov"
DecAbbreviation:		.asciiz	"Dec"

.text

main:
# print out welcome message
	li	$v0, 4
	la 	$a0, welcomeMessage
	syscall
	
	li	$v0, 4
	la	$a0, newline
	syscall
	
askNumberOrAbbreviation:
# prompt for whether they want to print out number or abbreviation for month
	li	$v0, 4
	la	$a0, numberOrAbbreviationPrompt
	syscall
	
	li	$v0, 5
	syscall
	# store what the user selected for number or abbreviation into memory
	sw	$v0, outputChoice
	
	# load output choice into $t4
	lw	$t4, outputChoice
	
# make sure the input is 1 or 2, if not, ask again
	li	$t5, 1
	blt	$t4, $t5, askNumberOrAbbreviation
	
	li	$t5, 2
	bgt	$t4, $t5, askNumberOrAbbreviation
	
	# jump to month number which determines the number of days in a month if the user input 1 or 2
	j 	monthNumber

monthOutOfBounds:
# if month is not 1-12, print error message and ask for month again
	li	$v0, 4
	la	$a0, monthError
	syscall
	
	li	$v0, 4
	la	$a0, newline
	syscall
	
monthNumber:	
# prompt for month and take it in
	li	$v0, 4
	la	$a0, monthPrompt
	syscall
	
	li	$v0, 5
	syscall
	# store the user input month into memory
	sw	$v0, userMonth
	
	# load the user input month into $t1
	lw	$t1, userMonth
	
	# if month is 0, exit
	beq	$t1, $zero, exit
	
	# if month isn't 1-12, print an error message and ask again
	li	$t2, 12
	bgt	$t1, $t2, monthOutOfBounds
	
	li	$t2, 1
	blt	$t1, $t2, monthOutOfBounds
	
	# branch statements to assign days based on the number of the month
	beq	$t1, $t2, daysThirtyOne
	
	li	$t2, 2
	beq	$t1, $t2, daysTwentyEight
	
	li	$t2, 3
	beq	$t1, $t2, daysThirtyOne
	
	li	$t2, 4
	beq	$t1, $t2, daysThirty
	
	li	$t2, 5
	beq	$t1, $t2, daysThirtyOne
	
	li	$t2, 6
	beq	$t1, $t2, daysThirty
	
	li	$t2, 7
	beq	$t1, $t2, daysThirtyOne
	
	li	$t2, 8
	beq	$t1, $t2, daysThirtyOne
	
	li	$t2, 9
	beq	$t1, $t2, daysThirty
	
	li	$t2, 10
	beq	$t1, $t2, daysThirtyOne
	
	li	$t2, 11
	beq	$t1, $t2, daysThirty
	
	li	$t2, 12
	beq	$t1, $t2, daysThirtyOne
daysThirty:
	
	# aasign 30 to days if month is 4, 6, 9, or 11
	li	$t3, 30
	sw	$t3, days
	j	printMonth
	
daysThirtyOne:
	
	# assign 31 to days if month is 1, 3, 5, 7, 8, 10, or 12
	li	$t3, 31
	sw	$t3, days
	j	printMonth
	
daysTwentyEight:
	# assign 28 to days if month is 2
	li	$t3, 28
	sw	$t3, days
	
printMonth:
	# print out "number of days in month "
	li	$v0, 4
	la	$a0, daysMessagePartOne
	syscall
	
	# print out user month abbreviation is the user's choice earlier was 2
	lw	$t4, outputChoice
	li	$t5, 1
	bne	$t4, $t5, printMonthAbbreviation
	
	# print out user month number if the user's choice earlier was 1
	li	$v0, 1
	lw	$a0, userMonth
	syscall
	
	# jump to print days if user's choice was 1 after printing the month number
	j	printDays

printMonthAbbreviation:
	# if user's choice was 2, use branch statements to determine what abbreviation to print out
	li	$t2, 1
	beq	$t1, $t2, printJan
	
	li	$t2, 2
	beq	$t1, $t2, printFeb
	
	li	$t2, 3
	beq	$t1, $t2, printMar
	
	li	$t2, 4
	beq	$t1, $t2, printApr
	
	li	$t2, 5
	beq	$t1, $t2, printMay
	
	li	$t2, 6
	beq	$t1, $t2, printJun
	
	li	$t2, 7
	beq	$t1, $t2, printJul
	
	li	$t2, 8
	beq	$t1, $t2, printAug
	
	li	$t2, 9
	beq	$t1, $t2, printSep
	
	li	$t2, 10
	beq	$t1, $t2, printOct
	
	li	$t2, 11
	beq	$t1, $t2, printNov
	
	# if not any month January to November, it is December
	j	printDec
	
# print out the abbreviation based on the user input and jump to print days
printJan:	
	li	$v0, 4
	la	$a0, JanAbbreviation
	syscall
	
	j	printDays

printFeb:	
	li	$v0, 4
	la	$a0, FebAbbreviation
	syscall
	
	j	printDays
	
printMar:	
	li	$v0, 4
	la	$a0, MarAbbreviation
	syscall
	
	j	printDays
	
printApr:	
	li	$v0, 4
	la	$a0, AprAbbreviation
	syscall
	
	j	printDays
	
printMay:	
	li	$v0, 4
	la	$a0, MayAbbreviation
	syscall
	
	j	printDays

printJun:	
	li	$v0, 4
	la	$a0, JunAbbreviation
	syscall
	
	j	printDays
	
printJul:	
	li	$v0, 4
	la	$a0, JulAbbreviation
	syscall
	
	j	printDays
	
printAug:	
	li	$v0, 4
	la	$a0, AugAbbreviation
	syscall
	
	j	printDays
	
printSep:	
	li	$v0, 4
	la	$a0, SepAbbreviation
	syscall
	
	j	printDays

printOct:	
	li	$v0, 4
	la	$a0, OctAbbreviation
	syscall
	
	j	printDays
	
printNov:	
	li	$v0, 4
	la	$a0, NovAbbreviation
	syscall
	
	j	printDays
	
printDec:	
	li	$v0, 4
	la	$a0, DecAbbreviation
	syscall
	
# print the number of days in the input month and loop
printDays:	
	li	$v0, 4
	la	$a0, daysMessagePartTwo
	syscall
	
	li	$v0, 1
	lw	$a0, days
	syscall
	
	li	$v0, 4
	la	$a0, newline
	syscall
	
	j 	monthNumber
		
# exiting the program
exit:	
	li	$v0, 10
	syscall
