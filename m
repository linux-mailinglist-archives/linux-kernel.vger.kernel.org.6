Return-Path: <linux-kernel+bounces-214329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AF0B9082D2
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 06:01:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69ED5B21B21
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 04:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A3B9146597;
	Fri, 14 Jun 2024 04:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="sjXL8UqG"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F12038B
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 04:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718337705; cv=none; b=J+sUsOxo6yBsFNIPGlLOcNiVOHdihiogThswhlb9o2fDkvI8pmtl5eemSeYq2VG89bqNMel2QuQk0rMrRCovx4IhIdjiQS7Fb84+fTl1M/bsaGmOVIJKVjFQ1cmITaQLl6LpaWM/54YgHsl8hkrxPXZQfHYEJyW+UhYYbsz040E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718337705; c=relaxed/simple;
	bh=1J3I0qkXhd8Uo9a/TwYTSNUiNxnTOL3jS3+k7E2B+0E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OGqdwx+lO/DVuaW/cQdMisqu/NHHQbivr7acryp3ObVOFLJ9gmG9S8gyZZcrW/a+ooGIpHAU8KjlXW+gCa+x5PkpJT770BJC47ZxVOBGwz63dzPen9nfH4gGx3UHgtgt6CNAOKiRGzrN0QjeUugm8gijrhJq3ME2T86vaqGAl3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=sjXL8UqG; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: cab483262a0211efa54bbfbb386b949c-20240614
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=oNX/6xJwVVdxINFYHElAcSxjFjZW+WO3wSYq/VQB9l8=;
	b=sjXL8UqGlWgIsnSo9lrwDIATD+jETQMlrfUpOs7JNrM2puod97FJGW150fc/atq+ZdTIxQR9BPCPpOjgCURwu1LN3l1FPAtdijzMcGzyarVHe9WBr441yHuZEGf2Y6lLcPa7qoJC/xqe+4WjsU6SOFGm50leCcm1mNmJOexY8yc=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.39,REQID:f648b6fd-3723-4186-a88a-cc3557ae90c4,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:393d96e,CLOUDID:32d09288-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: cab483262a0211efa54bbfbb386b949c-20240614
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
	(envelope-from <jason-jh.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1786620334; Fri, 14 Jun 2024 12:01:35 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 14 Jun 2024 12:01:34 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 14 Jun 2024 12:01:34 +0800
From: Jason-JH.Lin <jason-jh.lin@mediatek.com>
To: Jassi Brar <jassisinghbrar@gmail.com>, Chun-Kuang Hu
	<chunkuang.hu@kernel.org>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
CC: Matthias Brugger <matthias.bgg@gmail.com>, "Jason-JH . Lin"
	<jason-jh.lin@mediatek.com>, Singo Chang <singo.chang@mediatek.com>, Nancy
 Lin <nancy.lin@mediatek.com>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [PATCH 2/2] mailbox: mtk-cmdq: Move pm_runimte_get and put to mbox_chan_ops API
Date: Fri, 14 Jun 2024 12:01:33 +0800
Message-ID: <20240614040133.24967-3-jason-jh.lin@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20240614040133.24967-1-jason-jh.lin@mediatek.com>
References: <20240614040133.24967-1-jason-jh.lin@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N

When we run kernel with lockdebug option, we will get the BUG below:
  BUG: sleeping function called from invalid context at drivers/base/power/runtime.c:1164
  in_atomic(): 1, irqs_disabled(): 128, non_block: 0, pid: 3616, name: kworker/u17:3
    preempt_count: 1, expected: 0
    RCU nest depth: 0, expected: 0
    INFO: lockdep is turned off.
    irq event stamp: 0
    CPU: 1 PID: 3616 Comm: kworker/u17:3 Not tainted 6.1.87-lockdep-14133-g26e933aca785 #1
    Hardware name: Google Ciri sku0/unprovisioned board (DT)
    Workqueue: imgsys_runner imgsys_runner_func
    Call trace:
     dump_backtrace+0x100/0x120
     show_stack+0x20/0x2c
     dump_stack_lvl+0x84/0xb4
     dump_stack+0x18/0x48
     __might_resched+0x354/0x4c0
     __might_sleep+0x98/0xe4
     __pm_runtime_resume+0x70/0x124
     cmdq_mbox_send_data+0xe4/0xb1c
     msg_submit+0x194/0x2dc
     mbox_send_message+0x190/0x330
     imgsys_cmdq_sendtask+0x1618/0x2224
     imgsys_runner_func+0xac/0x11c
     process_one_work+0x638/0xf84
     worker_thread+0x808/0xcd0
     kthread+0x24c/0x324
     ret_from_fork+0x10/0x20

We found that there is a spin_lock_irqsave protection in msg_submit()
of mailbox.c and it is in the atomic context.
So when cmdq driver calls pm_runtime_get_sync() in cmdq_mbox_send_data(),
it will get this BUG report.

To avoid using sleep in atomic context, move pm_runtime_get_sync to
mbox_chan_ops->power_get and also move pm_runtime_put_autosuspend to
mbox_chan_ops->power_put.

Fixes: 8afe816b0c99 ("mailbox: mtk-cmdq-mailbox: Implement Runtime PM with autosuspend")
Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>
---
 drivers/mailbox/mtk-cmdq-mailbox.c | 37 +++++++++++++++---------------
 1 file changed, 18 insertions(+), 19 deletions(-)

diff --git a/drivers/mailbox/mtk-cmdq-mailbox.c b/drivers/mailbox/mtk-cmdq-mailbox.c
index 4aa394e91109..02cef3eee35a 100644
--- a/drivers/mailbox/mtk-cmdq-mailbox.c
+++ b/drivers/mailbox/mtk-cmdq-mailbox.c
@@ -387,20 +387,13 @@ static int cmdq_mbox_send_data(struct mbox_chan *chan, void *data)
 	struct cmdq *cmdq = dev_get_drvdata(chan->mbox->dev);
 	struct cmdq_task *task;
 	unsigned long curr_pa, end_pa;
-	int ret;
 
 	/* Client should not flush new tasks if suspended. */
 	WARN_ON(cmdq->suspended);
 
-	ret = pm_runtime_get_sync(cmdq->mbox.dev);
-	if (ret < 0)
-		return ret;
-
 	task = kzalloc(sizeof(*task), GFP_ATOMIC);
-	if (!task) {
-		pm_runtime_put_autosuspend(cmdq->mbox.dev);
+	if (!task)
 		return -ENOMEM;
-	}
 
 	task->cmdq = cmdq;
 	INIT_LIST_HEAD(&task->list_entry);
@@ -448,7 +441,6 @@ static int cmdq_mbox_send_data(struct mbox_chan *chan, void *data)
 	list_move_tail(&task->list_entry, &thread->task_busy_list);
 
 	pm_runtime_mark_last_busy(cmdq->mbox.dev);
-	pm_runtime_put_autosuspend(cmdq->mbox.dev);
 
 	return 0;
 }
