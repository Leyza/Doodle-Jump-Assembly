#####################################################################
#
# Bitmap Display Configuration:
# - Unit width in pixels: 8
# - Unit height in pixels: 8
# - Display width in pixels: 256
# - Display height in pixels: 512
# - Base Address for Display: 0x10008000 ($gp)
#
# Features:
# 1. Score board
# 2. Game Over/Retry
# 3. Increase jump speed based on score (Max speed at around score 3000)
# 4. Rocket jump and spring jump items
# 5. Jump sound effects based on platform height difference
# 6. Lethal creatures spawn randomly
# 7. Input name at beginning of first playthrough
#
# Usage information:
# 4x4 red blocks are lethal creatures
# 1x1 grey blocks are springs: jump 30 blocks
# 1x1 pink blocks are rockets: jump 100 blocks
# green blocks are platforms
# Scoreboard is on bottom left. Reach 9999 points to win.
# Once start the game, follow the instructions printed in Run I/O to input name.
# On start/won/lost menu, type "s" to play the game again, and "e" to exit the game
#
#####################################################################


.data
intro: .asciiz "Hi. Please input a name. Maximum 5 characters. Type 'space' when done. Name will automatically register when you hit 5 characters. "
welcome: .asciiz "Welcome to Doodle Jump "
tutorial: .asciiz "! Press 's' to play. Press 'e' to exit. Press 'j' to move left. Press 'k' to move right"

displayAddress: .word 0x10009c38
endScreen: .word 0x10008700
scoreBoard: .word 0x10009c84
lastPixel: .word 0x10009ffc
firstPixel: .word 0x10008000
maxDoodlerHeight: .word 0x10008900
doodler: .space 4
previousDoodler: .space 4
enemy: .space 4
previousPlatform: .space 4
platforms: .space 40
totalScore: .space 4
score: .space 16
bullets: .space 4
spring: .space 4
rocket: .space 4
name: .space 40
NUMBERS: .space 40

ONE: .word 0x80, 0x100, 0x180, 0x200, 0x280, 0
TWO: .word 0x80, 0x84, 0x88, 0x108, 0x188, 0x184, 0x180, 0x200, 0x280, 0x284, 0x288, 0
THREE: .word 0x80, 0x84, 0x88, 0x108, 0x188, 0x184, 0x180, 0x208, 0x288, 0x284, 0x280, 0
FOUR: .word 0x80, 0x100, 0x180, 0x184, 0x188, 0x88, 0x108, 0x208, 0x288, 0
FIVE: .word 0x88, 0x84, 0x80, 0x100, 0x180, 0x184, 0x188, 0x208, 0x288, 0x284, 0x280, 0
SIX: .word 0x88, 0x84, 0x80, 0x100, 0x180, 0x200, 0x280, 0x284, 0x288, 0x208, 0x188, 0x184, 0
SEVEN: .word 0x80, 0x84, 0x88, 0x108, 0x188, 0x208, 0x288, 0
EIGHT: .word 0x80, 0x84, 0x88, 0x108, 0x188, 0x184, 0x180, 0x100, 0x200, 0x280, 0x284, 0x288, 0x208, 0
NINE: .word 0x88, 0x84, 0x80, 0x100, 0x180, 0x184, 0x188, 0x108, 0x208, 0x288, 0
ZERO: .word 0x80, 0x84, 0x88, 0x108, 0x188, 0x208, 0x288, 0x284, 0x280, 0x200, 0x180, 0x100, 0

G: .word 0x90, 0x8c, 0x88, 0x84, 0x80, 0x100, 0x180, 0x200, 0x280, 0x284, 0x288, 0x28c, 0x290, 0x210, 0x190, 0x18c, 0x188, 0
A: .word 0x90, 0x8c, 0x88, 0x84, 0x80, 0x100, 0x180, 0x200, 0x280, 0x110, 0x190, 0x210, 0x290, 0x184, 0x188, 0x18c 0
M: .word 0x80, 0x100, 0x180, 0x200, 0x280, 0x084, 0x108, 0x8c, 0x90, 0x110, 0x190, 0x210, 0x290, 0
E: .word 0x8c, 0x88, 0x84, 0x80, 0x100, 0x180, 0x200, 0x280, 0x184, 0x188, 0x18c, 0x284, 0x288, 0x28c, 0
O: .word 0x8c, 0x88, 0x84, 0x100, 0x180, 0x200, 0x284, 0x288, 0x28c, 0x210, 0x190, 0x110, 0
V: .word 0x80, 0x100, 0x184, 0x204, 0x288, 0x20c, 0x18c, 0x110, 0x90, 0
R: .word 0x90, 0x8c, 0x88, 0x84, 0x80, 0x100, 0x180, 0x200, 0x280, 0x110, 0x190, 0x18c, 0x188, 0x184, 0x208, 0x28c, 0x290, 0
Y: .word 0x80, 0x90, 0x104, 0x10c, 0x188, 0x208, 0x288, 0
U: .word 0x80, 0x100, 0x180, 0x200, 0x284, 0x288, 0x28c, 0x210, 0x190, 0x110, 0x90, 0
W: .word 0x80, 0x100, 0x180, 0x200, 0x280, 0x284, 0x208, 0x28c, 0x290, 0x210, 0x190, 0x110, 0x90, 0
I: .word 0x80, 0x84, 0x88, 0x8c, 0x90, 0x108, 0x188, 0x208, 0x280, 0x284, 0x288, 0x28c, 0x290, 0
N: .word 0x80, 0x100, 0x180, 0x200, 0x280, 0x104, 0x188, 0x20c, 0x290, 0x210, 0x190, 0x110, 0x90, 0
D: .word 0x80, 0x100, 0x180, 0x200, 0x280, 0x84, 0x88, 0x10c, 0x18c, 0x20c, 0x288, 0x284, 0
L: .word 0x80, 0x100, 0x180, 0x200, 0x280, 0x284, 0x288, 0x28c, 0
J: .word 0x90, 0x110, 0x190, 0x210, 0x28c, 0x288, 0x284, 0x280, 0x200, 0
P: .word 0x80, 0x100, 0x180, 0x200, 0x280, 0x84, 0x88, 0x8c, 0x10c, 0x18c, 0x188, 0x184, 0
B: .word 0x80, 0x100, 0x180, 0x200, 0x280, 0x84, 0x88, 0x10c, 0x184, 0x188, 0x20c, 0x284, 0x288, 0
C: .word 0x8c, 0x88, 0x84, 0x100, 0x180, 0x200, 0x284, 0x288, 0x28c, 0
F: .word 0x8c, 0x88, 0x84, 0x80, 0x100, 0x180, 0x200, 0x280, 0x184, 0x188, 0
H: .word 0x80, 0x100, 0x180, 0x200, 0x280, 0x184, 0x188, 0x8c, 0x10c, 0x18c, 0x20c, 0x28c, 0
K: .word 0x80, 0x100, 0x180, 0x200, 0x280, 0x8c, 0x108, 0x184, 0x208, 0x28c, 0
Q: .word 0x80, 0x100, 0x180, 0x200, 0x280, 0x84, 0x88, 0x8c, 0x10c, 0x18c, 0x20c, 0x284, 0x288, 0x28c, 0x290, 0
S: .word 0x8c, 0x88, 0x84, 0x80, 0x100, 0x180, 0x184, 0x188, 0x18c, 0x20c, 0x28c, 0x288, 0x284, 0x280, 0
T: .word 0x80, 0x84, 0x88, 0x8c, 0x90, 0x108, 0x188, 0x208, 0x288, 0
X: .word 0x80, 0x90, 0x104, 0x10c, 0x188, 0x204, 0x20c, 0x280, 0x290, 0
Z: .word 0x80, 0x84, 0x88, 0x8c, 0x90, 0x10c, 0x188, 0x204, 0x280, 0x284, 0x288, 0x28c, 0x290, 0


