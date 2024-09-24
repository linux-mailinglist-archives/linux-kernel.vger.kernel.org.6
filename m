Return-Path: <linux-kernel+bounces-336985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09A0A9843AE
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 12:32:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E6921C2294D
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 10:32:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDFFB19C57F;
	Tue, 24 Sep 2024 10:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="aLMKg1/8"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA5E19B3CB;
	Tue, 24 Sep 2024 10:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727173934; cv=none; b=Ue6NJAY3YPR/eOaw8g74JiZZTa4AdOhQXlLi67yn8IAVmoyfnixBiuI1aWTc0NGwRXN59O+C4UncbEp+RQsw6tdsAN/bEudR1tBWxd8MNPFQ5tCMG4qNCFVMdiF8zlaW3aw9EsbZTdDSmuAYkuJ23DwcI+0Sq2fVuYEaIcQwZhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727173934; c=relaxed/simple;
	bh=QAIid23rCvAYIQEzhjq8SafrnrcV6apQMOXuz4wlofs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dJvAMz1uzrDiRq8INNyBGtqmG73B11mQDQFtIWKMEhIcLNW9kHS+tNgXhSKchJqgaKNzSHCKA2MGCkMeu/WgGQu3DZMy3+90IaxP16iEDuupDBhykneWDMkcjHXy++SvJn4ynznpu3anP3b2/ZnOFBBeMyl016yehT77jaTFYj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=aLMKg1/8; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 3ee852747a6011efb66947d174671e26-20240924
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=csjjaCeqHI0vaM4Mm3N+nZqqlWa9wg1GnsYJtr7M91A=;
	b=aLMKg1/8ZI4ea9a5DzqnbukubeKfzkacVQUcNz4EJJVeb3CYs4rtkIKrBPmhuQZ1U2sSCELSRaUKBPN+Cegl9QCOIXVgJGOSErtzfoHH+KvPef4UxUKAUQ/h0Det2BtzzCY+WB3g09yjccFPuSP4eoZDu/LJLsGfXUCXWurRfEM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:b9fa66b7-bc99-4b51-8c1b-e0892df0179e,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6dc6a47,CLOUDID:37847b9e-8e9a-4ac1-b510-390a86b53c0a,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 3ee852747a6011efb66947d174671e26-20240924
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw01.mediatek.com
	(envelope-from <macpaul.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1114679652; Tue, 24 Sep 2024 18:32:06 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 MTKMBS09N1.mediatek.inc (172.21.101.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 24 Sep 2024 18:32:04 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 24 Sep 2024 18:32:04 +0800
From: Macpaul Lin <macpaul.lin@mediatek.com>
To: Chun-Kuang Hu <chunkuang.hu@kernel.org>, Philipp Zabel
	<p.zabel@pengutronix.de>, Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Yong Wu
	<yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon
	<will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Matthias Brugger
	<matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, <dri-devel@lists.freedesktop.org>,
	<linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, Alexandre Mergnat
	<amergnat@baylibre.com>
CC: Bear Wang <bear.wang@mediatek.com>, Pablo Sun <pablo.sun@mediatek.com>,
	Macpaul Lin <macpaul.lin@mediatek.com>, Macpaul Lin <macpaul@gmail.com>, Sen
 Chu <sen.chu@mediatek.com>, Chris-qj chen <chris-qj.chen@mediatek.com>,
	MediaTek Chromebook Upstream
	<Project_Global_Chrome_Upstream_Group@mediatek.com>, Chen-Yu Tsai
	<wenst@chromium.org>
Subject: [PATCH 5/6] arm64: dts: mt8195: Fix dtbs_check error for mutex node
Date: Tue, 24 Sep 2024 18:31:55 +0800
Message-ID: <20240924103156.13119-5-macpaul.lin@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20240924103156.13119-1-macpaul.lin@mediatek.com>
References: <20240924103156.13119-1-macpaul.lin@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK: N

The mutex node in mt8195.dtsi was triggering a dtbs_check error:
  mutex@1c101000: 'clock-names', 'reg-names' do not match any of the
                  regexes: 'pinctrl-[0-9]+'

This seems no need by inspecting the DT schemas and other reference boards,
so drop 'clock-names' and 'reg-names' in mt8195.dtsi.

Fixes: 92d2c23dc269 ("arm64: dts: mt8195: add display node for vdosys1")
Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt8195.dtsi | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
index 2e1b41359b43..ade685ed2190 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
@@ -3331,11 +3331,9 @@ &larb19 &larb21 &larb24 &larb25
 		mutex1: mutex@1c101000 {
 			compatible = "mediatek,mt8195-disp-mutex";
 			reg = <0 0x1c101000 0 0x1000>;
-			reg-names = "vdo1_mutex";
 			interrupts = <GIC_SPI 494 IRQ_TYPE_LEVEL_HIGH 0>;
 			power-domains = <&spm MT8195_POWER_DOMAIN_VDOSYS1>;
 			clocks = <&vdosys1 CLK_VDO1_DISP_MUTEX>;
-			clock-names = "vdo1_mutex";
 			mediatek,gce-client-reg = <&gce0 SUBSYS_1c10XXXX 0x1000 0x1000>;
 			mediatek,gce-events = <CMDQ_EVENT_VDO1_STREAM_DONE_ENG_0>;
 		};
-- 
2.45.2


