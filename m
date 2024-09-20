Return-Path: <linux-kernel+bounces-334374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C1C397D66B
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 15:43:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7ACF2862B3
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 13:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 940A917C9F9;
	Fri, 20 Sep 2024 13:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="f+C/r1tS"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A41AE17BB0F;
	Fri, 20 Sep 2024 13:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726839757; cv=none; b=gnZu2xd8qTpSgLECkZ3FPdsdffSeYFDIHlKvfmfUgsAVetJKoNoIMbGPpA8GDXpbNS/YPgT/8MWUsRyzyOCzR2uc3BVeP38nBsBBZquDSMCdGm3EyRRkDIg2UmWVRHczgq/KknLzgIigLjM8QPEPZ1FpiwoTPHjn+FAuoCqNyk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726839757; c=relaxed/simple;
	bh=DhJb4r0uYkcNVczdi3DLzF4tM1a5LsIq3r3t8HukYLc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WRMAee01DgfJERXzTn7wOtcnrYpl3Q8PWSzEj1vzOomvt08mSsSSS58BjIOtPkbJSEWA6QxrLxQAwvIbTRFNImeuT+9BxQ9UYC9lq5x+mE72IQbd+XYPdynix8dCQSM+wC3WDgA4wYVu+l8P9MfZULvd1OpCOKGBUoYSnUcnLWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=f+C/r1tS; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 2d2cb802775611ef8b96093e013ec31c-20240920
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=D4jFeuq4sBdpGeCMt/guFSx2fzZMvzmjV65aeAueGRM=;
	b=f+C/r1tSHKwLikqBSA1OqN/1j6XQlJBWDL/WorG6H/5xqhe7UARf7bxfZQHAT1nnzncZDrklGFIHabwKjHsqRnvKlNCbdLgoBJqvB8hkIA6yzyDQq3EDhSjyRkxcgsMV/1qykLs0SIY7++h1tj42hfl99lbZgGzQlQqTsz92fq4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:df17bea0-4252-4365-a289-db1d7ba046fe,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6dc6a47,CLOUDID:e36bff17-b42d-49a6-94d2-a75fa0df01d2,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 2d2cb802775611ef8b96093e013ec31c-20240920
Received: from mtkmbs09n1.mediatek.inc [(172.21.101.35)] by mailgw02.mediatek.com
	(envelope-from <pablo.sun@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1765342811; Fri, 20 Sep 2024 21:42:28 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 20 Sep 2024 21:42:26 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 20 Sep 2024 21:42:26 +0800
From: Pablo Sun <pablo.sun@mediatek.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
	<matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, Michael Turquette
	<mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, "Srinivas
 Kandagatla" <srinivas.kandagatla@linaro.org>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	<linux-clk@vger.kernel.org>, Pablo Sun <pablo.sun@mediatek.com>
Subject: [PATCH 5/5] arm64: dts: mediatek: mt8390-genio-700-evk: Enable Mali GPU
Date: Fri, 20 Sep 2024 21:41:11 +0800
Message-ID: <20240920134111.19744-6-pablo.sun@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20240920134111.19744-1-pablo.sun@mediatek.com>
References: <20240920134111.19744-1-pablo.sun@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--2.132500-8.000000
X-TMASE-MatchedRID: yKCfkewtMJNcgzmua3ALxodlc1JaOB1TIfZjRfGTydjCJQ8asLA2FymF
	OYJJbPqpf146W0iUu2vednYgFc6jdmoOvZKQqN7ksyw+ZJnFumR9LQinZ4QefCP/VFuTOXUTKYO
	cjnHaFYKOhzOa6g8KrUNZLx701ylLZNlabEp+beNgV30RsrzFkpsG9tZP2PDMCxXIK6ID3jMoKN
	LuxkrzxPJboJY9QimDkaMcawjb1snfsU0wOw8Q+MGQYFMiVRG5ehcPPz6UzEWlb5ogMngNpHOTE
	n5IiRSOady5RJQR05c=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--2.132500-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 1205DADD2A2EEDD3CF06167194CE62D4F6C98BED4D4CE9704DCD6AE8E579CEAD2000:8
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

In this commit, we set DVDD_SRAM_GPU to typical 0.85V. It is possbile
to couple it to the DVDD_GPU in future patches.

Signed-off-by: Pablo Sun <pablo.sun@mediatek.com>
---
 .../dts/mediatek/mt8390-genio-700-evk.dts     | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8390-genio-700-evk.dts b/arch/arm64/boot/dts/mediatek/mt8390-genio-700-evk.dts
index 1474bef7e754..a1d6f4cd4e5f 100644
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
@@ -314,6 +327,11 @@ &mt6359_vpa_buck_reg {
 	regulator-max-microvolt = <3100000>;
 };
 
+&mt6359_vproc2_buck_reg {
+	regulator-min-microvolt = <550000>;
+	regulator-max-microvolt = <860000>;
+};
+
 &mt6359_vpu_buck_reg {
 	regulator-always-on;
 };
@@ -326,6 +344,12 @@ &mt6359_vsim1_ldo_reg {
 	regulator-enable-ramp-delay = <480>;
 };
 
+/* for GPU SRAM */
+&mt6359_vsram_others_ldo_reg {
+	regulator-min-microvolt = <850000>;
+	regulator-max-microvolt = <850000>;
+};
+
 &mt6359_vufs_ldo_reg {
 	regulator-always-on;
 };
-- 
2.45.2


