#include <stdint.h>

// ITM Registers
#define ITM_PORT0   (*((volatile uint32_t *)0xE0000000))

void ITM_SendChar_C(char c) // c takes input from r0
{
    ITM_PORT0 = c;				// output shows in printf viewer
}