.text

li $s0, 0xff0000 # #s0 stores the red colour code
li $s1, 0x0000ff # $s1 stores the blue colour code
li $s2, 0x00ff00 # $s2 stores the green colour code
li $s3, 0x000000 # $s3 stores the black colour code
li $s4, 0x808080 # $s5 stores grey colour code
li $s5, 0xffb6c1 # $s6 stores pink colour code


INTRO:
	li $t0, 20 #Initialize loop counter
	li $v0, 4 #Prepare to print strings
	la $a0, intro
	syscall
	
NAMEREFRESH:
	beq $t0, 0, NAMEINPUT
	la $t1, name
	add $t0, $t0, -4
	add $t1, $t1, $t0
	sw $zero, 0($t1)
	j NAMEREFRESH
NAMEINPUT:
	beq $t0, 20, WELCOME
	
	lw $t1, 0xffff0000
	bne $t1, 1, NAMEINPUT #Repeat if no input
	lw $t2, 0xffff0004
	beq $t2, 0x20, WELCOME #Click space to finish inputting name
	la $t3, name
	add $t3, $t3, $t0
	sw $t2, 0($t3) #Save letter
	add $t0, $t0, 4
	sw $zero, 0xffff0000 #Reset keyboard input
	sw $zero, 0xffff0004 #Reset keyboard input
	j NAMEINPUT
	
	
WELCOME:
	li $v0, 4 #Prepare to print strings
	la $a0, welcome
	syscall
	li $t0, 0
	PRINTNAME:
		beq $t0, 40, TUTORIAL
		la $t3, name
		add $t3, $t3, $t0
		lw $t2, 0($t3) #Get letter
		add $t0, $t0, 4
		beq $t2, $zero, PRINTNAME
		li $v0, 4 #Prepare to print strings
		add $a0, $zero, $t3
		syscall
		j PRINTNAME
		
		
TUTORIAL:
	li $v0, 4 #Prepare to print strings
	la $a0, tutorial
	syscall
	sw $zero, 0xffff0000 #Reset keyboard input
	sw $zero, 0xffff0004 #Reset keyboard input
	j STARTSCREEN


START:
jal WIPESCREEN

li $v0, 0
li $a0, 0

lw $t0, displayAddress
sw $t0, doodler # Store doodler location in doodler
sw $t0, previousDoodler #Store doodler location in previousDoodler
sw $zero, enemy #Initialize enemy address
sw $zero, spring #Initialize spring address
sw $zero, rocket #Initialize rocket address

add $t1, $t0, 124
sw $t1, platforms # Store platform 1 address
sw $t1, previousPlatform #Store initial platform position

li $t0, 0 #Store 0 in t0
la $t9, platforms #Load platform address stored in platforms
li $t3, 0 #Store 0 in t3

sw $zero, totalScore #Set score to 0


LOADNUMBERS:
	la $t1, NUMBERS #Get NUMBERS address
	la $t2, ZERO #Get ZERO address
	sw $t2, 0($t1) #Store ZERO address in NUMBERS
	la $t2, ONE #Get ONE address
	sw $t2, 4($t1) #Store ONE address in NUMBERS
	la $t2, TWO #Get TWO address
	sw $t2, 8($t1) #Store TWO address in NUMBERS
	la $t2, THREE #Get THREE address
	sw $t2, 12($t1) #Store THREE address in NUMBERS
	la $t2, FOUR #Get FOUR address
	sw $t2, 16($t1) #Store FOUR address in NUMBERS
	la $t2, FIVE #Get FIVE address
	sw $t2, 20($t1) #Store FIVE address in NUMBERS
	la $t2, SIX #Get SIX address
	sw $t2, 24($t1) #Store SIX address in NUMBERS
	la $t2, SEVEN #Get SEVEN address
	sw $t2, 28($t1) #Store SEVEN address in NUMBERS
	la $t2, EIGHT #Get EIGHT address
	sw $t2, 32($t1) #Store EIGHT address in NUMBERS
	la $t2, NINE #Get NINE address
	sw $t2, 36($t1) #Store NINE address in NUMBERS
	

