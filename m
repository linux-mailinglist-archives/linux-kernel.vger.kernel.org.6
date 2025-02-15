Return-Path: <linux-kernel+bounces-516127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2676CA36D39
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 11:07:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6FE31892D2E
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 10:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3D241C6FEB;
	Sat, 15 Feb 2025 10:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="FvgmFSCm"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA86B1AAA05;
	Sat, 15 Feb 2025 10:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739613992; cv=none; b=tszjzefaVAdq2bLimyZ5W48bhzCkbFNSqwGgVKJ4+n2av/N44ZSflaa0fCdPpqUe70IX4oKZfYilWxD8CjpylbRv4ovfBtHzjzO2YzOLMmm/K5Tz7EMf7shm4c1yoSvtOMjyKkL0UwQLbJ9mQfGIv1fWZBD3JYDTtwmJAuwegZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739613992; c=relaxed/simple;
	bh=tyf8NPa9Geq25877OuagqByF51whw5lMdn/1j5HXaSY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qQpfTqew10upRGqPyDe4nhAHE7Fj8KmRID4hf3pImWVhN367FJ5CM1ORt1W8moz/ZGoz9kHmvOjoBvgctrqoaX70uU5WqQzQtJ9JVV9ulXWnJ6o+lhjG0FT/pQN5w9Vqz6kwoLf/T9DtwPu1c+moxolYaPo5Jq5dx0UF0FICxco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=FvgmFSCm; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 81038968eb8411efbd192953cf12861f-20250215
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=wwUQ1gG+zU9mZ9mhGyEm41TVXi67wZbR+prnRoQw8Sc=;
	b=FvgmFSCmihpHrvGxlg1ecI2CEIh8HaUBLtROxfrH1EnmDsMY7vPLXTKpWFgUtxnQ5G4op24PqfVPLbtMTfgqwq64qMbwKvOtJH1LjcZj8xAsPLVZMagH57FXwC56PiZ/auiWgxxWrMEWqyzFNa0hYxQiAX3WNpzYN1s95QCbcrs=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.46,REQID:558e8a44-f558-4ccf-8264-4157f827a67c,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:60aa074,CLOUDID:d32864fc-7800-43c5-b97b-ddbe32561a5b,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:nil,Content:0|50,EDM:-3
	,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV
	:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 81038968eb8411efbd192953cf12861f-20250215
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
	(envelope-from <chunfeng.yun@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 2064509836; Sat, 15 Feb 2025 18:06:20 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Sat, 15 Feb 2025 18:06:19 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.28 via Frontend Transport; Sat, 15 Feb 2025 18:06:18 +0800
From: Chunfeng Yun <chunfeng.yun@mediatek.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring
	<robh@kernel.org>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
CC: Chunfeng Yun <chunfeng.yun@mediatek.com>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
	<matthias.bgg@gmail.com>, Mathias Nyman <mathias.nyman@intel.com>,
	<linux-usb@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v3 4/4] usb: mtu3: add support remote wakeup of mt8196
Date: Sat, 15 Feb 2025 18:06:14 +0800
Message-ID: <20250215100615.808-4-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20250215100615.808-1-chunfeng.yun@mediatek.com>
References: <20250215100615.808-1-chunfeng.yun@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK: N

There are three USB controllers on mt8196, each controller's wakeup
control is different, add some specific versions for them.

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
v3: add the ommitted third dual-role controller suggested by Angelo
v2: add wakeup for dual-role controllers
---
 drivers/usb/mtu3/mtu3_host.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/usb/mtu3/mtu3_host.c b/drivers/usb/mtu3/mtu3_host.c
index 7c657ea2dabd..8138b3f3096a 100644
--- a/drivers/usb/mtu3/mtu3_host.c
+++ b/drivers/usb/mtu3/mtu3_host.c
@@ -46,6 +46,14 @@
 #define WC1_IS_P_95		BIT(12)
 #define WC1_IS_EN_P0_95		BIT(6)
 
+/* mt8196 */
+#define PERI_WK_CTRL0_8196	0x08
+#define WC0_IS_EN_P0_96		BIT(0)
+#define WC0_IS_EN_P1_96		BIT(7)
+
+#define PERI_WK_CTRL1_8196	0x10
+#define WC1_IS_EN_P2_96		BIT(0)
+
 /* mt2712 etc */
 #define PERI_SSUSB_SPM_CTRL	0x0
 #define SSC_IP_SLEEP_EN	BIT(4)
@@ -59,6 +67,9 @@ enum ssusb_uwk_vers {
 	SSUSB_UWK_V1_3,		/* mt8195 IP0 */
 	SSUSB_UWK_V1_5 = 105,	/* mt8195 IP2 */
 	SSUSB_UWK_V1_6,		/* mt8195 IP3 */
+	SSUSB_UWK_V1_7, 	/* mt8196 IP0 */
+	SSUSB_UWK_V1_8, 	/* mt8196 IP1 */
+	SSUSB_UWK_V1_9, 	/* mt8196 IP2 */
 };
 
 /*
@@ -100,6 +111,21 @@ static void ssusb_wakeup_ip_sleep_set(struct ssusb_mtk *ssusb, bool enable)
 		msk = WC0_IS_EN_P3_95 | WC0_IS_C_95(0x7) | WC0_IS_P_95;
 		val = enable ? (WC0_IS_EN_P3_95 | WC0_IS_C_95(0x1)) : 0;
 		break;
+	case SSUSB_UWK_V1_7:
+		reg = ssusb->uwk_reg_base + PERI_WK_CTRL0_8196;
+		msk = WC0_IS_EN_P0_96;
+		val = enable ? msk : 0;
+		break;
+	case SSUSB_UWK_V1_8:
+		reg = ssusb->uwk_reg_base + PERI_WK_CTRL0_8196;
+		msk = WC0_IS_EN_P1_96;
+		val = enable ? msk : 0;
+		break;
+	case SSUSB_UWK_V1_9:
+		reg = ssusb->uwk_reg_base + PERI_WK_CTRL1_8196;
+		msk = WC1_IS_EN_P2_96;
+		val = enable ? msk : 0;
+		break;
 	case SSUSB_UWK_V2:
 		reg = ssusb->uwk_reg_base + PERI_SSUSB_SPM_CTRL;
 		msk = SSC_IP_SLEEP_EN | SSC_SPM_INT_EN;
-- 
2.46.0


