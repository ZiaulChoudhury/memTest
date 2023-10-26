//
// Generated by Bluespec Compiler, version 2023.01 (build 52adafa5)
//
// On Thu Oct 26 13:59:35 IST 2023
//
//
// Ports:
// Name                         I/O  size props
// RDY_put                        O     1
// get                            O   128
// RDY_get                        O     1
// CLK                            I     1 clock
// RST_N                          I     1 reset
// put_datas                      I   128 unused
// EN_put                         I     1
// EN_get                         I     1
//
// No combinational paths from inputs to outputs
//
//

`ifdef BSV_ASSIGNMENT_DELAY
`else
  `define BSV_ASSIGNMENT_DELAY
`endif

`ifdef BSV_POSITIVE_RESET
  `define BSV_RESET_VALUE 1'b1
  `define BSV_RESET_EDGE posedge
`else
  `define BSV_RESET_VALUE 1'b0
  `define BSV_RESET_EDGE negedge
`endif

module mkMem1(CLK,
	      RST_N,

	      put_datas,
	      EN_put,
	      RDY_put,

	      EN_get,
	      get,
	      RDY_get);
  input  CLK;
  input  RST_N;

  // action method put
  input  [127 : 0] put_datas;
  input  EN_put;
  output RDY_put;

  // actionvalue method get
  input  EN_get;
  output [127 : 0] get;
  output RDY_get;

  // signals for module outputs
  wire [127 : 0] get;
  wire RDY_get, RDY_put;

  // register mem_rCache
  reg [136 : 0] mem_rCache;
  wire [136 : 0] mem_rCache$D_IN;
  wire mem_rCache$EN;

  // register mem_rRdPtr
  reg [7 : 0] mem_rRdPtr;
  wire [7 : 0] mem_rRdPtr$D_IN;
  wire mem_rRdPtr$EN;

  // register mem_rWrPtr
  reg [7 : 0] mem_rWrPtr;
  wire [7 : 0] mem_rWrPtr$D_IN;
  wire mem_rWrPtr$EN;

  // ports of submodule mem_memory
  wire [127 : 0] mem_memory$DIA, mem_memory$DIB, mem_memory$DOB;
  wire [6 : 0] mem_memory$ADDRA, mem_memory$ADDRB;
  wire mem_memory$ENA, mem_memory$ENB, mem_memory$WEA, mem_memory$WEB;

  // remaining internal signals
  wire [127 : 0] x3__h645;
  wire [7 : 0] x__h728, x__h817;

  // action method put
  assign RDY_put = mem_rRdPtr + 8'd64 != mem_rWrPtr ;

  // actionvalue method get
  assign get =
	     (mem_rCache[136] && mem_rCache[135:128] == mem_rRdPtr) ?
	       mem_rCache[127:0] :
	       mem_memory$DOB ;
  assign RDY_get = mem_rRdPtr != mem_rWrPtr ;

  // submodule mem_memory
  BRAM2 #(.PIPELINED(1'd0),
	  .ADDR_WIDTH(32'd7),
	  .DATA_WIDTH(32'd128),
	  .MEMSIZE(8'd128)) mem_memory(.CLKA(CLK),
				       .CLKB(CLK),
				       .ADDRA(mem_memory$ADDRA),
				       .ADDRB(mem_memory$ADDRB),
				       .DIA(mem_memory$DIA),
				       .DIB(mem_memory$DIB),
				       .WEA(mem_memory$WEA),
				       .WEB(mem_memory$WEB),
				       .ENA(mem_memory$ENA),
				       .ENB(mem_memory$ENB),
				       .DOA(),
				       .DOB(mem_memory$DOB));

  // register mem_rCache
  assign mem_rCache$D_IN = { 1'd1, mem_rWrPtr, x3__h645 } ;
  assign mem_rCache$EN = EN_put ;

  // register mem_rRdPtr
  assign mem_rRdPtr$D_IN = x__h817 ;
  assign mem_rRdPtr$EN = EN_get ;

  // register mem_rWrPtr
  assign mem_rWrPtr$D_IN = x__h728 ;
  assign mem_rWrPtr$EN = EN_put ;

  // submodule mem_memory
  assign mem_memory$ADDRA = mem_rWrPtr[6:0] ;
  assign mem_memory$ADDRB = EN_get ? x__h817[6:0] : mem_rRdPtr[6:0] ;
  assign mem_memory$DIA = x3__h645 ;
  assign mem_memory$DIB =
	     128'hAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA /* unspecified value */  ;
  assign mem_memory$WEA = EN_put ;
  assign mem_memory$WEB = 1'd0 ;
  assign mem_memory$ENA = 1'b1 ;
  assign mem_memory$ENB = 1'b1 ;

  // remaining internal signals
  assign x3__h645 = EN_put ? 128'd128 : 128'd0 ;
  assign x__h728 = mem_rWrPtr + 8'd1 ;
  assign x__h817 = mem_rRdPtr + 8'd1 ;

  // handling of inlined registers

  always@(posedge CLK)
  begin
    if (RST_N == `BSV_RESET_VALUE)
      begin
        mem_rCache <= `BSV_ASSIGNMENT_DELAY
	    137'h0AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA;
	mem_rRdPtr <= `BSV_ASSIGNMENT_DELAY 8'd0;
	mem_rWrPtr <= `BSV_ASSIGNMENT_DELAY 8'd0;
      end
    else
      begin
        if (mem_rCache$EN)
	  mem_rCache <= `BSV_ASSIGNMENT_DELAY mem_rCache$D_IN;
	if (mem_rRdPtr$EN)
	  mem_rRdPtr <= `BSV_ASSIGNMENT_DELAY mem_rRdPtr$D_IN;
	if (mem_rWrPtr$EN)
	  mem_rWrPtr <= `BSV_ASSIGNMENT_DELAY mem_rWrPtr$D_IN;
      end
  end

  // synopsys translate_off
  `ifdef BSV_NO_INITIAL_BLOCKS
  `else // not BSV_NO_INITIAL_BLOCKS
  initial
  begin
    mem_rCache = 137'h0AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA;
    mem_rRdPtr = 8'hAA;
    mem_rWrPtr = 8'hAA;
  end
  `endif // BSV_NO_INITIAL_BLOCKS
  // synopsys translate_on
endmodule  // mkMem1