INITIALIZEPLATFORMS: #Create intial platform addresses
	beq $t0, 9, MAIN
	li $v0, 42 #Create randomized number 0-27
	li $a0, 0
	li $a1, 27
	syscall
	add $t2, $a0, $zero #Store first random number in t2
	sll $t2, $t2, 2 #Shift random number left by 2

	li $v0, 42 #Create randomized number 0-4
	li $a0, 0
	li $a1, 4
	syscall
	add $t3, $a0, $t3 #Sum second random number with previous random numbers in t3
	add $t3, $t3, 4 #Add 4 to second random number
	li $t4, 128 #Store 128 in t4
	mult $t4, $t3 #Multiply second random number by 128
	mflo $t5 #Store product in t5
	lw $t7, firstPixel
	add $t5, $t5, $t7

	add $t6, $t2, $t5 #Add first random number to second random number and store in t6
	addi $t9, $t9, 4 #Increment platforms memory address by 4

	sw $t6, 0($t9) #Store platform address to platforms
	addi $t0, $t0, 1 #Increment loop counter
	j INITIALIZEPLATFORMS


MAIN: #Main program
	lw $t5, totalScore #Get score
	bge $t5, 9999, WIN #Win game if score over 9999
	
	li $t9, 15 #Load jump up loop counter
	j JUMPUP
	j MAIN
	
	
	
KEYBOARDINPUT: #Check keyboard input
	lw $t1, 0xffff0000
	bne $t1, 1, LINK
	
	lw $t2, 0xffff0004
	beq $t2, 0x6A, JUMPLEFT
	beq $t2, 0x6B, JUMPRIGHT
	jr $ra
	
	
JUMPLEFT: #Move doodler address left
	la $t1, doodler #Load doodler memory address
	lw $t0, doodler #Load doodler address
	add $t0, $t0, -4 #Move doodler left
	sw $t0, 0($t1) #Store new doodler address
	jr $ra


JUMPRIGHT: #Move doodler address right
	la $t1, doodler #Load doodler memory address
	lw $t0, doodler #Load doodler address
	add $t0, $t0, 4 #Move doodler right
	sw $t0, 0($t1) #Store new doodler address
	jr $ra


JUMPUP: #Move doodler address up
	jal KEYBOARDINPUT
		
	lw $t1, totalScore #Get total score
	li $t2, 100
	div $a0, $t1, 50
	bgt $a0, 60, CAPSPEEDUP
	j JUMPPAUSEUP
	CAPSPEEDUP:
		li $a0, 60
	JUMPPAUSEUP:
		sub $a0, $t2, $a0 #Get pause duration based on score
		li $v0, 32 # A pause
		syscall

	beq $t9, 0, JUMPDOWN #Jump down after jumping up

	lw $t0, previousDoodler #Load previousDoodler address
	sw $s3, 0($t0) #Erase previousDoodler
	sw $s3, 4($t0)
	sw $s3, 8($t0)
	sw $s3, -124($t0)

	la $t1, doodler #Load doodler memory address
	lw $t0, doodler #Load doodler address
	add $t0, $t0, -128 #Move doodler up
	sw $t0, 0($t1) #Store new doodler address

	addi $t9, $t9, -1 #Increment loop count

	jal CHECKCOLLISIONENEMY
	jal SHIFTFRAME
	j JUMPUP



JUMPDOWN: #Move doodler address down
	jal KEYBOARDINPUT
	
	lw $t1, totalScore #Get total score
	li $t2, 100
	div $a0, $t1, 50
	bgt $a0, 60, CAPSPEEDDOWN
	j JUMPPAUSEDOWN
	CAPSPEEDDOWN:
		li $a0, 60
	JUMPPAUSEDOWN:
		sub $a0, $t2, $a0 #Get pause duration based on score
		li $v0, 32 # A pause
		syscall
	
	lw $t0, previousDoodler #Load previousDoodler address
	sw $s3, 0($t0) #Erase previousDoodler
	sw $s3, 4($t0)
	sw $s3, 8($t0)
	sw $s3, -124($t0)
	
	la $t1, doodler #Load doodler memory address
	lw $t0, doodler #Load doodler address
	add $t0, $t0, 128 #Move doodler down
	sw $t0, 0($t1) #Store new doodler address
	
	lw $t6, lastPixel #Load last pixel address
	bgt $t0, $t6, GAMEOVER #Game over if doodler falls out of screen
	
	li $t1, 0 #Initialize loop counter to 0
	la $t8, platforms + -4 #Load platforms memory address
	jal CHECKCOLLISIONENEMY
	li $t1, 0 #Initialize loop counter to 0
	la $t8, platforms #Load platforms memory address
	jal DRAWFRAME
	j JUMPDOWN
	
	
SPRINGJUMP:
	li $v0, 31 #Prepare play spring sound
	li $a0, 70 #pitch
	li $a1, 1000 #duration
	li $a2, 23 #instrument
	li $a3, 40 #volume
	syscall
	
	li, $t9, 30 #Load loop counter
	j JUMPUP
	
	
