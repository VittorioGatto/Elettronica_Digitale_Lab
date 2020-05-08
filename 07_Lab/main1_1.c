int main(void){
	//PORT REGISTERS A (LED)
	volatile unsigned int *GPIOA_MODER = (unsigned int*)(0x40020000 + 0x00);
	volatile unsigned int *GPIOA_ODR = (unsigned int*)(0x40020000 + 0x00 + 0x14);

	//PORT REGISTERS C (Push button)
	volatile unsigned int *GPIOC_MODER = (unsigned int*)(0x40020000 + 0x0800); //port location
	volatile unsigned int *GPIOC_IDR = (unsigned int*)(0x40020000 + 0x0800 + 0x10); //input mode port location

	//CLOCK REGISTERS
	volatile unsigned int *RCC_AHB1ENR = (unsigned int*)(0x40023800 + 0x30);

	//ENABLE PORT CLOCK
	*RCC_AHB1ENR |= 0x05U; //setting clock for GPIOC and GPIOA

	//set pin location (PA5) to mode 10 (AF) [11:10]
	*GPIOA_MODER = *GPIOA_MODER | 0x400;

	//set pin location (PC13)  to input mode (00) [27:26]
	*GPIOC_MODER = *GPIOC_MODER  & ~(3UL << 26); //set 27th and 26 bits off

	//set pin location (PA5) output to 0 (OFF) [5]
	*GPIOA_ODR &= ~(1UL << 5); //setting 5th bit off

	int bit;

	while(1){
		bit = (*GPIOC_IDR >> 13) & 1UL; //check 13th bit value (PC13)
		if(bit == 0){
			*GPIOA_ODR = *GPIOA_ODR | 0x20; //ON
		} else {
			*GPIOA_ODR &= ~(1UL << 5); //OFF
		}
	}
}

