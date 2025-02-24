Return-Path: <linux-kernel+bounces-528743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB16EA41BB3
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 11:54:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4F631892392
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 10:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 303252566D8;
	Mon, 24 Feb 2025 10:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Z+mGIdnx"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D25171AD3E0
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 10:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740394462; cv=none; b=pRc9WEW6kUCQ8HHBEadXLc/1s/k1XmwDDoyhde4jYb6dN2cfKsZ1Cbwrnpxh51cnCm3iZv5TZ3CU2XAUBip6auPhoIQX3LFZjkvoGy7ip3fOMlUDFtwQc7sMtsQGfSHYEyfjVxNfqqWA2RwM+oupsWeiTGmrEN7TlLj8lGHdLwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740394462; c=relaxed/simple;
	bh=+O97fdk0SkQVXJTm/eHWD998Z/84BZyKj2eVUkFhoGk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dOSkNHgRbhGeAQLfLo2oUaIUeCiW2KrKWaa2Xcede4+MI54s8glNEvLMmvVKTG+tB5rSMFlpDyqb6E8/Ma0rbIeOacDMZ8zOe9bYsK4ixbPNtOXyTooYv+KiCjsvAgNN7pZZ9riEsUlX8K6jFXwWFUJTBbTwRZxPQDxPvunTD9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=Z+mGIdnx; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: b0a917b2f29d11efaae1fd9735fae912-20250224
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=Z15wXjwmbvS8pqfSjgPL6Cg4YPAigbSKI6xhgGV4nu4=;
	b=Z+mGIdnxAueXSk1PXVm3TTT1zGNH/9vgwJclbjF3ohOCo3UpwHQzknimhcgX4WzgXoOFYt3iH/3u9zxY/CLClCx9/wRJmcR8Qs7nKQXYMT96keGmT+FbV1KyZzPdULH/0nEgKsi0ckVWaFwrYLUGuEGhFS4uxhAHpZ8h9cKg6X8=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.46,REQID:65b5b387-bbec-42e7-9f0f-f0159e1f78cf,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:60aa074,CLOUDID:ccf37ca4-5c06-4e72-8298-91cabc9efadf,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|50,EDM:-3,IP:ni
	l,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: b0a917b2f29d11efaae1fd9735fae912-20250224
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
	(envelope-from <jason-jh.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1866478650; Mon, 24 Feb 2025 18:54:15 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Mon, 24 Feb 2025 18:54:14 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.28 via Frontend Transport; Mon, 24 Feb 2025 18:54:14 +0800
From: Jason-JH Lin <jason-jh.lin@mediatek.com>
To: Chun-Kuang Hu <chunkuang.hu@kernel.org>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
CC: "Jason-JH . Lin" <jason-jh.lin@mediatek.com>, Nancy Lin
	<nancy.lin@mediatek.com>, Singo Chang <singo.chang@mediatek.com>, Yongqiang
 Niu <yongqiang.niu@mediatek.com>, Sirius Wang <sirius.wang@mediatek.com>,
	Xavier Chang <xavier.chang@mediatek.com>, Fei Shao <fshao@chromium.org>,
	Chen-yu Tsai <wenst@chromium.org>, Pin-yen Lin <treapking@chromium.org>,
	<dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
	<linux-mediatek@lists.infradead.org>, <linux-arm-kernel@lists.infradead.org>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [PATCH v2] mailbox: mtk-cmdq: Refine GCE_GCTL_VALUE setting
Date: Mon, 24 Feb 2025 18:50:13 +0800
Message-ID: <20250224105414.3576243-1-jason-jh.lin@mediatek.com>
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

Add cmdq_gctl_value_toggle() to configure GCE_CTRL_BY_SW and GCE_DDR_EN
together in the same GCE_GCTL_VALUE register.

For the SoCs whose GCE is located in MMINFRA and uses MMINFRA_AO power,
this allows it to be written without enabling the clocks. Otherwise, all
GCE registers should be written after the GCE clocks are enabled.
Move this function into cmdq_runtime_resume() and cmdq_runtime_suspend()
to ensure it is called when the GCE clock is enabled.

Fixes: 7abd037aa581 ("mailbox: mtk-cmdq: add gce ddr enable support flow")
Signed-off-by: Jason-JH Lin <jason-jh.lin@mediatek.com>
---
 drivers/mailbox/mtk-cmdq-mailbox.c | 41 +++++++++++++-----------------
 1 file changed, 17 insertions(+), 24 deletions(-)

diff --git a/drivers/mailbox/mtk-cmdq-mailbox.c b/drivers/mailbox/mtk-cmdq-mailbox.c
index d186865b8dce..a1841e4dc414 100644
--- a/drivers/mailbox/mtk-cmdq-mailbox.c
+++ b/drivers/mailbox/mtk-cmdq-mailbox.c
@@ -92,16 +92,17 @@ struct gce_plat {
 	u32 gce_num;
 };
 
-static void cmdq_sw_ddr_enable(struct cmdq *cmdq, bool enable)
+static void cmdq_gctl_value_toggle(struct cmdq *cmdq, bool ddr_enable)
 {
-	WARN_ON(clk_bulk_enable(cmdq->pdata->gce_num, cmdq->clocks));
+	u32 val = cmdq->pdata->control_by_sw ? GCE_CTRL_BY_SW : 0;
 
-	if (enable)
-		writel(GCE_DDR_EN | GCE_CTRL_BY_SW, cmdq->base + GCE_GCTL_VALUE);
-	else
-		writel(GCE_CTRL_BY_SW, cmdq->base + GCE_GCTL_VALUE);
+	if (!cmdq->pdata->control_by_sw && !cmdq->pdata->sw_ddr_en)
+		return;
 
-	clk_bulk_disable(cmdq->pdata->gce_num, cmdq->clocks);
+	if (cmdq->pdata->sw_ddr_en && ddr_enable)
+		val |= GCE_DDR_EN;
+
+	writel(val, cmdq->base + GCE_GCTL_VALUE);
 }
 
 u8 cmdq_get_shift_pa(struct mbox_chan *chan)
@@ -140,16 +141,10 @@ static void cmdq_thread_resume(struct cmdq_thread *thread)
 static void cmdq_init(struct cmdq *cmdq)
 {
 	int i;
-	u32 gctl_regval = 0;
 
 	WARN_ON(clk_bulk_enable(cmdq->pdata->gce_num, cmdq->clocks));
-	if (cmdq->pdata->control_by_sw)
-		gctl_regval = GCE_CTRL_BY_SW;
-	if (cmdq->pdata->sw_ddr_en)
-		gctl_regval |= GCE_DDR_EN;
 
-	if (gctl_regval)
-		writel(gctl_regval, cmdq->base + GCE_GCTL_VALUE);
+	cmdq_gctl_value_toggle(cmdq, true);
 
 	writel(CMDQ_THR_ACTIVE_SLOT_CYCLES, cmdq->base + CMDQ_THR_SLOT_CYCLES);
 	for (i = 0; i <= CMDQ_MAX_EVENT; i++)
@@ -315,14 +310,21 @@ static irqreturn_t cmdq_irq_handler(int irq, void *dev)
 static int cmdq_runtime_resume(struct device *dev)
 {
 	struct cmdq *cmdq = dev_get_drvdata(dev);
+	int ret;
 
-	return clk_bulk_enable(cmdq->pdata->gce_num, cmdq->clocks);
+	ret = clk_bulk_enable(cmdq->pdata->gce_num, cmdq->clocks);
+	if (ret)
+		return ret;
+
+	cmdq_gctl_value_toggle(cmdq, true);
+	return 0;
 }
 
 static int cmdq_runtime_suspend(struct device *dev)
 {
 	struct cmdq *cmdq = dev_get_drvdata(dev);
 
+	cmdq_gctl_value_toggle(cmdq, false);
 	clk_bulk_disable(cmdq->pdata->gce_num, cmdq->clocks);
 	return 0;
 }
@@ -347,9 +349,6 @@ static int cmdq_suspend(struct device *dev)
 	if (task_running)
 		dev_warn(dev, "exist running task(s) in suspend\n");
 
-	if (cmdq->pdata->sw_ddr_en)
-		cmdq_sw_ddr_enable(cmdq, false);
-
 	return pm_runtime_force_suspend(dev);
 }
 
@@ -360,9 +359,6 @@ static int cmdq_resume(struct device *dev)
 	WARN_ON(pm_runtime_force_resume(dev));
 	cmdq->suspended = false;
 
-	if (cmdq->pdata->sw_ddr_en)
-		cmdq_sw_ddr_enable(cmdq, true);
-
 	return 0;
 }
 
@@ -370,9 +366,6 @@ static void cmdq_remove(struct platform_device *pdev)
 {
 	struct cmdq *cmdq = platform_get_drvdata(pdev);
 
-	if (cmdq->pdata->sw_ddr_en)
-		cmdq_sw_ddr_enable(cmdq, false);
-
 	if (!IS_ENABLED(CONFIG_PM))
 		cmdq_runtime_suspend(&pdev->dev);
 
-- 
2.43.0


