package memory_test;
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

interface Mem1;
        method Action put(Bit#(WIDTH) datas);
        method ActionValue#(Bit#(WIDTH)) get;
endinterface

(*synthesize*)
module mkMem1(Mem1);
FIFOF#(Bit#(WIDTH)) mem <- mkSizedBRAMFIFOF(64);

        method Action put(Bit#(WIDTH) datas);
				mem.enq(WIDTH);	
	endmethod

        method ActionValue#(Bit#(WIDTH)) get;
			let d = mem.first;
			mem.deq;
			return d;
	endmethod	
endmodule
endpackage
