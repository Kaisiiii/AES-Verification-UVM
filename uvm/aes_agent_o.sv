`ifndef AES_AGENT_O__SV
`define AES_AGENT_O__SV
class aes_agent_o extends uvm_agent;
    //aes_sqr sqr;
    //aes_drv drv;
    aes_mon_o mon;
    uvm_analysis_port#(aes_tr) ap;
    
    `uvm_component_utils(aes_agent_o);
    function new(string name = "aes_agent_o", uvm_component parent);
        super.new(name, parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        //sqr = aes_sqr::type_id::create("sqr",this);
        mon = aes_mon_o::type_id::create("mon",this);
        //if(is_active == UVM_ACTIVE)
        //    drv = aes_drv::type_id::create("drv",this);
        //uvm_config_db#(uvm_object_wrapper)::set(this,"sqr.main_phase",
		//										"default_sequence",
		//										aes_seq::type_id::get());
    endfunction

    extern function void connect_phase(uvm_phase phase);
endclass

function void aes_agent_o::connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    //drv.seq_item_port.connect(sqr.seq_item_export);
    ap = mon.ap;
endfunction
`endif
