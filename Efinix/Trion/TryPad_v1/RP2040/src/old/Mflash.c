/*------------------------------------------------------------------------------
 * Create 2024/07/14
 * Author Kouta Kimura
 * 
 * FPGA のレジスタを設定して GPIO を制御し SPI 信号の生成して Flash の制御を行う。
 * Pico SPI 信号を Thru で使用する場合は、MflashPico 関数を使用する。
 *-----------------------------------------------------------------------------*/
#include "trypad.h"

/**-----------------------------------------------------------------------------
 * ファイル内 グローバル変数
 *-----------------------------------------------------------------------------*/


/**-----------------------------------------------------------------------------
 * ファイル内 プロトタイプ宣言
 *-----------------------------------------------------------------------------*/

/**-----------------------------------------------------------------------------
 * USER MACRO / 
 *-----------------------------------------------------------------------------*/
#define FLASH_DUMMY_CMD				(0x00)
#define FLASH_ID_READ_CMD			(0x9f)
#define FLASH_PROTECTION_REG_WRITE	(0x1f)
#define FLASH_STATUS_REG1_ADRS		(0xA0)
#define FLASH_STATUS_REG3_ADRS		(0xC3)
#define FLASH_WRITE_ENALE_CMD 		(0x06)
#define FLASH_BLOCK_ELASE			(0xd8)
#define FLASH_BUSY_WAIT_CHECK		(0x0f)
#define FLASH_PROGRAM_DATA_LOAD		(0x02)
#define FLASH_PROGRAM_DATA_EXECUTE	(0x10)
#define FLASH_PROGRAM_PAGE_READ		(0x13)
#define FLASH_READ_DATA_CMD			(0x03)
#define FLASH_STATUS_REG1			(0x03)
#define FLASH_READ_DATA_CMD			(0x03)
//
#define FLASH_PROTECTION_WRITE_VALUE (0x83)	//可変可能

/**-----------------------------------------------------------------------------
 * データベース定数
 *-----------------------------------------------------------------------------*/
#define SFM_REG_DB_SIZE     ((sizeof(sfm_reg_db)) / (sizeof(SfmRegDB)))

/**-----------------------------------------------------------------------------
 * static struct
 *-----------------------------------------------------------------------------*/
typedef struct {
	uint8_t id;
	uint32_t done;
	uint32_t mosi;
	uint32_t enable;
	uint32_t miso;
	uint32_t cs;
	uint8_t bit;
} SfmRegDB;

static const SfmRegDB sfm_reg_db[] = {
	{0,	SPI_REG_SFM_CPU_DONE, SPI_REG_SFM_CPU_WD_1,	SPI_REG_SFM_CPU_ENABLE,	SPI_REG_SFM_CPU_RD_1, SPI_REG_SFM_CPU_CS_CTRL,	0x01	},
	{1,	SPI_REG_SFM_CPU_DONE, SPI_REG_SFM_CPU_WD_2,	SPI_REG_SFM_CPU_ENABLE,	SPI_REG_SFM_CPU_RD_2, SPI_REG_SFM_CPU_CS_CTRL,	0x02	},
	{2,	SPI_REG_SFM_CPU_DONE, SPI_REG_SFM_CPU_WD_3,	SPI_REG_SFM_CPU_ENABLE,	SPI_REG_SFM_CPU_RD_3, SPI_REG_SFM_CPU_CS_CTRL,	0x04	},
};

/**-----------------------------------------------------------------------------
 * ファイル内 関数プロトタイプ宣言
 *-----------------------------------------------------------------------------*/
static void flash_write_enable_cmd(const SfmRegDB *sfm_reg_db);
static void flash_block_elase(const SfmRegDB *sfm_reg_db, uint16_t page_adrs);
static void flash_busy_wait(const SfmRegDB *sfm_reg_db);
static void flash_program_data_load(const SfmRegDB *sfm_reg_db, uint8_t *wbuff, uint16_t col_adrs, uint16_t len);
static void flash_program_data_execute(const SfmRegDB *sfm_reg_db, uint16_t page_adrs);
static void flash_page_read(const SfmRegDB *sfm_reg_db, uint16_t page_adrs);
static void flash_read_data(const SfmRegDB *sfm_reg_db, uint8_t *rbuff, uint16_t col_adrs, uint16_t len);
static void flash_spi_write(uint8_t mosi, uint32_t done_adrs, uint32_t mosi_adrs, uint32_t enable_adrs, uint8_t bit);
static uint8_t flash_spi_read(uint8_t mosi, uint32_t done_adrs, uint32_t mosi_adrs, uint32_t enable_adrs, uint32_t miso_adrs, uint8_t bit);


/**-----------------------------------------------------------------------------
 * user Flash Write
 * 
 * id = Sfm ID
 * page_adrs = 消去ブロック、64page単位で指定
 *-----------------------------------------------------------------------------*/
