/*------------------------------------------------------------------------------
 * Create  2024/08/02
 * Author  Kouta Kimura
 * Windows 11
 * Visual Studio 2022 
 * SDL2-2.30.6
 * 
 * SDL��p�����摜�ǂݍ��݃t�@�C���v���O����
 * ./program �摜�t�@�C����.�g���q
 * 
 * �����摜�t�@�C���̉���
 * RGB�̃J���[�摜
 * 1��f��R.G.B������1�o�C�g�ł��邱��
 * �摜�f�[�^�͌��ԂȂ�����ł��邱��
 * R.G.B�̏��ԂɃf�[�^���i�[����Ă��邱��
 *-----------------------------------------------------------------------------*/

 /**---------------------------------------------------------------------------
  * �C���N���[�h�t�@�C��
  * ---------------------------------------------------------------------------*/
#define _CRT_SECURE_NO_WARNINGS
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdint.h>
#include <stdbool.h>
#include <tchar.h>
#include <SDL.h>
#include <SDL_image.h>
#include <Windows.h>



/**-----------------------------------------------------------------------------
 * HD�掿�A1280 x 3 x 15��ʂ̃f�[�^�e�ʂ𒴂���ꍇ
 * N_POS�̏搔�𑝂₷
 *-----------------------------------------------------------------------------*/
#define BUFFER_SIZE 	(1920 * 1080)
#define CUT_LINE_MAX	(32)
#define WINDOW_WIDTH	(800)
#define WINDOW_HEIGHT	(600)
#define ID_TEXTBOX1		(101)
#define ID_TEXTBOX2		(102)
#define	ID_TEXTBOX3		(103)
#define	ID_TEXTBOX4		(104)
#define	ID_TEXTBOX5		(105)
#define ID_BUTTON1		(1)
#define ID_BUTTON2		(2)
#define TEXT_BUFFER_SIZE (64)

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
 * Global �C���X�^���X
 *-----------------------------------------------------------------------------*/
SDL_Surface* image;
SDL_PixelFormat* fmt;
FILE* fp;
HANDLE gFile;
HINSTANCE hInst;
TCHAR gMessageBuffer[1024];


/**-----------------------------------------------------------------------------
 * �v���g�^�C�v�錾
 *-----------------------------------------------------------------------------*/
HANDLE file_create(HWND hWnd, char* path, char* dir_path);
bool mapchip_info_eoc(uint8_t xpos, uint8_t* id_buff);
uint32_t mapchip_pixel_gen(uint32_t alpha, uint32_t red, uint32_t green, uint32_t blue, uint32_t type, uint32_t color_bit);
uint32_t mapchip_color_upload(PixelInfo* info, uint8_t* color, uint8_t* sdl_pixe, uint32_t byte_per_pixel);
void mapchip_file_save(PixelInfo* info, uint8_t* color, uint32_t wmax, uint32_t byte_per_pixel);
void mapchip_info_save(PixelInfo* info);
void pixel_generate(PixelInfo pinfo);
static int sdl_init(HWND hWnd);
static void append_to_buffer(HWND hWnd, TCHAR msg_buffer[], TCHAR add_str[]);

/**-----------------------------------------------------------------------------
 * �E�B���h�E�v���V�[�W���̃R�[���o�b�N�֐�
 *-----------------------------------------------------------------------------*/
LRESULT CALLBACK WindowProcedure(HWND, UINT, WPARAM, LPARAM);


/**-----------------------------------------------------------------------------
 * �����ݒ�֐�
 *
 * *path
 * �摜�f�[�^�̃p�X�����
 *-----------------------------------------------------------------------------*/
