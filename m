Return-Path: <linux-kernel+bounces-189759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 110928CF49C
	for <lists+linux-kernel@lfdr.de>; Sun, 26 May 2024 16:46:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAF46281469
	for <lists+linux-kernel@lfdr.de>; Sun, 26 May 2024 14:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 177D72B9D8;
	Sun, 26 May 2024 14:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="T1p5zk0p"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3C6E182D2;
	Sun, 26 May 2024 14:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716734697; cv=none; b=gxJ2DZFgm0FyBffXaXH4QC+r1SNnux11Py3eA/f4qpFb2uCab1bPvgpo5aVdi8MbK4Gd3RFOH9EB4/ivecG2Soq78TIXwl3BR7OQ5moBvc6GtmE2t87itCe22ChB1rJ4/YFAB3kJ7ET6Z1sMEzIIpCtEso1vmtG3KcO2NHM5UrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716734697; c=relaxed/simple;
	bh=XiUgGPQU36myNpr9nFmy+qf1YTERJM1asjy9o4VzTxQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N0vAleFCzutjpSqG9djPBYggYttASxuDo0ikwrWPz4OcP815snw1WoUo8txBJTvzOa8Ae28d5f6Pq+ryYC3EKN4k5cLLDm6myRCqKzBgpqohweNb6EMlYBZH9RkyQGkqjmiImkjmCw7ahD0yVbPRjfLe7HhBZ3NISzSwhy9fo68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=T1p5zk0p; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 7f3efc0c1b6e11ef8c37dd7afa272265-20240526
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=aaqTq4vfD7ofPN8So6mXirCjSkY58QkuXVkXd7MqJ2E=;
	b=T1p5zk0pVehrk7TOSedUVoPVxaAwgLV7gsxUtYHBxLJOg6SCvdFn8kiwqrLKBKZJ8gU7kLBH7rjEmhdW3pg2HAYslVYEkydXLv3Qz+heS0/+hoCo8A0pXBN/d8avRfJLhtdAg6VSrqZ8odcJJZnhBb0aDE/T32g/3x1TycspD8Y=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:6f071ef4-f7c8-4eb5-b346-4672143b030b,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:82c5f88,CLOUDID:7dbed387-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 7f3efc0c1b6e11ef8c37dd7afa272265-20240526
Received: from mtkmbs09n2.mediatek.inc [(172.21.101.94)] by mailgw01.mediatek.com
	(envelope-from <jason-jh.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1578489328; Sun, 26 May 2024 22:44:46 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Sun, 26 May 2024 22:44:45 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Sun, 26 May 2024 22:44:45 +0800
From: Jason-JH.Lin <jason-jh.lin@mediatek.com>
To: Jassi Brar <jassisinghbrar@gmail.com>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Rob Herring <robh+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>, Chun-Kuang Hu
	<chunkuang.hu@kernel.org>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
CC: Conor Dooley <conor+dt@kernel.org>, Jason-ch Chen
	<jason-ch.chen@mediatek.com>, "Jason-JH . Lin" <jason-jh.lin@mediatek.com>,
	Singo Chang <singo.chang@mediatek.com>, Nancy Lin <nancy.lin@mediatek.com>,
	Shawn Sung <shawn.sung@mediatek.com>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>, <dri-devel@lists.freedesktop.org>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [PATCH RESEND,v6 7/8] mailbox: mediatek: Add secure CMDQ driver support for CMDQ driver
Date: Sun, 26 May 2024 22:44:42 +0800
Message-ID: <20240526144443.14345-8-jason-jh.lin@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20240526144443.14345-1-jason-jh.lin@mediatek.com>
References: <20240526144443.14345-1-jason-jh.lin@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N

CMDQ driver will probe a secure CMDQ driver when has_sec flag
in platform data is true and its device node in dts has defined a
event id of CMDQ_SYNC_TOKEN_SEC_EOF.

Secure CMDQ driver support on mt8188 and mt8195 currently.
So add a has_secure flag to their driver data to probe it.

Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>
Signed-off-by: Hsiao Chien Sung <shawn.sung@mediatek.com>
---
 drivers/mailbox/mtk-cmdq-mailbox.c | 76 ++++++++++++++++++++++++++++++
 1 file changed, 76 insertions(+)

diff --git a/drivers/mailbox/mtk-cmdq-mailbox.c b/drivers/mailbox/mtk-cmdq-mailbox.c
index 025e53549a45..5c606684b07b 100644
--- a/drivers/mailbox/mtk-cmdq-mailbox.c
+++ b/drivers/mailbox/mtk-cmdq-mailbox.c
@@ -15,6 +15,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/mailbox_controller.h>
 #include <linux/mailbox/mtk-cmdq-mailbox.h>
+#include <linux/mailbox/mtk-cmdq-sec-mailbox.h>
 #include <linux/of.h>
 
 #define CMDQ_MBOX_AUTOSUSPEND_DELAY_MS	100
@@ -55,11 +56,22 @@
 #define CMDQ_JUMP_BY_OFFSET		0x10000000
 #define CMDQ_JUMP_BY_PA			0x10000001
 
+#define CMDQ_THR_IDX(thread, cmdq)	(((thread)->base - (cmdq)->base - CMDQ_THR_BASE) \
+					 / CMDQ_THR_SIZE)
+
+#define CMDQ_IS_SECURE_THREAD(idx, cmdq) ((cmdq)->pdata->has_secure && \
+					  (idx) >= (cmdq)->pdata->secure_thread_min && \
+					  (idx) < (cmdq)->pdata->secure_thread_min + \
+					  (cmdq)->pdata->secure_thread_nr)
+
 struct gce_plat {
 	u32 thread_nr;
 	u8 shift;
 	bool control_by_sw;
 	bool sw_ddr_en;
+	bool has_secure;
+	u32 secure_thread_nr;
+	u32 secure_thread_min;
 	u32 gce_num;
 };
 