void flash_rom_init(void)
{
	usi_write(SPI_REG_SFM_CLK_DIV, 0x040404);		// 動作周波数
	usi_write(SPI_REG_SFM_CS_HOLD_TIME, 0x020202);
	usi_write(SPI_REG_SFM_CPU_VALID, 0x3);
	flash_protection_reg_write(0);
	flash_protection_reg_write(1);
	// usi_write(SPI_REG_SFM_CPU_VALID, 0x0);
}

/**-----------------------------------------------------------------------------
 * user Flash Write
 * 
 * id = Sfm ID
 * page_adrs = 消去ブロック、64page単位で指定
 *-----------------------------------------------------------------------------*/
void flash_user_block_elase(uint8_t id, uint16_t page_adrs)
{
	const SfmRegDB *srd = sfm_reg_db;

	for (uint8_t i = 0; i < SFM_REG_DB_SIZE; i++, srd++) {
		if (srd->id == id) {
			break;
		}
	}

	flash_write_enable_cmd(srd);
	flash_block_elase(srd, page_adrs);
	flash_busy_wait(srd);
}


/**-----------------------------------------------------------------------------
 * user Flash Write
 * 
 * id = Sfm ID
 * *wbuff = 書き込みバッファアドレス
 * col_adrs = col adrs
 * page_adrs = 書き込みページアドレス、64page単位で指定
 * len = バッファサイズ
 *-----------------------------------------------------------------------------*/
void flash_user_page_write(uint8_t id, uint8_t *wbuff, uint16_t col_adrs, uint16_t page_adrs, uint16_t len)
{
	const SfmRegDB *srd = sfm_reg_db;

	for (uint8_t i = 0; i < SFM_REG_DB_SIZE; i++, srd++) {
		if (srd->id == id) {
			break;
		}
	}

	flash_write_enable_cmd(srd);
	flash_program_data_load(srd, wbuff, col_adrs, len);
	flash_program_data_execute(srd, page_adrs);
	flash_busy_wait(srd);
}


/**-----------------------------------------------------------------------------
 * Flash Write
 * 
 * id = Sfm ID
 * *wbuff = 書き込みバッファアドレス
 * col_adrs = col adrs
 * page_adrs = 書き込みページアドレス、64page単位で指定
 * len = バッファサイズ
 *-----------------------------------------------------------------------------*/
void flash_write(uint8_t id, uint8_t *wbuff, uint16_t col_adrs, uint16_t page_adrs, uint16_t len)
{
	const SfmRegDB *srd = sfm_reg_db;

	for (uint8_t i = 0; i < SFM_REG_DB_SIZE; i++, srd++) {
		if (srd->id == id) {
			break;
		}
	}

	flash_write_enable_cmd(srd);
	flash_block_elase(srd, page_adrs);
	flash_busy_wait(srd);
	flash_write_enable_cmd(srd);
	flash_program_data_load(srd, wbuff, col_adrs, len);
	flash_program_data_execute(srd, page_adrs);
	flash_busy_wait(srd);
}

/**-----------------------------------------------------------------------------
 * Flash Read
 * 
 * id = Sfm ID
 * *rbuff = 読み込みバッファアドレス
 * col_adrs = col adrs
 * page_adrs = 読み込みページアドレス、64page単位で指定
 * len = バッファサイズ
 *-----------------------------------------------------------------------------*/
void flash_read(uint8_t id, uint8_t *rbuff, uint16_t col_adrs, uint16_t page_adrs, uint16_t len)
{
	const SfmRegDB *srd = sfm_reg_db;

	for (uint8_t i = 0; i < SFM_REG_DB_SIZE; i++, srd++) {
		if (srd->id == id) {
			break;
		}
	}

	flash_page_read(srd, page_adrs);
	flash_busy_wait(srd);
	flash_read_data(srd, rbuff, col_adrs, len);
}


/**-----------------------------------------------------------------------------
 * Flash Rom ID Read
 * 
 * mfr_id 0xef
 * device_id_msi 0xba
 * device_id_lsb 0x21
 * 
 * W25N01GV
 * 0xef, 0xaa, 0x21
 *-----------------------------------------------------------------------------*/
