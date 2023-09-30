/**-----------------------------------------------------------------------------
 * Create  2023/07/09
 * Author  kouta kimura
 * -
 * 周辺機器のアドレスマップ、コマンド定数を管理
 * 
 *-----------------------------------------------------------------------------*/
#ifndef periheral_macro_h
#define periheral_macro_h


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
 * Bus Cmd
 *-----------------------------------------------------------------------------*/
#define USI_BUS_SELECT		(0x20)
#define UFI_BUS_SELECT		(0x30)
#define USI_READ_CMD		(0x80000000)
#define USI_WRITE_CMD		(0x40000000)
//
#define UFI_ENABLE_CMD		(0x80000000)
#define UFI_READ_CMD		(0x40000000)
#define UFI_WRITE_CMD		(0x00000000)


/**-----------------------------------------------------------------------------
 * USI Block Base Adrs
 *-----------------------------------------------------------------------------*/
#define BASE_BLOCK_USI_ADRS_GPIO	(0x00000000)
#define BASE_BLOCK_USI_ADRS_SPI		(0x00010000)
#define BASE_BLOCK_USI_ADRS_SYNTH	(0x00020000)
#define BASE_BLOCK_USI_ADRS_AUDIO	(0x00020000)
#define BASE_BLOCK_USI_ADRS_RAM		(0x00030000)
#define BASE_BLOCK_USI_ADRS_TIMER	(0x00040000)
#define BASE_BLOCK_USI_ADRS_MCB		(0x00050000)
#define BASE_BLOCK_USI_ADRS_NULL	(0x0fffffff)

// GPIO Block Reg Map
#define GPIO_REG_OUT_CTRL	(BASE_BLOCK_USI_ADRS_GPIO + 0x0)
#define GPIO_REG_ALTNATE	(BASE_BLOCK_USI_ADRS_GPIO + 0x8)

// SPI Block Reg Map
#define FLASH_MEM_PAGE_LEN	(2048)
#define SPI_REG_DIV			(BASE_BLOCK_USI_ADRS_SPI + 0x14)
#define SPI_REG_CS			(BASE_BLOCK_USI_ADRS_SPI + 0x1C)
#define SPI_REG_GPIO_ALT	(BASE_BLOCK_USI_ADRS_SPI + 0x20)
#define SPI_REG_MOSI		(BASE_BLOCK_USI_ADRS_SPI + 0x18)
#define SPI_REG_ENABLE		(BASE_BLOCK_USI_ADRS_SPI + 0x10)
#define SPI_REG_MISO		(BASE_BLOCK_USI_ADRS_SPI + 0x84)
#define SPI_REG_DONE		(BASE_BLOCK_USI_ADRS_SPI + 0x88)

// Syn Reg Map
#define SYNTH_REG_I2S_RST			(BASE_BLOCK_USI_ADRS_SYNTH + 0x00)
#define SYNTH_REG_DMA_ENABLE		(BASE_BLOCK_USI_ADRS_SYNTH + 0x04)
#define SYNTH_REG_DMA_CYCLE_ENABLE	(BASE_BLOCK_USI_ADRS_SYNTH + 0x08)
#define SYNTH_REG_DMA_ADRS_START	(BASE_BLOCK_USI_ADRS_SYNTH + 0x0C)
#define SYNTH_REG_DMA_ADRS_END		(BASE_BLOCK_USI_ADRS_SYNTH + 0x10)
#define SYNTH_REG_DMA_ADRS_ADD		(BASE_BLOCK_USI_ADRS_SYNTH + 0x14)
#define SYNTH_REG_AUDIO_AMP_CH4321	(BASE_BLOCK_USI_ADRS_SYNTH + 0x60)
#define SYNTH_REG_AUDIO_FREQ		(BASE_BLOCK_USI_ADRS_SYNTH + 0x80)
#define SYNTH_REG_AUDIO_PLAY		(BASE_BLOCK_USI_ADRS_SYNTH + 0x84)
#define SYNTH_REG_ON_NOTE_NUMBER	(BASE_BLOCK_USI_ADRS_SYNTH + 0xC0)

