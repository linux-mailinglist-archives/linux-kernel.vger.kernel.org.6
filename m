Return-Path: <linux-kernel+bounces-334373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6405497D668
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 15:43:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CF2D282E83
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 13:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4F2E17C7CB;
	Fri, 20 Sep 2024 13:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="gVA677OT"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 647F517ADF1;
	Fri, 20 Sep 2024 13:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726839756; cv=none; b=gEwrKA6IHUe76kUvS1mABVHZBcg3YcA41mz1pPaJttsg9Zh+/EWlSkAicZdZiw/sQwZpD7kq+RV1otHm9yciB8/4FPmkU3gy7pl81GlbNCPGOrSWONgc95bKVmEyFyAj9Zrk3YaVv+yOEkknP3wFNdTpBPwY8l2WpCcyxfBqTLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726839756; c=relaxed/simple;
	bh=FDiilQosAni9DEpJkTSUVoRswhKHk5VTZ02m7RWCIH0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VR1qGkSO0MyL71XVip60Fq48xIms87cCjdcHCV1JQJpnkr4fyqAZS8qvCSbSISuKnfOioWgysWujET8zsgTzci+Dj7RYDTQTPZOg0hJNRGmZHI/i/mHg7N9im4Q31IfyqNELPJu2uSL+vlEms7N8heA66qtbqKUPGE2mPggA3sM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=gVA677OT; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 2b71c476775611efb66947d174671e26-20240920
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=xAwibddJXVFpQUpjf1IuUnHdwc51z/1PEBeF4qdcOP0=;
	b=gVA677OTK5sRWHZpN/ErCVPJuFKbyZh/gnT8DXaSZ1Syx84GPSgdKAmjt7OKQDFDK1SuPSPotpgj7sWXcS+3GqkNteg3geDBOoHTJxQdl2j2VKRDJ9048tfQYk83dKHaGGS6EkwYoXUH25PPcoJhj9I+TFf/dIltKguBqSxKJ/4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:c86658c3-1c58-42ae-8c42-efcff3ad609f,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6dc6a47,CLOUDID:dbbe82d0-7921-4900-88a1-3aef019a55ce,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 2b71c476775611efb66947d174671e26-20240920
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
	(envelope-from <pablo.sun@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1269181255; Fri, 20 Sep 2024 21:42:25 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 20 Sep 2024 06:42:23 -0700
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 20 Sep 2024 21:42:23 +0800
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
Subject: [PATCH 4/5] arm64: dts: mediatek: mt8188: Add efuse for GPU speed binning
Date: Fri, 20 Sep 2024 21:41:10 +0800
Message-ID: <20240920134111.19744-5-pablo.sun@mediatek.com>
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
X-MTK: N

The OPP table of mt8188 GPU contains duplicated frequencies
for different speed bins.

In order to support OPP table, we need to provide the speed bin info
in the efuse data so the GPU driver could properly set the
supported hardware speed bin.

Signed-off-by: Pablo Sun <pablo.sun@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt8188.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8188.dtsi b/arch/arm64/boot/dts/mediatek/mt8188.dtsi
index 02a5bb4dbd1f..129edaf33704 100644
--- a/arch/arm64/boot/dts/mediatek/mt8188.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8188.dtsi
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