uint32_t flash_id_read(uint8_t id)
{
	uint8_t mfr_id, device_id_msb, device_id_lsb;
	const SfmRegDB *srd = sfm_reg_db;

	for (uint8_t i = 0; i < SFM_REG_DB_SIZE; i++, srd++) {
		if (srd->id == id) {
			break;
		}
	}

	usi_write(srd->cs, ~srd->bit);
	flash_spi_read(FLASH_ID_READ_CMD,	 				srd->done, srd->mosi, srd->enable, srd->miso, srd->bit);
	flash_spi_read(FLASH_DUMMY_CMD, 					srd->done, srd->mosi, srd->enable, srd->miso, srd->bit);
	mfr_id = flash_spi_read(FLASH_DUMMY_CMD, 			srd->done, srd->mosi, srd->enable, srd->miso, srd->bit);
	device_id_msb = flash_spi_read(FLASH_DUMMY_CMD, 	srd->done, srd->mosi, srd->enable, srd->miso, srd->bit);
	device_id_lsb = flash_spi_read(FLASH_DUMMY_CMD, 	srd->done, srd->mosi, srd->enable, srd->miso, srd->bit);
	usi_write(srd->cs, 0xffffffff);

	return (mfr_id << 16) | (device_id_msb << 8) | device_id_lsb;
}


/**-----------------------------------------------------------------------------
 * flash protction reg write
 * id = Sfm ID
 * 
 * 起動時は Program Reg にプロテクトがかかっており、データのRW	には解除が必要
 * S7 SRP0
 * S6 BP3
 * S5 BP2
 * S4 BP1
 * S3 BP0
 * S2 TB
 * WP-E S1
 * S0 SRP1
 *-----------------------------------------------------------------------------*/
void flash_protection_reg_write(uint8_t id)
{
	const SfmRegDB *srd = sfm_reg_db;

	for (uint8_t i = 0; i < SFM_REG_DB_SIZE; i++, srd++) {
		if (srd->id == id) {
			break;
		}
	}

	usi_write(srd->cs, ~srd->bit);
	flash_spi_write(FLASH_PROTECTION_REG_WRITE, 	srd->done, srd->mosi, srd->enable, srd->bit);
	flash_spi_write(FLASH_STATUS_REG1_ADRS, 		srd->done, srd->mosi, srd->enable, srd->bit);
	flash_spi_write(FLASH_PROTECTION_WRITE_VALUE,	srd->done, srd->mosi, srd->enable, srd->bit);
	usi_write(srd->cs, 0xffffffff);
}


/**-----------------------------------------------------------------------------
 * Flash Write Enable Cmd
 *-----------------------------------------------------------------------------*/
static void flash_write_enable_cmd(const SfmRegDB *srd)
{
	usi_write(srd->cs, ~srd->bit);
	flash_spi_write(FLASH_WRITE_ENALE_CMD, srd->done, srd->mosi, srd->enable, srd->bit);
	usi_write(srd->cs, 0xffffffff);
}

/**-----------------------------------------------------------------------------
 * Flash 128KB Block Elase
 * 1Block = 64Page x 2048 col
 * MAX = 1024 Block, 65536 Page
 * 
 * Block elase を実行する場合は、64Page ごとに行う。
 * Program する page は必ず Block elase しなければならない。
 *-----------------------------------------------------------------------------*/
static void flash_block_elase(const SfmRegDB *srd, uint16_t page_adrs)
{
	usi_write(srd->cs, ~srd->bit);
	flash_spi_write(FLASH_BLOCK_ELASE, srd->done, srd->mosi, srd->enable, srd->bit);
	flash_spi_write(FLASH_DUMMY_CMD, srd->done, srd->mosi, srd->enable, srd->bit);
	flash_spi_write(page_adrs >> 8, srd->done, srd->mosi, srd->enable, srd->bit);	// Page adrs "H"
	flash_spi_write(page_adrs, srd->done, srd->mosi, srd->enable, srd->bit);		// Page adrs "L"
	usi_write(srd->cs, 0xffffffff);
}

/**-----------------------------------------------------------------------------
 * Flash Busy Wait
 *-----------------------------------------------------------------------------*/
static void flash_busy_wait(const SfmRegDB *srd)
{
	while (1) {
		usi_write(srd->cs, ~srd->bit);
		flash_spi_write(FLASH_BUSY_WAIT_CHECK, srd->done, srd->mosi, srd->enable, srd->bit);
		flash_spi_write(FLASH_STATUS_REG3_ADRS, srd->done, srd->mosi, srd->enable, srd->bit);

		uint8_t id = flash_spi_read(FLASH_DUMMY_CMD, srd->done, srd->mosi, srd->enable, srd->miso, srd->bit);
		usi_write(srd->cs, 0xffffffff);

		if ((id & 0x01) == 0) {
			break;
		}
	}
}

/**-----------------------------------------------------------------------------
 * Flash Program Data Load Cmd
 * 
 * 基本的には各Page の先頭から Programを行うため、col adrs は "0" を指定する。
 *-----------------------------------------------------------------------------*/
