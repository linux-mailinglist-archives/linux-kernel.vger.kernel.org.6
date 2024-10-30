Return-Path: <linux-kernel+bounces-388014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D33529B5935
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 02:37:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7970A1F23EDE
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 01:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F4CD15575C;
	Wed, 30 Oct 2024 01:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="POQ4R38J"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73EDE4437
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 01:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730252259; cv=none; b=R9YLOYYSjemTDQFXY3D5onu1By8TMYmiN4uDk69Xs37FDepWNmm7forx2Bgh0uMDO96Zt4U4YmMgEygAguANGLSm6y4FNBcHWw8b7WkuIKl/YbhUZMMvlXbHCoYL/BYBrW1jvjAYUNBsOT/g5T+H14eOLI1zqqg5dGuqPzKqlQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730252259; c=relaxed/simple;
	bh=RLfpmUMahhgj2VtJJiFYWdZQx1rwpAQsriFNnBWzWxg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MUYYtwgzr0eBWrf7ryV7//0SghvE9ozSQfJskK2guJF1RyEeVtx0GtACzX+4+p3C1qLaG9LKL26qgGtn7ZVAd4lUfM7AozaXgvjf5KjyvFjPn6bytzhloEisVrZiqdFmDmZRLqAw9QLMH63HqZbs0nh/g4lEtevdgjJpW5QimeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=POQ4R38J; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 86d5619c965f11efb88477ffae1fc7a5-20241030
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=P7nbJqT7Rm1H4AHPjbsBGMrWkOmgdm228ehu4L7mLa0=;
	b=POQ4R38JY06+Gh2Hod44HBPTuSpkE7pQ88f1p/NHG3Uxt1iEQJfQ1IfqoPZIaRSsGtFThC3m8sHRQye+ulmPARkYDaJ8ew2FlI6wjsP0GBcVIOzlsaxr3q6rQa0Wk1c/dltc09UehxY94Quj9nG2p7/xMO9eJMxCkMn2NYx+YCQ=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.42,REQID:4fdfe099-8649-4e66-b521-d16144ee9151,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:b0fcdc3,CLOUDID:d5a23f07-7990-429c-b1a0-768435f03014,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 86d5619c965f11efb88477ffae1fc7a5-20241030
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
	(envelope-from <karl.li@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 97522183; Wed, 30 Oct 2024 09:37:29 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 30 Oct 2024 09:37:28 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 30 Oct 2024 09:37:28 +0800
From: Karl.Li <karl.li@mediatek.com>
To: Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>, Karl Li <Karl.Li@mediatek.com>,
	Chungying Lu <chungying.lu@mediatek.com>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>,
	<chien-chih.tseng@mediatek.com>, <andy.teng@mediatek.com>, Karl Li
	<karl.li@mediatek.com>
Subject: [PATCH v2 1/1] soc: mediatek: Add command for APU SMC call
Date: Wed, 30 Oct 2024 09:35:28 +0800
Message-ID: <20241030013533.855696-2-karl.li@mediatek.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241030013533.855696-1-karl.li@mediatek.com>
References: <20241030013533.855696-1-karl.li@mediatek.com>
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
 include/linux/firmware/mediatek/mtk-apu.h | 32 +++++++++++++++++++++++
 1 file changed, 32 insertions(+)
 create mode 100644 include/linux/firmware/mediatek/mtk-apu.h

diff --git a/include/linux/firmware/mediatek/mtk-apu.h b/include/linux/firmware/mediatek/mtk-apu.h
new file mode 100644
index 000000000000..a327e31d40fa
--- /dev/null
+++ b/include/linux/firmware/mediatek/mtk-apu.h
@@ -0,0 +1,32 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2024 MediaTek Inc.
+ */
+
+#ifndef __MEDIATEK_APU_H__
+#define __MEDIATEK_APU_H__
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


