Return-Path: <linux-kernel+bounces-377515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C58B9ABFDC
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 09:12:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0380C1F22713
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 07:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AB5814F10E;
	Wed, 23 Oct 2024 07:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="puLjNlWA"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1655114AD2B;
	Wed, 23 Oct 2024 07:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729667562; cv=none; b=UF6ZQmBVsAaAVO+US8O3/R8YPP+b0+bnNedqUNjKuTo8MOWCiIvqwE/B6VWsRqh7tQO91igcqtM9deMQ8ecjRQGsUWdctit6eQuIPyiVRUFU2LxaEy5dVaI/hvY533L/Kill5MG34I4Ve2iEAk88InrSRoQV39qmsjlsDpnK5j0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729667562; c=relaxed/simple;
	bh=beUL0rmIcem0SZRDP7ppXOGt2752o+FCQ4bSciydZK8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jcEOZxoC3Q8ZPUO9eUcQJOmoDX+CE3IynOJH7mYdLWrze02arZ8cDGCv82+kolTvpBsmy54IbFzDLMLfKycaVa1Er70iFUywoZ865szzClRKV6u1+wkOnZYqU3WZQ00pUbsZo955VSu8haSUcvVVgyoXJ/I5Om+vTDgDVR9hORM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=puLjNlWA; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 2d06e452910e11efb88477ffae1fc7a5-20241023
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=5DyChpYdm3ksXmmJjhWN/WFnsoQhtsbl9u4kQ/VRbik=;
	b=puLjNlWATTNEm026Tv0A8I6eOTE8ocIrW6mGmmw9ZyFyNpG9G1AVi26A1YfcSzX8x6mA7CO3ahUG/PySxl+hnR4Z9k1g4Eed9HKiwupA5TEUmbzSy2HVvyLB702S3YZzLOLPGK7JrpFe48sAvEHOTRYAnav4wdwgRh7EKzOw6uc=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.42,REQID:4a15ce66-3c93-4bce-be7c-9041ad899761,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:b0fcdc3,CLOUDID:5ee6f92d-a7a0-4b06-8464-80be82133975,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 2d06e452910e11efb88477ffae1fc7a5-20241023
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
	(envelope-from <macpaul.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1393681879; Wed, 23 Oct 2024 15:12:34 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 23 Oct 2024 00:12:32 -0700
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 23 Oct 2024 15:12:32 +0800
From: Macpaul Lin <macpaul.lin@mediatek.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
	<matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
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
Subject: [PATCH v2 1/2] arm64: dts: mediatek: mt8395-genio-1200-evk: add support for TCPC port
Date: Wed, 23 Oct 2024 15:12:25 +0800
Message-ID: <20241023071226.14090-1-macpaul.lin@mediatek.com>
X-Mailer: git-send-email 2.18.0
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
configuration for TCPC Port, USB-C connector, and related settings.

Configure dual role switch capability, set up PD (Power Delivery) profiles,
and establish endpoints for SSUSB (SuperSpeed USB).

Update pinctrl configurations for U3 P0 VBus default pins and set dr_mode
to "otg" for OTG (On-The-Go) mode operation.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
Signed-off-by: Yow-Shin Liou <yow-shin.liou@mediatek.com>
Signed-off-by: Simon Sun <simon.sun@yunjingtech.com>
Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
---
 .../dts/mediatek/mt8395-genio-1200-evk.dts    | 54 +++++++++++++++++++
 1 file changed, 54 insertions(+)

Changes for v2:
 - Drop the no need '1/2' DT Schema update patch in the 1st version.  
 - Fix intent for 'ports' node, it should under the 'connector' node.
 - Correct the index for 'port@0' and 'port@1' node.

diff --git a/arch/arm64/boot/dts/mediatek/mt8395-genio-1200-evk.dts b/arch/arm64/boot/dts/mediatek/mt8395-genio-1200-evk.dts
index 5f16fb820580..195e486d9101 100644
--- a/arch/arm64/boot/dts/mediatek/mt8395-genio-1200-evk.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8395-genio-1200-evk.dts
@@ -249,6 +249,43 @@ mt6360: pmic@34 {
 		#interrupt-cells = <1>;
 		pinctrl-0 = <&mt6360_pins>;
 
+		tcpc {
+			compatible = "mediatek,mt6360-tcpc";
+			interrupts-extended = <&pio 17 IRQ_TYPE_LEVEL_LOW>;
+			interrupt-names = "PD_IRQB";
+
+			connector {
+				compatible = "usb-c-connector";
+				label = "USB-C";
+				data-role = "dual";
+				power-role = "dual";
+				try-power-role = "sink";
+				source-pdos = <PDO_FIXED(5000, 1000, \
+					       PDO_FIXED_DUAL_ROLE | \
+					       PDO_FIXED_DATA_SWAP)>;
+				sink-pdos = <PDO_FIXED(5000, 2000, \
+					     PDO_FIXED_DUAL_ROLE | \
+					     PDO_FIXED_DATA_SWAP)>;
+				op-sink-microwatt = <10000000>;
+
+				ports {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					port@0 {
+						reg = <0>;
+					};
+
+					port@1 {
+						reg = <1>;
+						mt6360_ssusb_ep: endpoint {
+							remote-endpoint = <&ssusb_ep>;
+						};
+					};
+				};
+			};
+		};
+
 		charger {
 			compatible = "mediatek,mt6360-chg";
 			richtek,vinovp-microvolt = <14500000>;
@@ -446,6 +483,13 @@ &pciephy {
 };
 
 &pio {
+	u3_p0_vbus: u3-p0-vbus-default-pins {
+		pins-cmd-dat {
+			pinmux = <PINMUX_GPIO63__FUNC_VBUSVALID>;
+			input-enable;
+		};
+	};
+
 	audio_default_pins: audio-default-pins {
 		pins-cmd-dat {
 			pinmux = <PINMUX_GPIO61__FUNC_DMIC1_CLK>,
@@ -900,8 +944,18 @@ &ufsphy {
 };
 
 &ssusb0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&u3_p0_vbus>;
 	vusb33-supply = <&mt6359_vusb_ldo_reg>;
+	dr_mode = "otg";
+	usb-role-switch;
 	status = "okay";
+
+	port {
+		ssusb_ep: endpoint {
+			remote-endpoint = <&mt6360_ssusb_ep>;
+		};
+	};
 };
 
 &ssusb2 {
-- 
2.45.2


