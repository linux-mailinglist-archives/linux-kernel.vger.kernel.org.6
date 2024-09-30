Return-Path: <linux-kernel+bounces-343520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8DA7989BF8
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 09:55:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8A081C21088
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 07:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E91D170A2B;
	Mon, 30 Sep 2024 07:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="qU6TeY6X"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4819E208D0;
	Mon, 30 Sep 2024 07:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727682905; cv=none; b=TrL90Mq9eHtZ0CFoXjFS3DN96IJozJWtaJnQcyX6/p3X3y+6JVpHKHVNJS0/xPVd1qjPzVnv3wJt0LD8Ju7zNycOkMeL2uBtGqBwv6KPxIo/9ui6/gjN2lSjRePbbYAZPRYJQP7tvnQuxUfy2pJCz1OmAlD4f4vRakg3IPQIcL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727682905; c=relaxed/simple;
	bh=naKY3b1ZVG6+25TyOlVAQbQPWNbgOuU7B+56FoJ4wG0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=khndQbxXFCfkOAFJdG4p5UXwZOVLIkcIwZk9wQkxkD81otBMM8sxbOWg3iDdOkH361/0BkMHXzvSyL12Iq+EbbXsXf0GyI9A/WxO0m6dASUaOudGoJHHl+nhcMFmyvgkK+D3PZOdqBC96zokK9fdUeamkqVbF4zsZ2w6JEs+zII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=qU6TeY6X; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 49d5678a7f0111ef8b96093e013ec31c-20240930
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=IzL8e0gWyMmalbnWpKp/S5VfpI13HlNukKOu9iUiIw4=;
	b=qU6TeY6X8HATfUZU9CenNy3kbQp2O++FQvHYIcpmrZ1LT70hDbo2V8b+6Xd+mDeOz8ISFb/wcj10kxkYdmn/t7wVdso2Hl3qReuLrBFc4Eqsxj9GdUkRvGVcW9V6oTIR2/lWkL5oooRW1/7PTz+Bg5FxwpIIb7ZRyYNTncv1EXY=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:3172af26-4f99-45fe-8931-eb99f2b02dc6,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6dc6a47,CLOUDID:e42cc79e-8e9a-4ac1-b510-390a86b53c0a,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 49d5678a7f0111ef8b96093e013ec31c-20240930
Received: from mtkmbs09n2.mediatek.inc [(172.21.101.94)] by mailgw02.mediatek.com
	(envelope-from <macpaul.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1590979751; Mon, 30 Sep 2024 15:54:58 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 30 Sep 2024 15:54:57 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 30 Sep 2024 15:54:57 +0800
From: Macpaul Lin <macpaul.lin@mediatek.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	<linux-sound@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>, Alexandre Mergnat
	<amergnat@baylibre.com>
CC: Bear Wang <bear.wang@mediatek.com>, Pablo Sun <pablo.sun@mediatek.com>,
	Macpaul Lin <macpaul.lin@mediatek.com>, Macpaul Lin <macpaul@gmail.com>, Sen
 Chu <sen.chu@mediatek.com>, Chris-qj chen <chris-qj.chen@mediatek.com>,
	MediaTek Chromebook Upstream
	<Project_Global_Chrome_Upstream_Group@mediatek.com>, Chen-Yu Tsai
	<wenst@chromium.org>
Subject: [PATCH v2 2/2] arm64: dts: mediatek: mt6359: fix dtbs_check error for audio-codec
Date: Mon, 30 Sep 2024 15:54:51 +0800
Message-ID: <20240930075451.14196-2-macpaul.lin@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20240930075451.14196-1-macpaul.lin@mediatek.com>
References: <20240930075451.14196-1-macpaul.lin@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK: N

This change fixes these dtbs_check errors for audio-codec:
1. pmic: 'mt6359codec' does not match any of the regexes: 'pinctrl-[0-9]+'
 - Replace device node name to generic 'audio-codec'
2. pmic: regulators: 'compatible' is a required property
 - Add 'mediatek,mt6359-codec' to compatible.

Fixes: 3b7d143be4b7 ("arm64: dts: mt6359: add PMIC MT6359 related nodes")
Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt6359.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

Changes for v2:
 - No change. Because the 2/3 patch has been dropped from the v1 patch.
   Hence the new patch set v2 needs to be updated.

diff --git a/arch/arm64/boot/dts/mediatek/mt6359.dtsi b/arch/arm64/boot/dts/mediatek/mt6359.dtsi
index 8e1b8c85c6ed..98a4aaac7911 100644
--- a/arch/arm64/boot/dts/mediatek/mt6359.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt6359.dtsi
@@ -14,7 +14,8 @@ pmic_adc: adc {
 			#io-channel-cells = <1>;
 		};
 
-		mt6359codec: mt6359codec {
+		mt6359codec: audio-codec {
+			compatible = "mediatek,mt6359-codec";
 		};
 
 		regulators {
-- 
2.45.2


