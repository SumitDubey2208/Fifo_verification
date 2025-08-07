class fifo_txn extends uvm_sequence_item;
    rand bit wr_en;
    rand bit rd_en;
    rand bit [7:0] data_in;
    bit [7:0] data_out;

    `uvm_object_utils(fifo_txn)

    function new(string name = "fifo_txn");
        super.new(name);
    endfunction

    function string convert2string();
        return $sformatf("wr_en=%0b rd_en=%0b data_in=%0h data_out=%0h", wr_en, rd_en, data_in, data_out);
    endfunction
endclass