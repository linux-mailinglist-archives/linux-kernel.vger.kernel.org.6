Return-Path: <linux-kernel+bounces-379585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A1EF9AE0C2
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 11:30:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC7D6B23712
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 09:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 480FD1C07F3;
	Thu, 24 Oct 2024 09:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="dCvE/Pzj"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F531C07CE
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 09:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729762055; cv=none; b=TkhQZyzuu0T6S0FaDsw0mH+MXkFOGVl1mKz8+N2NDG6kpMQIPriXFqJcPLqxYPB/3cUBdC+yjZ32cAu9XkjfAL2dN9xNDSx5ZbriIH+Nht8dozquws5rdMnv7gCAHIikkoSBB1JBcSTyUFNhABBSrMxcibDdpvrofWAtLH9WTCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729762055; c=relaxed/simple;
	bh=ASqoW5IdnbjBtNCMGkaYnH5t6BOFxmOfqU+cZSxr3KI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=azKbIm/jaSMhYgvEvMo83gGzQ7HlJH3eXWSDyR3tg2dcnFdRGKREGjOQkmVtmxH+4rQs5zJF0NXlk6h9iH/8E5rlb3m5xDWPGrMPdeutvRxNnfFrFB1WnAwvSrMLqbhRFbjNmTNWXlHZtK4Q84Vy1ml8KNnAau4+ps+wtzFFAos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=dCvE/Pzj; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 2d4b002e91ea11efb88477ffae1fc7a5-20241024
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=hjrZqmlFFlSzh5vgtq7m7adfVk4oLYk4Vu2ErMdURd0=;
	b=dCvE/PzjiJToH7hKEXSWbSr0078gb6W+HJDpymUP8cx6z5AHA0KK66nP81EmZK/b+az9Zot1PxDKqz2ZJ3150bnEofNN6829vcywaXTz6aXpyomV/j2naV+XF88lP+OSmWNcOBMLWPu87fFnHOONlf5iHucBpnu6CR1F8xTYNKs=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.42,REQID:82a151ab-550f-4988-9cf3-e28a88bea240,IP:0,U
	RL:0,TC:0,Content:-20,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-20
X-CID-META: VersionHash:b0fcdc3,CLOUDID:c06d0b2e-a7a0-4b06-8464-80be82133975,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:1,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 2d4b002e91ea11efb88477ffae1fc7a5-20241024
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw01.mediatek.com
	(envelope-from <karl.li@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1063452508; Thu, 24 Oct 2024 17:27:24 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 24 Oct 2024 02:27:22 -0700
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 24 Oct 2024 17:27:22 +0800
From: Karl.Li <karl.li@mediatek.com>
To: Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>, Karl Li <Karl.Li@mediatek.com>,
	Chungying Lu <chungying.lu@mediatek.com>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>, Karl Li
	<karl.li@mediatek.com>
Subject: [PATCH 1/1] soc: mediatek: Add command for APU SMC call
Date: Thu, 24 Oct 2024 17:27:05 +0800
Message-ID: <20241024092712.431605-2-karl.li@mediatek.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241024092712.431605-1-karl.li@mediatek.com>
References: <20241024092712.431605-1-karl.li@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Karl Li <karl.li@mediatek.com>

Add command for APU SMC call.
The APU microprocess's start and stop sequence will process in ATF.

Signed-off-by: Karl Li <karl.li@mediatek.com>
---
 include/linux/soc/mediatek/mtk_apu_secure.h | 32 +++++++++++++++++++++
 1 file changed, 32 insertions(+)
 create mode 100644 include/linux/soc/mediatek/mtk_apu_secure.h

diff --git a/include/linux/soc/mediatek/mtk_apu_secure.h b/include/linux/soc/mediatek/mtk_apu_secure.h
new file mode 100644
index 000000000000..ea491bc24adb
--- /dev/null
+++ b/include/linux/soc/mediatek/mtk_apu_secure.h
@@ -0,0 +1,32 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2024 MediaTek Inc.
+ */
+
+#ifndef __MTK_APU_SECURE_H__
+#define __MTK_APU_SECURE_H__
+
+enum mtk_apusys_kernel_op {
+	MTK_APUSYS_KERNEL_OP_APUSYS_PWR_TOP_ON,			/*  0 */
+	MTK_APUSYS_KERNEL_OP_APUSYS_PWR_TOP_OFF,		/*  1 */
+	MTK_APUSYS_KERNEL_OP_APUSYS_RV_SETUP_REVISER,		/*  2 */
+	MTK_APUSYS_KERNEL_OP_APUSYS_RV_RESET_MP,		/*  3 */
+	MTK_APUSYS_KERNEL_OP_APUSYS_RV_SETUP_BOOT,		/*  4 */
+	MTK_APUSYS_KERNEL_OP_APUSYS_RV_START_MP,		/*  5 */
+	MTK_APUSYS_KERNEL_OP_APUSYS_RV_STOP_MP,			/*  6 */
+	MTK_APUSYS_KERNEL_OP_DEVAPC_INIT_RCX,			/*  7 */
+	MTK_APUSYS_KERNEL_OP_APUSYS_RV_SETUP_SEC_MEM,		/*  8 */
+	MTK_APUSYS_KERNEL_OP_APUSYS_RV_DISABLE_WDT_ISR,		/*  9 */
+	MTK_APUSYS_KERNEL_OP_APUSYS_RV_CLEAR_WDT_ISR,		/* 10 */
+	MTK_APUSYS_KERNEL_OP_APUSYS_RV_CG_GATING,		/* 11 */
+	MTK_APUSYS_KERNEL_OP_APUSYS_RV_CG_UNGATING,		/* 12 */
+	MTK_APUSYS_KERNEL_OP_APUSYS_RV_SETUP_APUMMU,		/* 13 */
+	MTK_APUSYS_KERNEL_OP_APUSYS_LOGTOP_REG_DUMP,		/* 14 */
+	MTK_APUSYS_KERNEL_OP_APUSYS_LOGTOP_REG_WRITE,		/* 15 */
+	MTK_APUSYS_KERNEL_OP_APUSYS_LOGTOP_REG_W1C,		/* 16 */
+	MTK_APUSYS_KERNEL_OP_APUSYS_COLD_BOOT_CLR_MBOX_DUMMY,	/* 17 */
+	MTK_APUSYS_KERNEL_OP_APUSYS_SETUP_CE_BIN,		/* 18 */
+	MTK_APUSYS_KERNEL_OP_NUM,
+};
+
+#endif
-- 
2.18.0


