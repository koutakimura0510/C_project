////////////////////////////////////////////////////////////////////////////////
// Copyright (C) 2013-2022 Efinix Inc. All rights reserved.              
//
// This   document  contains  proprietary information  which   is        
// protected by  copyright. All rights  are reserved.  This notice       
// refers to original work by Efinix, Inc. which may be derivitive       
// of other work distributed under license of the authors.  In the       
// case of derivative work, nothing in this notice overrides the         
// original author's license agreement.  Where applicable, the           
// original license agreement is included in it's original               
// unmodified form immediately below this header.                        
//                                                                       
// WARRANTY DISCLAIMER.                                                  
//     THE  DESIGN, CODE, OR INFORMATION ARE PROVIDED “AS IS” AND        
//     EFINIX MAKES NO WARRANTIES, EXPRESS OR IMPLIED WITH               
//     RESPECT THERETO, AND EXPRESSLY DISCLAIMS ANY IMPLIED WARRANTIES,  
//     INCLUDING, WITHOUT LIMITATION, THE IMPLIED WARRANTIES OF          
//     MERCHANTABILITY, NON-INFRINGEMENT AND FITNESS FOR A PARTICULAR    
//     PURPOSE.  SOME STATES DO NOT ALLOW EXCLUSIONS OF AN IMPLIED       
//     WARRANTY, SO THIS DISCLAIMER MAY NOT APPLY TO LICENSEE.           
//                                                                       
// LIMITATION OF LIABILITY.                                              
//     NOTWITHSTANDING ANYTHING TO THE CONTRARY, EXCEPT FOR BODILY       
//     INJURY, EFINIX SHALL NOT BE LIABLE WITH RESPECT TO ANY SUBJECT    
//     MATTER OF THIS AGREEMENT UNDER TORT, CONTRACT, STRICT LIABILITY   
//     OR ANY OTHER LEGAL OR EQUITABLE THEORY (I) FOR ANY INDIRECT,      
//     SPECIAL, INCIDENTAL, EXEMPLARY OR CONSEQUENTIAL DAMAGES OF ANY    
//     CHARACTER INCLUDING, WITHOUT LIMITATION, DAMAGES FOR LOSS OF      
//     GOODWILL, DATA OR PROFIT, WORK STOPPAGE, OR COMPUTER FAILURE OR   
//     MALFUNCTION, OR IN ANY EVENT (II) FOR ANY AMOUNT IN EXCESS, IN    
//     THE AGGREGATE, OF THE FEE PAID BY LICENSEE TO EFINIX HEREUNDER    
//     (OR, IF THE FEE HAS BEEN WAIVED, $100), EVEN IF EFINIX SHALL HAVE 
//     BEEN INFORMED OF THE POSSIBILITY OF SUCH DAMAGES.  SOME STATES DO 
//     NOT ALLOW THE EXCLUSION OR LIMITATION OF INCIDENTAL OR            
//     CONSEQUENTIAL DAMAGES, SO THIS LIMITATION AND EXCLUSION MAY NOT   
//     APPLY TO LICENSEE.                                                
//
////////////////////////////////////////////////////////////////////////////////

