`ifndef AES_SEQ__SV
`define AES_SEQ__SV
class aes_seq extends uvm_sequence#(aes_tr);
    aes_tr tr;
    `uvm_object_utils(aes_seq);
    function new(string name = "aes_seq");
        super.new(name);
    endfunction 
    extern task  body();
    extern task  pre_body();
    extern task  post_body();
endclass

task aes_seq::body();
	repeat(100)
    	`uvm_do(tr);
endtask

task aes_seq::pre_body();
    if(starting_phase != null) begin
		starting_phase.raise_objection(this);
    end
endtask

task aes_seq::post_body();
    if(starting_phase != null) begin
		starting_phase.drop_objection(this);
    end
endtask
`endif
