Return-Path: <linux-kernel+bounces-528943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D984A41E42
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 13:04:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0892188A36C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 11:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E71825C71E;
	Mon, 24 Feb 2025 11:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="PxbeCiXP"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 246D2158870;
	Mon, 24 Feb 2025 11:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740397809; cv=none; b=GVm8cyaJ6cwqNKlcrRGBh/PqcyEvDyX5t8k1sEGaLhD9oksKTmAVLnJnx0X/KMVJgF94Y2PFgmO+g1g3whEWAibCYWw+7MVNA6cwsio1vZOPYK3krkXZ/n4ISTjy9YTrVgIAGISJn2ZCgj3wkZBAbPRLjYFd4vH6FuMI+Lf5huA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740397809; c=relaxed/simple;
	bh=PSWqmG5uRw23IQ/mMzq14qL5ztMdUMVj9Gatu+r66gE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=so67LLDZXTOYIVMwtcMm4SXQB1w5I/xG8UJ5X6YRkpL34WhDHG75dzmYtlLe9hmtUBqU2j1Fb3AczPpDFaverFC0/3x1IVAXXoCWhLg1VbBIAnxP6tU+h0wYU3KB/zXRuWD4qYdvBv5fQ2qci4zD30e0p/EvsLOfDrM2mwJKlSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=PxbeCiXP; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 7a6a3840f2a511efaae1fd9735fae912-20250224
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=1yXoVn4d41rL3z4hjc5R72fder7LjdF+dcCF5p2tEkw=;
	b=PxbeCiXPMQuB0+w5zWALDbCctmV/PpoPrs9vqW2N/I3kulIjpnx+TehEwMhjJJeHcv8BAerOaNpMSLPbDMIo7KNd1i0y7Ag1goqoQnVrjdX4FLNvl+hrO3wv8/6258GTenJhtM0tZUcgHHFaEW+3QFKVUvXU0xwjR6yijk/kC5Q=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.46,REQID:b17fa284-d12b-4c4f-b479-d4fa89ac5dfe,IP:0,U
	RL:0,TC:0,Content:0,EDM:-25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:60aa074,CLOUDID:637244dc-d480-4873-806f-0f365159227b,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|50,EDM:1|19,IP:
	nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,L
	ES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 7a6a3840f2a511efaae1fd9735fae912-20250224
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
	(envelope-from <macpaul.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1041160626; Mon, 24 Feb 2025 19:50:00 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Mon, 24 Feb 2025 19:49:59 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.28 via Frontend Transport; Mon, 24 Feb 2025 19:49:59 +0800
From: Macpaul Lin <macpaul.lin@mediatek.com>
To: ChiYuan Huang <cy_huang@richtek.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>, Alexandre Mergnat
	<amergnat@baylibre.com>
CC: Bear Wang <bear.wang@mediatek.com>, Pablo Sun <pablo.sun@mediatek.com>,
	Macpaul Lin <macpaul.lin@mediatek.com>, Macpaul Lin <macpaul@gmail.com>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>,
	<linux-usb@vger.kernel.org>, Chris-qj chen <chris-qj.chen@mediatek.com>,
	Fabien Parent <fparent@baylibre.com>, Yow-Shin Liou
	<yow-shin.liou@mediatek.com>, Simon Sun <simon.sun@yunjingtech.com>
Subject: [PATCH v6] arm64: dts: mediatek: mt8395-genio-1200-evk: add support for TCPC port
Date: Mon, 24 Feb 2025 19:49:34 +0800
Message-ID: <20250224114934.3583191-1-macpaul.lin@mediatek.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK: N

From: Fabien Parent <fparent@baylibre.com>

Enable USB Type-C support on MediaTek MT8395 Genio 1200 EVK by adding
configuration for TCPC Port, USB-C connector, MUX IT5205 and related
settings.

Configure dual role switch capability, set up PD (Power Delivery) profiles,
and establish endpoints for SS (SuperSpeed) and HS (HighSpeed) USB.

Update pinctrl configurations for U3 P0 VBus default pins and set dr_mode
to "otg" for OTG (On-The-Go) mode operation.

Add ITE IT5205 (TYPEC MUX) under I2C2 bus and configure its properties;
also add references and configurations to 'typec-mux' node.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
Signed-off-by: Yow-Shin Liou <yow-shin.liou@mediatek.com>
Signed-off-by: Simon Sun <simon.sun@yunjingtech.com>
Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 .../dts/mediatek/mt8395-genio-1200-evk.dts    | 102 ++++++++++++++++++
 1 file changed, 102 insertions(+)

Changes for v2:
 - Drop the no need '1/2' DT Schema update patch in the 1st version.  
 - Fix indent for 'ports' node, it should under the 'connector' node.
 - Correct the index for 'port@0' and 'port@1' node.

Changes for v3:
 - Correct the order between new added nodes.

Changes for v4:
 - Reorder for property 'op-sink-microwatt'.
 - Fix indentation for 'source-pdos' and 'sink-pdos' nodes.
 - Correct node 'pin-cmd-dat' with 'pins-vbus'.
 - Add both Highspeed and Superspeed ports to ssusb0 port.
 - Set 'role-switch-default-mode' = "peripheral" for ssusb0 port.
 - Rename endpoint of USB data port to 'mtu3_hs0_role_sw' and
   'mtu3_ss0_role_sw'.
 - Drop it5205fn phandle for node typec-mux@48.
 - Reorder properties of typec-mux@48
 - Add "Reviewed-by:" tag. Thanks!

Changes for v5:
 - Squash two patches into one patch and refine commit messages:
   suggested by reviewer.
 - Drop 'role-switch-default-mode'
 - Add altmodes settings
 - Drop 'Reviewed-by:' tag since the two sub patches has been combined
   into a new patch.

Changes for v6:
 - Add 'pd-revision' property to 'connector', thanks ChiYuan Huang's help!.
 - Add 'Reviewed-by' tag. Thanks!

diff --git a/arch/arm64/boot/dts/mediatek/mt8395-genio-1200-evk.dts b/arch/arm64/boot/dts/mediatek/mt8395-genio-1200-evk.dts
index 5950194c9ccb..f02c32def593 100644
--- a/arch/arm64/boot/dts/mediatek/mt8395-genio-1200-evk.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8395-genio-1200-evk.dts
@@ -229,6 +229,21 @@ &i2c2 {
 	pinctrl-0 = <&i2c2_pins>;
 	pinctrl-names = "default";
 	status = "okay";
+
+	typec-mux@48 {
+		compatible = "ite,it5205";
+		reg = <0x48>;
+		vcc-supply = <&mt6359_vibr_ldo_reg>;
+		mode-switch;
+		orientation-switch;
+		status = "okay";
+
+		port {
+			it5205_sbu_ep: endpoint {
+				remote-endpoint = <&mt6360_ssusb_sbu_ep>;
+			};
+		};
+	};
 };
 
 &i2c6 {
@@ -335,6 +350,63 @@ mt6360_ldo7: ldo7 {
 				regulator-always-on;
 			};
 		};
+
+		tcpc {
+			compatible = "mediatek,mt6360-tcpc";
+			interrupts-extended = <&pio 17 IRQ_TYPE_LEVEL_LOW>;
+			interrupt-names = "PD_IRQB";
+
+			connector {
+				compatible = "usb-c-connector";
+				label = "USB-C";
+				data-role = "dual";
+				op-sink-microwatt = <10000000>;
+				power-role = "dual";
+				try-power-role = "sink";
+
+				source-pdos = <PDO_FIXED(5000, 1000,
+							 PDO_FIXED_DUAL_ROLE |
+							 PDO_FIXED_DATA_SWAP)>;
+				sink-pdos = <PDO_FIXED(5000, 2000,
+						       PDO_FIXED_DUAL_ROLE |
+						       PDO_FIXED_DATA_SWAP)>;
+
+				pd-revision = /bits/ 8 <0x03 0x01 0x01 0x06>;
+
+				altmodes {
+					displayport {
+						svid = /bits/ 16 <0xff01>;
+						vdo = <0x00001c46>;
+					};
+				};
+
+				ports {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					port@0 {
+						reg = <0>;
+						typec_con_hs: endpoint {
+							remote-endpoint = <&mtu3_hs0_role_sw>;
+						};
+					};
+
+					port@1 {
+						reg = <1>;
+						typec_con_ss: endpoint {
+							remote-endpoint = <&mtu3_ss0_role_sw>;
+						};
+					};
+
+					port@2 {
+						reg = <2>;
+						mt6360_ssusb_sbu_ep: endpoint {
+							remote-endpoint = <&it5205_sbu_ep>;
+						};
+					};
+				};
+			};
+		};
 	};
 };
 
@@ -770,6 +842,13 @@ pins-reset {
 		};
 	};
 
+	u3_p0_vbus: u3-p0-vbus-default-pins {
+		pins-vbus {
+			pinmux = <PINMUX_GPIO63__FUNC_VBUSVALID>;
+			input-enable;
+		};
+	};
+
 	uart0_pins: uart0-pins {
 		pins {
 			pinmux = <PINMUX_GPIO98__FUNC_UTXD0>,
@@ -898,8 +977,31 @@ &ufsphy {
 };
 
 &ssusb0 {
+	dr_mode = "otg";
+	pinctrl-names = "default";
+	pinctrl-0 = <&u3_p0_vbus>;
+	usb-role-switch;
 	vusb33-supply = <&mt6359_vusb_ldo_reg>;
 	status = "okay";
+
+	ports {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		port@0 {
+			reg = <0>;
+			mtu3_hs0_role_sw: endpoint {
+				remote-endpoint = <&typec_con_hs>;
+			};
+		};
+
+		port@1 {
+			reg = <1>;
+			mtu3_ss0_role_sw: endpoint {
+				remote-endpoint = <&typec_con_ss>;
+			};
+		};
+	};
 };
 
 &ssusb2 {
-- 
2.45.2


