// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2023 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2023.1 (win64) Build 3865809 Sun May  7 15:05:29 MDT 2023
// Date        : Sat Nov 11 14:21:30 2023
// Host        : LAPTOP-P2TTF1UO running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix
//               decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ filter_rom_sim_netlist.v
// Design      : filter_rom
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7a35tcpg236-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "filter_rom,dist_mem_gen_v8_0_13,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "dist_mem_gen_v8_0_13,Vivado 2023.1" *) 
(* NotValidForBitStream *)
module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix
   (a,
    spo);
  input [3:0]a;
  output [7:0]spo;

  wire [3:0]a;
  wire [7:0]spo;
  wire [7:0]NLW_U0_dpo_UNCONNECTED;
  wire [7:0]NLW_U0_qdpo_UNCONNECTED;
  wire [7:0]NLW_U0_qspo_UNCONNECTED;

  (* C_FAMILY = "artix7" *) 
  (* C_HAS_D = "0" *) 
  (* C_HAS_DPO = "0" *) 
  (* C_HAS_DPRA = "0" *) 
  (* C_HAS_I_CE = "0" *) 
  (* C_HAS_QDPO = "0" *) 
  (* C_HAS_QDPO_CE = "0" *) 
  (* C_HAS_QDPO_CLK = "0" *) 
  (* C_HAS_QDPO_RST = "0" *) 
  (* C_HAS_QDPO_SRST = "0" *) 
  (* C_HAS_WE = "0" *) 
  (* C_MEM_TYPE = "0" *) 
  (* C_PIPELINE_STAGES = "0" *) 
  (* C_QCE_JOINED = "0" *) 
  (* C_QUALIFY_WE = "0" *) 
  (* C_REG_DPRA_INPUT = "0" *) 
  (* c_addr_width = "4" *) 
  (* c_default_data = "0" *) 
  (* c_depth = "16" *) 
  (* c_elaboration_dir = "./" *) 
  (* c_has_clk = "0" *) 
  (* c_has_qspo = "0" *) 
  (* c_has_qspo_ce = "0" *) 
  (* c_has_qspo_rst = "0" *) 
  (* c_has_qspo_srst = "0" *) 
  (* c_has_spo = "1" *) 
  (* c_mem_init_file = "filter_rom.mif" *) 
  (* c_parser_type = "1" *) 
  (* c_read_mif = "1" *) 
  (* c_reg_a_d_inputs = "0" *) 
  (* c_sync_enable = "1" *) 
  (* c_width = "8" *) 
  (* is_du_within_envelope = "true" *) 
  decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_dist_mem_gen_v8_0_13 U0
       (.a(a),
        .clk(1'b0),
        .d({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .dpo(NLW_U0_dpo_UNCONNECTED[7:0]),
        .dpra({1'b0,1'b0,1'b0,1'b0}),
        .i_ce(1'b1),
        .qdpo(NLW_U0_qdpo_UNCONNECTED[7:0]),
        .qdpo_ce(1'b1),
        .qdpo_clk(1'b0),
        .qdpo_rst(1'b0),
        .qdpo_srst(1'b0),
        .qspo(NLW_U0_qspo_UNCONNECTED[7:0]),
        .qspo_ce(1'b1),
        .qspo_rst(1'b0),
        .qspo_srst(1'b0),
        .spo(spo),
        .we(1'b0));
endmodule
`pragma protect begin_protected
`pragma protect version = 1
`pragma protect encrypt_agent = "XILINX"
`pragma protect encrypt_agent_info = "Xilinx Encryption Tool 2023.1"
`pragma protect key_keyowner="Synopsys", key_keyname="SNPS-VCS-RSA-2", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
bEktTo8XfP53J4LC9J1bzNOsr+DeYSQtsSeSeRwv1ROtu7MJT7BubpFM5B3JNITvmmXMIQ7cHCcM
BFy5Vu0fdwcQmgznzr1F4XAF5OH/PlBVKmCiA5IZpd+UQUMuy8l823afh4u8+Fg3bwZX7B36A3bn
Zez9yHjSKD7JGdQ9zA8=

`pragma protect key_keyowner="Aldec", key_keyname="ALDEC15_001", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
vAZQ8ZTe/MermX+omywGuwEzd7SLijiaDbuX0B9K4vjWUXvRoI6Em0qizreOX/qdo4JlybEpt70i
jJhVvWv69a9yKb8TMuvLagWbQydSwTJKTY6VSR/CtA2Uive8NvQyiQKFXLjR8k8OBlgOYmyzZEEM
vYgZLdnM3d2xSMMmeGF+dNh8tCJpM10LRaCrnj5w8L73RtOImlhI/zlR8cC5oo1TbyRV+JuHvvMZ
sYS3+4qn/f80Ugvao3cYMW0LtoTftK9oYpzhiyqg6hnJnbGsAENom2wqBpcRJf1vsI98WiJqDCuh
LIdMFI+M5KuqToM8D+FTQUOT2NniYpTmj5qTFg==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VELOCE-RSA", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
VpwnevLJi/mNDesLbbdRntRX/1KkSUuxvcBO6/opCSkxKA2w7s8Eyh+CvZJvHhBMtWZquJPlWZsE
d3toYaeyczcrzAzfKryx5nnTvscAyYnKl8QyY0fWsE1UqWjg6tazMCtzxlfF3HfKx/GSm3D/0NEz
xzyxLBgRosbKCX4YRV0=

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VERIF-SIM-RSA-2", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
MhGbYf5xy0E517prDNoCHbf/sVQ5JHlfzlh1Fz+rfDm8S3/Zt1g/AR2QuQPNwJUQO22hvTTB491a
xRG5ct3upD6ZdXgMesPA9KgwjRjoBp/uriYuT6Sb/yE2jugYl2qBGpqxN9n2OgAVfK3o9XZ/aIcR
St2PwrmKRzU/ZoYenWUMZ6ZRsVNlzFCEBcKop6f5TBy0bWAeebXRZ0Mot23DVX4pqVyFaQoXdmkm
56Vr2jGszkLic4M0JoKahUlQpnrZuHIWgFVd/RzXXP9HwYBRQTxaKnNX6eWTdksVvzAImMYoPa4G
PJJFf+gsNAKp5BIFXjwHfNC+Nerc6XzDmxe+pw==

`pragma protect key_keyowner="Real Intent", key_keyname="RI-RSA-KEY-1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
jfnJJlFHpbB8S3PjID3rEIRi4fzY1WUZaITx6CJ38mSZfYSA13DJislb1OQ17w4Hnv5eGM/0GVgA
2jPR4wYaMzC8v3iDfETrH4kyrFglo3a/NDlACuR1U65YoHUnUu0UmMMovxQEnd9ByAfOtabZPL4j
FTvCoVMpwI8rdT4YJQ5pYXryESdM3NUe29p9OWbY1EalisEVViKuSwS4LzwtaOmrPecCE56FGEp+
2iyBMICOFF2PpT8Bqp39Z2rx4xyIiudZKo3LNimTm/UYBCnPAJ7XBIS+JiCIOkHsPER+wNivbtUb
J02F8ZLbEtS0qmUdYDXO4qqhc1njU9O6Uk9yNA==

`pragma protect key_keyowner="Xilinx", key_keyname="xilinxt_2022_10", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
uOK6pXmc+RsarhB5GcgUPkseiDLhaN7KZ4C18Aqea9NqSbvIERAENTml4U58cVlx6j599K+L2aW5
rVMZLtj8UE4yfEDhtivrSdBYh446mqbnToHhH5r4BmzYnr6BUuXVZ4NIUU29WnaJUZxwrvZeCln4
GQCdP1kUA1Ozy9B47ndTYgOzCcZSr9w36W7ZA1gm34lqVpXYuGsaRTvk1DhS96aFGCeiCTbs5HM3
e0JPkZ7YUsMgWuRzE+jHE1TEMVjbPkpPjFGCYOEeDf2bc/2s2fPLA3bxMs61xUFH5LAd7Qrs9D2v
Mx+Vcfvo7kmp3J5LW99NXfA9OvG1JgjJ7ykhmw==

`pragma protect key_keyowner="Metrics Technologies Inc.", key_keyname="DSim", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
OS52LCfxYaApFxxvQUqjJD8DSzwhbsM5irqCX6E4R0iBINlXI3QVmtLKp8vhPICYZWjEuTIVzohU
28vwAOP2ECPWOkJjN+ny9RQeAKmQhPbxHYOysXg4IgtMbK+ZODUoMyLIsJzz2yIFl5qvQeLBnc44
NvqDk7nFLhtrN9De4XV14FKtDvQG0BdWr2mXiS7WiEAQxiww87A0M8yP82JlG6ykYSwQh5G8K6pv
YHoqI8mKAC+KGuDltBnyBrKGip5pRq7Kf+0okVAOwt0lJwDvS0JMNEUg1HK/mEIR6TKUdd8B/fms
4qcaCBYsptjoZVCq4ygSG56x8uaQXMVsEALe2w==

`pragma protect key_keyowner="Atrenta", key_keyname="ATR-SG-RSA-1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=384)
`pragma protect key_block
Aew/RSoMZUIh8oIZPhChM37w+R5unp+7pprfqezjGFUVX16UeT1spPFU1DaqTQvQkXhBe4/aNxvo
Y2eUJsQd8zSC9wBoevCnvwaHEv/IBc+OKmBzOPxO1hHXDVPtDZWdRCx+1y0ZYhQa+NA6jLP2zOJx
/emAZW55AWgZKKJS4QgantVgmUSyKVe/LlIVstraTkF4EzV092mOj1iPH/UqFFno9IwE1aOXuYuT
XrZU9D1dkPLBMg3CDwOi+bXRSgjvuueWT7ostJSFraLwDkurP1pYHHG4NDxYiDxMFWarWeII+T6v
hMJKd/8ZRrh5aHvGV5O/Hdc4rPitxa/cdQPAc0r2e2XWAJIdic09atzXXyU9o2vV/urpMsjSVva4
B5a/PwS16c18IMm6vAeFSLMo0T/jor1Q5SoxEC5QEkxvEfIUjjw7k0b1Crv5EfWz/sJ1LHwqlG7t
az+h03yAqvqGfOHC+7YoilYImR1NiLTCLgxnUfIvxo6woY4SgD+hLki4

`pragma protect key_keyowner="Cadence Design Systems.", key_keyname="CDS_RSA_KEY_VER_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
iZJ+xdyrZbhNc8zYurF70yKiutV2IBjRXDiOZ/7w25UL6rCpY4Pd5gJN3+SNIoQ66bzRxlhaXMNu
tzoCM2kFY4N5ZbCy/S4rtBK0PUHKEVd7c5Btr5gn8BgQWiIafJ8Qa/8xqo95ocakFzN6/V+DNvyN
7FPkXDwuiaD0cmHW8XyOxnHM2b/XKHOibr7UKTRAomXyt7y80BVKpE50ddxXAxw9wlMn+gpW5Kpz
Dp8z4VH3uZrVv8Yl5RWELOQ3Uh0Xizb20mvc6Lu+BNoz0Ys9zZUaqKU71Kuv4s8vgPzrZXXNifo2
pU0aNj0oqAGlSTcTCBF8Tl6/jFvUXQEzYoIfiQ==

`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 2864)
`pragma protect data_block
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
437xG+KeZr0jazbLeLc=
`pragma protect end_protected
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;
    parameter GRES_WIDTH = 10000;
    parameter GRES_START = 10000;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    wire GRESTORE;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;
    reg GRESTORE_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (strong1, weak0) GSR = GSR_int;
    assign (strong1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;
    assign (strong1, weak0) GRESTORE = GRESTORE_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

    initial begin 
	GRESTORE_int = 1'b0;
	#(GRES_START);
	GRESTORE_int = 1'b1;
	#(GRES_WIDTH);
	GRESTORE_int = 1'b0;
    end

endmodule
`endif
