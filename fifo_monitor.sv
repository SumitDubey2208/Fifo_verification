class fifo_monitor extends uvm_component;
    `uvm_component_utils(fifo_monitor)

    uvm_analysis_port #(fifo_txn) ap;
    virtual fifo_if vif;

    function new(string name, uvm_component parent);
        super.new(name, parent);
        ap = new("ap", this);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if (!uvm_config_db #(virtual fifo_if)::get(this, "", "vif", vif))
            `uvm_fatal("NOVIF", "No virtual interface found!")
    endfunction

    virtual task run_phase(uvm_phase phase);
        fifo_txn tx;
        forever begin
            @(posedge vif.clk);
            tx = fifo_txn::type_id::create("tx");
            tx.data_out = vif.data_out;
            ap.write(tx);
        end
    endtask
endclass