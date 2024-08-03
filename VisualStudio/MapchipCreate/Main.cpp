/**-------------------------------------------------
 * SDL��p�����摜�ǂݍ��݃t�@�C���v���O����
 * �摜�t�@�C�����L�́A�w�b�_�E���k�E�t�@�C���̎�ނȂǂ̔�����s���Ă����
 * Ubuntu LTS 20.04 kimura
 * -------------------------------------------------
 * ���s���@
 * ./program �摜�t�@�C����.�g���q
 * -------------------------------------------------
 * �����摜�t�@�C���̉���
 * RGB�̃J���[�摜
 * 1��f��R.G.B������1�o�C�g�ł��邱��
 * �摜�f�[�^�͌��ԂȂ�����ł��邱��
 * R.G.B�̏��ԂɃf�[�^���i�[����Ă��邱��
 * -------------------------------------------------*/

 /**-------------------------------------------------
  * �C���N���[�h�t�@�C��
  * -------------------------------------------------*/
#define _CRT_SECURE_NO_WARNINGS
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdint.h>
#include <stdbool.h>
#include <SDL.h>
#include <SDL_image.h>
#include <Windows.h>


/**-----------------------------------------------------------------------------
 * HD�掿�A1280 x 3 x 15��ʂ̃f�[�^�e�ʂ𒴂���ꍇ
 * N_POS�̏搔�𑝂₷
 *-----------------------------------------------------------------------------*/
#define BUFFER_SIZE 	(1920 * 1080)
#define CUT_LINE_MAX	(32)

 /**-----------------------------------------------------------------------------
  * RGB�����^�C�v
  *-----------------------------------------------------------------------------*/
typedef enum
{
	XILINX,
	DEFAULT,
} RGB_TYPE;


/**-----------------------------------------------------------------------------
 * Pixel Info �\����
 *-----------------------------------------------------------------------------*/
typedef struct {
	uint32_t pixel_wid;			// 1�摜�� X���̐؂���̈�w��
	uint32_t pixel_hei;			// 1�摜�� Y���̐؂���̈�w��
	uint32_t type;				// RGB �f�[�^�̕��я��w��
	uint32_t color_bit;			// 1pixel �� Bit�����w��
	uint32_t memory_type;		// �������̃t�H�[�}�b�g�w��
	uint32_t id_cnt;			// �؂蔲���̈�� ID ������U��B�f�o�b�O�p�r�B
	uint32_t ypixel_cut;
	uint32_t xpixel_cut;
	uint32_t cut_line;
	uint8_t cut_line_buff[CUT_LINE_MAX];
} PixelInfo;


/**-----------------------------------------------------------------------------
 * Global
 *-----------------------------------------------------------------------------*/
SDL_Surface* image;
SDL_PixelFormat* fmt;
FILE* fp;


/**-----------------------------------------------------------------------------
 * �v���g�^�C�v�錾
 *-----------------------------------------------------------------------------*/
void error_fprintf(const char* s, int line);
int system_init(char* path, char* dir_path);
bool mapchip_info_eoc(uint8_t xpos, uint8_t* id_buff);
uint32_t mapchip_pixel_gen(uint32_t alpha, uint32_t red, uint32_t green, uint32_t blue, uint32_t type, uint32_t color_bit);
uint32_t mapchip_color_upload(PixelInfo* info, uint8_t* color, uint8_t* sdl_pixe, uint32_t byte_per_pixel);
void mapchip_file_save(PixelInfo* info, uint8_t* color, uint32_t wmax, uint32_t byte_per_pixel);
void mapchip_info_save(PixelInfo* info);
void pixel_generate(void);
static void sdl_init(void);


/**-----------------------------------------------------------------------------
 * �G���[�����֐�
 *-----------------------------------------------------------------------------*/
void error_fprintf(const char* s, int line)
{
	fprintf(stderr, "[Line] = %d\n", line);
	fprintf(stderr, "[func] = %s\n", s);
}


