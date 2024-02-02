`ifndef AES_SCOREBOARD__SV
`define AES_SCOREBOARD__SV
class aes_scoreboard extends uvm_scoreboard;

	aes_tr expect_queue[$];
	uvm_blocking_get_port#(aes_tr) exp_port;
	uvm_blocking_get_port#(aes_tr) act_port;

	function new (string name = "aes_scoreboard",uvm_component parent = null);
		super.new(name, parent);
	endfunction
	
	`uvm_component_utils(aes_scoreboard);

	extern virtual function void build_phase(uvm_phase phase);
	extern virtual task main_phase(uvm_phase phase);
endclass

function void aes_scoreboard::build_phase(uvm_phase phase);
	`uvm_info("aes_scoreboard","scoreboard build phase is called!",UVM_LOW);
	super.build_phase(phase);
	exp_port = new("exp_port",this);
	act_port = new("act_port",this);
endfunction

task aes_scoreboard::main_phase(uvm_phase phase);
	aes_tr get_exp, get_act, tmp_tr;
	bit result;
	`uvm_info("aes_scoreboard","aes_scoreboard main phase is called!",UVM_LOW);
	super.main_phase(phase);
	fork
		while(1)begin
			exp_port.get(get_exp);
			expect_queue.push_back(get_exp);
		end
		while(1)begin
			act_port.get(get_act);
			if(expect_queue.size() > 0)begin
				tmp_tr = expect_queue.pop_front();
				result = get_act.do_com(tmp_tr);
				//result = get_act.compare(tmp_tr);
				if(result) begin
					`uvm_info("aes_scoreboard","RESULT SATISFY",UVM_LOW);
					$display("The expexct data is ");
					tmp_tr.print();
					$display("The actual data is ");
					get_act.print();
				end
				else begin
					`uvm_info("aes_scoreboard","RESULT UNSATISFY",UVM_LOW);
					$display("The expexct data is ");
					tmp_tr.print();
					$display("The actual data is ");
					get_act.print();
				end
			end
			else begin
				`uvm_error("aes_scoreboard", "Received from DUT, while Expect Queue is empty");
				$display("the unexpected pkt is");
				get_act.print();
			end
		end
	join
endtask

`endif