HANDLE file_create(HWND hWnd, char* path, char* dir_path)
{
	char create_file[256] = "";
	strcat(create_file, path);
	size_t file_path_len = _tcslen(create_file);
	create_file[file_path_len - 3] = 'd';
	create_file[file_path_len - 2] = 'a';
	create_file[file_path_len - 1] = 't';

	image = IMG_Load(path);

	if (NULL == image) {
		MessageBox(hWnd, _T("�t�@�C���̓ǂݍ��݂Ɏ��s���܂����B"), _T("�G���["), MB_OK | MB_ICONERROR);

		return INVALID_HANDLE_VALUE;
	}

	/* �t�@�C���̃I�[�v���ƃG���[�`�F�b�N */
	gFile = CreateFile(
		create_file,				// �t�@�C����
		GENERIC_WRITE,              // �������݃A�N�Z�X
		0,                          // ���L���[�h
		NULL,                       // �Z�L�����e�B����
		CREATE_ALWAYS,              // �쐬���@
		FILE_ATTRIBUTE_NORMAL,      // �t�@�C������
		NULL);                      // �e���v���[�g�t�@�C��

	if (gFile == INVALID_HANDLE_VALUE) {
		MessageBox(hWnd, _T("�t�@�C���쐬�Ɏ��s���܂����B"), _T("�G���["), MB_OK | MB_ICONERROR);
		return INVALID_HANDLE_VALUE;
	}

	return gFile;
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
				// fprintf(fp, "%04x\n", pixel);
			}
			else
			{
				// fprintf(fp, "%08x\n", pixel);
			}
			break;

		default:
			if (info->color_bit == 0) {
				// fprintf(fp, "0x%04x\n", pixel);
			}
			else
			{
				// fprintf(fp, "0x%08x\n", pixel);
			}
			break;
		}
	}

	// fprintf(stderr, "ID = %3d,  �}�b�v�`�b�v�̃T�C�Y = %4d\n", info->id_cnt, wmax / byte_per_pixel);

	if (info->memory_type == 0) {	//�}�b�v�`�b�v�f�[�^�̐؂��肪�I����������s����
		// fprintf(fp, "\n");
	}
}

/**-----------------------------------------------------------------------------
 * MapChip Info Save
 * �p�����[�^�ݒ��ǉ�����ꍇ�́A���̊֐����ɏ����ǉ�
 *-----------------------------------------------------------------------------*/
