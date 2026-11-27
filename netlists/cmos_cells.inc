* Transistor-level cell definitions from the supplied Subcircuits.sp.

.subckt INV_X A Y vdd VSS
M0 Y A vdd vdd PMOS_VTG w='0.5u/1' l=0.05u
+ ad=0p pd=0u as=0p ps=0u
M1 Y A VSS VSS NMOS_VTG w='0.25u/1' l=0.05u
+ ad=0p pd=0u as=0p ps=0u
.ends INV_X

.subckt NAND_X A B Y vdd VSS
M0 Y A vdd vdd PMOS_VTG w=0.5u l=0.05u
+ ad=0p pd=0u as=0p ps=0u
M1 vdd B Y vdd PMOS_VTG w=0.5u l=0.05u
+ ad=0p pd=0u as=0p ps=0u
M2 a_9_6# A VSS VSS NMOS_VTG w=0.5u l=0.05u
+ ad=0p pd=0u as=0p ps=0u
M3 Y B a_9_6# VSS NMOS_VTG w=0.5u l=0.05u
+ ad=0p pd=0u as=0p ps=0u
.ends NAND_X

.subckt NOR_X A B Y vdd VSS
M0 a_9_54# A vdd vdd PMOS_VTG w=1u l=0.05u
+ ad=0p pd=0u as=0p ps=0u
M1 Y B a_9_54# vdd PMOS_VTG w=1u l=0.05u
+ ad=0p pd=0u as=0p ps=0u
M2 Y A VSS VSS NMOS_VTG w=0.25u l=0.05u
+ ad=0p pd=0u as=0p ps=0u
M3 VSS B Y VSS NMOS_VTG w=0.25u l=0.05u
+ ad=0p pd=0u as=0p ps=0u
.ends NOR_X
