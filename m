Return-Path: <linux-kernel+bounces-341618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E16D498827F
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 12:32:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77F23282763
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 10:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2333C1BD4E0;
	Fri, 27 Sep 2024 10:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="sdHECydX"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DBB01BC9FE;
	Fri, 27 Sep 2024 10:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727433065; cv=none; b=nxdQ3xEEIG1ghu3JyqmFKnO2x7rvnJMhxyi1UNjupicF5lTTasy7yg+/szNW5E3J8t2OG0wnwI+qpNRcPyECZ+D+jkaWMQLpzGgjI/WfyXUkkZGUVVvsD1wbzZVgbZDo09oXhBeg9wsjJHcWPI48/0heWPrSb/F8g5VkqGaPSbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727433065; c=relaxed/simple;
	bh=KaWPXepJuehfSjJcLHhJ8i3X/9cBCKdeHAGOKeUpX4M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OPiIRThK/t+6OUoHbnUv2VAfI5TLJ/wViDkto9ku3j05LUUQZ7OVTD0k/wnVcPVV5htmZkCFf07F+KyFUpJbjg2tiRPdfCzhCRaKX3lMzYlXGkXCJFA9roCOUp6Ea965s+i/qsSPjFSraML0Oopqv4YgHFnzs27iUpemg44rWi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=sdHECydX; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 96177c2a7cbb11ef8b96093e013ec31c-20240927
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=7pX6Bx2UDow/yH3v2m2llMgyTYlhfmP3tKJ6OGoPnUw=;
	b=sdHECydXUPxJbzrcVaSLHNJ3nJrQxaRYBjHSiskm9Xk7X3yfiSe7iJBOnu4c+QPoyHIzkOcX4+lxISQPPDoi2I3HLvM5fg0QwIDsBqrNN2cLMDDpMMp+ujT6bBPMY8gneP82ZYeHVSDfzSn5h5Zj2s41AbOHZa2vgN4oLrYhw5c=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:62755ebe-8a4e-4c01-8092-ae3462cbcac8,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6dc6a47,CLOUDID:c2de5a18-b42d-49a6-94d2-a75fa0df01d2,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_ULS,TF_CID_SPAM_SNR
X-UUID: 96177c2a7cbb11ef8b96093e013ec31c-20240927
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
	(envelope-from <pablo.sun@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 740005951; Fri, 27 Sep 2024 18:30:59 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 27 Sep 2024 03:30:57 -0700
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 27 Sep 2024 18:30:57 +0800
From: Pablo Sun <pablo.sun@mediatek.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
	<matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, Michael Turquette
	<mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Srinivas
 Kandagatla <srinivas.kandagatla@linaro.org>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	<linux-clk@vger.kernel.org>, Pablo Sun <pablo.sun@mediatek.com>
Subject: [PATCH v2 6/6] arm64: dts: mediatek: mt8390-genio-700-evk: Enable Mali GPU
Date: Fri, 27 Sep 2024 18:30:05 +0800
Message-ID: <20240927103005.17605-7-pablo.sun@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20240927103005.17605-1-pablo.sun@mediatek.com>
References: <20240927103005.17605-1-pablo.sun@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N

Configure GPU regulator supplies and enable GPU for GENIO 700 EVK.

The GPU in MT8390 & MT8188 has two power inputs: "DVDD_GPU" and
"DVDD_SRAM_GPU". In Genio 700 EVK, DVDD_GPU is supplied by
mt6359_vproc2_buck_reg, and DVDD_SRAM_GPU is supplied by
mt6359_vsram_others_ldo_reg.

According to section 5.2 "Recommended Operating Conditions" in
MT8390 IoT Application Processor Datasheet v1.9, The recommended
operating voltage ranges are:

- DVDD_GPU: min 0.55V, max 0.86V, typical 0.75V
- DVDD_SRAM_GPU: min 0.71V, max 0.92V, typical 0.85V

To further optimize power saving, we couple DVDD_SRAM_GPU to
DVDD_GPU according to the following relation:

- For opp-880000000 or lower frequency, keep 0.75V
- For opp-915000000 and higher, DVDD_SRAM_GPU should follow
  DVDD_GPU. The exact voltage for DVDD_GPU should be decided by
  speed binning.

This rule is derived from the OPP table in the link.

In addition, set the voltage spread to 6250 uV, the step size of
'ldo_vsram_others' regulator of mt6359, otherwise the regulator
set_voltage operation fails.

Link: https://gitlab.com/mediatek/aiot/rity/meta-mediatek-bsp/-/blob/eedd6aedd4b0cfc0ee79b9c9b9650dfa73cf87f6/recipes-kernel/dtbo/mt8390/gpu-mali.dts
Signed-off-by: Pablo Sun <pablo.sun@mediatek.com>
Suggested-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 .../dts/mediatek/mt8390-genio-700-evk.dts     | 31 +++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8390-genio-700-evk.dts b/arch/arm64/boot/dts/mediatek/mt8390-genio-700-evk.dts
index 1474bef7e754..0a6c9871b41e 100644
--- a/arch/arm64/boot/dts/mediatek/mt8390-genio-700-evk.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8390-genio-700-evk.dts
@@ -190,6 +190,11 @@ usb_p2_vbus: regulator-10 {
 	};
 };
 
+&gpu {
+	mali-supply = <&mt6359_vproc2_buck_reg>;
+	status = "okay";
+};
+
 &i2c0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&i2c0_pins>;
@@ -253,6 +258,14 @@ &i2c6 {
 	status = "okay";
 };
 
+&mfg0 {
+	domain-supply = <&mt6359_vproc2_buck_reg>;
+};
+
+&mfg1 {
+	domain-supply = <&mt6359_vsram_others_ldo_reg>;
+};
+
 &mmc0 {
 	status = "okay";
 	pinctrl-names = "default", "state_uhs";
@@ -314,6 +327,15 @@ &mt6359_vpa_buck_reg {
 	regulator-max-microvolt = <3100000>;
 };
 
+&mt6359_vproc2_buck_reg {
+	/* The name "vgpu" is required by mtk-regulator-coupler */
+	regulator-name = "vgpu";
+	regulator-min-microvolt = <550000>;
+	regulator-max-microvolt = <800000>;
+	regulator-coupled-with = <&mt6359_vsram_others_ldo_reg>;
+	regulator-coupled-max-spread = <6250>;
+};
+
 &mt6359_vpu_buck_reg {
 	regulator-always-on;
 };
@@ -326,6 +348,15 @@ &mt6359_vsim1_ldo_reg {
 	regulator-enable-ramp-delay = <480>;
 };
 
+&mt6359_vsram_others_ldo_reg {
+	/* The name "vsram_gpu" is required by mtk-regulator-coupler */
+	regulator-name = "vsram_gpu";
+	regulator-min-microvolt = <750000>;
+	regulator-max-microvolt = <800000>;
+	regulator-coupled-with = <&mt6359_vproc2_buck_reg>;
+	regulator-coupled-max-spread = <6250>;
+};
+
 &mt6359_vufs_ldo_reg {
 	regulator-always-on;
 };
-- 
2.45.2


