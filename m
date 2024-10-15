Return-Path: <linux-kernel+bounces-365571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B91B399E480
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 12:49:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79CB5283702
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 10:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 722C21E8855;
	Tue, 15 Oct 2024 10:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="dBmto+kN"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 676011DE2C5;
	Tue, 15 Oct 2024 10:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728989356; cv=none; b=iTtMIXHBC1L92HYYOin8NbZeHNuVnjLiQUIaigjQmz1FHrqTyaWIW2MqNWZ+AP0mmYgSRN7AprhYMZhmPF9nZoS3jIJONLrTolR8HDfx+RRB0k/yWiIvP5Ho7L8tfobn2AlsTv227jo1hQAshi4xK17xJOCQl+aU6NhbQkWKBQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728989356; c=relaxed/simple;
	bh=FOWdonqKACBG/O/a4NhCjuo9Ddc65VP5qbM04dAQ2hc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ay7+htevp7RF6Fts3Q2Q6/MLCqiIFWIpdUmHqaV2MIxGqiLAeMTlKpz4aC9MZSM9wUzqfKuhzp/+1f5eMrDVwPVUYVZJBMrXv8xo3eUzKPxwtieUc5WUTWLrvyLcbbJRXIcWHMOKQQitKHx+6GY+dmOqA2jlbQp0AdJbk6Ql7sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=dBmto+kN; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: fca872a48ae011ef8b96093e013ec31c-20241015
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=46mZ5GJZQgy4wb+8yI+bn0sWqlOFsJy9zMO5GZshhYo=;
	b=dBmto+kNUK/lZUp0Hi9bBvquPfH071lOaXMRJx3S0+2QUgid9VACDg8auZjSFrPeK5ZM3AjwBAzrL4x6zl1AMKmlDa8FgjBQUTK5O8EEVRoiPTBooLH9EJJ/5S24RyQzVg8r/uNw6ce86gJupWF6HFi8Eb8iRXRzJtT/WKnkF7s=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:42f73d5b-c846-4422-87ea-6e5db319dafb,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6dc6a47,CLOUDID:097fd106-3d5c-41f6-8d90-a8be388b5b5b,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: fca872a48ae011ef8b96093e013ec31c-20241015
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw02.mediatek.com
	(envelope-from <macpaul.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 663815740; Tue, 15 Oct 2024 18:33:58 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 15 Oct 2024 18:33:56 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 15 Oct 2024 18:33:56 +0800
From: Macpaul Lin <macpaul.lin@mediatek.com>
To: Chunfeng Yun <chunfeng.yun@mediatek.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	"Matthias Brugger" <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, ChiYuan Huang
	<cy_huang@richtek.com>, <linux-usb@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Bear Wang <bear.wang@mediatek.com>, Pablo Sun <pablo.sun@mediatek.com>,
	Macpaul Lin <macpaul.lin@mediatek.com>, Macpaul Lin <macpaul@gmail.com>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>, Chris-qj chen
	<chris-qj.chen@mediatek.com>, Fabien Parent <fparent@baylibre.com>, Simon Sun
	<simon.sun@yunjingtech.com>
Subject: [PATCH 2/2] arm64: dts: mediatek: mt8395-genio-1200-evk: add support for TCPC port
Date: Tue, 15 Oct 2024 18:33:37 +0800
Message-ID: <20241015103337.20479-2-macpaul.lin@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20241015103337.20479-1-macpaul.lin@mediatek.com>
References: <20241015103337.20479-1-macpaul.lin@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--3.087400-8.000000
X-TMASE-MatchedRID: Rxvf+mQJcSjL05PW1HuK4hcqpH7D1rtQE21NSmBqEKdeARTvhomDCuHM
	eGIgxik9FU2rnI3D77gOHPadhy5U4iUyFVKm+WpVMZ8cIdf+aBRhBfGxmdHCgvHFoBcOsKezmQJ
	6sUxppuKjkL1tNPFpRsZqGjAGu4ch71K1g/S2Z7cQ9/tMNQ4aipSL3AH2CZxKAfnelbSvK7z+/e
	pfiALZfjX5qFNuFL7ljdYbhXOHYJUfE8yM4pjsDwtuKBGekqUpm+MB6kaZ2g55Bwpd6xJsJwss9
	KgMSo3mfrGPTbsXwGPyUWByt6T+uCofFl27RgzTlBOk5L4/h4cNzbvTBDU7hBglWB0w9QO2hYAi
	cWtJQzzyNp7g4PXe0BXsxz6ujBxUq1f8XSkHBUmNJXmEMVvLtmcjFnImzvyS
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--3.087400-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	C6D7F85AEBD0D5129E358CA1986CEF593FF6154C17636121425DFB97FD909F8C2000:8
X-MTK: N

From: Fabien Parent <fparent@baylibre.com>

Enable USB Type-C support on MediaTek MT8395 Genio 1200 EVK by adding
configuration for TCPC Port, USB-C connector, and related settings.

Configure dual role switch capability, set up PD (Power Delivery) profiles,
and establish endpoints for SSUSB (SuperSpeed USB).

Update pinctrl configurations for U3 P0 VBus default pins and set dr_mode
to "otg" for OTG (On-The-Go) mode operation.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
Signed-off-by: Simon Sun <simon.sun@yunjingtech.com>
Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
---
 .../dts/mediatek/mt8395-genio-1200-evk.dts    | 51 +++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8395-genio-1200-evk.dts b/arch/arm64/boot/dts/mediatek/mt8395-genio-1200-evk.dts
index 5f16fb820580..b91a46f4a702 100644
--- a/arch/arm64/boot/dts/mediatek/mt8395-genio-1200-evk.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8395-genio-1200-evk.dts
@@ -249,6 +249,39 @@ mt6360: pmic@34 {
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
+			};
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+					mt6360_ssusb_ep: endpoint {
+						remote-endpoint = <&ssusb_ep>;
+					};
+				};
+			};
+		};
+
 		charger {
 			compatible = "mediatek,mt6360-chg";
 			richtek,vinovp-microvolt = <14500000>;
@@ -446,6 +479,13 @@ &pciephy {
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
@@ -900,8 +940,19 @@ &ufsphy {
 };
 
 &ssusb0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&u3_p0_vbus>;
 	vusb33-supply = <&mt6359_vusb_ldo_reg>;
+	dr_mode = "otg";
+	mediatek,usb3-drd;
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


