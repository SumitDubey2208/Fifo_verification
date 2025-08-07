`timescale 1ns / 1ps
module fifo #(parameter DEPTH = 63, WIDTH = 8) (
    input                      clk,
    input                      rst,
    input                      wr_en,
    input                      rd_en,
    input        [WIDTH-1:0]   data_in,
    output logic               empty,
    output logic               full,
    output logic [WIDTH-1:0]   data_out
);

    logic [WIDTH-1:0] data_mem [DEPTH];
    logic [$clog2(DEPTH)-1:0] wr_ptr;
    logic [$clog2(DEPTH)-1:0] rd_ptr;

    always_ff @(posedge clk) begin
        if (rst) begin
            wr_ptr   <= 0;
            rd_ptr   <= 0;
            data_out <= 0;
        end
        else if (wr_en && !full) begin
            data_mem[wr_ptr] <= data_in;
            wr_ptr <= wr_ptr + 1;
        end
        else if (rd_en && !empty && rd_ptr <= DEPTH-1) begin
            data_out <= data_mem[rd_ptr];
            rd_ptr <= rd_ptr + 1;
        end
        if (rd_ptr == DEPTH) begin
            data_out <= rd_ptr;
        end
    end

    assign full  = (wr_ptr == rd_ptr) && rd_en;
    assign empty = (wr_ptr == rd_ptr) && wr_en;

endmodule