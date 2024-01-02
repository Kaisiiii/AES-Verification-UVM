`ifndef AES_TR__SV
`define AES_TR__SV
class aes_tr extends uvm_sequence_item;
 
    rand bit [127:0] cipher_key, plain_text;
    rand bit [127:0] cipher_text;
    `uvm_object_utils_begin(aes_tr)
        `uvm_field_int(cipher_key, UVM_DEFAULT);
        `uvm_field_int(plain_text, UVM_DEFAULT);
        `uvm_field_int(cipher_text, UVM_DEFAULT);
    `uvm_object_utils_end
  
    constraint c1{cipher_key inside {[0:$]};};
    function new (string name = "aes_tr");
        super.new(name);
    endfunction

endclass
`endif
