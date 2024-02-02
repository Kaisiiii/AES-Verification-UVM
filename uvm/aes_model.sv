`ifndef AES_MODEL__SV
`define AES_MODEL__SV

import "DPI-C" function void reference_model(input byte plain_text[], input byte key[], output byte cipher_text[]);
class aes_model extends uvm_component;

    uvm_blocking_get_port#(aes_tr) port;
    uvm_analysis_port#(aes_tr) ap;
	
    function new(string name = "aes_model", uvm_component parent);
        super.new(name, parent);
    endfunction
	`uvm_component_utils(aes_model);
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        port = new("port", this);
        ap = new("ap", this);
    endfunction

    extern virtual task main_phase(uvm_phase phase);
    extern virtual function void calcu(ref aes_tr tr, ref logic [127:0] cipher_text);
endclass

task aes_model::main_phase(uvm_phase phase);
    aes_tr tr;
    aes_tr tr_to_scoreboard;
    logic [127:0] cipher_text;
    while(1) begin
        port.get(tr);
        calcu(tr, cipher_text);
        tr_to_scoreboard = new("tr_to_scoreboard");
        tr_to_scoreboard.cipher_text = cipher_text ;
        tr_to_scoreboard.plain_text = tr.plain_text;
        tr_to_scoreboard.cipher_key = tr.cipher_key;
        //tr.tmp[127:0] = tr.cipher_text;
        tr_to_scoreboard.tmp = tr.tmp;
        ap.write(tr_to_scoreboard); 
    end
endtask

function void aes_model::calcu(ref aes_tr tr, ref logic [127:0] cipher_text);

    logic [127:0]key,plain_text;
    byte cipher_text_ref [0:15];
    byte plain_text_ref [0:15];
    byte key_ref [0:15];
    key = tr.cipher_key;
    plain_text = tr.plain_text;


    plain_text_ref[0]  = plain_text[127:120];
	plain_text_ref[1]  = plain_text[119:112];
	plain_text_ref[2]  = plain_text[111:104];
	plain_text_ref[3]  = plain_text[103:96];
	plain_text_ref[4]  = plain_text[95:88];
	plain_text_ref[5]  = plain_text[87:80];
	plain_text_ref[6]  = plain_text[79:72];
	plain_text_ref[7]  = plain_text[71:64];
	plain_text_ref[8]  = plain_text[63:56];
	plain_text_ref[9]  = plain_text[55:48];
	plain_text_ref[10] = plain_text[47:40];
	plain_text_ref[11] = plain_text[39:32];
	plain_text_ref[12] = plain_text[31:24];
	plain_text_ref[13] = plain_text[23:16];
	plain_text_ref[14] = plain_text[15:8];
	plain_text_ref[15] = plain_text[7:0]; 

    key_ref[0] = key[127:120];
	key_ref[1] = key[119:112];
	key_ref[2] = key[111:104];
	key_ref[3] = key[103:96];
	key_ref[4] = key[95:88];
	key_ref[5] = key[87:80];
	key_ref[6] = key[79:72];
	key_ref[7] = key[71:64];
	key_ref[8] = key[63:56];
	key_ref[9] = key[55:48];
	key_ref[10] = key[47:40];
	key_ref[11] = key[39:32];
	key_ref[12] = key[31:24];
	key_ref[13] = key[23:16];
	key_ref[14] = key[15:8];
	key_ref[15] = key[7:0]; 
	
    
    reference_model(plain_text_ref, key_ref, cipher_text_ref);

    cipher_text[127:120] = cipher_text_ref[0] ;
	cipher_text[119:112] = cipher_text_ref[1] ;
	cipher_text[111:104] = cipher_text_ref[2] ;
	cipher_text[103:96]  = cipher_text_ref[3] ;
	cipher_text[95:88]   = cipher_text_ref[4] ;
	cipher_text[87:80]   = cipher_text_ref[5] ;
	cipher_text[79:72]   = cipher_text_ref[6] ;
	cipher_text[71:64]   = cipher_text_ref[7] ;
	cipher_text[63:56]   = cipher_text_ref[8] ;
	cipher_text[55:48]   = cipher_text_ref[9] ;
	cipher_text[47:40]   = cipher_text_ref[10];
	cipher_text[39:32]   = cipher_text_ref[11];
	cipher_text[31:24]   = cipher_text_ref[12];
	cipher_text[23:16]   = cipher_text_ref[13];
	cipher_text[15:8]    = cipher_text_ref[14];
	cipher_text[7:0]     = cipher_text_ref[15]; 


endfunction
`endif