ROCKETJUMP:
	li $v0, 31 #Prepare play jump sound
	li $a0, 50 #pitch
	li $a1, 5000 #duration
	li $a2, 20 #instrument
	li $a3, 40 #volume
	syscall
	
	li $v0, 31 #Prepare play jump sound
	li $a0, 57 #pitch
	li $a1, 5000 #duration
	li $a2, 20 #instrument
	li $a3, 40 #volume
	syscall
	
	li $v0, 31 #Prepare play jump sound
	li $a0, 66 #pitch
	li $a1, 5000 #duration
	li $a2, 20 #instrument
	li $a3, 40 #volume
	syscall
	
	li, $t9, 100 #Load loop counter
	j JUMPUP


SHIFTFRAME: #Check if map needs to be shifted down
	li $t1, 0 #Initialize loop counter to 0
	la $t8, platforms #Load platforms memory address
	
	lw $t4, doodler #Load doodler address
	la $t2, doodler #Load doodler memory address
	lw $t3, maxDoodlerHeight #Load maximum doodler location
	bgt $t4, $t3, DRAWFRAME #Draw frame if under max height
	add $t4, $t4, 128 #Move doodler down
	sw $t4, 0($t2) #Store new doodler address
	
	lw $t5, previousPlatform #Load previous platform location
	addi $t5, $t5, 128 #Move previous platform location down
	sw $t5, previousPlatform #Save new previous platform location
	
	li $t1, 10 #Initialize loop counter to 10
	la $t8, platforms + 40 #Load platforms memory address
	j SHIFTENEMY
	
	
SHIFTENEMY:
	lw $t3, enemy
	beq $t3, 0, GENERATEENEMY
	
	sw $s3, 0($t3) #Erase previous enemy
	sw $s3, 4($t3)
	sw $s3, 128($t3)
	sw $s3, 132($t3)
	
	addi $t3, $t3, 128 #Move enemy down
	
	lw $t4, lastPixel
	bgt $t3, $t4, GENERATEENEMY #If enemy exists screen, call generateenemy
	
	sw $s0, 0($t3) #Draw enemy
	sw $s0, 4($t3)
	sw $s0, 128($t3)
	sw $s0, 132($t3)
	sw $t3, enemy #Store new enemy address
	
	j SHIFTPLATFORMS


SHIFTPLATFORMS: #Shift platforms down
	add $t1, $t1, -1 #increment loop counter
	addi $t8, $t8, -4 #increment platforms memory address
	
	lw $t7, 0($t8) #Load platform address
	sw $s3, 0($t7) #Erase platform
	sw $s3, 4($t7)
	sw $s3, 8($t7)
	sw $s3, 12($t7)
	sw $s3, 16($t7)
	sw $s3, -128($t7) #Erase potential spring/rocket
	add $t7, $t7, 128 #Move platform down
	sw $t7, 0($t8) #Save new platform address
	
	lw $t6, lastPixel #Load address of last pixel
	bgt $t7, $t6, GENERATEPLATFORMS
	beq $t1, 0, DRAWFRAME
	j SHIFTPLATFORMS


DRAWFRAME: #Draw doodler and platforms
	beq $t1, 10, CONVERTSCORE #Go to draw score cycle after finish drawing frame
	lw $t0, doodler #Load doodler address
	sw $s1, 0($t0) #Draw doodler
	sw $s1, 4($t0)
	sw $s1, 8($t0)
	sw $s1, -124($t0)
	sw $t0, previousDoodler #Save current doodler address to previousDoodler

	lw $t7, 0($t8) #Load platform address
	sw $s2, 0($t7) #Draw platform
	sw $s2, 4($t7)
	sw $s2, 8($t7)
	sw $s2, 12($t7)
	sw $s2, 16($t7)

	add $t1, $t1, 1 #increment loop counter
	addi $t8, $t8, 4 #increment platforms memory address
	
	lw $t0, enemy #Load enemy address
	beq $t0, 0, DRAWROCKET #If there is no enemy, move on.
	sw $s0, 0($t0) #Draw enemy
	sw $s0, 4($t0)
	sw $s0, 128($t0)
	sw $s0, 132($t0)
	
	DRAWROCKET:
	lw $t0, rocket #Load rocket's platform address
	beq $t0, 0, DRAWSPRING #If there is no rocket, move on
	lw $t2, 0($t0) #Load platform location
	add $t2, $t2, -128
	sw $s5, 0($t2) #Draw rocket
	
	DRAWSPRING:
	lw $t0, spring #Load spring's platform address
	beq $t0, 0, DRAWFRAME #If there is no spring, move on
	lw $t2, 0($t0) #Load platform location
	add $t2, $t2, -128
	sw $s4, 0($t2) #Draw spring
	j DRAWFRAME
	
	
CHECKCOLLISIONENEMY:
	lw $t2, enemy #Load enemy location
	li $t3, 0 #Initialize loop counter
		
	CHECKCOLLISIONENEMYLOOP:
		lw $t0, doodler #Load doodler location
		add $t2, $t2, $t3 #Add counter to enemy location
		beq $t0, $t2, GAMEOVER #Check bottom left doodler pixel
		addi $t0, $t0, 4
		beq $t0, $t2, GAMEOVER #Check bottom middle doodler pixel
		addi $t0, $t0, 4
		beq $t0, $t2, GAMEOVER #Check bottom right doodler pixel
		addi $t0, $t0, -132
		beq $t0, $t2, GAMEOVER #Check doodler head pixel
		addi $t3, $t3, 4 #Increment loop counter
		ble $t3, 4, CHECKCOLLISIONENEMYLOOP #Loop if counter not high enough
			
		lw $t4, enemy
		addi $t4, $t4, 132
		beq $t2, $t4, EXITCOLLISIONCHECKENEMY #Check if done checking enemy collision. Exit check if done.
		lw $t2, enemy
		addi $t2, $t2, 128 #Not done checking, adjust which pixels to check on
		li $t3, 0 #reset loop counter
		j CHECKCOLLISIONENEMYLOOP
		
		EXITCOLLISIONCHECKENEMY:
			la $t5, JUMPUP
			la $t6, JUMPDOWN
			bgt $ra, $t6, CHECKCOLLISION
			ble $ra, $t5, CHECKCOLLISION
			j LINK


