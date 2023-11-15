// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2023 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2023.1 (win64) Build 3865809 Sun May  7 15:05:29 MDT 2023
// Date        : Sat Nov 11 14:21:31 2023
// Host        : LAPTOP-P2TTF1UO running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim
//               d:/col215/hw3_2/hw3_2.gen/sources_1/ip/filter_rom/filter_rom_sim_netlist.v
// Design      : filter_rom
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7a35tcpg236-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "filter_rom,dist_mem_gen_v8_0_13,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "dist_mem_gen_v8_0_13,Vivado 2023.1" *) 
(* NotValidForBitStream *)
module filter_rom
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
  filter_rom_dist_mem_gen_v8_0_13 U0
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
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 2880)
`pragma protect data_block
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
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