/**-----------------------------------------------------------------------------
 * �����ݒ�֐�
 *
 * *path
 * �摜�f�[�^�̃p�X�����
 *-----------------------------------------------------------------------------*/
int system_init(char* path, char* dir_path)
{
	char filename[256];
	char raw[] = ".raw";
	char dat[] = ".dat";
	uint32_t count = 0;
	uint32_t file_type;

	/* ��̓t�@�C���̃G���[�`�F�b�N */
	if (!path) {
		fprintf(stderr, "img load error\n");
		error_fprintf(__func__, __LINE__);
		return 1;
	}

	/* �摜�f�[�^�̃I�[�v���ƃG���[�`�F�b�N */
	image = IMG_Load(path);

	if (image == NULL) {
		fprintf(stderr, "img open error\n");
		error_fprintf(__func__, __LINE__);
		return 1;
	}

	/* �g���q�܂ŃA�h���X���X�V */
	do
	{
		path++;
	} while (*path != '.');

	/* �p�X�̋�؂�܂ŃA�h���X��߂� */
	do
	{
		path--;
	} while (*path != '/');

	/* '/'�̎��̃A�h���X����t�@�C�����̂ݒ��o */
	path++;
	while (path[count] != '.')
	{
		filename[count] = path[count];
		count++;
	}

	fprintf(stderr, "\n");
	fprintf(stderr, "�쐬����t�@�C���̊g���q��I�����ĉ������B\n");
	fprintf(stderr, "0 = raw, 1 = dat\n");
	scanf_s("%d", &file_type);

	/* �t�@�C�����Əo�͐�̃p�X�𐶐� */
	strcat(dir_path, filename);

	if (file_type == 0) {
		strcat(dir_path, raw);
	}
	else {
		strcat(dir_path, dat);
	}

	/* �t�@�C���̃I�[�v���ƃG���[�`�F�b�N */
	fp = fopen(dir_path, "wb");

	if (fp == NULL) {
		fprintf(stderr, "File Open error\n");
		error_fprintf(__func__, __LINE__);
		return 1;
	}

	fprintf(stderr, "�f�B���N�g���Ƀt�@�C���𐶐����܂� = %s\n", dir_path);
	fprintf(stderr, "\n");

	return 0;
}


/**-----------------------------------------------------------------------------
 * �w�肵���摜�f�[�^�̂��蔲���̈���`�F�b�N
 *-----------------------------------------------------------------------------*/
bool mapchip_info_eoc(uint8_t xpos, uint8_t* id_buff)
{
	for (uint8_t i = 0; i < CUT_LINE_MAX; i++) {
		if (xpos == id_buff[i]) {
			return true;
		}
	}

	return false;
}

/**-----------------------------------------------------------------------------
 * �w��͈͂̃}�b�v�`�b�v�f�[�^�擾
 *-----------------------------------------------------------------------------*/
 // void mapchip_pixel_get()
 // {
 // 	uint32_t wpos   = 0;
 // 	uint32_t id_cnt = x + (y * (image->w / pixel_wid));
 // 	uint32_t xpixel = x * pixel_wid * fmt->BytesPerPixel;

 // 	/* �w��͈͂̃}�b�v�`�b�v�f�[�^�擾 */
 // 	for (uint32_t j = 0; j < pixel_hei; j++)
 // 	{
 // 		uint32_t cuty = j * image->w * fmt->BytesPerPixel;
 // 		for (uint32_t i = 0; i < pixel_wid; i++)
 // 		{
 // 			uint32_t cutx = i * fmt->BytesPerPixel;
 // 			for (uint32_t x = 0; x < fmt->BytesPerPixel; x++)
 // 			{
 // 				uint32_t pos = x + cutx + cuty + xpixel + ypixel;
 // 				color[wpos] = p[pos];
 // 				wpos++;
 // 			}
 // 		}
 // 	}
 // }



 /*
  * RGB���`��
  *
  * type
  * RGB�̐����p�^�[����I��
  */
