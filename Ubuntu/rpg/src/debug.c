/**-------------------------------------------------
 * デバッグ関数をまとめたファイル
 * -------------------------------------------------*/


/**-------------------------------------------------
 * includeファイル
 * -------------------------------------------------*/
#include <LIB.H>


/**--------------------------------------------
 * デバッグ出力
 * --------------------------------------------
 * arg1: *s    " "の文字列を表示
 * arg2: d     表示データ
 *--------------------------------------------*/
void debug(char *s, int32_t d)
{
    printf("%s = ", s);
    printf("%d\r\n", d);
}


/**--------------------------------------------
 * バイナリデータを表示
 * --------------------------------------------*/
void divprintf(int32_t d)
{
    printf("%d\r\n", d);
}

/**--------------------------------------------
 * 文字データを表示
 * --------------------------------------------*/
void strprintf(char *s)
{
    printf("%s\r\n", s);
}