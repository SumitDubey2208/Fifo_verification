class fifo_scoreboard extends uvm_component;
    `uvm_component_utils(fifo_scoreboard)

    uvm_analysis_imp #(fifo_txn, fifo_scoreboard) ap;

    bit [7:0] expected_data[$];

    function new(string name, uvm_component parent);
        super.new(name, parent);
        ap = new("ap", this);
    endfunction

    virtual function void write(fifo_txn tx);
        if (tx.wr_en && !tx.rd_en)
            expected_data.push_back(tx.data_in);
        else if (tx.rd_en && expected_data.size() > 0) begin
            if (tx.data_out !== expected_data.pop_front())
                `uvm_error("SCOREBOARD", $sformatf("Data mismatch: got %0h", tx.data_out))
            else
                `uvm_info("SCOREBOARD", $sformatf("Matched: %0h", tx.data_out), UVM_MEDIUM)
        end
    endfunction
endclass