uint32_t mapchip_pixel_gen(uint32_t alpha, uint32_t red, uint32_t green, uint32_t blue, uint32_t type, uint32_t color_bit)
{
	uint32_t pixel;
	uint8_t msb;
	uint8_t lsb;

	switch (color_bit) {
	case 0:
		msb = 4;
		lsb = 4;
		break;

	default:
		msb = 8;
		lsb = 0;
		break;
	}

	switch (type) {
	case XILINX:
		pixel = alpha >> lsb;
		pixel = (pixel << msb) | (red >> lsb);
		pixel = (pixel << msb) | (blue >> lsb);
		pixel = (pixel << msb) | (green >> lsb);
		break;

	default:
		pixel = alpha >> lsb;
		pixel = (pixel << msb) | (red >> lsb);
		pixel = (pixel << msb) | (green >> lsb);
		pixel = (pixel << msb) | (blue >> lsb);
		break;
	}

	return pixel;
}

/**-----------------------------------------------------------------------------
 * MapChip �F�f�[�^���o
 *-----------------------------------------------------------------------------*/
uint32_t mapchip_color_upload(PixelInfo* info, uint8_t* color, uint8_t* sdl_pixel, uint32_t byte_per_pixel)
{
	uint32_t wpos = 0;

	for (uint32_t y = 0; y < info->pixel_hei; y++) { // �w��͈͂̃}�b�v�`�b�v�f�[�^�擾
		uint32_t cuty = y * image->w * byte_per_pixel;

		for (uint32_t x = 0; x < info->pixel_wid; x++) {
			uint32_t cutx = x * byte_per_pixel;

			for (uint32_t rgbx = 0; rgbx < byte_per_pixel; rgbx++) {	// 1pixel �� RGB �v�f�����o��
				uint32_t pos = rgbx + cutx + cuty + info->xpixel_cut + info->ypixel_cut;
				color[wpos] = sdl_pixel[pos];
				wpos++;
			}
		}
	}

	return wpos;
}

/**-----------------------------------------------------------------------------
 * MapChip RGB �f�[�^�̃t�@�C���o��
 *-----------------------------------------------------------------------------*/
void mapchip_file_save(PixelInfo* info, uint8_t* color, uint32_t wmax, uint32_t byte_per_pixel)
{
	for (uint32_t x = 0; x < wmax; x = x + byte_per_pixel)
	{
		uint32_t pixel;

		if (byte_per_pixel == 3)
		{
			pixel = mapchip_pixel_gen(0xff, color[x + 2], color[x + 1], color[x], info->type, info->color_bit);
		}
		else
		{
			pixel = mapchip_pixel_gen(color[x + 3], color[x], color[x + 1], color[x + 2], info->type, info->color_bit);
		}

		switch (info->memory_type) {
		case 0:
			if (info->color_bit == 0) {
				fprintf(fp, "%04x\n", pixel);
			}
			else
			{
				fprintf(fp, "%08x\n", pixel);
			}
			break;

		default:
			if (info->color_bit == 0) {
				fprintf(fp, "0x%04x\n", pixel);
			}
			else
			{
				fprintf(fp, "0x%08x\n", pixel);
			}
			break;
		}
	}

	fprintf(stderr, "ID = %3d,  �}�b�v�`�b�v�̃T�C�Y = %4d\n", info->id_cnt, wmax / byte_per_pixel);

	if (info->memory_type == 0) {	//�}�b�v�`�b�v�f�[�^�̐؂��肪�I����������s����
		fprintf(fp, "\n");
	}
}

/**-----------------------------------------------------------------------------
 * MapChip Info Save
 * �p�����[�^�ݒ��ǉ�����ꍇ�́A���̊֐����ɏ����ǉ�
 *-----------------------------------------------------------------------------*/
