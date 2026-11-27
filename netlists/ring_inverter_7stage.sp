7-stage CMOS inverter ring oscillator

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

.SUBCKT RO7 OUT VDD VSS
X_INV1 OUT n1 VDD VSS INV_X
X_INV2 n1 n2 VDD VSS INV_X
X_INV3 n2 n3 VDD VSS INV_X
X_INV4 n3 n4 VDD VSS INV_X
X_INV5 n4 n5 VDD VSS INV_X
X_INV6 n5 n6 VDD VSS INV_X
X_INV7 n6 OUT VDD VSS INV_X
.ENDS

.IC V(n_A1) = 0
X_RO7 n_A1 n_VDD n_VSS RO7

.TRAN 1p 8ns
.PROBE V(*) I(*)

.MEASURE TRAN t_oscill_period trig V(n_A1) val = 'SupplyVoltage/2' RISE=2
+ targ V(n_A1) val = 'SupplyVoltage/2' RISE=3

.END