mCsiIpCore u_mCsiIpCore(
.reset_n ( reset_n ),
.clk ( clk ),
.reset_byte_HS_n ( reset_byte_HS_n ),
.clk_byte_HS ( clk_byte_HS ),
.reset_pixel_n ( reset_pixel_n ),
.clk_pixel ( clk_pixel ),
.vsync_vc1 ( vsync_vc1 ),
.vsync_vc15 ( vsync_vc15 ),
.vsync_vc12 ( vsync_vc12 ),
.vsync_vc9 ( vsync_vc9 ),
.vsync_vc7 ( vsync_vc7 ),
.vsync_vc14 ( vsync_vc14 ),
.vsync_vc13 ( vsync_vc13 ),
.vsync_vc11 ( vsync_vc11 ),
.vsync_vc10 ( vsync_vc10 ),
.vsync_vc8 ( vsync_vc8 ),
.vsync_vc6 ( vsync_vc6 ),
.vsync_vc4 ( vsync_vc4 ),
.vsync_vc0 ( vsync_vc0 ),
.vsync_vc5 ( vsync_vc5 ),
.irq ( irq ),
.pixel_data_valid ( pixel_data_valid ),
.pixel_data ( pixel_data ),
.pixel_per_clk ( pixel_per_clk ),
.datatype ( datatype ),
.shortpkt_data_field ( shortpkt_data_field ),
.word_count ( word_count ),
.vcx ( vcx ),
.vc ( vc ),
.hsync_vc3 ( hsync_vc3 ),
.hsync_vc2 ( hsync_vc2 ),
.hsync_vc8 ( hsync_vc8 ),
.hsync_vc12 ( hsync_vc12 ),
.hsync_vc7 ( hsync_vc7 ),
.hsync_vc10 ( hsync_vc10 ),
.hsync_vc1 ( hsync_vc1 ),
.hsync_vc0 ( hsync_vc0 ),
.hsync_vc13 ( hsync_vc13 ),
.hsync_vc4 ( hsync_vc4 ),
.hsync_vc11 ( hsync_vc11 ),
.hsync_vc6 ( hsync_vc6 ),
.hsync_vc9 ( hsync_vc9 ),
.hsync_vc15 ( hsync_vc15 ),
.hsync_vc14 ( hsync_vc14 ),
.hsync_vc5 ( hsync_vc5 ),
.axi_rready ( axi_rready ),
.axi_rvalid ( axi_rvalid ),
.axi_rdata ( axi_rdata ),
.axi_arready ( axi_arready ),
.axi_arvalid ( axi_arvalid ),
.axi_araddr ( axi_araddr ),
.axi_bready ( axi_bready ),
.axi_bvalid ( axi_bvalid ),
.axi_wready ( axi_wready ),
.axi_wvalid ( axi_wvalid ),
.axi_wdata ( axi_wdata ),
.vsync_vc3 ( vsync_vc3 ),
.vsync_vc2 ( vsync_vc2 ),
.axi_awready ( axi_awready ),
.axi_clk ( axi_clk ),
.axi_reset_n ( axi_reset_n ),
.axi_awaddr ( axi_awaddr ),
.axi_awvalid ( axi_awvalid ),
.RxUlpsClkNot ( RxUlpsClkNot ),
.RxUlpsActiveClkNot ( RxUlpsActiveClkNot ),
.RxClkEsc ( RxClkEsc ),
.RxErrEsc ( RxErrEsc ),
.RxErrControl ( RxErrControl ),
.RxErrSotSyncHS ( RxErrSotSyncHS ),
.RxUlpsEsc ( RxUlpsEsc ),
.RxUlpsActiveNot ( RxUlpsActiveNot ),
.RxSkewCalHS ( RxSkewCalHS ),
.RxStopState ( RxStopState ),
.RxSyncHS ( RxSyncHS ),
.RxDataHS0 ( RxDataHS0 ),
.RxDataHS1 ( RxDataHS1 ),
.RxDataHS2 ( RxDataHS2 ),
.RxDataHS3 ( RxDataHS3 ),
.RxDataHS4 ( RxDataHS4 ),
.RxDataHS5 ( RxDataHS5 ),
.RxDataHS6 ( RxDataHS6 ),
.RxDataHS7 ( RxDataHS7 ),
.RxValidHS0 ( RxValidHS0 ),
.RxValidHS1 ( RxValidHS1 ),
.RxValidHS2 ( RxValidHS2 ),
.RxValidHS3 ( RxValidHS3 ),
.RxValidHS4 ( RxValidHS4 ),
.RxValidHS5 ( RxValidHS5 ),
.RxValidHS6 ( RxValidHS6 ),
.RxValidHS7 ( RxValidHS7 )
);
