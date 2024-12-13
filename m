Return-Path: <linux-kernel+bounces-444533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D41879F087A
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 10:51:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 943EF282E67
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 09:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E20A81B4F15;
	Fri, 13 Dec 2024 09:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="QAWJhtxJ"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED201AE005;
	Fri, 13 Dec 2024 09:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734083455; cv=none; b=RAeaWXvZVL3qw7D1LwOnV2sXGG9iWjUuM8EEX3A4fqZof/CZmJY+ZnrpWb3LcXrINzy183DsDj8pMvZRgkukC3GMn8wbU/nghb2NCpF3D/FLGvL7PQ40KWj0BRlsRTEoFMyKcFdaM32xBwR/ZkkcyGFZUe6+4Su5qG82lZ6/N1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734083455; c=relaxed/simple;
	bh=b1lXyl4pT3tcGYKBCEnNtStJxpPc3RcJD6qJvldtwzs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZWPvs0WfQnYVzh2+BLlDWsikzDIDYd0n6jlcsEdXuTV+Xq8OqkU8c/4baZ9uEJW8t0D5FQ5bQixq53hVl7Qe/A46uJE0+LAOtPFMMz4uzqzBlmjweM/tCOKBtX1QUwfOVZEt6cYAMdj4Jmw8Oz8N1VStFkxQZvT/a55hZTUrVR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=QAWJhtxJ; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: baf1ad1eb93711ef99858b75a2457dd9-20241213
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=1mgJFotG3RcgJMHCzt5CNI6Nab3EgikzA5VpiV/4n3U=;
	b=QAWJhtxJ+JkvzcmX8RieYYu1zOp+8oBnYZUQU2Mltef6Vf5fBZp5wZos6t8nHJlc8bqJmcjWtpAra2Q8bbvkb1TWlKcD4YVzacacierDY0TAh/beLX9dERGefUbij/JuCmhxMDICnwP/BZz4Y1yC1RQZqU+ldhdqWdYdQzmwPRU=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:2ef325f5-a4ca-40e9-8d18-69efea3179c3,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6493067,CLOUDID:cb94eb3b-e809-4df3-83cd-88f012b9e9ba,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:nil,Content:0,EDM:-3,IP
	:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,
	LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: baf1ad1eb93711ef99858b75a2457dd9-20241213
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw01.mediatek.com
	(envelope-from <jason-jh.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 445858338; Fri, 13 Dec 2024 17:50:48 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 13 Dec 2024 17:50:46 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 13 Dec 2024 17:50:46 +0800
From: Jason-JH.Lin <jason-jh.lin@mediatek.com>
To: Chun-Kuang Hu <chunkuang.hu@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
CC: Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, "Jason-JH . Lin"
	<jason-jh.lin@mediatek.com>, Singo Chang <singo.chang@mediatek.com>, Nancy
 Lin <nancy.lin@mediatek.com>, Shawn Sung <shawn.sung@mediatek.com>,
	<dri-devel@lists.freedesktop.org>, <linux-mediatek@lists.infradead.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>, Fei Shao
	<fshao@chromium.org>, Pin-yen Lin <treapking@chromium.org>
Subject: [PATCH v2 2/3] dts: arm64: mediatek: mt8188: Update OVL compatible from MT8183 to MT8195
Date: Fri, 13 Dec 2024 17:50:43 +0800
Message-ID: <20241213095044.23757-3-jason-jh.lin@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20241213095044.23757-1-jason-jh.lin@mediatek.com>
References: <20241213095044.23757-1-jason-jh.lin@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N

The OVL hardware capabilities have changed starting from MT8195,
making the MT8183 compatible no longer applicable.
Therefore, it is necessary to update the OVL compatible from MT8183 to
MT8195.

Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt8188.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8188.dtsi b/arch/arm64/boot/dts/mediatek/mt8188.dtsi
index faccc7f16259..23ec3ff6cad9 100644
--- a/arch/arm64/boot/dts/mediatek/mt8188.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8188.dtsi
@@ -2488,7 +2488,7 @@ jpeg_decoder: jpeg-decoder@1a040000 {
 		};
 
 		ovl0: ovl@1c000000 {
-			compatible = "mediatek,mt8188-disp-ovl", "mediatek,mt8183-disp-ovl";
+			compatible = "mediatek,mt8188-disp-ovl", "mediatek,mt8195-disp-ovl";
 			reg = <0 0x1c000000 0 0x1000>;
 			clocks = <&vdosys0 CLK_VDO0_DISP_OVL0>;
 			interrupts = <GIC_SPI 636 IRQ_TYPE_LEVEL_HIGH 0>;
-- 
2.43.0