CHECKCOLLISION: #Check if doodler collides with a platform
	add $t1, $t1, 1 #increment loop
	add $t8, $t8, 4 #incremember platforms memory address

	beq $t1, 11, LINK
	lw $t0, doodler #Load doodler address
	lw $t7, 0($t8) #Load platfrom address
	lw $t6, spring #Load spring's platform address
	beq $t6, $t8, CHECKSPRINGCOLLISION
	lw $t6, rocket #Load rocket's platform address
	beq $t6, $t8, CHECKROCKETCOLLISION
	j CHECKPLATFORMCOLLISION
	
	CHECKSPRINGCOLLISION:
		lw $t6, 0($t8) #Load platform location
		add $t6, $t6, -128
		beq $t6, $t0, SPRINGJUMP #Check if doodler collide with spring
		add $t0, $t0, 4
		beq $t6, $t0, SPRINGJUMP #Check if doodler collide with spring
		add $t0, $t0, 4
		beq $t6, $t0, SPRINGJUMP #Check if doodler collide with spring
		add $t0, $t0, -128
		beq $t6, $t0, SPRINGJUMP
		add $t0, $t0, -4
		beq $t6, $t0, SPRINGJUMP
		add $t0, $t0, -4
		beq $t6, $t0, SPRINGJUMP
		lw $t0, doodler #Load doodler address
		lw $t6, rocket #Load rocket's platform address
		beq $t6, $t8, CHECKROCKETCOLLISION
		j CHECKPLATFORMCOLLISION
		
	CHECKROCKETCOLLISION:
		lw $t6, 0($t8) #Load platform location
		add $t6, $t6, -128
		beq $t6, $t0, ROCKETJUMP #Check if doodler collide with rocket
		add $t0, $t0, 4
		beq $t6, $t0, ROCKETJUMP #Check if doodler collide with rocket
		add $t0, $t0, 4
		beq $t6, $t0, ROCKETJUMP #Check if doodler collid with rocket
		add $t0, $t0, -128
		beq $t6, $t0, ROCKETJUMP
		add $t0, $t0, -4
		beq $t6, $t0, ROCKETJUMP
		add $t0, $t0, -4
		beq $t6, $t0, ROCKETJUMP
		lw $t0, doodler #Load doodler address
		j CHECKPLATFORMCOLLISION
	
	CHECKPLATFORMCOLLISION:
	addi $t7, $t7, 16 #Get right pixel of platform
	bgt $t0, $t7, CHECKCOLLISION #Redo loop if collision condition 1 not met
	lw $t7, 0($t8) #Get left pixel of platform
	addi $t0, $t0, 8 #Get right pixel of doodler
	bgt $t7, $t0, CHECKCOLLISION #Redo loop if collision condition 2 not met
	
	la $t1, doodler #Load doodler memory address
	lw $t0, doodler #Load doodler address
	add $t0, $t0, -128 #Move doodler up
	sw $t0, 0($t1) #Store new doodler address
	
	lw $t2, previousPlatform #Load location of previous platform
	bgt $t2, $t7, ADDSCORE
	
	li $v0, 31 #Prepare play jump sound
	li $a0, 55 #pitch
	li $a1, 500 #duration
	li $a2, 12 #instrument
	li $a3, 70 #volume
	syscall

	j MAIN
	
ADDSCORE:
	sub $t3, $t2, $t7
	li $t5, 128
	div $t3, $t5
	mflo $t3 #The height difference between previous platform and current platform
	lw $t4, totalScore #Get current score
	add $t4, $t4, $t3 #Update score
	sw $t4, totalScore #Save updated score
	sw $t7, previousPlatform #Update previous platform location
	
	li $v0, 31 #Prepare play jump sound
	add $a0, $t3, 55 #pitch
	li $a1, 500 #duration
	li $a2, 12 #instrument
	li $a3, 70 #volume
	syscall
	j MAIN
	

GENERATEPLATFORMS:
	li $v0, 42 #Create randomized number 0-27
	li $a0, 0
	li $a1, 27
	syscall
	add $t2, $a0, $zero #Store first random number in t2
	sll $t2, $t2, 2 #Shift random number left by 2
	lw $t5, firstPixel #Load address of first pixel
	add $t2, $t2, $t5 #Add random number to first pixel address
	
	sw $t2, 0($t8) #Save new platform address
	
	lw $t5, spring
	beq $t5, $t8, ERASESPRING #Erase spring if platform its on is gone
	lw $t5, rocket
	beq $t5, $t8, ERASEROCKET #Erase rocket if platform its on is gone
	
	li $v0, 42 #Create randomized number 0-30
	li $a0, 0
	li $a1, 20
	syscall
	beq $a0, 10, GENERATESPRING #chance to spawn spring
	beq $a0, 15, GENERATEROCKET #Chance to spawn rocket
	j FINISHGENERATEPLATFORMS
	
	GENERATESPRING:
	lw $t5, spring
	bne $t5, 0, FINISHGENERATEPLATFORMS #If spring already exists, don't spawn another
	sw $t8, spring #Save platform address that spring is attached to
	j FINISHGENERATEPLATFORMS
	
	GENERATEROCKET:
	lw $t5, rocket
	bne $t5, 0, FINISHGENERATEPLATFORMS #If rocket already exists, don't spawn another
	sw $t8, rocket #Save platform address that rocket is attached to
	
	FINISHGENERATEPLATFORMS:
	beq $t1, 0, DRAWFRAME
	j SHIFTPLATFORMS
	