@@ -368,6 +380,7 @@ static int cmdq_mbox_send_data(struct mbox_chan *chan, void *data)
 	struct cmdq *cmdq = dev_get_drvdata(chan->mbox->dev);
 	struct cmdq_task *task;
 	unsigned long curr_pa, end_pa;
+	u32 idx = CMDQ_THR_IDX(thread, cmdq);
 	int ret;
 
 	/* Client should not flush new tasks if suspended. */
@@ -377,6 +390,13 @@ static int cmdq_mbox_send_data(struct mbox_chan *chan, void *data)
 	if (ret < 0)
 		return ret;
 
+	if (CMDQ_IS_SECURE_THREAD(idx, cmdq)) {
+		ret = cmdq_sec_mbox.ops->send_data(chan, data);
+		pm_runtime_mark_last_busy(cmdq->mbox.dev);
+		pm_runtime_put_autosuspend(cmdq->mbox.dev);
+		return ret;
+	}
+
 	task = kzalloc(sizeof(*task), GFP_ATOMIC);
 	if (!task) {
 		pm_runtime_put_autosuspend(cmdq->mbox.dev);
@@ -436,6 +456,13 @@ static int cmdq_mbox_send_data(struct mbox_chan *chan, void *data)
 
 static int cmdq_mbox_startup(struct mbox_chan *chan)
 {
+	struct cmdq *cmdq = dev_get_drvdata(chan->mbox->dev);
+	struct cmdq_thread *thread = (struct cmdq_thread *)chan->con_priv;
+	u32 idx = CMDQ_THR_IDX(thread, cmdq);
+
+	if (CMDQ_IS_SECURE_THREAD(idx, cmdq))
+		cmdq_sec_mbox.ops->startup(chan);
+
 	return 0;
 }
 
@@ -445,9 +472,17 @@ static void cmdq_mbox_shutdown(struct mbox_chan *chan)
 	struct cmdq *cmdq = dev_get_drvdata(chan->mbox->dev);
 	struct cmdq_task *task, *tmp;
 	unsigned long flags;
+	u32 idx = CMDQ_THR_IDX(thread, cmdq);
 
 	WARN_ON(pm_runtime_get_sync(cmdq->mbox.dev) < 0);
 
+	if (CMDQ_IS_SECURE_THREAD(idx, cmdq)) {
+		cmdq_sec_mbox.ops->shutdown(chan);
+		pm_runtime_mark_last_busy(cmdq->mbox.dev);
+		pm_runtime_put_autosuspend(cmdq->mbox.dev);
+		return;
+	}
+
 	spin_lock_irqsave(&thread->chan->lock, flags);
 	if (list_empty(&thread->task_busy_list))
 		goto done;
@@ -488,12 +523,20 @@ static int cmdq_mbox_flush(struct mbox_chan *chan, unsigned long timeout)
 	struct cmdq_task *task, *tmp;
 	unsigned long flags;
 	u32 enable;
+	u32 idx = CMDQ_THR_IDX(thread, cmdq);
 	int ret;
 
 	ret = pm_runtime_get_sync(cmdq->mbox.dev);
 	if (ret < 0)
 		return ret;
 
+	if (CMDQ_IS_SECURE_THREAD(idx, cmdq)) {
+		cmdq_sec_mbox.ops->flush(chan, timeout);
+		pm_runtime_mark_last_busy(cmdq->mbox.dev);
+		pm_runtime_put_autosuspend(cmdq->mbox.dev);
+		return 0;
+	}
+
 	spin_lock_irqsave(&thread->chan->lock, flags);
 	if (list_empty(&thread->task_busy_list))
 		goto out;
@@ -569,6 +612,7 @@ static int cmdq_probe(struct platform_device *pdev)
 	int alias_id = 0;
 	static const char * const clk_name = "gce";
 	static const char * const clk_names[] = { "gce0", "gce1" };
+	u32 hwid = 0;
 
 	cmdq = devm_kzalloc(dev, sizeof(*cmdq), GFP_KERNEL);
 	if (!cmdq)
@@ -594,6 +638,8 @@ static int cmdq_probe(struct platform_device *pdev)
 		dev, cmdq->base, cmdq->irq);
 
 	if (cmdq->pdata->gce_num > 1) {
+		hwid = of_alias_get_id(dev->of_node, clk_name);
+
 		for_each_child_of_node(phandle->parent, node) {
 			alias_id = of_alias_get_id(node, clk_name);
 			if (alias_id >= 0 && alias_id < cmdq->pdata->gce_num) {
@@ -643,6 +689,30 @@ static int cmdq_probe(struct platform_device *pdev)
 		cmdq->mbox.chans[i].con_priv = (void *)&cmdq->thread[i];
 	}
 
+	if (cmdq->pdata->has_secure) {
+		struct platform_device *cmdq_sec;
+		static struct gce_sec_plat sec_plat = {0};
+
+		if (of_property_read_u32_index(dev->of_node, "mediatek,gce-events", 0,
+					       &sec_plat.cmdq_event) == 0) {
+			sec_plat.mbox = &cmdq->mbox;
+			sec_plat.base = cmdq->base;
+			sec_plat.hwid = hwid;
+			sec_plat.secure_thread_nr = cmdq->pdata->secure_thread_nr;
+			sec_plat.secure_thread_min = cmdq->pdata->secure_thread_min;
+			sec_plat.shift = cmdq->pdata->shift;
+
+			cmdq_sec = platform_device_register_data(dev, "mtk-cmdq-sec",
+								 PLATFORM_DEVID_AUTO,
+								 &sec_plat,
+								 sizeof(sec_plat));
+			if (IS_ERR(cmdq_sec)) {
+				dev_err(dev, "failed to register platform_device mtk-cmdq-sec\n");
+				return PTR_ERR(cmdq_sec);
+			}
+		}
+	}
+
 	err = devm_mbox_controller_register(dev, &cmdq->mbox);
 	if (err < 0) {
 		dev_err(dev, "failed to register mailbox: %d\n", err);
@@ -719,6 +789,9 @@ static const struct gce_plat gce_plat_mt8188 = {
 	.thread_nr = 32,
 	.shift = 3,
 	.control_by_sw = true,
+	.has_secure = true,
+	.secure_thread_nr = 2,
+	.secure_thread_min = 8,
 	.gce_num = 2
 };
 
@@ -733,6 +806,9 @@ static const struct gce_plat gce_plat_mt8195 = {
 	.thread_nr = 24,
 	.shift = 3,
 	.control_by_sw = true,
+	.has_secure = true,
+	.secure_thread_nr = 2,
+	.secure_thread_min = 8,
 	.gce_num = 2
 };
 
-- 
2.18.0


