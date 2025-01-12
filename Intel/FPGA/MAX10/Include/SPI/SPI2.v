/**-------------------------------------------------
 * SPI通信　スレーブ動作
 * 8bitシリアルデータを受信し、1バイトのパラレルデータとして出力
 * 
 * -------------------------------------------------*/
module SPI2 (
	input CLK, RESET,
	input SCLK, MOSI, CS,
	output reg MISO,
	output reg SPI_LOAD_ENABLE,
	output reg [1:0] SPI_BYTES,
	output reg [7:0] SPI_8BIT_D_OUT
);


/**-------------------------------------------------
 * shift_reg	:パラレル出力シフトレジスタ
 * count	 	:SCK8bitカウンタ
 * sck_posdge	:SCKの立ち上がり検出生成
 * spi_load_cnt	:8itデータ受信完了ロードレジスタ
 * -------------------------------------------------*/
reg [7:0] shift_reg;
reg [2:0] count;
reg [1:0] sck_posdge;
reg [1:0] spi_load_cnt;


/**-------------------------------------------------
 * シフトレジスタにシリアルデータを保存
 * -------------------------------------------------*/
always @(posedge SCLK, negedge RESET) begin
	if (RESET == 1'b0) begin
		shift_reg <= 8'b0;
	end else begin
		shift_reg <= {shift_reg[6:0], MOSI};
	end
end


/**-------------------------------------------------
 * SCKの立ち上がりを生成
 * -------------------------------------------------*/
always @(posedge CLK, negedge RESET) begin
	if (RESET == 1'b0) begin
		sck_posdge <= 2'b0;
	end else begin
		sck_posdge <= {sck_posdge[0], SCLK};
	end
end


/**-------------------------------------------------
 * SCLKの立ち上がりカウンター
 * -------------------------------------------------*/
always @(posedge CLK, negedge RESET) begin
	if (RESET == 1'b0) begin
		count <= 3'b0;
	end else if (CS == 1'b1) begin
		count <= 3'b0;
	end else if (sck_posdge == 2'b01) begin
		count <= count + 3'b1;
	end
end


/**-------------------------------------------------
 * 8bitカウント時の、受信完了ロードレジスタ動作
 * -------------------------------------------------*/
always @(posedge CLK, negedge RESET) begin
	if (RESET == 1'b0) begin
		spi_load_cnt <= 2'b0;
	end else begin
		spi_load_cnt <= {spi_load_cnt[0], count[2]};
	end
end


/**-------------------------------------------------
 * シフトレジスタのデータをパラレル出力
 * -------------------------------------------------*/
always @(posedge CLK, negedge RESET) begin
	if (RESET == 1'b0) begin
		SPI_LOAD_ENABLE <= 1'b0;
		SPI_8BIT_D_OUT  <= 8'b0;
	end else if (spi_load_cnt == 2'b10) begin
		SPI_LOAD_ENABLE <= 1'b1;
		SPI_8BIT_D_OUT  <= shift_reg;
	end else begin
		SPI_LOAD_ENABLE <= 1'b0; 
	end
end


/**-------------------------------------------------
 * CSがアクティブの時、受信データのバイト数カウント
 * -------------------------------------------------*/
always @(posedge CLK, negedge RESET) begin
	if (RESET == 1'b0) begin
		SPI_BYTES <= 2'b0;
	end else if (CS == 1'b1) begin
		SPI_BYTES <= 2'b0;
	end else if (SPI_LOAD_ENABLE == 1'b1) begin
		SPI_BYTES <= SPI_BYTES + 1'b1;
	end
end


/**-------------------------------------------------
 * MISO 今回は不使用
 * -------------------------------------------------*/
always @(negedge SCLK, negedge RESET) begin
	if (RESET == 1'b0) begin
		MISO <= 1'b0;
	end else begin
		MISO <= shift_reg[7];
	end
end

endmodule
