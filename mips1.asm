.data
inName:.asciiz"\nEnter the name:"
inPhone:.asciiz"\nEnter the phone number:"
inId:.asciiz"\nEnter the Id:"
inAddr:.asciiz"\nEnter the address:"
notF:.asciiz"\nThere is no data\n"
showN:.asciiz "\nName is:"
showP:.asciiz"\nPhone number is:"
showA:.asciiz"\nAdress is:"
showId:.asciiz"\nId is:"
endl:.asciiz"\n"
space:.asciiz" "
strN:.space 100
arrN:.space 40
strP:.space 100
strAd:.space 100
arrId:.space 40
arrAd:.space 40
arrP:.space 40
option:.asciiz "\n1) Input New Contacts\n2) Display Stored Contacts\n3) Search Contacts using ID\n4) Delete Stored Contacts\n5) Update Stored Contacts\n6) Exit the Program\nYour choice: "
NoId:.asciiz"\nIncorrect id\n"
DelS:.asciiz"\nDeleted Successfully\n"
Null:.asciiz"0"
small:.asciiz"\nPlease use less than 8 charecters while entering data\n"
Management:.asciiz"\n\t\t~~~Telephone Directory~~~\n\t\t\t<Welcome>\n"
Practice:.asciiz"\n"
Mod:.asciiz"\nData is Modified\n"

.text

li $t1,0#Using for zero index ($t1)

# USED REGISTERS (t1,t2,t3,t4,t5,t6,t7,t8,t9,s0,s1,s2,s3,s4,s5)

addi $s0,$zero,1
addi $t5,$zero,1
addi $t6,$zero,2
addi $t8,$zero,3
addi $t9,$zero,4
addi $s5,$zero,5
addi $s6,$zero,6

main:

li $v0,4
la $a0,Management
syscall

li $v0,4
la $a0,Practice
syscall

li $v0,4
la $a0,option
syscall

li $v0,5
syscall
move $s1,$v0

beq $s1,$t5,test
beq $s1,$t6,show
beq $s1,$t8,search
beq $s1,$t9,delete
beq $s1,$s5,Modify
beq $s1,$s6,Exit
syscall

li $v0,10
syscall

test:

li $v0,4
la $a0,small#Please use less than 8 characters in data in Name
syscall

li $v0,4
la $a0,inName#Enter Your name
syscall

li $v0,8#Inpute Name (String Type)
la $a0,strN($t1)
li $a1,100#For storing array a1 is used
syscall#Array would get stored in strN after this call

sw $a0,arrN($t1)#
li $v0,4
la $a0,inPhone#Enter your phone number
syscall

li $v0,8#Input of Phone Number
la $a0,strP($t1)#Phone number is getting stored in strp array
li $a1,100# for storing string
syscall#Array would get stored after call
sw $a0,arrP($t1)

li $v0,4
la $a0,inAddr
syscall

li $v0,8
la $a0,strAd($t1)
li $a1,100
syscall
sw $a0,arrAd($t1)

li $v0,4
la $a0,inId
syscall

li $v0,5#input ID (integer)
syscall
sw $v0,arrId($t1)
addi $t1,$t1,8#Loop would increment 8Bytes in the index of $t1

j main#would jump to main, but the index would be incremented by 8 bytes
syscall


show:
li $t2,0

inShow:
beq $t2,$t1,main
li $v0,4
la $a0,showN
syscall

lw $t7,arrN($t2)
li $v0,4
move $a0,$t7#Stored Name would be displayed
syscall

li $v0,4
la $a0,showP
syscall

lw $t7,arrP($t2)
li $v0,4
move $a0,$t7#Arrayp would be displayed
syscall

li $v0,4
la $a0,showA
syscall

lw $t7,arrAd($t2)
li $v0,4
move $a0,$t7#Address would be displayed
syscall

li $v0,4
la $a0,showId
syscall

lw $t7,arrId($t2)
li $v0,1
move $a0,$t7#Id Would be displayed
syscall

addi $t2,$t2,8

j inShow

syscall

search:

li $t3,0#Register t3 is initialized as 0 index for array
li $v0,4
la $a0,inId
syscall

li $v0,5#id input
syscall
move $s2,$v0

inSearch:

beq $t3,$t1,No
lw $t4,arrId($t3)
beq $s2,$t4,SId
addi $t3,$t3,8
j inSearch
syscall

SId:

li $v0,4
la $a0,showN
syscall

lw $s3,arrN($t3)
li $v0,4
move $a0,$s3
syscall

li $v0,4
la $a0,showP
syscall

lw $s3,arrP($t3)
li $v0,4
move $a0,$s3
syscall

li $v0,4
la $a0,showA
syscall

lw $s3,arrAd($t3)
li $v0,4
move $a0,$s3
syscall

li $v0,4
la $a0,showId
syscall

lw $s3,arrId($t3)
li $v0,1
move $a0,$s3
syscall

j main
syscall

No:

li $v0,4
la $a0,NoId
syscall

j main
syscall

delete:

addi $t3,$zero,0

li $v0,4
la $a0,inId
syscall

li $v0,5
syscall
move $s2,$v0

inDel:

beq $t3,$t1,No
lw $t4,arrId($t3)
beq $s2,$t4,SDel
addi $t3,$t3,8

j inDel
syscall

SDel:

la $s3,Null#Used for Nulling the selected ID Arrays
li $s4,0
sw $s3,arrN($t3)
sw $s3,arrP($t3)
sw $s3,arrAd($t3)
sw $s4,arrId($t3)
li $v0,4
la $a0,DelS
syscall

j main
syscall

Modify:

li $t3,0
li $v0,4
la $a0,inId
syscall

li $v0,5
syscall
move $s2,$v0

inMod:

beq $t3,$t1,No
lw $t4,arrId($t3)
beq $s2,$t4,SMod
addi $t3,$t3,8

j inMod
syscall

 

SMod:

li $v0,4
la $a0,inName
syscall

li $v0,8
la $a0,strN($t3)
li $a1,100
syscall

sw $a0,arrN($t3)
li $v0,4
la $a0,inPhone
syscall

li $v0,8
la $a0,strP($t3)
li $a1,100
syscall

sw $a0,arrP($t3)
li $v0,4
la $a0,inAddr
syscall

li $v0,8
la $a0,strAd($t3)
li $a1,100
syscall

sw $a0,arrAd($t3)
li $v0,4
la $a0,inId
syscall

li $v0,5
syscall

sw $v0,arrId($t3)

li $v0,4
la $a0,Mod
syscall

j main
syscall

Exit:
li $v0,10
syscall