@@ -465,8 +457,6 @@ static void cmdq_mbox_shutdown(struct mbox_chan *chan)
 	struct cmdq_task *task, *tmp;
 	unsigned long flags;
 
-	WARN_ON(pm_runtime_get_sync(cmdq->mbox.dev) < 0);
-
 	spin_lock_irqsave(&thread->chan->lock, flags);
 	if (list_empty(&thread->task_busy_list))
 		goto done;
@@ -496,7 +486,6 @@ static void cmdq_mbox_shutdown(struct mbox_chan *chan)
 	spin_unlock_irqrestore(&thread->chan->lock, flags);
 
 	pm_runtime_mark_last_busy(cmdq->mbox.dev);
-	pm_runtime_put_autosuspend(cmdq->mbox.dev);
 }
 
 static int cmdq_mbox_flush(struct mbox_chan *chan, unsigned long timeout)
@@ -507,11 +496,6 @@ static int cmdq_mbox_flush(struct mbox_chan *chan, unsigned long timeout)
 	struct cmdq_task *task, *tmp;
 	unsigned long flags;
 	u32 enable;
-	int ret;
-
-	ret = pm_runtime_get_sync(cmdq->mbox.dev);
-	if (ret < 0)
-		return ret;
 
 	spin_lock_irqsave(&thread->chan->lock, flags);
 	if (list_empty(&thread->task_busy_list))
@@ -536,7 +520,6 @@ static int cmdq_mbox_flush(struct mbox_chan *chan, unsigned long timeout)
 out:
 	spin_unlock_irqrestore(&thread->chan->lock, flags);
 	pm_runtime_mark_last_busy(cmdq->mbox.dev);
-	pm_runtime_put_autosuspend(cmdq->mbox.dev);
 
 	return 0;
 
@@ -551,15 +534,31 @@ static int cmdq_mbox_flush(struct mbox_chan *chan, unsigned long timeout)
 		return -EFAULT;
 	}
 	pm_runtime_mark_last_busy(cmdq->mbox.dev);
-	pm_runtime_put_autosuspend(cmdq->mbox.dev);
+
 	return 0;
 }
 
+static int cmdq_mbox_pm_resume(struct mbox_chan *chan)
+{
+	struct cmdq *cmdq = dev_get_drvdata(chan->mbox->dev);
+
+	return pm_runtime_get_sync(cmdq->mbox.dev);
+}
+
+static void cmdq_mbox_pm_susepnd(struct mbox_chan *chan)
+{
+	struct cmdq *cmdq = dev_get_drvdata(chan->mbox->dev);
+
+	pm_runtime_put_autosuspend(cmdq->mbox.dev);
+}
+
 static const struct mbox_chan_ops cmdq_mbox_chan_ops = {
 	.send_data = cmdq_mbox_send_data,
 	.startup = cmdq_mbox_startup,
 	.shutdown = cmdq_mbox_shutdown,
 	.flush = cmdq_mbox_flush,
+	.power_get = cmdq_mbox_pm_resume,
+	.power_put = cmdq_mbox_pm_susepnd,
 };
 
 static struct mbox_chan *cmdq_xlate(struct mbox_controller *mbox,
-- 
2.18.0


