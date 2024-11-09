// `timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.11.2024 16:30:31
// Design Name: 
// Module Name: Hash
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Hash(
    input clk,
    input rst,
    input [1:0] mode,
    input is_last,
    input start_calc,
    input in_valid,
    input n,
    input start,
    input [63:0] in,
    
    output ack,
    output [47:0] out_sample,
    output done,
    output [7:0] SRAM_address
);

    CBD_Super SKIBIDI (
         .start(start_calc),
         .clk(clk),
         .reset(rst),
         .n(n), //n = 0 for eta  = 2 mode, and n = 1 for eta = 3 mode
         .In(out),
         .ready(out_ready),
         .Out(out_sample),
         .done(done),//signal for mux to send output to Write buffer
         .give_bits(gimme), //signal for PRG to give bit array
         .address(SRAM_address)
    );
    
     keccak KEKKAK (
        .clk(clk),
        .rst(rst),
        .in(in), // Represents the seed
        .mode(mode),
        .is_last(is_last), // Indicated the last input seed
        .start_calc(start_calc), // signifies vaild instruction
        .gimme(gimme), // handshaking from parse and CBD
        .ack(ack),
        .in_valid(in_valid),//total goes to padding
        .out(out),
        .out_ready(out_ready),
        .out_buf_empty(out_buf_empty) // Output FIFO is empty
    );
        
    wire gimme;
    wire [63:0] out;
    wire out_ready; 
    wire out_buf_empty;

endmodule