static void flash_program_data_load(const SfmRegDB *srd, uint8_t *wbuff, uint16_t col_adrs, uint16_t len)
{
	usi_write(srd->cs, ~srd->bit);
	flash_spi_write(FLASH_PROGRAM_DATA_LOAD, srd->done, srd->mosi, srd->enable, srd->bit);	// Program Data Load Cmd
	flash_spi_write(col_adrs >> 8, srd->done, srd->mosi, srd->enable, srd->bit);				// col adrs "H"
	flash_spi_write(col_adrs, srd->done, srd->mosi, srd->enable, srd->bit);					// col adrs "L"

	for (uint16_t i = 0; i < len; i++) {
		flash_spi_write(wbuff[i], srd->done, srd->mosi, srd->enable, srd->bit);
	}

	usi_write(srd->cs, 0xffffffff);
}

/**-----------------------------------------------------------------------------
 * Flash Program Data Execute
 *-----------------------------------------------------------------------------*/
static void flash_program_data_execute(const SfmRegDB *srd, uint16_t page_adrs)
{
	usi_write(srd->cs, ~srd->bit);
	flash_spi_write(FLASH_PROGRAM_DATA_EXECUTE, srd->done, srd->mosi, srd->enable, srd->bit);
	flash_spi_write(FLASH_DUMMY_CMD, srd->done, srd->mosi, srd->enable, srd->bit);
	flash_spi_write(page_adrs >> 8, srd->done, srd->mosi, srd->enable, srd->bit);	// Page adrs "H"
	flash_spi_write(page_adrs, srd->done, srd->mosi, srd->enable, srd->bit);		// Page adrs "L"
	usi_write(srd->cs, 0xffffffff);
}

/**-----------------------------------------------------------------------------
 * Flash Page Read
 *-----------------------------------------------------------------------------*/
static void flash_page_read(const SfmRegDB *srd, uint16_t page_adrs)
{
	usi_write(srd->cs, ~srd->bit);
	flash_spi_write(FLASH_PROGRAM_PAGE_READ, srd->done, srd->mosi, srd->enable, srd->bit);
	flash_spi_write(FLASH_DUMMY_CMD, srd->done, srd->mosi, srd->enable, srd->bit);
	flash_spi_write(page_adrs >> 8, srd->done, srd->mosi, srd->enable, srd->bit);	// Page adrs "H"
	flash_spi_write(page_adrs, srd->done, srd->mosi, srd->enable, srd->bit);		// Page adrs "L"
	usi_write(srd->cs, 0xffffffff);
}

/**-----------------------------------------------------------------------------
 * Flash Page Read
 * 
 * 基本的には各Page の先頭から read を行うため、col adrs は "0" を指定する。
 *-----------------------------------------------------------------------------*/
static void flash_read_data(const SfmRegDB *srd, uint8_t *rbuff, uint16_t col_adrs, uint16_t len)
{
	usi_write(srd->cs, ~srd->bit);
	flash_spi_write(FLASH_READ_DATA_CMD, srd->done, srd->mosi, srd->enable, srd->bit);
	flash_spi_write(col_adrs >> 8, srd->done, srd->mosi, srd->enable, srd->bit);	// col adrs "H"
	flash_spi_write(col_adrs, srd->done, srd->mosi, srd->enable, srd->bit);		// col adrs "L"
	flash_spi_write(FLASH_DUMMY_CMD, srd->done, srd->mosi, srd->enable, srd->bit);

	for (uint16_t i = 0; i < len; i++) {
		rbuff[i] = flash_spi_read(FLASH_DUMMY_CMD, srd->done, srd->mosi, srd->enable, srd->miso, srd->bit);
	}

	usi_write(srd->cs, 0xffffffff);
}


/**-----------------------------------------------------------------------------
 * FPGA の SPI Block を制御し SPI Write 信号を発行
 * mosi = 1byte の送信データ
 *-----------------------------------------------------------------------------*/
static void flash_spi_write(uint8_t mosi, uint32_t done_adrs, uint32_t mosi_adrs, uint32_t enable_adrs, uint8_t bit)
{
	usi_write(done_adrs, 0);		// Done(Intr) Clear
	usi_write(mosi_adrs, mosi);		// MOSI Send
	usi_write(enable_adrs, bit);	// Spi Enable

	while (1) {
		if (bit == usi_read(done_adrs)) {	// Intr Wait
			break;
		}
	}
}

/**-----------------------------------------------------------------------------
 * FPGA の SPI Block を制御し SPI Read 信号を発行
 * mosi = 1byte の送信データ
 *-----------------------------------------------------------------------------*/
static uint8_t flash_spi_read(uint8_t mosi, uint32_t done_adrs, uint32_t mosi_adrs, uint32_t enable_adrs, uint32_t miso_adrs, uint8_t bit)
{
	usi_write(done_adrs, 0);		// Done(Intr) Clear
	usi_write(mosi_adrs, mosi);		// MOSI Send
	usi_write(enable_adrs, bit);	// Spi Enable

	 while (1) {
	 	if (bit == usi_read(done_adrs)) {	// Intr Wait
	 		break;
	 	}
	 }

	return usi_read(miso_adrs);
}