void mapchip_info_save(PixelInfo* info)
{
	/* �摜�f�[�^�̏��o�� */
	fprintf(stderr, "�摜�t�@�C���̃f�[�^�v���W�F�N�g�Ŏg�p���� RAW ���� dat �t�@�C���𐶐����܂��B\n");
	fprintf(stderr, "�Ȃ��A�s���l����͂����ꍇ�̃G���[�͏����͍s���Ă��܂���B\n");
	fprintf(stderr, "�������t�@�C������������܂���̂Œ��ӂ��Ă��������B\n");
	fprintf(stderr, "\n");
	fprintf(stderr, "----------------------------------------------\n");
	fprintf(stderr, "�ǂݍ��񂾉摜�t�@�C���� Info ���o�͂��܂��B\n");
	fprintf(stderr, "height   = %d\n", image->h);
	fprintf(stderr, "width    = %d\n", image->w);
	fprintf(stderr, "fmt->BytesPerPixel = %dBytes\n", fmt->BytesPerPixel);
	fprintf(stderr, "fmt->BitsPerPixel  = %dbit\n", fmt->BitsPerPixel);
	fprintf(stderr, "\n");

	/* �摜�f�[�^�̐؂�����W��RGB�����p�^�[���I�� */
	fprintf(stderr, "Width��Pixel������؂���W�����ĉ������B\n");
	fprintf(stderr, "0�܂���width�ȏ�̏ꍇ�A�ő�l��ݒ肵�܂��B\n");
	scanf_s("%d", &info->pixel_wid);
	fprintf(stderr, "PixelWidth = %d\n", info->pixel_wid);
	fprintf(stderr, "\n");
	fprintf(stderr, "----------------------------------------------\n");
	fprintf(stderr, "Height��Pixel������؂���W�����ĉ������B\n");
	fprintf(stderr, "0�܂���height�ȏ�̏ꍇ�A�ő�l��ݒ肵�܂��B\n");
	scanf_s("%d", &info->pixel_hei);
	fprintf(stderr, "PixelHeight = %d\n", info->pixel_hei);
	fprintf(stderr, "\n");
	fprintf(stderr, "----------------------------------------------\n");
	fprintf(stderr, "RGB�̐����^�C�v���w�肵�ĉ������B\n");
	fprintf(stderr, "0 = RBG, 1 = RGB\n");
	scanf_s("%d", &info->type);
	fprintf(stderr, "PixelType = %d\n", info->type);
	fprintf(stderr, "\n");
	fprintf(stderr, "----------------------------------------------\n");
	fprintf(stderr, "ARGB��Bit����I�����ĉ�����\n");
	fprintf(stderr, "0 = 4Bit, 1 = 8Bit\n");
	scanf_s("%d", &info->color_bit);
	fprintf(stderr, "\n");
	fprintf(stderr, "----------------------------------------------\n");
	fprintf(stderr, "�f�[�^�̕ۑ��`����I�����ĉ������B\n");
	fprintf(stderr, "0 = Flash Memory, 1 = FPGA Block RAM\n");
	scanf_s("%d", &info->memory_type);
	fprintf(stderr, "\n");
	fprintf(stderr, "----------------------------------------------\n");
	fprintf(stderr, "�g�p����摜���C���̑I�������܂��B\n");
	fprintf(stderr, "0 �̏ꍇ���ׂẴ��C����ǂݎ��܂��B\n");
	fprintf(stderr, "�����A���p�A�����̕��s�摜 = ID 1,2,3 �Ƃ����Ƃ��A���p���΂������ꍇ�� 13 �Ɠ��͂��Ă��������B \n");
	fprintf(stderr, "�ȍ~�� 4,5,6 ���C�����g�p����ꍇ�́A13456 �Ɠ��͂��܂��B\n");
	fprintf(stderr, "0 = AllLine, 123456 -> 135 CutLine\n");
	scanf_s("%d", &info->cut_line);

	if (info->cut_line != 0) {
		uint32_t dec = 1;

		for (uint8_t i = 0; i < image->w / info->pixel_wid; i++) {
			dec *= 10;
		}

		for (uint8_t i = image->w / info->pixel_wid; i > 0; i--) {
			info->cut_line_buff[i] = info->cut_line / dec;
			info->cut_line %= dec;
		}
	}
	else {
		for (uint8_t i = 0; i < CUT_LINE_MAX; i++) {
			info->cut_line_buff[i] = i;
		}
	}

	for (uint8_t i = 0; i < image->w / info->pixel_wid; i++) {
		printf("0x%x\n", info->cut_line_buff[i]);
	}
}