ERASESPRING:
	sw $zero, spring
	j FINISHGENERATEPLATFORMS
	
ERASEROCKET:
	sw $zero, rocket
	j FINISHGENERATEPLATFORMS
	
	
GENERATEENEMY:
	sw $zero, enemy #Set enemy value to 0
	
	li $v0, 42 #Create randomized number 0-5
	li $a0, 0
	li $a1, 5
	syscall
	bne $a0, 2, SHIFTPLATFORMS #20% chance to spawn enemy if one doesn't exist already. Otherwise go to shift platforms.
	
	la $t3, enemy
	
	li $v0, 42 #Create randomized number 0-27
	li $a0, 0
	li $a1, 27
	syscall
	add $t2, $a0, $zero #Store first random number in t2
	sll $t2, $t2, 2 #Shift random number left by 2
	lw $t5, firstPixel #Load address of first pixel
	add $t2, $t2, $t5 #Add random number to first pixel address
	
	sw $t2, 0($t3) #Store new address of enemy
	j SHIFTPLATFORMS
	
	
CONVERTSCORE:
	lw $t1, totalScore #Load total score
	la $t5, score #Get address of score
	li $t2, 1000
	div $t1, $t2
	mflo $t3
	sw $t3, 0($t5) #Store first digit of score
	mfhi $t1
	li $t2, 100
	div $t1, $t2
	mflo $t3
	sw $t3, 4($t5) #Store second digit of score
	mfhi $t1
	li $t2, 10
	div $t1, $t2
	mflo $t3
	sw $t3, 8($t5) #Store third digit of score
	mfhi $t3
	sw $t3, 12($t5) #Store fourth digit of score
	j GETSCORE
	
	
GETSCORE:
	lw $t2, score + 12 #Get fourth digit in score
	li $t3, 4
	mult $t2, $t3
	mflo $t2
	la $t4, NUMBERS
	add $a0, $t4, $t2 #Get the right number location from NUMBERS
	
	lw $t2, score + 8 #Get third digit in score
	li $t3, 4
	mult $t2, $t3
	mflo $t2
	la $t4, NUMBERS
	add $a1, $t4, $t2 #Get the right number location from NUMBERS
	
	lw $t2, score + 4 #Get second digit in score
	li $t3, 4
	mult $t2, $t3
	mflo $t2
	la $t4, NUMBERS
	add $a2, $t4, $t2 #Get the right number location from NUMBERS
	
	lw $t2, score #Get first digit in score
	li $t3, 4
	mult $t2, $t3
	mflo $t2
	la $t4, NUMBERS
	add $a3, $t4, $t2 #Get the right number location from NUMBERS
	
	j PRINTSCOREONEPREP
	
	
PRINTSCOREONEPREP:
	lw $t5, 0($a3) #Get address of first digit printing offsets
	lw $t6, scoreBoard #Get location of score board
	la $t4, EIGHT
ERASESCOREONE:
	lw $t1, 0($t4) #Get the offset of the part of eight
	beq $t1, $zero, PRINTSCOREONE #Print new score after erasing
	add $t8, $t1, $t6 #Find location of where to write eight
	sw $s3, 0($t8) #Write part of eight
	addi $t4, $t4, 4 #Get address of next offset of part of eight
	j ERASESCOREONE
PRINTSCOREONE:
	lw $t1, 0($t5) #Get the offset of the part of number
	beq $t1, $zero, PRINTSCORETWOPREP #Get next score when finish writing number
	add $t8, $t1, $t6 #Find location of where to write number
	sw $s1, 0($t8) #Write part of number
	addi $t5, $t5, 4 #Get address of next offset of part of number
	j PRINTSCOREONE
	
	
PRINTSCORETWOPREP:
	lw $t5, 0($a2) #Get address of second digit printing offsets
	lw $t6, scoreBoard #Get location of score board
	addi $t6, $t6, 16
	la $t4, EIGHT
ERASESCORETWO:
	lw $t1, 0($t4) #Get the offset of the part of eight
	beq $t1, $zero, PRINTSCORETWO #Print new score after erasing
	add $t8, $t1, $t6 #Find location of where to write eight
	sw $s3, 0($t8) #Write part of eight
	addi $t4, $t4, 4 #Get address of next offset of part of eight
	j ERASESCORETWO
PRINTSCORETWO:
	lw $t1, 0($t5) #Get the offset of the part of number
	beq $t1, $zero, PRINTSCORETHREEPREP #Get next score when finish writing number
	add $t8, $t1, $t6 #Find location of where to write number
	sw $s1, 0($t8) #Write part of number
	addi $t5, $t5, 4 #Get address of next offset of part of number
	j PRINTSCORETWO
	
	
PRINTSCORETHREEPREP:
	lw $t5, 0($a1) #Get address of third digit printing offsets
	lw $t6, scoreBoard #Get location of score board
	addi $t6, $t6, 32
	la $t4, EIGHT
ERASESCORETHREE:
	lw $t1, 0($t4) #Get the offset of the part of eight
	beq $t1, $zero, PRINTSCORETHREE #Print new score after erasing
	add $t8, $t1, $t6 #Find location of where to write eight
	sw $s3, 0($t8) #Write part of eight
	addi $t4, $t4, 4 #Get address of next offset of part of eight
	j ERASESCORETHREE
PRINTSCORETHREE:
	lw $t1, 0($t5) #Get the offset of the part of number
	beq $t1, $zero, PRINTSCOREFOURPREP #Get next score when finish writing number
	add $t8, $t1, $t6 #Find location of where to write number
	sw $s1, 0($t8) #Write part of number
	addi $t5, $t5, 4 #Get address of next offset of part of 
	j PRINTSCORETHREE
	
	
