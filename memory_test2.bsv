package memory_test2;
import FixedPoint::*;
import FIFO::*;
import FIFOF::*;
import datatypes::*;
import SpecialFIFOs:: * ;
import Real::*;
import Vector::*;
import BRAMFIFO::*;

#define DATA_WORD 8 
#define WIDTH 128
#define PAR 16

interface Mem2;
        method Action put(Bit#(WIDTH) datas);
        method ActionValue#(Bit#(WIDTH)) get;
endinterface

(*synthesize*)
module mkMem2(Mem2);
FIFOF#(Bit#(8)) mem[PAR];
for(int i=0; i<PAR; i = i + 1)
	mem[i] <- mkSizedBRAMFIFOF(64);

        method Action put(Bit#(WIDTH) datas);
				Vector#(PAR,Bit#(8)) dx = unpack(datas);
				for(int i=0 ;i<PAR; i = i + 1)
					mem[i].enq(dx[i]);	
	endmethod

        method ActionValue#(Bit#(WIDTH)) get;
			Vector#(PAR,Bit#(8)) dx = newVector;
			for(int i=0 ;i<PAR; i = i + 1) begin
				let d = mem[i].first;
				dx[i] = d;
				mem[i].deq;
			end
			return  pack(dx);
	endmethod	
endmodule
endpackage
