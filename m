Return-Path: <linux-kernel+bounces-189564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DA48B8CF20C
	for <lists+linux-kernel@lfdr.de>; Sun, 26 May 2024 01:09:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7AC22B2112B
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2024 23:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C7D212BF20;
	Sat, 25 May 2024 23:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="aTauG0kR"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B950129A8E;
	Sat, 25 May 2024 23:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716678509; cv=none; b=QkDzW89qBkYEW5CaTRJxnaS06+a9yH0sbEj2umK3dfLFQHwXTzx6nF7e5a4FCJ98FoWAIhYloTsiow1iv5j+0Qc42azZ9SVc+TvWBP1/MQNfV48fq5FwcHpphgLHJNDy5KC9ZR8JEUjAY+59Sb5h3kZTsGXy0aL0dVvd9/w633Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716678509; c=relaxed/simple;
	bh=9euSA4jHUb3p7wBq4f/MU/OK495sqi86B0XSBvvvWBM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G5s/SThfE0Tb2Hdrvxc8CfCwF0TmLO9Er1s56HPW9ghfwuhxljznthSvQRJZNpR1V8bGkOY5wVU2XlUHCjxdcXgmgwrjPK8+BWyyu0uDxHnH8mprz5D6E6ZyGKojSRmYsbBtW2NC6HiMmDH1QC8nZo8qQczG4NmT1FiErv6Hb/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=aTauG0kR; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: aa05d66e1aeb11ef8c37dd7afa272265-20240526
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=KxN0Cn2UnxKhpBITEVR5MpMye8qsppNfTxaYmd0XbS0=;
	b=aTauG0kRpwTDQ9sIv4H0AAT3stTKQbUGZ2+cFDr69tycDizdp4hkK0NvSC6f3RdVpcH1pOOEm+VbFlb3zfEd3fSzs2+9A9qIoWKe6JlX5ddBnHS8sK+4CA52c5oioW4qxut+LBdx3JQCW0pRMxSXcyGxZlS1GlJINvzu9XTa26Y=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:9065121b-40c3-4a5b-8dee-e4dea0faf204,IP:0,U
	RL:0,TC:0,Content:56,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:56
X-CID-META: VersionHash:82c5f88,CLOUDID:dcdb4f84-4f93-4875-95e7-8c66ea833d57,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:801|102,TC:nil,Content:3,EDM:-3,IP:n
	il,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LE
	S:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: aa05d66e1aeb11ef8c37dd7afa272265-20240526
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw01.mediatek.com
	(envelope-from <jason-jh.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 2130040980; Sun, 26 May 2024 07:08:14 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 MTKMBS14N2.mediatek.inc (172.21.101.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Sun, 26 May 2024 07:08:11 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Sun, 26 May 2024 07:08:11 +0800
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
Subject: [PATCH v6 4/8] mailbox: mtk-cmdq: Support GCE loop packets in interrupt handler
Date: Sun, 26 May 2024 07:08:06 +0800
Message-ID: <20240525230810.24623-5-jason-jh.lin@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20240525230810.24623-1-jason-jh.lin@mediatek.com>
References: <20240525230810.24623-1-jason-jh.lin@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--6.597500-8.000000
X-TMASE-MatchedRID: wDTc/wNgEcPlOkrqlJanurMjW/sniEQKLoYOuiLW+uUnArDy4nBG1Hv9
	jBhUgWuoqNt6gBjaBAGOpJpDdVJ03s3AmdtMjGJVA9lly13c/gHt/okBLaEo+E1KG1YrOQW/OXU
	FK+IJNsIOrPUQy5xzLmzlLAWyLHZTHxPMjOKY7A8LbigRnpKlKSPzRlrdFGDwh3LZaf1ztKRY2x
	n3QyvH0HjL7r86SIjXnbUmGdsUI/85dsuF2FPBIg==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--6.597500-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	D14A99AFF9CDE27804D20F65FF61FCCE37C598278DE54D7A2A25CAD5161804D02000:8
X-MTK: N

1. Add a loop flag for CMDQ packet struct.
CMDQ helper will use a loop flag to mark CMDQ packet as lopping command
and make current command buffer jumps to the beginning when GCE executes
to the end of command buffer.

2. Add a looping task handle flow in irq handler.
GCE irq occurs when GCE executes to the end of command(EOC) instruction.
If the CMDQ packet is a loopping command, GCE irq handler can not
delete the CMDQ task and disable the GCE thread.

Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>
Signed-off-by: Hsiao Chien Sung <shawn.sung@mediatek.com>
---
 drivers/mailbox/mtk-cmdq-mailbox.c       | 11 +++++++++++
 include/linux/mailbox/mtk-cmdq-mailbox.h |  1 +
 2 files changed, 12 insertions(+)

diff --git a/drivers/mailbox/mtk-cmdq-mailbox.c b/drivers/mailbox/mtk-cmdq-mailbox.c
index 4aa394e91109..618023011d31 100644
--- a/drivers/mailbox/mtk-cmdq-mailbox.c
+++ b/drivers/mailbox/mtk-cmdq-mailbox.c
@@ -267,6 +267,17 @@ static void cmdq_thread_irq_handler(struct cmdq *cmdq,
 
 	curr_pa = readl(thread->base + CMDQ_THR_CURR_ADDR) << cmdq->pdata->shift;
 
+	task = list_first_entry_or_null(&thread->task_busy_list,
+					struct cmdq_task, list_entry);
+	if (task && task->pkt->loop) {
+		struct cmdq_cb_data data;
+
+		data.sta = err;
+		data.pkt = task->pkt;
+		mbox_chan_received_data(task->thread->chan, &data);
+		return;
+	}
+
 	list_for_each_entry_safe(task, tmp, &thread->task_busy_list,
 				 list_entry) {
 		task_end_pa = task->pa_base + task->pkt->cmd_buf_size;
diff --git a/include/linux/mailbox/mtk-cmdq-mailbox.h b/include/linux/mailbox/mtk-cmdq-mailbox.h
index a8f0070c7aa9..f78a08e7c6ed 100644
--- a/include/linux/mailbox/mtk-cmdq-mailbox.h
+++ b/include/linux/mailbox/mtk-cmdq-mailbox.h
@@ -76,6 +76,7 @@ struct cmdq_pkt {
 	size_t			cmd_buf_size; /* command occupied size */
 	size_t			buf_size; /* real buffer size */
 	void			*cl;
+	bool			loop;
 };
 
 u8 cmdq_get_shift_pa(struct mbox_chan *chan);
-- 
2.18.0


