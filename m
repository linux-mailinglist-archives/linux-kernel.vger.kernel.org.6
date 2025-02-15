Return-Path: <linux-kernel+bounces-516116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C14FA36D16
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 10:44:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7CA0171544
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 09:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D456A1A23BD;
	Sat, 15 Feb 2025 09:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="lvUyxxqz"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B9B81922ED;
	Sat, 15 Feb 2025 09:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739612662; cv=none; b=cc65FQrg6T6Oko4t785cZBDfkPaXmyFNIHvIue3K0v/MAfWtbVkFcWCmGEtnOKMkOtmBJZkUy9tVAKcfZrZCr9OiqXzO3lcS7571AugIZHsXZl8H5pQWpFTfnFtNpk+3W9UUlkAYlo5ZKWWOP0vUY6wRnq9gzC/6soWC/3GX8TY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739612662; c=relaxed/simple;
	bh=39W915W90wBjOzdIVOt7oYW/Ka3WhSbVWJjph/J/k2o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TAwI3/XLZx5IIh83K86MUAUKHBslOfh6r8TySng6hhbtE2bo3sh/r8vg4osuFi2ekRxkMFmlC9/965bNPaAg1NTN8TRXVRNUC+1bD0FsIjA2ORH8WpB+U5BLfVm/UL5WIZ1scqjka84iTs4iqtcoDJawvJql9bUgoZKkICzDeJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=lvUyxxqz; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 6ae1a852eb8111efb8f9918b5fc74e19-20250215
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=1XRwV3v0Pr5UX8e3+ENacWcRYH9cJyzTBU7O5dVKwSQ=;
	b=lvUyxxqzUNF5OQ2JPAvIfyScN8AnxyZfaImVuHKTe8xQ7xxXV62akasdkmVhkpm2PEVD4SoQDseQsL5FglUfHHde9sKrHSgi3F2121Du8j6x7zG/LFb5nsT9iivcQkPcqWgGkbAQvvW3PomCSe6TfILt520p0M/nA9VWnLWrMYA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.46,REQID:b910a98f-351b-4813-acaa-9ec8d023c7e2,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:60aa074,CLOUDID:c9f9cb24-96bd-4ac5-8f2e-15aa1ef9defa,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:nil,Content:0|50,EDM:-3
	,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV
	:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 6ae1a852eb8111efb8f9918b5fc74e19-20250215
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
	(envelope-from <chunfeng.yun@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1907960357; Sat, 15 Feb 2025 17:44:14 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Sat, 15 Feb 2025 17:44:13 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.28 via Frontend Transport; Sat, 15 Feb 2025 17:44:13 +0800
From: Chunfeng Yun <chunfeng.yun@mediatek.com>
To: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>
CC: Chunfeng Yun <chunfeng.yun@mediatek.com>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
	<matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	<linux-phy@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v2 2/2] phy: mediatek: xsphy: add support to set disconnect threshold
Date: Sat, 15 Feb 2025 17:44:10 +0800
Message-ID: <20250215094410.547-2-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20250215094410.547-1-chunfeng.yun@mediatek.com>
References: <20250215094410.547-1-chunfeng.yun@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK: N

Add a property to tune usb2 phy's disconnect threshold.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
v2: Add Reviewed by Angelo
---
 drivers/phy/mediatek/phy-mtk-xsphy.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/mediatek/phy-mtk-xsphy.c b/drivers/phy/mediatek/phy-mtk-xsphy.c
index 7c248f5cfca5..718ed8f17c2d 100644
--- a/drivers/phy/mediatek/phy-mtk-xsphy.c
+++ b/drivers/phy/mediatek/phy-mtk-xsphy.c
@@ -59,6 +59,7 @@
 #define XSP_USBPHYACR6		((SSUSB_SIFSLV_U2PHY_COM) + 0x018)
 #define P2A6_RG_BC11_SW_EN	BIT(23)
 #define P2A6_RG_OTG_VBUSCMP_EN	BIT(20)
+#define PA6_RG_U2_DISCTH	GENMASK(7, 4)
 
 #define XSP_U2PHYDTM1		((SSUSB_SIFSLV_U2PHY_COM) + 0x06C)
 #define P2D_FORCE_IDDIG		BIT(9)
@@ -95,6 +96,7 @@ struct xsphy_instance {
 	int eye_src;
 	int eye_vrt;
 	int eye_term;
+	int discth;
 };
 
 struct mtk_xsphy {
@@ -244,9 +246,12 @@ static void phy_parse_property(struct mtk_xsphy *xsphy,
 					 &inst->eye_vrt);
 		device_property_read_u32(dev, "mediatek,eye-term",
 					 &inst->eye_term);
-		dev_dbg(dev, "intr:%d, src:%d, vrt:%d, term:%d\n",
+		device_property_read_u32(dev, "mediatek,discth",
+					 &inst->discth);
+		dev_dbg(dev, "intr:%d, src:%d, vrt:%d, term:%d, discth:%d\n",
 			inst->efuse_intr, inst->eye_src,
-			inst->eye_vrt, inst->eye_term);
+			inst->eye_vrt, inst->eye_term,
+			inst->discth);
 		break;
 	case PHY_TYPE_USB3:
 		device_property_read_u32(dev, "mediatek,efuse-intr",
@@ -285,6 +290,9 @@ static void u2_phy_props_set(struct mtk_xsphy *xsphy,
 	if (inst->eye_term)
 		mtk_phy_update_field(pbase + XSP_USBPHYACR1, P2A1_RG_TERM_SEL,
 				     inst->eye_term);
+	if (inst->discth)
+		mtk_phy_update_field(pbase + XSP_USBPHYACR6, PA6_RG_U2_DISCTH,
+				     inst->discth);
 }
 
 static void u3_phy_props_set(struct mtk_xsphy *xsphy,
-- 
2.46.0


