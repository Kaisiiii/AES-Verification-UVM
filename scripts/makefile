.PHONY: clr com sim
OUTPUT = simv
OUT = crg
CM = -cm line+cond+fsm+branch+tgl
CM_NAME = -cm_name ${OUT}
CM_DIR = -cm_dir ./${OUT}.vdb

com:
	vcs -sverilog -full64 \
		-timescale=1ns/1ps \
		-debug_acc+r	\
		-LDFLAGS -DVCS	\
		${UVM_HOME}/src/dpi/uvm_dpi.cc	\
		+vcs+lic+wait	\
		-f file.list	\
		${CM} ${CM_NAME} ${CM_DIR} \
		-o ${OUTPUT}	\
		-l com.log

sim:
	./${OUTPUT} -l sim.log	\
	${CM} ${CM_NAME} ${CM_DIR} \
	+fsdb+autoflush	
		
dve:
	dve -full64 -vpd vcdplus.vpd &
cov:
	dve -full64 -covdir *vdb &

urg:
	urg -dir *.vdb -report ./reg_result/total/coverg/ -format both
	
verdi:
	verdi	-nologo	\
			-f file.list	\
			-ssf *.fsdb &	
								
clr:
	rm -rf sim* *.log csrc DVE* *.key \
		*.vpd novas* verdi* *.fsdb *.vpd \
		*Log 64 *.h	*.tcl reStart* *.vdb reg_result *.vcd 
