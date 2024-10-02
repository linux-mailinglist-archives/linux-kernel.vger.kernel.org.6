Return-Path: <linux-kernel+bounces-346940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B203398CB3F
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 04:23:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46E5BB22C88
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 02:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDE2C1AAD7;
	Wed,  2 Oct 2024 02:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="CT0twVsa"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 688E18BE8;
	Wed,  2 Oct 2024 02:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727835728; cv=none; b=UY0eLgNY2tn2uWB8xiieRIusi2eMkfBzSl7fSTcOtVoveRLIX6//lAsYNe1EYjotNPDOtoXrryGfVauZnud/P8rGpxzOqIu0PMvUr2Au1etH5OSE7WRRD9rp2dQUk/AQz6B71ZntGI26b3HHC81K4/bm9jQWA4Kyi0e+oUKEuZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727835728; c=relaxed/simple;
	bh=Up/G51w0ZgELiMbwqu+Z4QT1KQFqbVdEu3EnhZL0rk0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TKyAXw65OgW6rL5ApmMz5PCXKWwvXOJOBnfMZV5W5v8O5ERYr3qEnrTrvfgTpCLg+goT/RpDY4khuTD65WAXjMHJ1ydKLX6eWFCoIr2iUvSHoIbBFY1bWcTSytKPBwmfK/R2GJi2hfXQRN+1c/+/Sx7uWMOrZ2ippEVu9a4yY4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=CT0twVsa; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 1adf21cc806511ef8b96093e013ec31c-20241002
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=xBo18OY7jIH06kEmNWA17AbP34Khga3KC/4P2QqJSMk=;
	b=CT0twVsaQ8/v6JM2OXYjamGF3rqM5LyLFeM/fAxfca0dHT7RSYmpnTgrRrFDw9f5Zfh7QmWtRku0fCWNvoiyuVR1tQxv75KuAA1bOwi8nM2PjavvQHvwAeRjHHI+67ikBH0Xztu/3/G9kqSxfVkjbTFygEKmJ2HDbIUEqMyc2hU=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:e9a3dcc9-41f5-4cae-b0d5-6d422cb53a51,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6dc6a47,CLOUDID:223888b6-067a-45ef-ad40-860f1548309a,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 1adf21cc806511ef8b96093e013ec31c-20241002
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
	(envelope-from <pablo.sun@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1178770159; Wed, 02 Oct 2024 10:22:00 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 2 Oct 2024 10:21:58 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 2 Oct 2024 10:21:58 +0800
From: Pablo Sun <pablo.sun@mediatek.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
	<matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	Pablo Sun <pablo.sun@mediatek.com>
Subject: [PATCH v3 4/6] arm64: dts: mediatek: mt8188: Add efuse for GPU speed binning
Date: Wed, 2 Oct 2024 10:21:36 +0800
Message-ID: <20241002022138.29241-5-pablo.sun@mediatek.com>
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
X-TM-AS-Result: No-10--5.854000-8.000000
X-TMASE-MatchedRID: 6mUaupESUidDEf2XTEVmBuEbUg4xvs+wuLwbhNl9B5Xjud2x7TPVt24m
	YyZykPQLUmRjgBcG9aHVL7DIQyVd77BAQLqGlKivDB+ErBr0bAO/zKpacmFSwWtMM0lBc7ENo8W
	MkQWv6iXBcIE78YqRWo6HM5rqDwqtvYleIqFvs8A2phfZsYdfLs+HApG3JERBShvfteGq5ePyVC
	DhCBZnzg==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--5.854000-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	40DEB7F6E06D7E7ECE8520CEA621040041A387B66122C541676612DCC12965B12000:8
X-MTK: N

The OPP table of mt8188 GPU contains duplicated frequencies
for different speed bins.

In order to support OPP table, we need to provide the speed bin info
in the efuse data so the GPU driver could properly set the
supported hardware speed bin.

Same as mt8186, the efuse data for mt8188's GPU speed binning
requires post-process to convert the bit field format expected
by the OPP table.

Signed-off-by: Pablo Sun <pablo.sun@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt8188.dtsi | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8188.dtsi b/arch/arm64/boot/dts/mediatek/mt8188.dtsi
index 02a5bb4dbd1f..2d9378c16e42 100644
--- a/arch/arm64/boot/dts/mediatek/mt8188.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8188.dtsi
@@ -1744,7 +1744,7 @@ imp_iic_wrap_en: clock-controller@11ec2000 {
 		};
 
 		efuse: efuse@11f20000 {
-			compatible = "mediatek,mt8188-efuse", "mediatek,efuse";
+			compatible = "mediatek,mt8188-efuse", "mediatek,mt8186-efuse";
 			reg = <0 0x11f20000 0 0x1000>;
 			#address-cells = <1>;
 			#size-cells = <1>;
@@ -1752,6 +1752,11 @@ efuse: efuse@11f20000 {
 			lvts_efuse_data1: lvts1-calib@1ac {
 				reg = <0x1ac 0x40>;
 			};
+
+			gpu_speedbin: gpu-speedbin@580 {
+				reg = <0x581 0x1>;
+				bits = <0 3>;
+			};
 		};
 
 		gpu: gpu@13000000 {
@@ -1763,6 +1768,8 @@ gpu: gpu@13000000 {
 				     <GIC_SPI 382 IRQ_TYPE_LEVEL_HIGH 0>,
 				     <GIC_SPI 381 IRQ_TYPE_LEVEL_HIGH 0>;
 			interrupt-names = "job", "mmu", "gpu";
+			nvmem-cells = <&gpu_speedbin>;
+			nvmem-cell-names = "speed-bin";
 			operating-points-v2 = <&gpu_opp_table>;
 			power-domains = <&spm MT8188_POWER_DOMAIN_MFG2>,
 					<&spm MT8188_POWER_DOMAIN_MFG3>,
-- 
2.45.2


