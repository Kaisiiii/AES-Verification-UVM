`include "uvm_macros.svh"
import uvm_pkg::*;
 
`include "aes_if.sv"
`include "aes_tr.sv"
`include "aes_seq.sv"
`include "aes_sqr.sv"
`include "aes_drv.sv"
`include "aes_mon_i.sv"
`include "aes_mon_o.sv"
`include "aes_agent_i.sv"
`include "aes_agent_o.sv"
`include "aes_model.sv"
`include "aes_scoreboard.sv"
`include "aes_env.sv"


`timescale 1ns/1ps
module test;

bit clk = 0;
bit reset = 0; 

aes_env env;
	
dut_if in_dif(
	.clk(clk),
	.reset(reset)
);

initial begin
	#30;
	reset = 1;
   
end
 
initial begin
     forever  #5 clk = ~clk;
end

initial begin
    uvm_config_db#(virtual dut_if)::set(null, "env.i_agt.drv", "vif", in_dif);
    uvm_config_db#(virtual dut_if)::set(null, "env.i_agt.mon", "mon_if", in_dif);
    uvm_config_db#(virtual dut_if)::set(null, "env.o_agt.mon", "mon_if", in_dif);
end

initial begin
    env = new("env",null);
    run_test();
    #500;
    $finish;
end

Top_PipelinedCipher aes_1(
  .cipher_key(in_dif.cipher_key), 
  .plain_text(in_dif.plain_text),
  .valid_out(in_dif.valid_out),
  .cipher_text(in_dif.cipher_text),
  .reset(reset),
  .data_valid_in(in_dif.data_valid_in),
  .cipherkey_valid_in(in_dif.cipherkey_valid_in),
  .clk(clk)
); 

  
initial begin
	$vcdpluson;
	$fsdbDumpfile("aes.fsdb");
	$fsdbDumpvars(0);
end  
endmodule

