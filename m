Return-Path: <linux-kernel+bounces-323243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 430E39739F3
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 16:34:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC51F1F262FB
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 14:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CCB3194145;
	Tue, 10 Sep 2024 14:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="cwcnUmC8"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F86244C61;
	Tue, 10 Sep 2024 14:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725978841; cv=none; b=fa3rIR+UoGdDCZ9zOooFt6VqZFsEIMDsRTyxK9nbmyrtrOnEN5l9mh3I3cCHskklb+dbV0F6R/D0Ht3w6BPV5fhHyZL6EOMfqQOVqF9s1yher3GBNcsyNSIK4FjsXiaiFFantJfBUTISBvVDhAP77G3P8vpiBoHiaugGLbqhej4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725978841; c=relaxed/simple;
	bh=akHoeEyu6oXO9RsE8vGoWLrLQrSi86lNh1DN/6MeCOA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Ptl/0Gg5fgkkhGus8cuMB7LoSrQ/OufWlE2mvbFHbD2VmOoaBLkGmM5brOo3WW7zonaCmGkf4yDJqj+yB2Vjzvb/OsOFemM8mSINH44Qd/YUZS6Jz42VD3RMTX1TTYHqVXpxtlwmcX3N+w/mfChSQ4GpT6HHqEY95JgVu3+VvL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=cwcnUmC8; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: b4beb6446f8111efb66947d174671e26-20240910
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=IPd+yNhEEbyPiT0k0o8ZJIdSI74U6bOUQ9kyzB9b6oI=;
	b=cwcnUmC8Mrce1Jchx8572iNcyk7zvhSZRzbOUTkBlnZZzq+DJGvTwQWPgoHEqGVlA+6jLgFIWInFUP7DF1ewdUBQv4XKBYQvQdD5oRlv3QAi4qdboh5Xsh06qWf2JbF0YzE0xLa5jOJryujnsdGLWmVrdzxIeIOWihh+Snhihyk=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:456a3d80-117a-4903-a0da-0f23ac2a04d0,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6dc6a47,CLOUDID:efe3bebf-d7af-4351-93aa-42531abf0c7b,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: b4beb6446f8111efb66947d174671e26-20240910
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
	(envelope-from <pablo.sun@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1304355489; Tue, 10 Sep 2024 22:33:54 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 10 Sep 2024 22:33:53 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 10 Sep 2024 22:33:53 +0800
From: Pablo Sun <pablo.sun@mediatek.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
	<matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	Pablo Sun <pablo.sun@mediatek.com>
Subject: [PATCH] arm64: dts: mediatek: mt8395-genio-1200-evk: Enable GPU
Date: Tue, 10 Sep 2024 22:32:45 +0800
Message-ID: <20240910143245.5282-1-pablo.sun@mediatek.com>
X-Mailer: git-send-email 2.18.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N

Enable the Mali Valhall GPU on Genio 1200 EVK by providing regulator
supply settings and enable the GPU node.

In addition, set the GPU related regulator voltage range:

1. Set the recommended input voltage range of DVDD_GPU to (0.546V-0.787V),
   based on Table 5-3 of MT8395 Application Processor Datasheet.
   The regulator mt6315_7_vbuck1("Vgpu") connects to the DVDD_GPU input.
2. Set the input voltage of DVDD_SRAM_GPU, supplied by
   mt6359_vsram_others_ldo_reg, to 0.75V and set it always on for GPU SRAM.

This patch is tested by enabling CONFIG_DRM_PANFROST and
on Genio 1200 EVK it probed with following dmesg:

```
panfrost 13000000.gpu: clock rate = 700000092
panfrost 13000000.gpu: mali-g57 id 0x9093 major 0x0 minor 0x1 status 0x0
panfrost 13000000.gpu: features: 00000000,000019f7,
	               issues: 00000001,80000400
panfrost 13000000.gpu: Features: L2:0x07120206 Shader:0x00000000
                       Tiler:0x00000809 Mem:0x301
		       MMU:0x00002830 AS:0xff JS:0x7
panfrost 13000000.gpu: shader_present=0x50045 l2_present=0x1
[drm] Initialized panfrost 1.2.0 for 13000000.gpu on minor 0
```

Signed-off-by: Pablo Sun <pablo.sun@mediatek.com>
---
 .../boot/dts/mediatek/mt8395-genio-1200-evk.dts  | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8395-genio-1200-evk.dts b/arch/arm64/boot/dts/mediatek/mt8395-genio-1200-evk.dts
index a06610fff8ad..9b7850b0b9b4 100644
--- a/arch/arm64/boot/dts/mediatek/mt8395-genio-1200-evk.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8395-genio-1200-evk.dts
@@ -194,6 +194,11 @@ eth_phy0: eth-phy0@1 {
 	};
 };
 
+&gpu {
+	mali-supply = <&mt6315_7_vbuck1>;
+	status = "okay";
+};
+
 &i2c0 {
 	clock-frequency = <400000>;
 	pinctrl-0 = <&i2c0_pins>;
@@ -407,6 +412,13 @@ &mt6359_vrf12_ldo_reg {
 	regulator-always-on;
 };
 
+/* for GPU SRAM */
+&mt6359_vsram_others_ldo_reg {
+	regulator-always-on;
+	regulator-min-microvolt = <750000>;
+	regulator-max-microvolt = <750000>;
+};
+
 &mt6359codec {
 	mediatek,mic-type-0 = <1>; /* ACC */
 	mediatek,mic-type-1 = <3>; /* DCC */
@@ -839,8 +851,8 @@ regulators {
 			mt6315_7_vbuck1: vbuck1 {
 				regulator-compatible = "vbuck1";
 				regulator-name = "Vgpu";
-				regulator-min-microvolt = <300000>;
-				regulator-max-microvolt = <1193750>;
+				regulator-min-microvolt = <546000>;
+				regulator-max-microvolt = <787000>;
 				regulator-enable-ramp-delay = <256>;
 				regulator-allowed-modes = <0 1 2>;
 			};
-- 
2.45.2


