#define MYWAIT 1000000

int main(void){
	//PORT REGISTERS
	volatile unsigned int *GPIOA_MODER = (unsigned int*)(0x40020000 + 0x00);
	volatile unsigned int *GPIOA_ODR = (unsigned int*)(0x40020000 + 0x14);

	//CLOCK REGISTERS
	volatile unsigned int *RCC_AHB1ENR = (unsigned int*)(0x40023800 + 0x30);

	//ENABLE PORT CLOCK
	*RCC_AHB1ENR |= 0x05U;

	//set pin location (PA5) to mode 10 (AF) [11:10]
	*GPIOA_MODER = *GPIOA_MODER | 0x400;

	//set pin location (PA5) to 1 (output) [11:10]
	*GPIOA_ODR = *GPIOA_ODR | 0x20;

	while(1){
		*GPIOA_ODR = *GPIOA_ODR ^ 0x20;

		for(int i = 0; i < MYWAIT; i++){}
	}
}
