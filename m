Return-Path: <linux-kernel+bounces-346942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 007A698CB43
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 04:23:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99E091F24644
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 02:23:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81A9B49631;
	Wed,  2 Oct 2024 02:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="raiCm+8y"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60C58BE8;
	Wed,  2 Oct 2024 02:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727835734; cv=none; b=dmts2kF2t1AScmvedWYDOkD/PVbKA3dOUyqKdilgPamVDYTX+ApGnmVTB7t3+Fh14KbOcl54Lq+LhPgLOlq9G4A7KK0VNtXxEdKnosTW+nckwv6F2m5eicZiNm/6X+VgEp6x3ChWydh1GcsAy+zWJcMKthHbPY9/lJmNulfAevM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727835734; c=relaxed/simple;
	bh=UN8pnlJ71URgkeTCRTsh4oI4uVjCaD8k054V82yuOGc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fGN2cRigIFCCWPic35JSTS4TyV5rjhS+jLwsj3fLlzS2jTGVnwBj1uiwTA+ZQmz0fT5jqgaz9SUfUrw7OdVsEi0Be5o169aJeUFt6Wqy9+C9VcRgG46ih0zxJB+FgP+3r9wNRPJSnVzmEcp99n+G/bcu6VsKZ+uzji6jN8g+9Xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=raiCm+8y; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 1e9b9aac806511efb66947d174671e26-20241002
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=AXo4qg1qbW5uH1IaDDE0fD77SMCRdYG9ygic6+svJAY=;
	b=raiCm+8yJLRTAtAlXjrojjcT6xt5R5ks1GszE7CSFd/jXO21j+GAv5Qx01HiFQqeVad2er4F9arFqrgYS3ExmAo/dG8REHhWxuzMmgrnQo8Yi29eA7JEtxFFFhUrTW9bznf/+HROR3Qekm57dTNd+O8637FAL+I7XPjPuG1ynec=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:6d7b2a11-9223-4dc0-af24-bd0054f11b45,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6dc6a47,CLOUDID:473888b6-067a-45ef-ad40-860f1548309a,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: 1e9b9aac806511efb66947d174671e26-20241002
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw01.mediatek.com
	(envelope-from <pablo.sun@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 136844816; Wed, 02 Oct 2024 10:22:06 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 2 Oct 2024 10:22:04 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 2 Oct 2024 10:22:04 +0800
From: Pablo Sun <pablo.sun@mediatek.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
	<matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	Pablo Sun <pablo.sun@mediatek.com>
Subject: [PATCH v3 6/6] arm64: dts: mediatek: mt8390-genio-700-evk: Enable Mali GPU
Date: Wed, 2 Oct 2024 10:21:38 +0800
Message-ID: <20241002022138.29241-7-pablo.sun@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20241002022138.29241-1-pablo.sun@mediatek.com>
References: <20241002022138.29241-1-pablo.sun@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--1.748400-8.000000
X-TMASE-MatchedRID: M6m/rk6FrQxcgzmua3ALxodlc1JaOB1TIfZjRfGTydjCJQ8asLA2F7DW
	HFry+EP4rgnTk236K6go59mvNdf5O4vTpuEjuIpknVTWWiNp+v8adfsoBn8KlbKsKQz2vVta+4w
	NuQyQe6mjkL1tNPFpRqBjuNhZcYw1QkfxbJAyTm7r/EBmiNuXt1VDM0QjJZ5DmyiLZetSf8mfop
	0ytGwvXiq2rl3dzGQ1zZk/ADR33yL9eqS9TsKMChGHbBOHfyCLJGGjpNIwYaJasW5PvkLnF6Qwj
	W1eRoC+Aw44L2WMxzIHWGA9o1ZuoRzevJ3An0JpYODWiKq2wvZ0BNB20+SxH7f8mJY57oZddJaB
	DYald1lvF9+X2GEIHA==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--1.748400-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	9F6F30D13840FA44F3EE82DAECC8688D34F0A906778796E2D3E209B0B9A3F3DA2000:8
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
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
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