/*
 * �摜�f�[�^�̓ǂݍ���
 *
 * 1. �摜�f�[�^�̐擪�A�h���X�擾
 * 2. �����A�c���̍ő�l���擾
 * 3. �摜�����t�@�C���ɏo��
 * 4. 1pixel�̍ő�o�C�g�����f�[�^�𐶐��A(RGB24bit = 3bytes)
 *
 * �F�f�[�^�̕��я��� RGB�ł���A�g�p����XilinxIP�� RBG�̂��߃f�[�^��������ѕς��Ȃ���s��
 */
void pixel_generate(void)
{
	PixelInfo info;
	uint8_t color[BUFFER_SIZE];
	uint8_t* sdl_pixel;
	uint32_t wpos;	// Color Buffer WP

	fmt = image->format;
	SDL_LockSurface(image);
	sdl_pixel = ((uint8_t*)image->pixels);
	SDL_UnlockSurface(image);
	mapchip_info_save(&info);

	for (uint32_t y = 0; y < image->h / info.pixel_hei; y++)
	{
		info.ypixel_cut = y * info.pixel_hei * image->w * fmt->BytesPerPixel; // �摜�̐؂��� Y���W�v�Z

		for (uint32_t x = 0; x < image->w / info.pixel_wid; x++)
		{
			if (false == mapchip_info_eoc(x, info.cut_line_buff)) {
				continue;
			}

			info.xpixel_cut = x * info.pixel_wid * fmt->BytesPerPixel;	// �摜�̐؂��� x���W�v�Z
			info.id_cnt = x + (y * (image->w / info.pixel_wid));		// �؂�����W��ID�Z�o
			wpos = mapchip_color_upload(&info, color, sdl_pixel, fmt->BitsPerPixel);
			mapchip_file_save(&info, color, wpos, fmt->BitsPerPixel);
		}
	}

	fclose(fp);
	SDL_Quit();
}

/*
 * ver1. 2021/07/10
 * sdl��png�ݒ�
 */
static void sdl_init(void)
{
	int32_t flags = IMG_INIT_JPG | IMG_INIT_PNG;
	int32_t initted = IMG_Init(flags);

	if ((initted & flags) != flags) {		// png jpg���g�p�\�ɂ���
		fprintf(stderr, "IMG Init: %s\n", IMG_GetError());
	}

	if (SDL_Init(SDL_INIT_EVERYTHING) != 0) {
		fprintf(stderr, "SDL Init ERROR!: %s\n", SDL_GetError());
	}

	fprintf(stderr, "SDL �̏����ݒ肪�������܂���\n");
}


/*
 * main�֐�
 */
int main(int argc, char** argv)
{
	char dir_path[256] = "./raw/";	// file �ۑ��f�B���N�g��

	if (0 != system_init(argv[1], dir_path)) {
		fprintf(stderr, "�����Ƀt�@�C����I�����Ă��������B\n");
		SDL_Quit();
		return 1;
	}

	sdl_init();
	pixel_generate();
	fprintf(stderr, "�t�@�C�����o�͂��܂��� %s\n", dir_path);

	return 0;
}
