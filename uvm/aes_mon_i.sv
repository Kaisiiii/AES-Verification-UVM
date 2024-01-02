`ifndef  AES_MON_I__SV
`define AES_MON_I__SV
class aes_mon_i extends uvm_monitor;
    virtual dut_if mon_if;
    uvm_analysis_port#(aes_tr) ap;

    `uvm_component_utils(aes_mon_i);
    function new(string name = "aes_mon_i", uvm_component parent);
        super.new(name, parent);
    endfunction
    
    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if(!uvm_config_db#(virtual dut_if)::get(this, "", "mon_if", mon_if))
            `uvm_fatal("aes_mon_i", "Virtual interface must be configured");
        ap = new("ap", this);
    endfunction

    extern virtual task main_phase(uvm_phase phase);
    extern virtual task collect_one_tr(aes_tr tr);

endclass

task aes_mon_i::main_phase(uvm_phase phase);
    aes_tr tr;
    super.main_phase(phase);
    while(1) begin
    	tr = new("tr");
        collect_one_tr(tr);
        ap.write(tr);
    end
endtask

task aes_mon_i::collect_one_tr(aes_tr tr);
    while(1) begin
        @(posedge mon_if.clk)
        if(mon_if.data_valid_in == 1'b1 && mon_if.cipherkey_valid_in == 1'b1)
            break;
    end
    tr.plain_text = mon_if.plain_text;
    tr.cipher_key = mon_if.cipher_key;

endtask
`endif  
