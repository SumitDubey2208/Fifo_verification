class fifo_driver extends uvm_driver #(fifo_txn);
    `uvm_component_utils(fifo_driver)

    virtual fifo_if vif;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if (!uvm_config_db #(virtual fifo_if)::get(this, "", "vif", vif))
            `uvm_fatal("NOVIF", "No virtual interface found!")
    endfunction

    virtual task run_phase(uvm_phase phase);
        fifo_txn tx;
        forever begin
            seq_item_port.get_next_item(tx);
            vif.wr_en   <= tx.wr_en;
            vif.rd_en   <= tx.rd_en;
            vif.data_in <= tx.data_in;
            @(posedge vif.clk);
            seq_item_port.item_done();
        end
    endtask
endclass