PRINTSCOREFOURPREP:
	lw $t5, 0($a0) #Get address of fourth digit printing offsets
	lw $t6, scoreBoard #Get location of score board
	addi $t6, $t6, 48
	la $t4, EIGHT
ERASESCOREFOUR:
	lw $t1, 0($t4) #Get the offset of the part of eight
	beq $t1, $zero, PRINTSCOREFOUR #Print new score after erasing
	add $t8, $t1, $t6 #Find location of where to write eight
	sw $s3, 0($t8) #Write part of eight
	addi $t4, $t4, 4 #Get address of next offset of part of eight
	j ERASESCOREFOUR
PRINTSCOREFOUR:
	lw $t1, 0($t5) #Get the offset of the part of number
	beq $t1, $zero, LINK #Get next score when finish writing number
	add $t8, $t1, $t6 #Find location of where to write number
	sw $s1, 0($t8) #Write part of number
	addi $t5, $t5, 4 #Get address of next offset of part of 
	j PRINTSCOREFOUR


LINK:
jr $ra


STARTSCREEN:	
	lw $t9, endScreen
	la $t0, D
	jal PRINTLETTER

	add $t9, $t9, 20
	la $t0, O
	jal PRINTLETTER

	add $t9, $t9, 24
	la $t0, O
	jal PRINTLETTER

	add $t9, $t9, 24
	la $t0, D
	jal PRINTLETTER
	
	add $t9, $t9, 20
	la $t0, L
	jal PRINTLETTER
	
	add $t9, $t9, 20
	la $t0, E
	jal PRINTLETTER

	lw $t9, endScreen
	add $t9, $t9, 784
	la $t0, J
	jal PRINTLETTER

	add $t9, $t9, 24
	la $t0, U
	jal PRINTLETTER

	add $t9, $t9, 24
	la $t0, M
	jal PRINTLETTER
	
	add $t9, $t9, 24
	la $t0, P
	jal PRINTLETTER	
	
	lw $t9, endScreen
	add $t9, $t9, 2344
	la $t0, H
	jal PRINTLETTER
	
	add $t9, $t9, 24
	la $t0, I
	jal PRINTLETTER
	j DISPLAYNAME
	
DISPLAYNAME:
	lw $t9, endScreen
	add $t9, $t9, 3072
	la $t5, name #Get name address
	addi $t6, $t5, 20
	
	DISPLAYNAMELOOP:
		beq $t5, $t6, MENU 
		lw $t7, 0($t5) #Get letter
		add $t5, $t5, 4 #Increment counter
		beq $t7, 0x61, PrintA
		beq $t7, 0x62, PrintB
		beq $t7, 0x63, PrintC
		beq $t7, 0x64, PrintD
		beq $t7, 0x65, PrintE
		beq $t7, 0x66, PrintF
		beq $t7, 0x67, PrintG
		beq $t7, 0x68, PrintH
		beq $t7, 0x69, PrintI
		beq $t7, 0x6A, PrintJ
		beq $t7, 0x6B, PrintK
		beq $t7, 0x6C, PrintL
		beq $t7, 0x6D, PrintM
		beq $t7, 0x6E, PrintN
		beq $t7, 0x6F, PrintO
		beq $t7, 0x70, PrintP
		beq $t7, 0x71, PrintQ
		beq $t7, 0x72, PrintR
		beq $t7, 0x73, PrintS
		beq $t7, 0x74, PrintT
		beq $t7, 0x75, PrintU
		beq $t7, 0x76, PrintV
		beq $t7, 0x77, PrintW
		beq $t7, 0x78, PrintX
		beq $t7, 0x79, PrintY
		beq $t7, 0x7A, PrintZ
		j DISPLAYNAMELOOP
		
PrintA:
	la $t0, A
	jal PRINTLETTER
	add $t9, $t9, 24
	j DISPLAYNAMELOOP
	
PrintB:
	la $t0, B
	jal PRINTLETTER
	add $t9, $t9, 24
	j DISPLAYNAMELOOP
	
PrintC:
	la $t0, C
	jal PRINTLETTER
	add $t9, $t9, 24
	j DISPLAYNAMELOOP
	
PrintD:
	la $t0, D
	jal PRINTLETTER
	add $t9, $t9, 24
	j DISPLAYNAMELOOP
	
PrintE:
	la $t0, E
	jal PRINTLETTER
	add $t9, $t9, 24
	j DISPLAYNAMELOOP
	
PrintF:
	la $t0, F
	jal PRINTLETTER
	add $t9, $t9, 24
	j DISPLAYNAMELOOP
	
PrintG:
	la $t0, G
	jal PRINTLETTER
	add $t9, $t9, 24
	j DISPLAYNAMELOOP
	
PrintH:
	la $t0, H
	jal PRINTLETTER
	add $t9, $t9, 24
	j DISPLAYNAMELOOP
	
PrintI:
	la $t0, I
	jal PRINTLETTER
	add $t9, $t9, 24
	j DISPLAYNAMELOOP
	
PrintJ:
	la $t0, J
	jal PRINTLETTER
	add $t9, $t9, 24
	j DISPLAYNAMELOOP
	
PrintK:
	la $t0, K
	jal PRINTLETTER
	add $t9, $t9, 24
	j DISPLAYNAMELOOP
	
PrintL:
	la $t0, L
	jal PRINTLETTER
	add $t9, $t9, 24
	j DISPLAYNAMELOOP
	
PrintM:
	la $t0, M
	jal PRINTLETTER
	add $t9, $t9, 24
	j DISPLAYNAMELOOP
	
PrintN:
	la $t0, N
	jal PRINTLETTER
	add $t9, $t9, 24
	j DISPLAYNAMELOOP
	
PrintO:
	la $t0, O
	jal PRINTLETTER
	add $t9, $t9, 24
	j DISPLAYNAMELOOP
	
