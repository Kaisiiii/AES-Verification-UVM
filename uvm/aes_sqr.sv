`ifndef AES_SQR__SV
`define AES_SQR__SV
class aes_sqr extends uvm_sequencer#(aes_tr);
	`uvm_component_utils(aes_sqr);
    function new(string name = "aes_sqr", uvm_component parent);
        super.new(name, parent);
    endfunction
endclass
`endif
