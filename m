Return-Path: <linux-kernel+bounces-377676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 537979AC22D
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 10:50:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F7A7283594
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 08:50:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C81716130B;
	Wed, 23 Oct 2024 08:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="nQulJnPW"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 263D62AD2C;
	Wed, 23 Oct 2024 08:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729673445; cv=none; b=ZKyX7+/TDtsKUjfQ1RbUCTVey6ynnZoEA8XBc/K1jyilz7xTRVVy5jXBuvzWDkA0OgxwTBtYyzJrjj3qsipj7wWIBsi6dw2QmSHrwapAVBwGyl+m5vnIY+f9RMsf7H+Sb0Ta5mB/EJa0Wtb9Cgb+G5FEkRX+Frnd+RMx8ru89c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729673445; c=relaxed/simple;
	bh=hQJBmAaHHOFocQccrtpufzQoxQQkliDzv0bMlcLCQWg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Gd9UImEEdKjGUI6OKii02JOe6SzvBv3TNnaNwF4BfWJtpmF0QQ2DjWWCeTHUIUPXF8RxwNEfItMGzjdvxH/STzKH15UrtVjO3TVXbq46vrM7rn7SbZXsmN0aaAOa3G/ZAKu8n/i8PdIt4afsF0HBaJlFiaDzcEr1ewJJj4OpfNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=nQulJnPW; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: de83f9f6911b11efbd192953cf12861f-20241023
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=Se1VIgGsvPlT3D/sfCOm2ULU4V8mtQ1l49iIAp9o/g8=;
	b=nQulJnPW1WI+id/H5HuzNgmVJ20f70Eqrf6WUlrGbKk8keMZpUg9IEvE6RW13Z/JyMhavTV5Z54Auywzdth63T++kT7an6kVTZilxP1bNDmIWEA7XLhHItB5Z+a7jlZR8+MF9GycxVYhmk+HZFg+cmlzev5hNttrEIhUsIfaRog=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.42,REQID:8627380d-0b1a-424e-ad78-55a17beea379,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:b0fcdc3,CLOUDID:da7efb2d-a7a0-4b06-8464-80be82133975,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: de83f9f6911b11efbd192953cf12861f-20241023
Received: from mtkmbs09n2.mediatek.inc [(172.21.101.94)] by mailgw02.mediatek.com
	(envelope-from <macpaul.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1231604684; Wed, 23 Oct 2024 16:50:35 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 23 Oct 2024 16:50:14 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 23 Oct 2024 16:50:14 +0800
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
	<linux-usb@vger.kernel.org>, Chris-qj chen <chris-qj.chen@mediatek.com>,
	Yu-wen Fang <yu-wen.fang@mediatek.com>, Simon Sun <simon.sun@yunjingtech.com>
Subject: [PATCH] arm64: dts: mediatek: mt8395-genio-1200-evk: add adc and led for mt6360
Date: Wed, 23 Oct 2024 16:50:10 +0800
Message-ID: <20241023085010.7524-1-macpaul.lin@mediatek.com>
X-Mailer: git-send-email 2.18.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--1.494300-8.000000
X-TMASE-MatchedRID: Mn10dBkbTvtKC7lijxWoOAPZZctd3P4Bf2g6KJZtxl0UtdRZTmEaIb2O
	4dp/1Rff4vM1YF6AJbbCCfuIMF6xLVgXepbcl7r7ejqoqUDei9WWVgE8Bu1hS0hiHNv5G75DlwA
	lN0nV/xT6BF14XxOvjI2guP2Quj6armhikiR2ttDg30lwp7cJ8GHE6HLVPu61hJVRlkc0uv5GBX
	oeyrLHXVBo425nomviD2TeXwRpghyi+kNdVAfMg37cGd19dSFd
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--1.494300-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	D0EE629A02F439079A853651305B65B35D8AF92D7D429C00FA773FB68A4AD7182000:8
X-MTK: N

From: Yu-wen Fang <yu-wen.fang@mediatek.com>

Enable ADC and LED of MT6360 for MT8395 Genio-1200-EVK board.

Signed-off-by: Yu-wen Fang <yu-wen.fang@mediatek.com>
Signed-off-by: Simon Sun <simon.sun@yunjingtech.com>
Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
---
 .../arm64/boot/dts/mediatek/mt8395-genio-1200-evk.dts | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8395-genio-1200-evk.dts b/arch/arm64/boot/dts/mediatek/mt8395-genio-1200-evk.dts
index 4c11c100e7b6..6aa6fa64044e 100644
--- a/arch/arm64/boot/dts/mediatek/mt8395-genio-1200-evk.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8395-genio-1200-evk.dts
@@ -264,6 +264,11 @@ mt6360: pmic@34 {
 		#interrupt-cells = <1>;
 		pinctrl-0 = <&mt6360_pins>;
 
+		adc {
+			compatible = "mediatek,mt6360-adc";
+			#io-channel-cells = <1>;
+		};
+
 		charger {
 			compatible = "mediatek,mt6360-chg";
 			richtek,vinovp-microvolt = <14500000>;
@@ -275,6 +280,12 @@ otg_vbus_regulator: usb-otg-vbus-regulator {
 			};
 		};
 
+		led {
+			compatible = "mediatek,mt6360-led";
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
 		regulator {
 			compatible = "mediatek,mt6360-regulator";
 			LDO_VIN3-supply = <&mt6360_buck2>;
-- 
2.45.2


