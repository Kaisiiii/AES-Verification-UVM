`ifndef AES_ENV__SV
`define AES_ENV__SV
class aes_env extends uvm_env;
    aes_agent_i i_agt;
    aes_agent_o o_agt;
	aes_model mdl;
	aes_scoreboard aes_scb;
    uvm_tlm_analysis_fifo#(aes_tr) agt2mdl_fifo;
    uvm_tlm_analysis_fifo#(aes_tr) agt2scb_fifo;
    uvm_tlm_analysis_fifo#(aes_tr) mdl2scb_fifo;

    `uvm_component_utils(aes_env);
    function new(string name = "aes_env", uvm_component parent);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        i_agt = aes_agent_i::type_id::create("i_agt",this);
        o_agt = aes_agent_o::type_id::create("o_agt",this);
        mdl = aes_model::type_id::create("mdl",this);
        aes_scb = aes_scoreboard::type_id::create("aes_scb",this);
        agt2mdl_fifo = new("agt2mdl_fifo", this);
        agt2scb_fifo = new("agt2scb_fifo", this);
        mdl2scb_fifo = new("mdl2scb_fifo", this);
        i_agt.is_active  = UVM_ACTIVE;
    endfunction

    extern virtual function void connect_phase(uvm_phase phase);
    extern virtual task main_phase(uvm_phase phase);
endclass

function void aes_env::connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    i_agt.ap.connect(agt2mdl_fifo.analysis_export);
    mdl.port.connect(agt2mdl_fifo.blocking_get_export);
    
    o_agt.ap.connect(agt2scb_fifo.analysis_export);
    aes_scb.act_port.connect(agt2scb_fifo.blocking_get_export);
    
    mdl.ap.connect(mdl2scb_fifo.analysis_export);
	aes_scb.exp_port.connect(mdl2scb_fifo.blocking_get_export);
    
endfunction

task aes_env::main_phase(uvm_phase phase);
	super.main_phase(phase);
	uvm_top.print_topology();
endtask
`endif
