.data
	
	msg1: .asciiz "Digite o CPF:"
	msg2: .asciiz "CPF VALIDO."
	msg3: .asciiz "CPF INVALIDO."

.text

	#Entrada do CPF pelo usuario (digito por digito):
	
	li $v0, 4	#primeira mensagem
	la $a0, msg1	
	syscall

	li $v0, 5	#le um valor inteiro do usuario
	syscall
	move $t0, $v0	#primeiro digito
	
	li $v0, 5	
	syscall
	move $t1, $v0	#segundo digito
	
	li $v0, 5	
	syscall
	move $t2, $v0	#terceiro digito
	
	li $v0, 5
	syscall 
	move $s0, $v0	#quarto digito
	
	li $v0, 5
	syscall
	move $s1, $v0	#quinto digito
	
	li $v0, 5
	syscall
	move $s2, $v0	#sexto digito
	
	li $v0, 5
	syscall
	move $s3, $v0	#setimo digito
	
	li $v0, 5
	syscall 
	move $s4, $v0	#oitavo digito
	
	li $v0, 5
	syscall 
	move $s5, $v0	#nono digito
	
	li $v0, 5
	syscall 
	move $s6, $v0	#decimo digito (verificador1)
	
	li $v0, 5
	syscall 
	move $s7, $v0	#decimo primeiro digito (verificador2)
	
#------------------------------------------------------------------------------------------------------------------

	#multiplicacao e soma dos digitos (sem os verificadores):
	
	li $t3, 10		#li carrega o valor para o registrador de destino
	mul $t4, $t0, $t3
	
	li $t3, 9
	mul $t5, $t1, $t3
	add $t5, $t5, $t4
	
	li $t3, 8
	mul $t4, $t2, $t3
	add $t5, $t5, $t4
	
	li $t3, 7
	mul $t4, $s0, $t3
	add $t5, $t5, $t4
	
	li $t3, 6
	mul $t4, $s1, $t3
	add $t5, $t5, $t4
	
	li $t3, 5
	mul $t4, $s2, $t3
	add $t5, $t5, $t4
	
	li $t3, 4
	mul $t4, $s3, $t3
	add $t5, $t5, $t4
	
	li $t3, 3
	mul $t4, $s4, $t3
	add $t5, $t5, $t4
	
	li $t3, 2
	mul $t4, $s5, $t3
	add $t5, $t5, $t4
	
	#resto da divisao da soma total por 11:
	
	li $t3, 11
	
	rem $t6, $t5, $t3	#resto da divisao
	
	li $t3, 11
	
	sub $t7, $t3, $t6	#subtrair o resto da divisao por 11
	
	#conferir se o primeiro digito verificador e igual ao resto da divisao subtraido por 11:
	
	#se o calculo final do resto for >= 10 o digito verificador sera zero:
	
	li $t3, 10
	
	bge $t7, $t3, digito1Zero	#se $t7 >= $t3
	
	#se não;
	
	beq $t7, $s6, digito1Valido	#se o digito verificador 1 for igual ao resultado dos calculos
	j exit				#se nao, exit
	
digito1Zero:

	li $t3, 0
	
	beq $s6, $t3, digito1Valido	#se $s6 == $t3, se for valido, pula para o label digito1valido
	j exit
	
digito1Valido:

	#comeca o calculo do segundo digito verificador:
	
	li $t3, 11
	mul $t4, $t0, $t3
	
	li $t3, 10
	mul $t5, $t1, $t3
	add $t5, $t5, $t4
	
	li $t3, 9
	mul $t4, $t2, $t3
	add $t5, $t5, $t4
	
	li $t3, 8
	mul $t4, $s0, $t3
	add $t5, $t5, $t4
	
	li $t3, 7
	mul $t4, $s1, $t3
	add $t5, $t5, $t4
	
	li $t3, 6
	mul $t4, $s2, $t3
	add $t5, $t5, $t4
	
	li $t3, 5
	mul $t4, $s3, $t3
	add $t5, $t5, $t4
	
	li $t3, 4
	mul $t4, $s4, $t3
	add $t5, $t5, $t4
	
	li $t3, 3
	mul $t4, $s5, $t3
	add $t5, $t5, $t4
	
	li $t3, 2
	mul $t4, $s6, $t3
	add $t5, $t5, $t4
	
	#resto da divisao da soma total por 11:
	
	li $t3, 11
	
	rem $t6, $t5, $t3	#resto da divisao
	
	li $t3, 11
	
	sub $t7, $t3, $t6	#subtrair o resto da divisao por 11
	
	#conferir se o segundo digito verificador e igual ao resto da divisao subtraido por 11:
	
	#se o calculo final do resto for >= 10 o digito verificador sera zero:
	
	li $t3, 10
	
	bge $t7, $t3, digito2Zero	#Se $t7 >= $t3
	
	#se não;
	
	beq $t7, $s7, cpfValido		#se o digito verificador 2 for igual ao resultado dos calculos
	j exit				
	
digito2Zero:

	li $t3, 0
	
	beq $s7, $t3, cpfValido		#$s7 == $t3, se for valido, pula para o label cpfValido
	j exit
	
cpfValido:

	#caso os dois digitos forem validados:
	
	li $v0, 4	#mensagem de cpf valido
	la $a0, msg2
	syscall
	
	j exitValido
	
exit:

	#caso um dos digitos for invalido:
	
	li $v0, 4	#mensagem de cpf invalido
	la $a0, msg3
	syscall
	
exitValido:

	
	
	
	
	
	
	
	
	
	
	
	
	