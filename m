Return-Path: <linux-kernel+bounces-550489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EEB3A56036
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 06:45:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87A5C16E551
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 05:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30D031922DC;
	Fri,  7 Mar 2025 05:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="uOjyGJgk"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F97D4A21
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 05:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741326327; cv=none; b=pQ40XKSU3KW6/mMRgRPH5pNSgtJygXTP3PelvTIPkwhJPf4W0/UDzYAGcSfiNrjj86PsCkyXgq+n957lqJd67XALPqJbra4UIFmRJN0CG9jVX1GicmS/KhOgzN4V5ADSxC3YrO2Pn1ck+VyAWU075KMJgzsa26ZEWEhOcBfnodw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741326327; c=relaxed/simple;
	bh=FrPFJOi5cvGEKY4s2nV7EyjhGWXJ99ekvAiQeCBRjvc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DWrpITfRgQPEk0auyglF+v1SaWY7882Xy40kquWc9gpZedfO5TsnshgaH4rkO8AueQQwxJb7dC6rs8li+rIdOmPMSoTdyoKBB0DYeYKmk5Pm/qNVrVEjDFlmYgv49hzO5C8rAIbeoXMK7LnSVfwIHdnQG5u5zndzNGbZDtvnNhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=uOjyGJgk; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 5ae3d56afb1711ef8eb9c36241bbb6fb-20250307
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=sb9MNp7gIFnjf4puevqUWTv9bTnAa3A6ErG94WVlhYc=;
	b=uOjyGJgkU2vTgU9aaxr5SIKnt1JAPVDefpRFX0lBZOfC2vjiXHbZEhf8GQbooiyelQkLdmi2T16re8ehWYh5P9JA6d/8r4MjD45mbtSPpvkKGJ6C3momeieje3G1kgAQUhoxboF/AbRk2RkJ1K8yhkljQwd+2wWLalNKGtmF4W8=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.2.1,REQID:c5ee9363-f073-4767-b4fe-46df21ea50a5,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:0ef645f,CLOUDID:244c09c6-16da-468a-87f7-8ca8d6b3b9f7,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|50,EDM:-3,IP:ni
	l,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 5ae3d56afb1711ef8eb9c36241bbb6fb-20250307
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
	(envelope-from <xueqi.zhang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1863938294; Fri, 07 Mar 2025 13:45:19 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 7 Mar 2025 13:45:18 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.28 via Frontend Transport; Fri, 7 Mar 2025 13:45:18 +0800
From: Xueqi Zhang <xueqi.zhang@mediatek.com>
To: Yong Wu <yong.wu@mediatek.com>, Krzysztof Kozlowski <krzk@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
CC: <Project_Global_Chrome_Upstream_Group@mediatek.com>,
	<linux-mediatek@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, Xueqi Zhang
	<xueqi.zhang@mediatek.com>
Subject: [PATCH] memory: mtk-smi: Add ostd setting for mt8192
Date: Fri, 7 Mar 2025 13:45:08 +0800
Message-ID: <20250307054515.23455-1-xueqi.zhang@mediatek.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Add initial ostd setting for mt8192. All the settings come from DE.
These settings help adjust Multimedia HW's bandwidth limits to achieve
a balanced bandwidth requirement.
Without this, the VENC HW work abnormal while stress testing.

Fixes: 02c02ddce427 ("memory: mtk-smi: Add mt8192 support")
Signed-off-by: Xueqi Zhang <xueqi.zhang@mediatek.com>
---
 drivers/memory/mtk-smi.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/memory/mtk-smi.c b/drivers/memory/mtk-smi.c
index 5710348f72f6..a8f5467d6b31 100644
--- a/drivers/memory/mtk-smi.c
+++ b/drivers/memory/mtk-smi.c
@@ -332,6 +332,38 @@ static const u8 mtk_smi_larb_mt8188_ostd[][SMI_LARB_PORT_NR_MAX] = {
 	[25] = {0x01},
 };
 
+static const u8 mtk_smi_larb_mt8192_ostd[][SMI_LARB_PORT_NR_MAX] = {
+	[0] = {0x2, 0x2, 0x28, 0xa, 0xc, 0x28,},
+	[1] = {0x2, 0x2, 0x18, 0x18, 0x18, 0xa, 0xc, 0x28,},
+	[2] = {0x5, 0x5, 0x5, 0x5, 0x1,},
+	[3] = {},
+	[4] = {0x28, 0x19, 0xb, 0x1, 0x1, 0x1, 0x1, 0x1, 0x1, 0x4, 0x1,},
+	[5] = {0x1, 0x1, 0x4, 0x1, 0x1, 0x1, 0x1, 0x16,},
+	[6] = {},
+	[7] = {0x1, 0x3, 0x2, 0x1, 0x1, 0x5, 0x2, 0x12, 0x13, 0x4, 0x4, 0x1,
+	       0x4, 0x2, 0x1,},
+	[8] = {},
+	[9] = {0xa, 0x7, 0xf, 0x8, 0x1, 0x8, 0x9, 0x3, 0x3, 0x6, 0x7, 0x4,
+	       0xa, 0x3, 0x4, 0xe, 0x1, 0x7, 0x1, 0x1, 0x1, 0x1, 0x1, 0x1,
+	       0x1, 0x1, 0x1, 0x1, 0x1,},
+	[10] = {},
+	[11] = {0x1, 0x1, 0x1, 0x1, 0x1, 0x1, 0x1, 0x1, 0x1, 0x1, 0x1, 0x1,
+		0x1, 0x1, 0x1, 0xe, 0x1, 0x7, 0x8, 0x7, 0x7, 0x1, 0x6, 0x2,
+		0xf, 0x8, 0x1, 0x1, 0x1,},
+	[12] = {},
+	[13] = {0x2, 0xc, 0xc, 0xe, 0x6, 0x6, 0x6, 0x6, 0x6, 0x12, 0x6, 0x28,
+		0x2, 0xc, 0xc, 0x28, 0x12, 0x6,},
+	[14] = {},
+	[15] = {0x28, 0x14, 0x2, 0xc, 0x18, 0x4, 0x28, 0x14, 0x4, 0x4, 0x4, 0x2,
+		0x4, 0x2, 0x8, 0x4, 0x4,},
+	[16] = {0x28, 0x14, 0x2, 0xc, 0x18, 0x4, 0x28, 0x14, 0x4, 0x4, 0x4, 0x2,
+		0x4, 0x2, 0x8, 0x4, 0x4,},
+	[17] = {0x28, 0x14, 0x2, 0xc, 0x18, 0x4, 0x28, 0x14, 0x4, 0x4, 0x4, 0x2,
+		0x4, 0x2, 0x8, 0x4, 0x4,},
+	[18] = {0x2, 0x2, 0x4, 0x2,},
+	[19] = {0x9, 0x9, 0x5, 0x5, 0x1, 0x1,},
+};
+
 static const u8 mtk_smi_larb_mt8195_ostd[][SMI_LARB_PORT_NR_MAX] = {
 	[0] = {0x0a, 0xc, 0x22, 0x22, 0x01, 0x0a,}, /* larb0 */
 	[1] = {0x0a, 0xc, 0x22, 0x22, 0x01, 0x0a,}, /* larb1 */
@@ -427,6 +459,7 @@ static const struct mtk_smi_larb_gen mtk_smi_larb_mt8188 = {
 
 static const struct mtk_smi_larb_gen mtk_smi_larb_mt8192 = {
 	.config_port                = mtk_smi_larb_config_port_gen2_general,
+	.ostd			    = mtk_smi_larb_mt8192_ostd,
 };
 
 static const struct mtk_smi_larb_gen mtk_smi_larb_mt8195 = {
-- 
2.46.0


