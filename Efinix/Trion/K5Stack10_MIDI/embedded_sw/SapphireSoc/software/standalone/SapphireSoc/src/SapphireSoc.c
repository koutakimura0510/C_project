#include <stdint.h>
#include "bsp.h"
// #include "soc.h"


/**-----------------------------------------------------------------------------
 * Soc Periheral Adrs
 *-----------------------------------------------------------------------------*/
#define ADRS_GPIO_0_IO_CTRL		(0xf8015000)
#define ADRS_GPIO_0_IO_CTRL_OUT (ADRS_GPIO_0_IO_CTRL + 4)
#define ADRS_GPIO_0_IO_CTRL_EN 	(ADRS_GPIO_0_IO_CTRL + 8)
#define ADRS_GPIO_1_IO_CTRL 	(0xf8018000)
#define ADRS_GPIO_1_IO_CTRL_OUT (ADRS_GPIO_1_IO_CTRL + 4)
#define ADRS_GPIO_1_IO_CTRL_EN 	(ADRS_GPIO_1_IO_CTRL + 8)

/**-----------------------------------------------------------------------------
 * USI コマンド
 *-----------------------------------------------------------------------------*/
#define USI_READ_CMD		(0x80000000)
#define USI_WRITE_CMD		(0x40000000)

/**-----------------------------------------------------------------------------
 * Block Base Adrs
 *-----------------------------------------------------------------------------*/
#define BASE_BLOCK_ADRS_GPIO	(0x00000000)
#define BASE_BLOCK_ADRS_TIMER	(0x00040000)


/**-----------------------------------------------------------------------------
 * USI Bus Read Sequence
 * adrs = block adrs
 *-----------------------------------------------------------------------------*/
uint32_t usi_read_cmd(uint32_t adrs)
{
	uint32_t lsbrd, msbrd;

	adrs |= USI_READ_CMD;
	write_u32(adrs, ADRS_GPIO_0_IO_CTRL_OUT);
	write_u32(adrs >> 16, ADRS_GPIO_1_IO_CTRL_OUT);
	write_u32(1, ADRS_GPIO_1_IO_CTRL_EN);
	lsbrd = read_u32(ADRS_GPIO_0_IO_CTRL);
	msbrd = read_u32(ADRS_GPIO_1_IO_CTRL) << 16;
	write_u32(0, ADRS_GPIO_1_IO_CTRL_EN);
	
	return msbrd | lsbrd;
}

/**-----------------------------------------------------------------------------
 * USI Bus Write Sequence
 * wd   = write data
 * adrs = block adrs
 *-----------------------------------------------------------------------------*/
void usi_write_cmd(uint32_t wd, uint32_t adrs)
{
	write_u32(wd, ADRS_GPIO_0_IO_CTRL_OUT);
	write_u32(wd>>16, ADRS_GPIO_1_IO_CTRL_OUT);
	write_u32(1, ADRS_GPIO_0_IO_CTRL_EN);
	write_u32(0, ADRS_GPIO_0_IO_CTRL_EN);
	
	adrs |= USI_WRITE_CMD;
	write_u32(adrs, ADRS_GPIO_0_IO_CTRL_OUT);
	write_u32(adrs >> 16, ADRS_GPIO_1_IO_CTRL_OUT);
	write_u32(1, ADRS_GPIO_1_IO_CTRL_EN);
	write_u32(0, ADRS_GPIO_1_IO_CTRL_EN);
}

/**-----------------------------------------------------------------------------
 * LED FLASH
 *-----------------------------------------------------------------------------*/
void led_flash(void)
{
	static uint32_t t = 0;
	static uint8_t flash = 0x01;
	uint32_t now_t = usi_read_cmd(BASE_BLOCK_ADRS_TIMER);

	if ((t + 100) < now_t) {
		t = now_t;
		flash++;
		flash &= 0x07;
		usi_write_cmd(flash, BASE_BLOCK_ADRS_GPIO);
	}
}

/**-----------------------------------------------------------------------------
 * main 関数
 *-----------------------------------------------------------------------------*/
void main()
{
	// bsp_init();
	// uint8_t ss = usi_read_cmd(BASE_BLOCK_ADRS_GPIO + 0x8);
	usi_write_cmd(0x00, BASE_BLOCK_ADRS_GPIO + 0x8);
	
	while (1)
	{
		led_flash();
		// d = usi_read_cmd(BASE_BLOCK_ADRS_GPIO);
		// bsp_printf("Teeeeeee!! \r\n");
	}
}
