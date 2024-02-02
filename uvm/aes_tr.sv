`ifndef AES_TR__SV
`define AES_TR__SV
class aes_tr extends uvm_sequence_item;
 
    rand bit [127:0] cipher_key, plain_text;
    rand bit [127:0] cipher_text;
    rand bit [9999:0] tmp;
    `uvm_object_utils_begin(aes_tr)
        `uvm_field_int(cipher_key, UVM_PRINT|UVM_NOCOMPARE);
        `uvm_field_int(plain_text, UVM_PRINT|UVM_NOCOMPARE);
        `uvm_field_int(cipher_text, UVM_ALL_ON);
        `uvm_field_int(tmp, UVM_ALL_ON);
    `uvm_object_utils_end
  
    constraint c1{cipher_key inside {[0:$]};};
    constraint c2{tmp == 0;};
    function new (string name = "aes_tr");
        super.new(name);
    endfunction

	extern virtual function bit do_com(aes_tr tr);
endclass

function bit aes_tr::do_com(aes_tr tr);
	int i;
	bit result = 1;
	if(tr == null)
		`uvm_fatal("aes_tr","tr is null");
		
	for (i = 0; i < 10000; i++)begin
		if(tmp[i] != tr.tmp[i])
			result = 0;
	end
	
	return result;
endfunction
`endif
