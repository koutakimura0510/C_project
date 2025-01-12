/**------------------------------------------------/
 * KeyBoard Toho RPG Game
 * ------------------------------------------------
 * OS Ubuntu LTS 20.04
 * Editor vim non plugin
 * Compiler gcc
 * ------------------------------------------------
 * リアルタイムでデジタルフィルタと映像描画の処理を行うためGPUとCPUの両立を目指す。
 * 逐次型の処理ではなく、なるべく並列を意識したソースの書き方をすること。
 * マイコンのC言語の書き方ではなく、OS寄りの書き方にすること。
 * かなり大規模なソースになる予定なので、データ構造は予めしっかりと決めておくこと。
 * ------------------------------------------------*/


/**------------------------------------------------/
 * include
 * gf   :pathを指定することによりヘッダファイルに移動できる
 * <C-^>:直前のバッファに移動する
 * <C-o>:直前の作業ポイントにジャンプする
 * ------------------------------------------------
 * キーボード操作にgtkライブラリ使用（ncrsesでも可能)
 * ------------------------------------------------*/
#include "../include/LIB.H"
#include "../include/DRAW.H"
#include "../include/FILE.H"
#include <gtk/gtk.h>
#include <gdk/gdkkeysyms.h>



/**----------------------------------------------------
 * key動作処理
 * ---------------------------------------------------*/
static bool key_press(GtkWidget *widget, GdkEventKey *key)
{
	uint8_t id;

    switch (key->keyval)
    {
        case GDK_KEY_Left:
			id = LEFT;
            break;

        case GDK_KEY_Up:
			id = UP;
            break;

        case GDK_KEY_Down:
			id = DOWN;
            break;

        case GDK_KEY_Right:
			id = RIGHT;
            break;

		case GDK_KEY_C:
            saveing();    //プログラム終了
            break;


        case GDK_KEY_S:
            gtk_main_quit();    //プログラム終了
            break;

		case GDK_OK:
            gtk_main_quit();    //プログラム終了
			break;

        default:
            return false;
    }

	animation_move(id);

    return false;
}


/**---------------------------------------------------
 * デバッグ用keycode取得
 * ---------------------------------------------------*/
static bool key_debug(GtkWidget *widget, GdkEventKey *key, gpointer user_data)
{
    g_print("keyval=%d static=%d string=%s\n", key->keyval, key->state, key->string);
    return false;
}


/**---------------------------------------------------
 * メインループ
 * ---------------------------------------------------*/
int main(int argc, char **argv)
{
    GtkWidget *window;
    gtk_init(&argc, &argv);

    window = gtk_window_new(GTK_WINDOW_TOPLEVEL);
    gtk_widget_set_size_request(window, 0, 0);  //windowを描画しない
    g_signal_connect(G_OBJECT(window), "key_press_event", G_CALLBACK(key_press), NULL);
    //g_signal_connect(G_OBJECT(window), "key_press_event", G_CALLBACK(key_debug), NULL); //デバッグ
    g_signal_connect(window, "destroy", G_CALLBACK(gtk_main_quit), NULL);   //プログラム終了
    gtk_widget_show_all(window);    //windowを描画

    CURSOL_OFF();
	clear_screen();
	map_info_struct_write(GLASS);
	animation_move(NON);
	savewrite();
    gtk_main(); //gtkメインループを行う

	clear_screen();
	CURSOL_ON();
	SET_TYPE(NORMAL);
    strprintf("GTK RPG END");

    return 0;
}
