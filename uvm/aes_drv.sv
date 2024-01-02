`ifndef AES_DRV__SV
`define AES_DRV__SV
class aes_drv extends uvm_driver#(aes_tr);
    virtual dut_if vif;

    `uvm_component_utils(aes_drv);
    function new(string name = "aes_drv", uvm_component parent);
        super.new(name, parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if(!uvm_config_db#(virtual dut_if)::get(this, "", "vif",vif))
            `uvm_fatal("aes_drv","Virtual interface must be correctly configured");
    endfunction

    extern task main_phase(uvm_phase phase);
    extern virtual task drv_one_tr(aes_tr tr);
    extern virtual task init();
endclass

task aes_drv::main_phase(uvm_phase phase);
    `uvm_info("aes_drv","main_phase is called",UVM_LOW);
    //super.main_phase(phase);
    while(!vif.reset) begin
    	@(posedge vif.clk);
    	init();
    end
    
    while(1) begin
		seq_item_port.get_next_item(req);
		drv_one_tr(req);
		seq_item_port.item_done();
    end
endtask

task aes_drv::drv_one_tr(aes_tr tr);
	@(posedge vif.clk)
	while(1) begin 
		vif.data_valid_in <= 1'b1;
		vif.cipherkey_valid_in <= 1'b1;
		vif.cipher_key <= tr.cipher_key;
		vif.plain_text <= tr.plain_text;
	break;
	end
endtask

task aes_drv::init();
    vif.data_valid_in <= 0;
    vif.cipherkey_valid_in <= 0;
	vif.cipher_key <= 0;
	vif.plain_text <= 0;
endtask
`endif
