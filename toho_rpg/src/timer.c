/**-------------------------------------------------
 * 時間操作ファイル
 * -------------------------------------------------
 * Ubuntu LTS 20.04 kimura
 * -------------------------------------------------*/

#include "../include/LIB.H"
#include <sys/time.h>


/**-------------------------------------------------
 * 構造体定義
 * -------------------------------------------------*/
struct timeval TimeAll;


/*-----------------------------------------------------
 * 現在時刻の取得を行う
 *----------------------------------------------------*/
long gettime(void)
{
    gettimeofday(&TimeAll,NULL);	//現在の時間取得
	return ((TimeAll.tv_sec + (TimeAll.tv_usec*1.0E-6))*GETMAXTIME);
}


/*-----------------------------------------------------
 * 指定時間経過の判断を行う
 * ----------------------------------------------------
 * arg1: *t   .long型の時間比較用変数のアドレスを指定
 * arg2: timer.GETMAXTIMEによって引数の値は変更される
 *----------------------------------------------------*/
bool comtimer(long *t, uint32_t timer)
{
	long nowt = gettime();

	if (*t+timer < nowt) {
		*t = nowt;
		return true;
	}
	
	return false;
}


/**-------------------------------------------------
 * 待ち時間関数
 * -------------------------------------------------
 * arg1: timer 待ち時間を指定
 * -------------------------------------------------*/
void waittime(uint32_t timer)
{
	long t = gettime();

	while (1) {
		if (true == comtimer(&t, timer)) {
			break;
		}
	}
}
