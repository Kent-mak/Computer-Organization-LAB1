`timescale 1ns / 1ps
// <your student id>

/* checkout FIGURE C.5.10 (Bottom) */
/* [Prerequisite] complete bit_alu.v */
module msb_bit_alu (
    input        a,          // 1 bit, a
    input        b,          // 1 bit, b
    input        less,       // 1 bit, Less
    input        a_invert,   // 1 bit, Ainvert
    input        b_invert,   // 1 bit, Binvert
    input        carry_in,   // 1 bit, CarryIn
    input  [1:0] operation,  // 2 bit, Operation
    output reg       result,     // 1 bit, Result (Must it be a reg?)
    output       set,        // 1 bit, Set
    output       overflow    // 1 bit, Overflow
);

    /* Try to implement the most significant bit ALU by yourself! */
/* [step 1] invert input on demand */
    wire ai, bi;  // what's the difference between `wire` and `reg` ?
    assign ai = a_invert ?  ~a : a; // remember `?` operator in C/C++?
    assign bi = b_invert ?  ~b:b;  // you can use logical expression too!
    
     wire sum;
    assign sum = (ai ^ bi) ^ carry_in;
    assign set = sum;
    assign overflow= (ai & bi & ~sum) | (~ai & ~bi & sum) ;    
    
    always @(*) begin  // `*` auto captures sensitivity ports, now it's combinational logic
        case (operation)  // `case` is similar to `switch` in C
            2'b00:   result <= ai & bi;  // AND
            2'b01:   result <= ai | bi;  // OR
            2'b10:   result <= sum;  // ADD
            2'b11:   result <= less; // SLT
            default: result <= 0;  // should not happened
        endcase
    end
    
endmodule
