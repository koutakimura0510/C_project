/*------------------------------------------------------------------------------
 * Create  2024/06/16
 * Author  Kouta Kimura
 * 
 *-----------------------------------------------------------------------------*/
#ifndef Mtimer_h
#define Mtimer_h

/**-----------------------------------------------------------------------------
 * USER MACRO
 *-----------------------------------------------------------------------------*/
#define MTIMER_3S		(3000000)
#define MTIMER_1S		(1000000)
#define MTIMER_100MS	(100000)
#define MTIMER_10MS		(10000)
#define MTIMER_1MS		(1000)
#define MTIMER_1US		(1)

/**-----------------------------------------------------------------------------
 * プロトタイプ宣言
 *-----------------------------------------------------------------------------*/
uint32_t get_time(void);
bool timer_compare(uint32_t *tmr, uint32_t duration);
void wait_us(uint32_t delay_us);
void wait_ms(uint32_t delay_ms);
bool is_alarm_fired(void);
void alarm_in_us(uint32_t delay_us);

#endif