void mapchip_info_save(PixelInfo* info)
{
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
void pixel_generate(PixelInfo pinfo)
{
	PixelInfo info = pinfo;
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

	//fclose(fp);
	SDL_Quit();
}

/**-----------------------------------------------------------------------------
 * SDL �摜�f�[�^�ǂݍ��ݐݒ�
 *-----------------------------------------------------------------------------*/
static int sdl_init(HWND hWnd)
{
	int32_t flags = IMG_INIT_JPG | IMG_INIT_PNG;
	int32_t initted = IMG_Init(flags);

	if ((initted & flags) != flags) {		// png jpg���g�p�\�ɂ���
		MessageBox(hWnd, _T("SDL Init 0 �������Ɏ��s���܂���"), _T("�G���["), MB_OK | MB_ICONERROR);
		return 1;
	}

	if (SDL_Init(SDL_INIT_EVERYTHING) != 0) {
		MessageBox(hWnd, _T("SDL Init 1 �������Ɏ��s���܂���"), _T("�G���["), MB_OK | MB_ICONERROR);
		return 1;
	}

	return 0;
}


/**-----------------------------------------------------------------------------
 * main�֐�
 *-----------------------------------------------------------------------------*/
int WINAPI WinMain(
	HINSTANCE hInstance,
	HINSTANCE hPrevInstance,
	LPSTR lpCmdLine,
	int nCmdShow)
{
	WNDCLASSW wc = { 0 };
	wc.hbrBackground = (HBRUSH)COLOR_WINDOW;
	wc.hCursor = LoadCursor(NULL, IDC_ARROW);
	wc.hInstance = hInst;
	wc.lpszClassName = L"myWindowClass";
	wc.lpfnWndProc = WindowProcedure;

	if (!RegisterClassW(&wc))
		return -1;

	// main window �̐���
	CreateWindowW(L"myWindowClass", L"Mapchip Edit", WS_OVERLAPPEDWINDOW | WS_VISIBLE,
		100, 100, 800, 600, NULL, NULL, NULL, NULL);

	//szWindowClass,					// �A�v���P�[�V�����̖��O
	//	szTitle,						// �^�C�g���o�[�Ɍ���镶����
	//	WS_OVERLAPPEDWINDOW,			// ��������E�B���h�E�̃^�C�v
	//	CW_USEDEFAULT, CW_USEDEFAULT,	// �ŏ��ɒu���|�W�V���� (x, y)
	//	WINDOW_WIDTH, WINDOW_HEIGHT,	// �ŏ��̃T�C�Y (��, ����)
	//	NULL,							// ���̃E�B���h�E�̐e�E�B���h�E�̃n���h��
	//	NULL,							// ���j���[�o�[�i���̃T���v���ł͎g�p�����j
	//	hInstance,						// WinMain�֐��̍ŏ��̃p�����[�^
	//	NULL							// WM_CREATE���i���̃A�v���P�[�V�����ł͎g�p�����j
	//ShowWindow(hWnd, nCmdShow);
	
	MSG msg = { 0 };

	while (GetMessage(&msg, NULL, NULL, NULL)) {
		TranslateMessage(&msg);
		DispatchMessage(&msg);
	}
	return 0;
}

/**-----------------------------------------------------------------------------
 * �E�B���h�E�v���V�[�W���i���b�Z�[�W�ɑ΂���R�[���o�b�N�֐��j
 *-----------------------------------------------------------------------------*/
LRESULT CALLBACK WindowProcedure(HWND hWnd, UINT message, WPARAM wParam, LPARAM lParam)
{
	static HWND hEdit1, hEdit2, hEdit3, hEdit4;
	PAINTSTRUCT ps;
	HDC hdc;
	RECT textRect;
	WCHAR width_window_str[] = L"Width �� Pixel ������؂���W�����";
	WCHAR height_window_str[] = L"Height �� Pixel ������؂���W�����";
	WCHAR rom_window_str[] = L"�f�[�^�̕ۑ��`�� 0=Flash Memory, 1=BRAM";
	WCHAR clip_window_str[] = L"�g�p����摜���C����I�� �����A���p�A�����̕��s�摜 = ID 1,2,3 �Ƃ����Ƃ��A���p���΂������ꍇ�� 13 �Ɠ��͂��Ă��������B";
	static TCHAR window_message[TEXT_BUFFER_SIZE] ="ABCDEFGHJKI\n";
	static TCHAR file_path[260];
	TCHAR dir[] = "raw\\";
	TCHAR ADD[TEXT_BUFFER_SIZE] = "1234\n";

	switch (message)
	{
	case WM_CREATE: // ��ʂ̐���
		// ����
		CreateWindowW(L"static", width_window_str, WS_VISIBLE | WS_CHILD,
			100, 20, 500, 20, hWnd, NULL, NULL, NULL);
		hEdit1 = CreateWindowW(L"edit", L"", WS_VISIBLE | WS_CHILD | WS_BORDER | ES_NUMBER,
			20, 20, 60, 20, hWnd, (HMENU)ID_TEXTBOX1, NULL, NULL);

		// �c��
		CreateWindowW(L"static", height_window_str, WS_VISIBLE | WS_CHILD,
			100, 60, 500, 20, hWnd, NULL, NULL, NULL);
		hEdit2 = CreateWindowW(L"edit", L"", WS_VISIBLE | WS_CHILD | WS_BORDER | ES_NUMBER,
			20, 60, 60, 20,  hWnd, (HMENU)ID_TEXTBOX2, NULL, NULL);

		// �������\���I��
		CreateWindowW(L"static", rom_window_str, WS_VISIBLE | WS_CHILD,
			100, 100, 500, 20, hWnd, NULL, NULL, NULL);
		hEdit3 = CreateWindowW(L"edit", L"", WS_VISIBLE | WS_CHILD | WS_BORDER | ES_NUMBER,
			20, 100, 60, 20,  hWnd, (HMENU)ID_TEXTBOX3, NULL, NULL);

		// �ǂݍ��݃f�[�^�I��
		CreateWindowW(L"static", clip_window_str, WS_VISIBLE | WS_CHILD,
			100, 140, 500, 40, hWnd, NULL, NULL, NULL);
		hEdit4 = CreateWindowW(L"edit", L"", WS_VISIBLE | WS_CHILD | WS_BORDER | ES_NUMBER,
			20, 140, 60, 20, hWnd, (HMENU)ID_TEXTBOX4, NULL, NULL);

		// �t�@�C���I���{�^��
		CreateWindowW(L"button", L"�t�@�C���I��", WS_TABSTOP | WS_VISIBLE | WS_CHILD | BS_DEFPUSHBUTTON,
			20, 180, 120, 25,
			hWnd, (HMENU)ID_BUTTON1, (HINSTANCE)GetWindowLongPtr(hWnd, GWLP_HINSTANCE), NULL);

		// �J�n�{�^��
		CreateWindowW(L"button", L"�J�n", WS_TABSTOP | WS_VISIBLE | WS_CHILD | BS_DEFPUSHBUTTON,
			20, 220, 120, 25,
			hWnd, (HMENU)ID_BUTTON2, (HINSTANCE)GetWindowLongPtr(hWnd, GWLP_HINSTANCE), NULL);

		break;

	case WM_COMMAND: // �{�^�����̓C�x���g
		switch (LOWORD(wParam)) {
		case ID_BUTTON1:
			OPENFILENAME ofn;
			ZeroMemory(&ofn, sizeof(ofn));
			ofn.lStructSize = sizeof(ofn);
			ofn.hwndOwner = hWnd;
			ofn.lpstrFile = file_path;
			ofn.lpstrFile[0] = '\0'; // �o�b�t�@����ɏ�����
			ofn.nMaxFile = sizeof(file_path) / sizeof(TCHAR); // WCHAR �Ȃ̂ŃT�C�Y����
			ofn.lpstrFilter = "All\0*.*\0Text\0*.TXT\0"; // ���C�h������
			ofn.nFilterIndex = 1;
			ofn.lpstrFileTitle = NULL;
			ofn.nMaxFileTitle = 0;
			ofn.lpstrInitialDir = NULL;
			ofn.Flags = OFN_PATHMUSTEXIST | OFN_FILEMUSTEXIST;

			// �t�@�C���I���_�C�A���O��\��
			if (GetOpenFileName(&ofn)) {
				// �I�����ꂽ�t�@�C���̃p�X���擾���Ďg�p����
				//MessageBox(hWnd, ofn.lpstrFile, "Selected File", MB_OK);
			}

			file_create(hWnd, ofn.lpstrFile, dir);
			//InvalidateRect(hWnd, NULL, TRUE); // �E�B���h�E�̍ĕ`���v��
			//UpdateWindow(hWnd);
			break;

		case ID_BUTTON2:
			PixelInfo pinfo;
			GetWindowText(hEdit1, gMessageBuffer, 256);
			pinfo.pixel_wid = atoi(gMessageBuffer);

			GetWindowText(hEdit2, gMessageBuffer, 256);
			pinfo.pixel_hei= atoi(gMessageBuffer);

			GetWindowText(hEdit3, gMessageBuffer, 256);
			pinfo.memory_type = atoi(gMessageBuffer);

			GetWindowText(hEdit4, gMessageBuffer, 256);
			pinfo.cut_line = atoi(gMessageBuffer);

			//sprintf(gMessageBuffer, "Values entered: %d, %d, %d", value1, value2, value3);
			//MessageBox(hWnd, gMessageBuffer, "Input Values", MB_OK);
			// sdl_init();
			sdl_init(hWnd);
			pixel_generate(pinfo);
			append_to_buffer(hWnd, window_message, ADD);
			CloseHandle(gFile); // �t�@�C�������
		default:
			break;
		}

	case WM_PAINT:
		//GetClientRect(hWnd, &rect);

		hdc = BeginPaint(hWnd, &ps);	//  �`�揈���̊J�n
		textRect.left = 20;
		textRect.top = 300;
		textRect.right = 600;
		textRect.bottom = 600;
		DrawText(hdc, window_message, -1, &textRect, /*DT_WORDBREAK*/DT_LEFT | DT_TOP | DT_NOCLIP);
		EndPaint(hWnd, &ps);	//  �y�C���g�����̏I��
		break;

	case WM_DESTROY:
		//PostQuitMessage(0);
		break;

	default:
		return DefWindowProc(hWnd, message, wParam, lParam);
		break;
	}

	return 0;
}

/**-----------------------------------------------------------------------------
 * ������̍X�V
 *-----------------------------------------------------------------------------*/
static void append_to_buffer(HWND hWnd, TCHAR msg_buffer[], TCHAR add_str[])
{
    size_t msg_len = _tcslen(msg_buffer);
    size_t add_len = _tcslen(add_str);
    
    // �o�b�t�@�������ς��ɂȂ�ꍇ�ɑΉ�
    if (msg_len + add_len >= TEXT_BUFFER_SIZE) {
        // �o�b�t�@�̊J�n�ʒu�����炷
        size_t available_space = TEXT_BUFFER_SIZE - add_len - 1;
        if (available_space < msg_len) {
            memmove(msg_buffer, msg_buffer + (msg_len - available_space), available_space * sizeof(TCHAR));
        }
        msg_len = available_space;
    }
	_tcscat_s(msg_buffer, TEXT_BUFFER_SIZE, add_str);
    
	InvalidateRect(hWnd, NULL, TRUE); // WM_PAINT �̍ĕ`���v��
	UpdateWindow(hWnd);
}