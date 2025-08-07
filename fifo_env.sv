class fifo_env extends uvm_env;
    `uvm_component_utils(fifo_env)

    fifo_driver drv;
    fifo_monitor mon;
    fifo_scoreboard sb;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        drv = fifo_driver::type_id::create("drv", this);
        mon = fifo_monitor::type_id::create("mon", this);
        sb  = fifo_scoreboard::type_id::create("sb", this);
    endfunction

    virtual function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        mon.ap.connect(sb.ap);
    endfunction
endclass