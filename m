Return-Path: <linux-kernel+bounces-353057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6200E9927BE
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 11:03:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC6BA1F23331
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 09:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 064CD18454C;
	Mon,  7 Oct 2024 09:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="cnDeJr9h"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F41228EA;
	Mon,  7 Oct 2024 09:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728291778; cv=none; b=mndizpUMUFBe4TINOYvBitZva3AKtflXFeUfzVWWQG2S6Z4HDciHgcrup2E/CyaCDyHxdQh/cx0EkkqdiBIkEDsFGfmJvTxB/bcjx2RSrNGhQrqnQmXlmd48XlaOP/6uH0xd4ZCffCea7t6RAT67xr77/V1ivs/itRYmRWRt8Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728291778; c=relaxed/simple;
	bh=4MqTx/paSn9vadT8O1mObZh0ibwgYiEuZZuzgoRsbrE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jIbRna93eEbdhQWdnMnsmW0TOyP3WSglTb2ARMEdVWqOw39llh1VKkOL+0t0c2g5eHwKQxBCT+Q2wuPV5iF9kTWeSf4+yESlpIcCgE23yZjYJj1ZuehVYOLaREbo6DRw+Grl4kXdb1K8bYgJcMqM+1BH7hCGJKPFmNywOWEq+TY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=cnDeJr9h; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: ecd57dba848a11efb66947d174671e26-20241007
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=tLD59Qal+yNHH79nNHu2/GDRtEORj0I1HW1oIFM8IC8=;
	b=cnDeJr9hGnPP0LEUn0ZN41DAHIIWnPTHRulhTIZUuaqlJiLOr1/eq9iYZnlYvKBH6oc/YMu9tL8HCGH5NNIwvcfEFfvgj6MrL2SG8zNpTB4Y2HUrXKm0B74vnYma3EI/pNIbxe9Y3E8OG+6No2uxjvNEeQQQKEYY+/OjLKfycB8=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:2e6c0400-efc8-490c-92b7-7de8b5edcfd4,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6dc6a47,CLOUDID:a3926726-5902-4533-af4f-d0904aa89b3c,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: ecd57dba848a11efb66947d174671e26-20241007
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw01.mediatek.com
	(envelope-from <macpaul.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1624306198; Mon, 07 Oct 2024 17:02:48 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 7 Oct 2024 02:02:47 -0700
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 7 Oct 2024 17:02:47 +0800
From: Macpaul Lin <macpaul.lin@mediatek.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
	<matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>, Alexandre Mergnat
	<amergnat@baylibre.com>
CC: Bear Wang <bear.wang@mediatek.com>, Pablo Sun <pablo.sun@mediatek.com>,
	Macpaul Lin <macpaul.lin@mediatek.com>, Macpaul Lin <macpaul@gmail.com>, Sen
 Chu <sen.chu@mediatek.com>, Chris-qj chen <chris-qj.chen@mediatek.com>,
	MediaTek Chromebook Upstream
	<Project_Global_Chrome_Upstream_Group@mediatek.com>, Chen-Yu Tsai
	<wenst@chromium.org>
Subject: [PATCH v2 1/2] arm64: dts: mediatek: mt8390-genio-700-evk: update regulator names
Date: Mon, 7 Oct 2024 17:02:43 +0800
Message-ID: <20241007090244.1731-1-macpaul.lin@mediatek.com>
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

Update regulator names to match schematics, replacing generic terms.
1. Add system wide 'reg_vsys' node for 4.2V power rail.
2. Add 'reg_vsys' node as 'vin-supply' for the following nodes
 - common_fixed_5v, edp_panel_fixed_3v3, gpio_fixed_3v3, sdio_fixed_3v3,
   touch0_fixed_3v3, usb_hub_fixed_3v3, usb_p0_vbus, and usb_p1_vbus.
3. Update regulator names according to the stable output name on
   schematics.
 - vdd_5v, vedp_3v3, ext_3v3, vio18_conn, wifi_3v3, vio33_tp1, vhub_3v3,
   vbus_p0, vbus_p1.
 - vcn18_pmu, vcn33_2_pmu, dvdd_proc_l, dvdd_core, vpa_pmu, dvdd_adsp,
   va12_abb2_pmu, vsim1_pmu, vufs18_pmu.
4. Remove usb_hub_reset_1v8. Use 'hub' node to probe USB HUB
   in subsequent patches.

Suggested-by: Chen-Yu Tsai <wenst@chromium.org>
Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
---
 .../dts/mediatek/mt8390-genio-700-evk.dts     | 65 ++++++++++++-------
 1 file changed, 42 insertions(+), 23 deletions(-)

Changes for v2:
 - Add Suggested-by: tag.
 - Rebase on mediatek/dts64 branch (v6.12-rc1)

diff --git a/arch/arm64/boot/dts/mediatek/mt8390-genio-700-evk.dts b/arch/arm64/boot/dts/mediatek/mt8390-genio-700-evk.dts
index 0a6c9871b41e..96b272567cb1 100644
--- a/arch/arm64/boot/dts/mediatek/mt8390-genio-700-evk.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8390-genio-700-evk.dts
@@ -87,103 +87,113 @@ vpu_mem: memory@57000000 {
 
 	common_fixed_5v: regulator-0 {
 		compatible = "regulator-fixed";
-		regulator-name = "5v_en";
+		regulator-name = "vdd_5v";
 		regulator-min-microvolt = <5000000>;
 		regulator-max-microvolt = <5000000>;
 		gpio = <&pio 10 GPIO_ACTIVE_HIGH>;
 		enable-active-high;
 		regulator-always-on;
+		vin-supply = <&reg_vsys>;
 	};
 
 	edp_panel_fixed_3v3: regulator-1 {
 		compatible = "regulator-fixed";
-		regulator-name = "edp_panel_3v3";
+		regulator-name = "vedp_3v3";
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
 		enable-active-high;
 		gpio = <&pio 15 GPIO_ACTIVE_HIGH>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&edp_panel_3v3_en_pins>;
+		vin-supply = <&reg_vsys>;
 	};
 
 	gpio_fixed_3v3: regulator-2 {
 		compatible = "regulator-fixed";
-		regulator-name = "gpio_3v3_en";
+		regulator-name = "ext_3v3";
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
 		gpio = <&pio 9 GPIO_ACTIVE_HIGH>;
 		enable-active-high;
 		regulator-always-on;
+		vin-supply = <&reg_vsys>;
 	};
 
+	/* system wide 4.2V power rail from charger */
+	reg_vsys: regulator-vsys {
+		compatible = "regulator-fixed";
+		regulator-name = "vsys";
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
+	/* used by mmc2 */
 	sdio_fixed_1v8: regulator-3 {
 		compatible = "regulator-fixed";
-		regulator-name = "sdio_io";
+		regulator-name = "vio18_conn";
 		regulator-min-microvolt = <1800000>;
 		regulator-max-microvolt = <1800000>;
 		enable-active-high;
 		regulator-always-on;
 	};
 
+	/* used by mmc2 */
 	sdio_fixed_3v3: regulator-4 {
 		compatible = "regulator-fixed";
-		regulator-name = "sdio_card";
+		regulator-name = "wifi_3v3";
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
 		gpio = <&pio 74 GPIO_ACTIVE_HIGH>;
 		enable-active-high;
 		regulator-always-on;
+		vin-supply = <&reg_vsys>;
 	};
 
 	touch0_fixed_3v3: regulator-5 {
 		compatible = "regulator-fixed";
-		regulator-name = "touch_3v3";
+		regulator-name = "vio33_tp1";
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
 		gpio = <&pio 119 GPIO_ACTIVE_HIGH>;
 		enable-active-high;
+		vin-supply = <&reg_vsys>;
 	};
 
 	usb_hub_fixed_3v3: regulator-6 {
 		compatible = "regulator-fixed";
-		regulator-name = "usb_hub_3v3";
+		regulator-name = "vhub_3v3";
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
 		gpio = <&pio 112 GPIO_ACTIVE_HIGH>; /* HUB_3V3_EN */
 		startup-delay-us = <10000>;
 		enable-active-high;
+		vin-supply = <&reg_vsys>;
 	};
 
-	usb_hub_reset_1v8: regulator-7 {
-		compatible = "regulator-fixed";
-		regulator-name = "usb_hub_reset";
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <1800000>;
-		gpio = <&pio 7 GPIO_ACTIVE_HIGH>; /* HUB_RESET */
-		vin-supply = <&usb_hub_fixed_3v3>;
-	};
-
-	usb_p0_vbus: regulator-8 {
+	usb_p0_vbus: regulator-7 {
 		compatible = "regulator-fixed";
-		regulator-name = "usb_p0_vbus";
+		regulator-name = "vbus_p0";
 		regulator-min-microvolt = <5000000>;
 		regulator-max-microvolt = <5000000>;
 		gpio = <&pio 84 GPIO_ACTIVE_HIGH>;
 		enable-active-high;
+		vin-supply = <&reg_vsys>;
 	};
 
-	usb_p1_vbus: regulator-9 {
+	usb_p1_vbus: regulator-8 {
 		compatible = "regulator-fixed";
-		regulator-name = "usb_p1_vbus";
+		regulator-name = "vbus_p1";
 		regulator-min-microvolt = <5000000>;
 		regulator-max-microvolt = <5000000>;
 		gpio = <&pio 87 GPIO_ACTIVE_HIGH>;
 		enable-active-high;
+		vin-supply = <&reg_vsys>;
 	};
 
-	usb_p2_vbus: regulator-10 {
+	/* used by ssusb2 */
+	usb_p2_vbus: regulator-9 {
 		compatible = "regulator-fixed";
-		regulator-name = "usb_p2_vbus";
+		regulator-name = "wifi_3v3";
 		regulator-min-microvolt = <5000000>;
 		regulator-max-microvolt = <5000000>;
 		enable-active-high;
@@ -308,22 +318,27 @@ &mt6359_vbbck_ldo_reg {
 };
 
 &mt6359_vcn18_ldo_reg {
+	regulator-name = "vcn18_pmu";
 	regulator-always-on;
 };
 
 &mt6359_vcn33_2_bt_ldo_reg {
+	regulator-name = "vcn33_2_pmu";
 	regulator-always-on;
 };
 
 &mt6359_vcore_buck_reg {
+	regulator-name = "dvdd_proc_l";
 	regulator-always-on;
 };
 
 &mt6359_vgpu11_buck_reg {
+	regulator-name = "dvdd_core";
 	regulator-always-on;
 };
 
 &mt6359_vpa_buck_reg {
+	regulator-name = "vpa_pmu";
 	regulator-max-microvolt = <3100000>;
 };
 
@@ -337,14 +352,17 @@ &mt6359_vproc2_buck_reg {
 };
 
 &mt6359_vpu_buck_reg {
+	regulator-name = "dvdd_adsp";
 	regulator-always-on;
 };
 
 &mt6359_vrf12_ldo_reg {
+	regulator-name = "va12_abb2_pmu";
 	regulator-always-on;
 };
 
 &mt6359_vsim1_ldo_reg {
+	regulator-name = "vsim1_pmu";
 	regulator-enable-ramp-delay = <480>;
 };
 
@@ -358,6 +376,7 @@ &mt6359_vsram_others_ldo_reg {
 };
 
 &mt6359_vufs_ldo_reg {
+	regulator-name = "vufs18_pmu";
 	regulator-always-on;
 };
 
@@ -902,10 +921,10 @@ &xhci0 {
 &xhci1 {
 	status = "okay";
 	vusb33-supply = <&mt6359_vusb_ldo_reg>;
-	vbus-supply = <&usb_hub_reset_1v8>;
 };
 
 &xhci2 {
 	status = "okay";
 	vusb33-supply = <&mt6359_vusb_ldo_reg>;
+	vbus-supply = <&sdio_fixed_3v3>; /* wifi_3v3 */
 };
-- 
2.45.2


