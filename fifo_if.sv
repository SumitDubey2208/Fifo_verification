interface fifo_if #(parameter WIDTH = 8) (input logic clk);
    logic rst;
    logic wr_en;
    logic rd_en;
    logic [WIDTH-1:0] data_in;
    logic [WIDTH-1:0] data_out;
    logic empty;
    logic full;

    modport DUT_MODPORT (
        input  clk, rst, wr_en, rd_en, data_in,
        output data_out, empty, full
    );
endinterface