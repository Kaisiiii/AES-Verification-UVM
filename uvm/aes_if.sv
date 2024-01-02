interface dut_if(input bit clk,
				 input bit reset);
	logic data_valid_in;
	logic cipherkey_valid_in;
	logic [127:0] cipher_key, plain_text;
	logic valid_out;
	logic [127:0] cipher_text;
endinterface
