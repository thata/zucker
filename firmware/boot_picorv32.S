.section .init
.global main

reset_vec:
	j start

start:
	addi x1, zero, 0
	addi x2, zero, 0
	addi x3, zero, 0
	addi x4, zero, 0
	addi x5, zero, 0
	addi x6, zero, 0
	addi x7, zero, 0
	addi x8, zero, 0
	addi x9, zero, 0
	addi x10, zero, 0
	addi x11, zero, 0
	addi x12, zero, 0
	addi x13, zero, 0
	addi x14, zero, 0
	addi x15, zero, 0
	addi x16, zero, 0
	addi x17, zero, 0
	addi x18, zero, 0
	addi x19, zero, 0
	addi x20, zero, 0
	addi x21, zero, 0
	addi x22, zero, 0
	addi x23, zero, 0
	addi x24, zero, 0
	addi x25, zero, 0
	addi x26, zero, 0
	addi x27, zero, 0
	addi x28, zero, 0
	addi x29, zero, 0
	addi x30, zero, 0
	addi x31, zero, 0

	// SDRAMへの値の出し入れ

	// mem[0x4000_0000] = 10
	li t1, 0x40000000
	li t0, 10
	sw t0, 0(t1)

	// mem[0x4000_0004] = 20
	li t1, 0x40000004
	li t0, 20
	sw t0, 0(t1)

	// t2 = mem[0x4000_0000]
	li t1, 0x40000000
	lw t2, 0(t1)

	// t3 = mem[0x4000_0004]
	li t1, 0x40000004
	lw t3, 0(t1)

	// t0 = t2 + t3
	add t0, t2, t3

	// 10 + 20 の結果をLEDに表示
    li t1, 0xf0001000   // LEDコントロールレジスタのアドレス
    sw t0, 0(t1)        // LEDコントロールレジスタへ書き込み

	// 無限ループ
foo:
	j foo

	// データ
	// - counter = 10
	// - sum = 0
counter:
	.word 9
sum:
	.word 0

	/* set stack pointer to end of block ram */
//	lui sp, %hi(5120)
//	addi sp, sp, %lo(5120)
	lui sp, %hi(6144)
	addi sp, sp, %lo(6144)

	/* call firmware main */
	jal ra, main

	/* set stack pointer to end of HRAM */
	lui sp, %hi(0x42000000)
	addi sp, sp, %lo(0x42000000)

	/* jump to LIX or baremetal app */
	li a0, 0x40000000
	jr a0
