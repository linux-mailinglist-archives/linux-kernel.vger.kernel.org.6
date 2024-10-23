Return-Path: <linux-kernel+bounces-377598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 477E69AC111
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 10:09:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6C8D1F228E2
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 08:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0F31158555;
	Wed, 23 Oct 2024 08:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="uosTkOjU"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30E8C153BD7;
	Wed, 23 Oct 2024 08:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729670966; cv=none; b=WSDwQuNQVT2/8TFq0rRVV2vVZRe5QXuhEd3wuhDWtyQP5i8k260FVPINx0muX3j2/GaLpTVOTNqumPbE9/1lfVRSwUMZwoX4VYrr9dNXopmjQkwmjN1SLXcxYUbLul962Gnw3Xtt3j2vUaZZulZ8ESPTbcUTMCfcdh8DwayLLNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729670966; c=relaxed/simple;
	bh=b9rIGqkwFiF+b1e6pMCLITJkoINEPLKpPW+O+tiLKek=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OOYAW+BTKb224rpa8sa/Yibkj6gZ3EJYi6ia5TuJnC8zYE6SDuKci1BCkQ48mTP7+Y6NhCTfyfPbqixb+W5oS0kaIZrGgLk50XyREfHZwQwIDt0YB1t5J/65nckkxwme0grT6zTUMVE3NhOszotA8YyAulDvJa9n4IqQCP/BkR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=uosTkOjU; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 194a1daa911611efbd192953cf12861f-20241023
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=1DC0MZ+8RliOZSB75DH8kd3TwbqOFjqN7QSkI/xXet0=;
	b=uosTkOjUXhPoqgTtjWERjY2QR2OyU/MiBpFbPwKaLpVMLbnTpTCZP9CP3zXlVTSAhxxBETdo1VbApwRqTOehxrZWmz5RhqK/seci/NPTUtymRZp/rch1fQM8Yo28NPm+yx62oAPWy3UYAfsaDA2rVOCaXLzoNg3/JuosUZe+IIc=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.42,REQID:fb9f2bc7-c86c-4add-9659-62c70111ea83,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:b0fcdc3,CLOUDID:3e04b441-8751-41b2-98dd-475503d45150,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 194a1daa911611efbd192953cf12861f-20241023
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
	(envelope-from <macpaul.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1632562414; Wed, 23 Oct 2024 16:09:17 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 23 Oct 2024 16:09:15 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 23 Oct 2024 16:09:15 +0800
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
Subject: [PATCH v3 1/2] arm64: dts: mediatek: mt8395-genio-1200-evk: add support for TCPC port
Date: Wed, 23 Oct 2024 16:09:11 +0800
Message-ID: <20241023080912.15349-1-macpaul.lin@mediatek.com>
X-Mailer: git-send-email 2.18.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--4.063000-8.000000
X-TMASE-MatchedRID: jrpkWNovQHLL05PW1HuK4hcqpH7D1rtQE21NSmBqEKdeARTvhomDCuHM
	eGIgxik9FU2rnI3D77gOHPadhy5U4iUyFVKm+WpVMZ8cIdf+aBRhBfGxmdHCgvHFoBcOsKezmQJ
	6sUxppuIriEKQi78d2EIIZCwYBulFL0W1btd8e55H4a2iJdV4MdiK7AdEh6lNi093rJhkH8DeSC
	fd3mLQsdz6+jdXWZjHIUmX+V9fKhLSuXLpNqOJSQ2HDswcCnIjFk73i4rVVIEL7naABknk8qPFj
	JEFr+olwXCBO/GKkVqOhzOa6g8KrUejv7saCNrxDkDf5XgSMVjSgRuPc0nbfBQdxtQMtuV3bTJk
	Ocw4jjZoosmzpgSGI9wd5pmRNJ9i6cN15/z/mmzyzY8c1oKYwOLDq7G+Ik/yv22xKJRyIGVDnOx
	ozmpp1r+WvXJiKHRLMw/B2eF7ydmUTGVAhB5EbQ==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--4.063000-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	29A60159753BBF7D539EB962A6F99A9AA4213D7938370545EF29296C4B93CDEB2000:8
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

Changes for v3:
 - Correct the order between new added nodes.

diff --git a/arch/arm64/boot/dts/mediatek/mt8395-genio-1200-evk.dts b/arch/arm64/boot/dts/mediatek/mt8395-genio-1200-evk.dts
index 5f16fb820580..83d520226302 100644
--- a/arch/arm64/boot/dts/mediatek/mt8395-genio-1200-evk.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8395-genio-1200-evk.dts
@@ -335,6 +335,43 @@ mt6360_ldo7: ldo7 {
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
 	};
 };
 
@@ -770,6 +807,13 @@ pins-reset {
 		};
 	};
 
+	u3_p0_vbus: u3-p0-vbus-default-pins {
+		pins-cmd-dat {
+			pinmux = <PINMUX_GPIO63__FUNC_VBUSVALID>;
+			input-enable;
+		};
+	};
+
 	uart0_pins: uart0-pins {
 		pins {
 			pinmux = <PINMUX_GPIO98__FUNC_UTXD0>,
@@ -900,8 +944,18 @@ &ufsphy {
 };
 
 &ssusb0 {
+	dr_mode = "otg";
+	pinctrl-names = "default";
+	pinctrl-0 = <&u3_p0_vbus>;
+	usb-role-switch;
 	vusb33-supply = <&mt6359_vusb_ldo_reg>;
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