// Audio Tx Block Reg Map
#define AUDIO_REG_IO_HIZ			(BASE_BLOCK_USI_ADRS_AUDIO + 0x00)
#define AUDIO_REG_SFM_ENABLE		(BASE_BLOCK_USI_ADRS_AUDIO + 0x04)
#define AUDIO_REG_SFM_CYCLE_ENABLE	(BASE_BLOCK_USI_ADRS_AUDIO + 0x08)
#define AUDIO_REG_SFM_CLK_DIV		(BASE_BLOCK_USI_ADRS_AUDIO + 0x0C)
#define AUDIO_REG_SFM_CS_HOLD_TIME	(BASE_BLOCK_USI_ADRS_AUDIO + 0x10)
#define AUDIO_REG_SFM_CPU_WD		(BASE_BLOCK_USI_ADRS_AUDIO + 0x14)
#define AUDIO_REG_SFM_CPU_ENABLE	(BASE_BLOCK_USI_ADRS_AUDIO + 0x18)
#define AUDIO_REG_SFM_CPU_CS_CTRL	(BASE_BLOCK_USI_ADRS_AUDIO + 0x1C)
#define AUDIO_REG_SFM_CPU_VALID		(BASE_BLOCK_USI_ADRS_AUDIO + 0x20)
#define AUDIO_REG_SFM_CPU_DONE		(BASE_BLOCK_USI_ADRS_AUDIO + 0x30)
#define AUDIO_REG_SFM_START_ADRS_1	(BASE_BLOCK_USI_ADRS_AUDIO + 0x60)
#define AUDIO_REG_SFM_END_ADRS_1	(BASE_BLOCK_USI_ADRS_AUDIO + 0x64)
#define AUDIO_REG_SFM_START_ADRS_2	(BASE_BLOCK_USI_ADRS_AUDIO + 0x68)
#define AUDIO_REG_SFM_END_ADRS_2	(BASE_BLOCK_USI_ADRS_AUDIO + 0x6C)
#define AUDIO_REG_SFM_START_ADRS_3	(BASE_BLOCK_USI_ADRS_AUDIO + 0x70)
#define AUDIO_REG_SFM_END_ADRS_3	(BASE_BLOCK_USI_ADRS_AUDIO + 0x74)
#define AUDIO_REG_SFM_CPU_RD_1		(BASE_BLOCK_USI_ADRS_AUDIO + 0x90)
#define AUDIO_REG_SFM_CPU_RD_2		(BASE_BLOCK_USI_ADRS_AUDIO + 0x94)
#define AUDIO_REG_SFM_CPU_RD_3		(BASE_BLOCK_USI_ADRS_AUDIO + 0x98)

// Timer Block Reg Map
#define TIMER_REG_DIV1	    (BASE_BLOCK_USI_ADRS_TIMER + 0x00)
#define TIMER_REG_DIV2	    (BASE_BLOCK_USI_ADRS_TIMER + 0x04)
#define TIMER_REG_DIV3	    (BASE_BLOCK_USI_ADRS_TIMER + 0x08)
#define TIMER_REG_ENABLE	(BASE_BLOCK_USI_ADRS_TIMER + 0x0C)
#define TIMER_REG_COUNT1	(BASE_BLOCK_USI_ADRS_TIMER + 0x40)
#define TIMER_REG_COUNT2	(BASE_BLOCK_USI_ADRS_TIMER + 0x44)
#define TIMER_REG_COUNT3	(BASE_BLOCK_USI_ADRS_TIMER + 0x48)

// Video Tx Block Reg Map
#define TIMER_REG_DIV1	    (BASE_BLOCK_USI_ADRS_TIMER + 0x00)
#define TIMER_REG_DIV2	    (BASE_BLOCK_USI_ADRS_TIMER + 0x04)
#define TIMER_REG_DIV3	    (BASE_BLOCK_USI_ADRS_TIMER + 0x08)
#define TIMER_REG_ENABLE	(BASE_BLOCK_USI_ADRS_TIMER + 0x0C)
#define TIMER_REG_COUNT1	(BASE_BLOCK_USI_ADRS_TIMER + 0x40)
#define TIMER_REG_COUNT2	(BASE_BLOCK_USI_ADRS_TIMER + 0x44)
#define TIMER_REG_COUNT3	(BASE_BLOCK_USI_ADRS_TIMER + 0x48)

// MCB Reg Map
#define MCB_REG_RAM_WD			(BASE_BLOCK_USI_ADRS_MCB + 0x00)
#define MCB_REG_RAM_ADRS		(BASE_BLOCK_USI_ADRS_MCB + 0x04)
#define MCB_REG_RAM_ENABLE		(BASE_BLOCK_USI_ADRS_MCB + 0x08)
#define MCB_REG_RAM_BURST_RUN	(BASE_BLOCK_USI_ADRS_MCB + 0x0C)
#define MCB_REG_RAM_RAM_STATUS	(BASE_BLOCK_USI_ADRS_MCB + 0x40)
#define MCB_REG_RAM_RD			(BASE_BLOCK_USI_ADRS_MCB + 0x44)
#define MCB_REG_RAM_RD_VD		(BASE_BLOCK_USI_ADRS_MCB + 0x48)


/**-----------------------------------------------------------------------------
 * UFI Block Base Adrs
 *-----------------------------------------------------------------------------*/
#define BASE_UFI_BLOCK_ADRS_MCB	(0x00000000)
#define BASE_UFI_BLOCK_ADRS_VTB	(0x02000000)


#define MCB_CACHE_READ			(BASE_UFI_BLOCK_ADRS_MCB | UFI_READ_CMD)


#endif