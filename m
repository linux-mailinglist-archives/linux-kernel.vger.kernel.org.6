Return-Path: <linux-kernel+bounces-517518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DD14A381FB
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 12:40:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50B143B4822
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 11:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31E7F218E9F;
	Mon, 17 Feb 2025 11:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="FVnEflPk"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D76194C8B;
	Mon, 17 Feb 2025 11:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739792280; cv=none; b=fAqwRPQKY42nIwu/mOAJA9g9sY6ngM07ahOegCgm2+Tj0tLsn529XMbudC2wmTqSujcKExkLKqzzMn5ru83p+Qo8IYvNSm37xgtSKY2XwUVqRX9K7+tHvki/VLixvF8pTkP1fHQShLtoh2zdefUPWOJF+We807Zs5v1jf1TEPpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739792280; c=relaxed/simple;
	bh=/ACTGZEmOGEMJW+VSLUpRkaXoC8ByG57LGhsF7zKvIk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=V+eq2URgXKVxZsFH7ecZg4Bk1YdcGufAEyJFoGoJ+UGAv7qYfleoixGAEHJa2KOdtfGvQ3MEIG1xBOflJOhfQhm40VYQ6L52GO5TzU01RiQDW6miqglNBlTcwt6NNzt7sqXLZ6nIIYVKLPXYGFXrnsr2/ZfgtxohFqhz3JrVNoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=FVnEflPk; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 9de83a4ced2311efaae1fd9735fae912-20250217
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=DbjxxvFUSINuD+GS4bDK4+YmMPoBQQThSlhkpsMhcDg=;
	b=FVnEflPk2PsDj3/N4oTcnyRQvjt03qjd/n959qEcD7g4Gah8BsrzVdYsyUSk3mO9WIFFrV/km6GaAL9pxcyuoFWPIg6OYS3SocNCed0Fx448rQODp0sAFfNVh412/x9tv5pWQMT1KTLD2tMW+ItstL4BT6YCe9FiMJSockubjmA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.46,REQID:93bd6619-0b0a-41c0-8175-b2a69cd78ad1,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:60aa074,CLOUDID:c2c37f88-f9ab-4ac1-951b-e3a689bed90c,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|50,EDM:-3,IP:ni
	l,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 9de83a4ced2311efaae1fd9735fae912-20250217
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
	(envelope-from <macpaul.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 856791141; Mon, 17 Feb 2025 19:37:50 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Mon, 17 Feb 2025 19:37:48 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.28 via Frontend Transport; Mon, 17 Feb 2025 19:37:48 +0800
From: Macpaul Lin <macpaul.lin@mediatek.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
	<matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>, Alexandre Mergnat
	<amergnat@baylibre.com>
CC: Bear Wang <bear.wang@mediatek.com>, Pablo Sun <pablo.sun@mediatek.com>,
	Macpaul Lin <macpaul.lin@mediatek.com>, Macpaul Lin <macpaul@gmail.com>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>,
	<linux-usb@vger.kernel.org>, Sen Chu <sen.chu@mediatek.com>, Chris-qj chen
	<chris-qj.chen@mediatek.com>
Subject: [PATCH v3] arm64: dts: mediatek: mt6359: fix dtbs_check error for audio-codec
Date: Mon, 17 Feb 2025 19:37:36 +0800
Message-ID: <20250217113736.1867808-1-macpaul.lin@mediatek.com>
X-Mailer: git-send-email 2.45.2
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
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 arch/arm64/boot/dts/mediatek/mt6359.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

Changes for v2:
 - No change. Because the 2/3 patch has been dropped from the v1 patch.
   Hence the new patch set v2 needs to be updated.

Changes for v3:
 - Add "Reviewed-by:" tag. Thanks!.

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


