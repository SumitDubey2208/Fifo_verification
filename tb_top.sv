`timescale 1ns/1ps
module tb_top;
    logic clk = 0;
    always #5 clk = ~clk;

    fifo_if #(8) fifo_vif(clk);

    fifo #(.DEPTH(63), .WIDTH(8)) dut (
        .clk(clk),
        .rst(fifo_vif.rst),
        .wr_en(fifo_vif.wr_en),
        .rd_en(fifo_vif.rd_en),
        .data_in(fifo_vif.data_in),
        .data_out(fifo_vif.data_out),
        .empty(fifo_vif.empty),
        .full(fifo_vif.full)
    );

    initial begin
        uvm_config_db #(virtual fifo_if)::set(null, "*", "vif", fifo_vif);
        run_test("fifo_test");
    end
endmodule