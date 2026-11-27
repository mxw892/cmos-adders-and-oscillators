CMOS full adder built from nine NAND gates

.protec
.include '$PDK_DIR/ncsu_basekit/models/hspice/hspice_nom.include'
.include 'cmos_cells.inc'
.unprotec

.TEMP 25

.OPTION POST
+ PUTMEAS=0
+ MEASFAIL=0
+ PROBE=1
+ AUTOSTOP
+ RUNLVL = 6

.PARAM SupplyVoltage = 1.0V
.PARAM VDD = 1
Vn_VDD n_VDD 0 DC 'SupplyVoltage'
Vn_VSS n_VSS 0 DC 0.000000e+00

.SUBCKT FA2_X A B Cin S Co VDD VSS
X_NAND_X1 A B d1 VDD VSS NAND_X
X_NAND_X2 A d1 d2 VDD VSS NAND_X
X_NAND_X3 d1 B d3 VDD VSS NAND_X
X_NAND_X4 d2 d3 d4 VDD VSS NAND_X
X_NAND_X5 d4 Cin d5 VDD VSS NAND_X
X_NAND_X6 d4 d5 d6 VDD VSS NAND_X
X_NAND_X7 d5 Cin d7 VDD VSS NAND_X
X_NAND_X8 d5 d1 Co VDD VSS NAND_X
X_NAND_X9 d6 d7 S VDD VSS NAND_X
.ENDS

VA0 A0 0 Pulse(0 VDD 4ns 20ps 20ps 3.98ns 8ns)
VB0 B0 0 Pulse(0 VDD 2ns 20ps 20ps 1.98ns 4ns)
VCI0 Cin0 0 Pulse(0 VDD 1ns 20ps 20ps 0.98ns 2ns)

X_FA_X02 A0 B0 Cin0 S0 Co0 n_VDD n_VSS FA2_X

.TRAN 1p 8ns
.PROBE V(*) I(*)

.MEASURE TRAN P_AVG AVG PAR('-V(n_VDD)*I(Vn_VDD)')

.MEASURE TRAN P_MAX MAX PAR('-V(n_VDD)*I(Vn_VDD)')

.END
