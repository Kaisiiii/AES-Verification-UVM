`ifndef  AES_MON_O__SV
`define AES_MON_O__SV
class aes_mon_o extends uvm_monitor;
    virtual dut_if mon_if;
    uvm_analysis_port#(aes_tr) ap;

    `uvm_component_utils(aes_mon_o);
    function new(string name = "aes_mon_o", uvm_component parent);
        super.new(name, parent);
    endfunction
    
    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if(!uvm_config_db#(virtual dut_if)::get(this, "", "mon_if", mon_if))
            `uvm_fatal("aes_mon_o", "Virtual interface must be configured");
        ap = new("ap", this);
    endfunction

    extern virtual task main_phase(uvm_phase phase);
    extern virtual task collect_one_tr(aes_tr tr);

endclass

task aes_mon_o::main_phase(uvm_phase phase);
    aes_tr tr;
    super.main_phase(phase);
    while(1) begin
    	tr = new("tr");
        collect_one_tr(tr);
        ap.write(tr);
    end
endtask

task aes_mon_o::collect_one_tr(aes_tr tr);
    while(1) begin
        @(posedge mon_if.clk)
        if(mon_if.valid_out == 1'b1)
            break;
    end
    tr.cipher_text = mon_if.cipher_text;

endtask
`endif  
