CMOS half adder

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

.SUBCKT HA_X A B S Co VDD VSS
X_NAND_X1 A B n1 VDD VSS NAND_X
X_NAND_X2 A n1 n2 VDD VSS NAND_X
X_NAND_X3 n1 B n3 VDD VSS NAND_X
X_NAND_X4 n2 n3 S VDD VSS NAND_X
X_INV_X1 n1 Co VDD VSS INV_X
.ENDS

VA0 A0 0 Pulse(0 VDD 1ns 20ps 20ps 3ns 40ns)
VB0 B0 0 Pulse(0 VDD 2ns 20ps 20ps 3ns 40ns)

X_HA_X01 A0 B0 S0 Co0 n_VDD n_VSS HA_X

.TRAN 1p 30ns
.PROBE V(*) I(*)

.MEASURE TRAN P_AVG AVG PAR('-V(n_VDD)*I(Vn_VDD)')

.MEASURE TRAN P_MAX MAX PAR('-V(n_VDD)*I(Vn_VDD)')

.END
