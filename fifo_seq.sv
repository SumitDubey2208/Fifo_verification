class fifo_seq extends uvm_sequence #(fifo_txn);
    `uvm_object_utils(fifo_seq)

    function new(string name = "fifo_seq");
        super.new(name);
    endfunction

    virtual task body();
        fifo_txn tx;
        repeat (20) begin
            tx = fifo_txn::type_id::create("tx");
            tx.randomize();
            start_item(tx);
            finish_item(tx);
        end
    endtask
endclass