PrintP:
	la $t0, P
	jal PRINTLETTER
	add $t9, $t9, 24
	j DISPLAYNAMELOOP
	
PrintQ:
	la $t0, Q
	jal PRINTLETTER
	add $t9, $t9, 24
	j DISPLAYNAMELOOP
	
PrintR:
	la $t0, R
	jal PRINTLETTER
	add $t9, $t9, 24
	j DISPLAYNAMELOOP
	
PrintS:
	la $t0, S
	jal PRINTLETTER
	add $t9, $t9, 24
	j DISPLAYNAMELOOP
	
PrintT:
	la $t0, T
	jal PRINTLETTER
	add $t9, $t9, 24
	j DISPLAYNAMELOOP
	
PrintU:
	la $t0, U
	jal PRINTLETTER
	add $t9, $t9, 24
	j DISPLAYNAMELOOP
	
PrintV:
	la $t0, V
	jal PRINTLETTER
	add $t9, $t9, 24
	j DISPLAYNAMELOOP
	
PrintW:
	la $t0, W
	jal PRINTLETTER
	add $t9, $t9, 24
	j DISPLAYNAMELOOP
	
PrintX:
	la $t0, X
	jal PRINTLETTER
	add $t9, $t9, 24
	j DISPLAYNAMELOOP
	
PrintY:
	la $t0, Y
	jal PRINTLETTER
	add $t9, $t9, 24
	j DISPLAYNAMELOOP
	
PrintZ:
	la $t0, Z
	jal PRINTLETTER
	add $t9, $t9, 24
	j DISPLAYNAMELOOP
	

GAMEOVER:
	jal WIPESCREEN
	jal CONVERTSCORE
	
	lw $t9, endScreen
	add $t9, $t9, 16
	la $t0, G
	jal PRINTLETTER

	add $t9, $t9, 24
	la $t0, A
	jal PRINTLETTER

	add $t9, $t9, 24
	la $t0, M
	jal PRINTLETTER

	add $t9, $t9, 24
	la $t0, E
	jal PRINTLETTER

	lw $t9, endScreen
	add $t9, $t9, 784
	la $t0, O
	jal PRINTLETTER

	add $t9, $t9, 24
	la $t0, V
	jal PRINTLETTER

	add $t9, $t9, 24
	la $t0, E
	jal PRINTLETTER
	
	add $t9, $t9, 24
	la $t0, R
	jal PRINTLETTER	
	
	li $v0, 31 #Prepare play spring sound
	li $a0, 74 #pitch
	li $a1, 500 #duration
	li $a2, 57 #instrument
	li $a3, 40 #volume
	syscall
	
	li $a0, 550
	li $v0, 32 # A pause
	syscall
	
	li $v0, 31 #Prepare play spring sound
	li $a0, 73 #pitch
	li $a1, 500 #duration
	li $a2, 57 #instrument
	li $a3, 40 #volume
	syscall
	
	li $a0, 550
	li $v0, 32 # A pause
	syscall
	
	li $v0, 31 #Prepare play spring sound
	li $a0, 72 #pitch
	li $a1, 1000 #duration
	li $a2, 57 #instrument
	li $a3, 40 #volume
	syscall
	
	j MENU
	
	
WIN:
	li $t5, 9999 #Load 9999 into $t5
	sw $t5, totalScore #Cap score to 9999
	
	jal WIPESCREEN
	jal CONVERTSCORE
	
	lw $t9, endScreen
	add $t9, $t9, 32
	la $t0, Y
	jal PRINTLETTER
	
	add $t9, $t9, 24
	la $t0, O
	jal PRINTLETTER

	add $t9, $t9, 24
	la $t0, U
	jal PRINTLETTER

	lw $t9, endScreen
	add $t9, $t9, 800
	la $t0, W
	jal PRINTLETTER

	add $t9, $t9, 24
	la $t0, I
	jal PRINTLETTER

	add $t9, $t9, 24
	la $t0, N
	jal PRINTLETTER
	
	li $v0, 31 #Prepare play spring sound
	li $a0, 70 #pitch
	li $a1, 800 #duration
	li $a2, 57 #instrument
	li $a3, 40 #volume
	syscall
	
	li $a0, 850
	li $v0, 32 # A pause
	syscall
	
	li $v0, 31 #Prepare play spring sound
	li $a0, 74 #pitch
	li $a1, 800 #duration
	li $a2, 57 #instrument
	li $a3, 40 #volume
	syscall
	
	li $a0, 850
	li $v0, 32 # A pause
	syscall
	
	li $v0, 31 #Prepare play spring sound
	li $a0, 82 #pitch
	li $a1, 1000 #duration
	li $a2, 57 #instrument
	li $a3, 40 #volume
	syscall
	
	j MENU

	
PRINTLETTER:
	lw $t1, 0($t0) #Get the offset of the part of letter
	beq $t1, $zero, LINK #Finish writing number when reach the end
	add $t8, $t1, $t9 #Find location of where to write number
	sw $s0, 0($t8) #Write part of number
	addi $t0, $t0, 4 #Get address of next offset of part of number
	j PRINTLETTER
	
	
WIPESCREEN:
	lw $t0, firstPixel
	lw $t1, lastPixel
	WIPESCREENLOOP:
		bgt $t0, $t1, LINK #Return when done wiping
		sw $s3, 0($t0) #Draw black
		add $t0, $t0, 4 #Increment counter
		j WIPESCREENLOOP


MENU:
	lw $t2, 0xffff0004
	
	li $a0, 60
	li $v0, 32 # A pause
	syscall
	
	beq $t2, 0x73, START #Play game again if click s
	beq $t2, 0x65, EXIT #Exit game if click e
	j MENU


EXIT:
jal WIPESCREEN
li $v0, 10 # terminate the program gracefully
syscall

